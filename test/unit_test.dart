import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_news_app/api/apiProvider.dart';
import 'package:flutter_news_app/bloc/articleBloc.dart';
import 'package:flutter_news_app/bloc/event.dart';
import 'package:flutter_news_app/bloc/state.dart';
import 'package:flutter_news_app/model/articles.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'MockService.dart';

void main() {
  ApiProvider apiProvider;
  ArticleBloc articleBloc;
  setUp(() {
    apiProvider = MockService();
    articleBloc = ArticleBloc(LoadingData(), apiProvider);
  });
  tearDown(() {
    articleBloc?.close();
  });
  group('ArticleBloc', () {
    final _article = Articles();

    blocTest('first state should be loading and then Success',
        build: () {
          when(apiProvider.getData()).thenAnswer((_) async => _article);
          return articleBloc;
        },
        act: (articleBloc) => articleBloc.add(FetchData()),
        expect: [LoadingData(), Success(_article)]);

    blocTest('socket exception should give failure state',
        build: () {
          when(apiProvider.getData()).thenThrow(SocketException);
          return articleBloc;
        },
        act: (articleBloc) => articleBloc.add(FetchData()),
        expect: [LoadingData(), Failure()]);
  });
}
