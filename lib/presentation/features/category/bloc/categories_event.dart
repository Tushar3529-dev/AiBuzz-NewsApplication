import 'package:equatable/equatable.dart';

abstract class CategoriesEvent extends Equatable {
  const CategoriesEvent();

  @override
  List<Object?> get props => [];
}

class LoadCategoriesNews extends CategoriesEvent {
  final String category;

  const LoadCategoriesNews(this.category);

  @override
  List<Object?> get props => [category];
}
