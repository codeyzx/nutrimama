import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nutrimama/src/features/education/domain/article.dart';
import 'package:nutrimama/src/features/education/domain/video.dart';
import 'package:nutrimama/src/services/remote/remote.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'education_repository.g.dart';

class EducationRepository {
  final articleDb =
      FirebaseFirestore.instance.collection('articles').withConverter(
            fromFirestore: (snapshot, _) => Article.fromJson(snapshot.data()!),
            toFirestore: (Article article, _) => article.toJson(),
          );

  final videoDb = FirebaseFirestore.instance.collection('videos').withConverter(
        fromFirestore: (snapshot, _) => Video.fromJson(snapshot.data()!),
        toFirestore: (Video video, _) => video.toJson(),
      );

  Future<Result<List<Article>>> getArticles() async {
    try {
      final resultArticles = await articleDb.get();
      final articles = resultArticles.docs.map((e) => e.data()).toList();
      return Result.success(articles);
    } catch (e) {
      return Result.failure(
          NetworkExceptions.getFirebaseException(e), StackTrace.current);
    }
  }

  Future<Result<String>> addArticle(List<Article> articles) async {
    try {
      for (final article in articles) {
        final ref = articleDb.doc();
        await ref.set(article.copyWith(id: ref.id, imageUrl: ''));
      }
      return const Result.success('Success');
    } catch (e) {
      return Result.failure(
          NetworkExceptions.getFirebaseException(e), StackTrace.current);
    }
  }

  Future<Result<List<Video>>> getVideos() async {
    try {
      final resultVideos = await videoDb.get();
      final videos = resultVideos.docs.map((e) => e.data()).toList();
      return Result.success(videos);
    } catch (e) {
      return Result.failure(
          NetworkExceptions.getFirebaseException(e), StackTrace.current);
    }
  }

  Future<Result<String>> addVideo(Video video) async {
    try {
      final ref = videoDb.doc();
      video = video.copyWith(id: ref.id);
      await ref.set(video);
      return const Result.success('Success');
    } catch (e) {
      return Result.failure(
          NetworkExceptions.getFirebaseException(e), StackTrace.current);
    }
  }
}

@Riverpod(keepAlive: true)
EducationRepository educationRepository(EducationRepositoryRef ref) {
  return EducationRepository();
}
