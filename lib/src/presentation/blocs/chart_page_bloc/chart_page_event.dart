part of 'chart_page_bloc.dart';

sealed class ChartPageEvent extends Equatable {
  const ChartPageEvent();

  @override
  List<Object> get props => [];
}

class GetChartData extends ChartPageEvent{

}