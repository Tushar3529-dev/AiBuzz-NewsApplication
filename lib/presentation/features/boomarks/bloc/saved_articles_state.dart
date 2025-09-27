part of 'saved_articles_bloc.dart';

abstract class SavedArticlesState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SavedArticlesInitial extends SavedArticlesState {}

class SavedArticlesLoaded extends SavedArticlesState {
  final List<ArticleEntity> articles;
  SavedArticlesLoaded(this.articles);

  @override
  List<Object?> get props => [articles];
}
