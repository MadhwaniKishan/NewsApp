import 'package:flutter_news_app/model/articles.dart';
import 'package:equatable/equatable.dart';

class DataState extends Equatable {
  @override
  List<Object> get props => [];
}

class NotFetching extends DataState {}

class LoadingData extends DataState {}

class Success extends DataState {
  final _articlesObject;

  Success(this._articlesObject);

  Articles get articlesObject => _articlesObject;
}

class Failure extends DataState {}
