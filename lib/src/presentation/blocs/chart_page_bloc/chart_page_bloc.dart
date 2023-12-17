import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:expense_repository/expense_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'chart_page_event.dart';
part 'chart_page_state.dart';

class ChartPageBloc extends Bloc<ChartPageEvent, ChartPageState> {
  ExpenseRepository _expenseRepository;
  ChartPageBloc({required ExpenseRepository expenseRepository})
      : _expenseRepository = expenseRepository,
        super(ChartPageInitial()) {
    on<GetChartData>((event, emit) async {
      emit(ChartPostLoading());
      try {
        List<Expense> expenselist = await _expenseRepository
            .getExpenses(FirebaseAuth.instance.currentUser!.uid);
        emit(ChartPageSucess(expenselist));
      } catch (e) {
        emit(ChartPostFailure());
      }
    });
  }
}
