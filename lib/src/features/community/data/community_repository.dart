import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nutrimama/src/features/community/domain/comment.dart';
import 'package:nutrimama/src/features/community/domain/post.dart';
import 'package:nutrimama/src/services/remote/remote.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'community_repository.g.dart';

class CommunityRepository {
  final postDb = FirebaseFirestore.instance.collection('posts').withConverter(
        fromFirestore: (snapshot, _) => Post.fromJson(snapshot.data()!),
        toFirestore: (Post post, _) => post.toJson(),
      );

  Future<Result<List<Post>>> getPosts() async {
    try {
      final resultPosts = await postDb.get();
      final posts = resultPosts.docs.map((e) => e.data()).toList();
      posts.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      return Result.success(posts);
    } catch (e) {
      return Result.failure(
          NetworkExceptions.getFirebaseException(e), StackTrace.current);
    }
  }

  //getPost
  Future<Result<Post>> getPost(String postId) async {
    try {
      final result = await postDb.doc(postId).get();
      final post = result.data();
      return Result.success(post!);
    } catch (e) {
      return Result.failure(
          NetworkExceptions.getFirebaseException(e), StackTrace.current);
    }
  }

  Future<Result<String>> addPost(Post post) async {
    try {
      final ref = postDb.doc();
      post = post.copyWith(id: ref.id);
      await ref.set(post);
      return const Result.success('Success');
    } catch (e) {
      return Result.failure(
          NetworkExceptions.getFirebaseException(e), StackTrace.current);
    }
  }

  Future<Result<String>> addComment(String postId, Comment comment) async {
    try {
      final ref = postDb.doc(postId);
      final result = await ref.get();
      final post = result.data();
      List<Comment> comments = post?.comments ?? [];
      comments.add(comment);
      await ref.set(post!.copyWith(comments: comments));
      return const Result.success('Success');
    } catch (e) {
      return Result.failure(
          NetworkExceptions.getFirebaseException(e), StackTrace.current);
    }
  }

  Future<Result<void>> updateUserPost(Map<String, String> user) async {
    try {
      final resultPosts =
          await postDb.where('userId', isEqualTo: user['userId']).get();
      final postsToUpdate = resultPosts.docs;

      final batch = postDb.firestore.batch();
      for (final post in postsToUpdate) {
        batch.update(post.reference, user);
      }

      await batch.commit();

      return const Result.success(null);
    } catch (e) {
      return Result.failure(
          NetworkExceptions.getFirebaseException(e), StackTrace.current);
    }
  }

  Future<Result<void>> updateUserComments(Map<String, String> user) async {
    try {
      final resultPosts = await postDb.get();
      final posts = resultPosts.docs.map((e) => e.data()).toList();

      final batch = postDb.firestore.batch();

      for (final post in posts) {
        Comment comment = Comment(
          createdAt: DateTime.now(),
          postId: post.id,
          text: '',
          userId: user['userId'] ?? '',
          userName: user['userName'] ?? '',
          userPhoto: user['userPhoto'] ?? '',
        );
        List<Comment> comments = post.comments;
        for (final temp in comments) {
          if (temp.userId == user['userId']) {
            comment = temp.copyWith(
              userName: user['userName'] ?? '',
              userPhoto: user['userPhoto'] ?? '',
            );
            comments[comments.indexOf(temp)] = comment;
          }
        }
        batch.update(postDb.doc(post.id),
            {'comments': comments.map((e) => e.toJson()).toList()});
      }

      await batch.commit();

      return const Result.success(null);
    } catch (e) {
      return Result.failure(
          NetworkExceptions.getFirebaseException(e), StackTrace.current);
    }
  }
}

@Riverpod(keepAlive: true)
CommunityRepository communityRepository(CommunityRepositoryRef ref) {
  return CommunityRepository();
}
