import 'package:aibuzz_newsapp/data/remote/repository/news_repository.dart';
import 'package:aibuzz_newsapp/presentation/features/details/bloc/headlines_event.dart';
import 'package:aibuzz_newsapp/presentation/features/details/bloc/headlines_state.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class HeadlinesBloc extends Bloc<HeadlinesEvent, HeadlinesState> {
  final NewsRepository newsRepository;

  HeadlinesBloc(this.newsRepository) : super(HeadlinesInitial()) {
    on<LoadHeadlinesNews>((event, emit) async {
      emit(HeadlinesLoading());
      try {
        final response = await newsRepository.fetchNewChannelHeadlinesApi(
          event.channel,
        );
        emit(HeadlinesLoaded(response.articles ?? []));
      } catch (e) {
        emit(HeadlinesError(e.toString()));
      }
    });
  }
}
