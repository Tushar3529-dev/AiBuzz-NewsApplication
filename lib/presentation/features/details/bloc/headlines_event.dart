import 'package:equatable/equatable.dart';

abstract class HeadlinesEvent extends Equatable {
  const HeadlinesEvent();

  @override
  List<Object?> get props => [];
}

class LoadHeadlinesNews extends HeadlinesEvent {
  final String channel;

  const LoadHeadlinesNews(this.channel);

  @override
  List<Object?> get props => [channel];
}
