import 'package:aibuzz_newsapp/data/remote/model/news_channels_headlines_model.dart';
import 'package:equatable/equatable.dart';

abstract class HeadlinesState extends Equatable {
  const HeadlinesState();

  @override
  List<Object?> get props => [];
}

class HeadlinesInitial extends HeadlinesState {}

class HeadlinesLoading extends HeadlinesState {}

class HeadlinesLoaded extends HeadlinesState {
  final List<Articles> articles;

  const HeadlinesLoaded(this.articles);

  @override
  List<Object?> get props => [articles];
}

class HeadlinesError extends HeadlinesState {
  final String message;

  const HeadlinesError(this.message);

  @override
  List<Object?> get props => [message];
}
