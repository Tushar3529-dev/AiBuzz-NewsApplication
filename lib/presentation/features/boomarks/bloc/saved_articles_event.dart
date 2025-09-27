part of 'saved_articles_bloc.dart';

abstract class SavedArticlesEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadSavedArticles extends SavedArticlesEvent {}

class SaveArticle extends SavedArticlesEvent {
  final ArticleEntity article;
  SaveArticle(this.article);
}

class DeleteArticle extends SavedArticlesEvent {
  final int index;
  DeleteArticle(this.index);
}
