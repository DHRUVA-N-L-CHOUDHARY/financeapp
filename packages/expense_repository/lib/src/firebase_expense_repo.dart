import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_repository/expense_repository.dart';
import 'package:uuid/uuid.dart';
import 'expense_repo.dart';

class FirebaseExpenseRepository implements ExpenseRepository {
  final expenseCollection = FirebaseFirestore.instance.collection('expenses');

  @override
  Future<Expense> createExpense(Expense expense) async {
    try {
      expense.expenseId = const Uuid().v1();

      await expenseCollection
          .doc(expense.expenseId)
          .set(expense.toEntity().toDocument());

      return expense;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<List<Expense>> getExpenses(String userId) async {
    try {
      return expenseCollection
          .where('myUser.userId', isEqualTo: userId)
          .get()
          .then((value) => value.docs
              .map((e) =>
                  Expense.fromEntity(ExpenseEntity.fromDocument(e.data())))
              .toList());
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }
}
