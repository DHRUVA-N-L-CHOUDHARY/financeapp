part of 'get_bills_bloc.dart';

sealed class GetBillsState extends Equatable {
  const GetBillsState();
  
  @override
  List<Object> get props => [];
}

final class GetBillsInitial extends GetBillsState {}

final class GetBillsFailure extends GetBillsState {}

final class GetBillsLoading extends GetBillsState {}

final class GetBillsSucess extends GetBillsState {
  final List<Bill> bills;

  GetBillsSucess(this.bills);
}
