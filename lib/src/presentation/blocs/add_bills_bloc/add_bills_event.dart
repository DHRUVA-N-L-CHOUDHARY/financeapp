part of 'add_bills_bloc.dart';

sealed class AddBillsEvent extends Equatable {
  const AddBillsEvent();

  @override
  List<Object> get props => [];
}

class AddBills extends AddBillsEvent
{
  final Bill bill;

  const AddBills(this.bill);
}