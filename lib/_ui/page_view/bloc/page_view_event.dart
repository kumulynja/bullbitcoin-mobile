part of 'page_view_bloc.dart';

sealed class PageViewEvent extends Equatable {
  const PageViewEvent();

  @override
  List<Object> get props => [];
}

final class PageViewNextPagePressed extends PageViewEvent {
  const PageViewNextPagePressed();
}

final class PageViewPreviousPagePressed extends PageViewEvent {
  const PageViewPreviousPagePressed();
}

final class PageViewPageChanged extends PageViewEvent {
  final int page;

  const PageViewPageChanged(this.page);

  @override
  List<Object> get props => [page];
}
