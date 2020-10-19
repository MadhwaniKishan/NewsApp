import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app/api/apiProvider.dart';
import 'package:flutter_news_app/bloc/event.dart';
import 'package:flutter_news_app/bloc/state.dart';
import 'package:flutter_news_app/model/articles.dart';

class ArticleBloc extends Bloc<Event, DataState> {
  ArticleBloc(DataState initialState, this.apiProvider) : super(initialState);

  ApiProvider apiProvider;

  @override
  Stream<DataState> mapEventToState(Event event) async* {
    if (event is FetchData) {
      yield LoadingData();
      try {
        Articles articles = await apiProvider.getData();
        yield Success(articles);
      } catch (_) {
        yield Failure();
      }
    }
  }
}
