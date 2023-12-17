part of 'add_bills_bloc.dart';

sealed class AddBillsState extends Equatable {
  const AddBillsState();
  
  @override
  List<Object> get props => [];
}

final class AddBillsInitial extends AddBillsState {}


final class AddBillsFailure extends AddBillsState {}

final class AddBillsLoading extends AddBillsState {}

final class AddBillsSuccess extends AddBillsState {
  final Bill bill;

  const AddBillsSuccess(this.bill);
}
