import 'package:aibuzz_newsapp/data/remote/repository/news_repository.dart';
import 'package:aibuzz_newsapp/presentation/features/category/bloc/categories_event.dart';
import 'package:aibuzz_newsapp/presentation/features/category/bloc/categories_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  final NewsRepository newsRepository;

  CategoriesBloc(this.newsRepository) : super(CategoriesInitial()) {
    on<LoadCategoriesNews>((event, emit) async {
      emit(CategoriesLoading());
      try {
        final response = await newsRepository.fetchCategoriesNewsApi(
          event.category,
        );
        emit(CategoriesLoaded(response.articles ?? []));
      } catch (e) {
        emit(CategoriesError(e.toString()));
      }
    });
  }
}
