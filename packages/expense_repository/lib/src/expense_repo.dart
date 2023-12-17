import 'models/models.dart';

abstract class ExpenseRepository {

	Future<Expense> createExpense(Expense expense);

	Future<List<Expense>> getExpenses(String userId);


}