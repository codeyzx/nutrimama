import 'package:nutrimama/src/features/education/data/education_repository.dart';
import 'package:nutrimama/src/features/education/domain/article.dart';
import 'package:nutrimama/src/features/education/domain/video.dart';
import 'package:nutrimama/src/features/education/presentation/education_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'education_controller.g.dart';

@Riverpod(keepAlive: true)
class EducationController extends _$EducationController {
  @override
  EducationState build() {
    return EducationState();
  }

  Future<void> getArticles() async {
    final result = await ref.read(educationRepositoryProvider).getArticles();
    result.when(
      success: (data) {
        state = state.copyWith(
          articles: AsyncData(data),
        );
      },
      failure: (error, stackTrace) {
        state = state.copyWith(
          articles: AsyncError(error, stackTrace),
        );
      },
    );
  }

  // getVideos
  Future<void> getVideos() async {
    final result = await ref.read(educationRepositoryProvider).getVideos();
    result.when(
      success: (data) {
        state = state.copyWith(
          videos: AsyncData(data),
        );
      },
      failure: (error, stackTrace) {
        state = state.copyWith(
          videos: AsyncError(error, stackTrace),
        );
      },
    );
  }

  // addArticle
  Future<void> addArticle() async {
    Article article = const Article(
      id: '',
      title: 'Title',
      description: 'Description',
      imageUrl: 'https://via.placeholder.com/150',
      category: ArticleCategory.kesehatan,
    );
    final result =
        await ref.read(educationRepositoryProvider).addArticle(article);
    result.when(
      success: (data) {
        getArticles();
      },
      failure: (error, stackTrace) {
        state = state.copyWith(
          articles: AsyncError(error, stackTrace),
        );
      },
    );
  }

  //addVideo
  Future<void> addVideo() async {
    Video video = const Video(
      id: '',
      title: 'Title',
      description: 'Description',
      videoUrl: 'https://www.youtube.com/watch?v=6g3DcLrm9Kw',
      category: VideoCategory.kesehatan,
      imageUrl: 'https://via.placeholder.com/150',
    );
    final result = await ref.read(educationRepositoryProvider).addVideo(video);
    result.when(
      success: (data) {
        getVideos();
      },
      failure: (error, stackTrace) {
        state = state.copyWith(
          videos: AsyncError(error, stackTrace),
        );
      },
    );
  }
}
