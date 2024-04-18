import 'package:cloud_firestore/cloud_firestore.dart';
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
}

@Riverpod(keepAlive: true)
CommunityRepository communityRepository(CommunityRepositoryRef ref) {
  return CommunityRepository();
}
