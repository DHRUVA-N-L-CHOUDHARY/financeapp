part of 'add_expense_bloc.dart';

sealed class AddExpenseEvent extends Equatable {
  const AddExpenseEvent();

  @override
  List<Object> get props => [];
}

class AddExpense extends AddExpenseEvent
{
  final Expense expense;

  const AddExpense(this.expense);
}