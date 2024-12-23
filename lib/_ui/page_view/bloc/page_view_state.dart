part of 'page_view_bloc.dart';

enum PageViewStatus { initial, loading, success, failure }

final class PageViewState extends Equatable {
  final int currentPage;
  final PageViewStatus status;

  const PageViewState({
    required this.currentPage,
    required this.status,
  });

  @override
  List<Object> get props => [currentPage, status];
}
