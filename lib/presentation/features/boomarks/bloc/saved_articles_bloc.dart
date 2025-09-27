import 'package:aibuzz_newsapp/domain/repository/local/article_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:aibuzz_newsapp/domain/entities/article_entity.dart';

part 'saved_articles_event.dart';
part 'saved_articles_state.dart';

class SavedArticlesBloc extends Bloc<SavedArticlesEvent, SavedArticlesState> {
  final ArticleRepository repository;

  SavedArticlesBloc(this.repository) : super(SavedArticlesInitial()) {
    on<LoadSavedArticles>((event, emit) async {
      final articles = await repository.getSavedArticles();
      emit(SavedArticlesLoaded(articles));
    });

    on<SaveArticle>((event, emit) async {
      await repository.saveArticle(event.article);
      final articles = await repository.getSavedArticles();
      emit(SavedArticlesLoaded(articles));
    });

    on<DeleteArticle>((event, emit) async {
      await repository.deleteArticle(event.index);
      final articles = await repository.getSavedArticles();
      emit(SavedArticlesLoaded(articles));
    });
  }
}
