part of 'get_bills_bloc.dart';

sealed class GetBillsEvent extends Equatable {
  const GetBillsEvent();

  @override
  List<Object> get props => [];
}

class GetBillsData extends GetBillsEvent{

}