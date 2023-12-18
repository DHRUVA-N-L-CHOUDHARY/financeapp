import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:expense_repository/expense_repository.dart';

part 'add_expense_event.dart';
part 'add_expense_state.dart';

class AddExpenseBloc extends Bloc<AddExpenseEvent, AddExpenseState> {
  ExpenseRepository _expenseRepository;
  AddExpenseBloc({required ExpenseRepository expenseRepository})
      : _expenseRepository = expenseRepository,
        super(AddExpenseInitial()) {
    on<AddExpense>((event, emit) async {
      // TODO: implement event handler
      emit(AddExpenseLoading());
      try {
        Expense expense = await _expenseRepository.createExpense(event.expense);
        emit(AddExpenseSuccess(expense));
      } catch (e) {
        emit(AddExpenseFailure());
      }
    });
  }
}
