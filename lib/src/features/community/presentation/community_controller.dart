import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:nutrimama/src/features/auth/domain/user.dart';
import 'package:nutrimama/src/features/community/data/community_repository.dart';
import 'package:nutrimama/src/features/community/domain/comment.dart';
import 'package:nutrimama/src/features/community/domain/post.dart';
import 'package:nutrimama/src/features/community/presentation/community_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as image_reduce;

part 'community_controller.g.dart';

@Riverpod(keepAlive: true)
class CommunityController extends _$CommunityController {
  @override
  CommunityState build() {
    getPosts();
    return CommunityState(
      titleController: TextEditingController(),
      descriptionController: TextEditingController(),
      commentController: TextEditingController(),
    );
  }

  Future<void> getPosts() async {
    final result = await ref.read(communityRepositoryProvider).getPosts();
    result.when(
      success: (data) {
        state = state.copyWith(
          posts: AsyncData(data),
        );
      },
      failure: (error, stackTrace) {
        state = state.copyWith(
          posts: AsyncError(error, stackTrace),
        );
      },
    );
  }

  //getPost
  Future<void> getPost(String postId) async {
    final result = await ref.read(communityRepositoryProvider).getPost(postId);
    result.when(
      success: (data) {
        state = state.copyWith(
          post: AsyncData(data),
        );
      },
      failure: (error, stackTrace) {
        state = state.copyWith(
          post: AsyncError(error, stackTrace),
        );
      },
    );
  }

  Future<void> pickImage({required bool isCamera}) async {
    if (isCamera) {
      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.camera);
      if (pickedFile != null) {
        // Get the temporary directory
        final tempDir = await getTemporaryDirectory();
        final path = tempDir.path;

        // Resize the image
        image_reduce.Image image =
            image_reduce.decodeImage(File(pickedFile.path).readAsBytesSync())!;
        image_reduce.copyResize(image, width: 500);

        // Compress and save the image
        final compressedImage = File('$path/img_$image.jpg')
          ..writeAsBytesSync(image_reduce.encodeJpg(image, quality: 85));

        // Upload the image to Firebase Storage
        final imageUrl = compressedImage.path;
        state = state.copyWith(
          imageUrl: imageUrl,
        );
      }
    } else {
      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        // Check if the file has a valid image extension
        final validExtensions = ['jpg', 'jpeg', 'png', 'gif'];
        final String extension = pickedFile.path.split('.').last.toLowerCase();
        if (!validExtensions.contains(extension)) {
          throw Exception(
              'Only allowed extensions are jpg, jpeg, png, and gif.');
        }

        final tempDir = await getTemporaryDirectory();
        final path = tempDir.path;
        final File imageFile = File(pickedFile.path);
        final image_reduce.Image image =
            image_reduce.decodeImage(imageFile.readAsBytesSync())!;

        // Resize the image
        final image_reduce.Image resizedImage =
            image_reduce.copyResize(image, width: 500);

        // Compress and save the image
        final compressedImageFile = File('$path/img_$image.$extension')
          ..writeAsBytesSync(image_reduce.encodeJpg(resizedImage, quality: 85));

        // Upload the image to Firebase Storage
        final imageUrl = compressedImageFile.path;
        state = state.copyWith(
          imageUrl: imageUrl,
        );
      }
    }
  }

  Future<String> uploadImages(String imagesPath) async {
    final value = await FirebaseStorage.instance
        .ref()
        .child(
            'posts/images/${DateTime.now().millisecondsSinceEpoch}.${imagesPath.split('.').last}')
        .putFile(File(imagesPath));
    return value.ref.getDownloadURL();
  }

  Future<void> addPost(User user) async {
    state = state.copyWith(
      posts: const AsyncLoading(),
    );

    final imageUrl =
        state.imageUrl != null ? await uploadImages(state.imageUrl!) : '';

    Post post = Post(
      id: '',
      comments: [],
      createdAt: DateTime.now(),
      imageUrl: imageUrl,
      likes: 0,
      userId: user.id,
      userName: user.name,
      userPhoto: user.photoUrl,
      title: state.titleController.text,
      description: state.descriptionController.text,
    );

    final result = await ref.read(communityRepositoryProvider).addPost(post);
    result.when(
      success: (data) {
        getPosts();
        dispose();
      },
      failure: (error, stackTrace) {
        state = state.copyWith(
          posts: AsyncError(error, stackTrace),
        );
      },
    );
  }

  Future<void> addComment(String postId, Comment comment) async {
    final result =
        await ref.read(communityRepositoryProvider).addComment(postId, comment);
    result.when(
      success: (data) {
        getPosts();
      },
      failure: (error, stackTrace) {
        state = state.copyWith(
          posts: AsyncError(error, stackTrace),
        );
      },
    );
  }

  void dispose() {
    state = state.copyWith(
      titleController: TextEditingController(),
      descriptionController: TextEditingController(),
      imageUrl: '',
    );
  }
}
