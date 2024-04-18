import 'package:nutrimama/src/features/education/domain/article.dart';
import 'package:nutrimama/src/features/education/domain/video.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

class EducationState {
  final AsyncValue<List<Article>?> articles;
  final AsyncValue<List<Video>?> videos;
  final AsyncValue<List<Article>?> filteredArticles;
  final AsyncValue<List<Video>?> filteredVideos;
  final Enum? category;
  final String selectedIndex;

  EducationState({
    this.articles = const AsyncLoading(),
    this.videos = const AsyncLoading(),
    this.filteredArticles = const AsyncLoading(),
    this.filteredVideos = const AsyncLoading(),
    this.category,
    this.selectedIndex = 'Semua',
  });

  EducationState copyWith({
    AsyncValue<List<Article>?>? articles,
    AsyncValue<List<Video>?>? videos,
    AsyncValue<List<Article>?>? filteredArticles,
    AsyncValue<List<Video>?>? filteredVideos,
    Enum? category,
    String? selectedIndex,
  }) {
    return EducationState(
      articles: articles ?? this.articles,
      videos: videos ?? this.videos,
      filteredArticles: filteredArticles ?? this.filteredArticles,
      filteredVideos: filteredVideos ?? this.filteredVideos,
      category: category ?? this.category,
      selectedIndex: selectedIndex ?? this.selectedIndex,
    );
  }
}
