part of 'chart_page_bloc.dart';

sealed class ChartPageState extends Equatable {
  const ChartPageState();

   @override
  List<Object> get props => [];
}

final class ChartPageInitial extends ChartPageState {}

final class ChartPostFailure extends ChartPageState {}

final class ChartPostLoading extends ChartPageState {}

final class ChartPageSucess extends ChartPageState {
  final List<Expense> salesData;

  ChartPageSucess(this.salesData);
}
