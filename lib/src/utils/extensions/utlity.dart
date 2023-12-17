import 'package:expense_repository/expense_repository.dart';

int totals = 0;

int calculateBalance(List<Expense> expenses) {
  int total = 0;
  for (var i = 0; i < expenses.length; i++) {
    total += expenses[i].expenseType == 'Income'
        ? int.parse(expenses[i].expenseCost)
        : int.parse(expenses[i].expenseCost) * -1;
  }
  return total;
}

int calculateIncome(List<Expense> expenses) {
  int total = 0;
  for (var i = 0; i < expenses.length; i++) {
    total += expenses[i].expenseType == 'Income'
        ? int.parse(expenses[i].expenseCost)
        : 0;
  }
  return total;
}

int calculateExpenses(List<Expense> expenses) {
  int total = 0;
  for (var i = 0; i < expenses.length; i++) {
    total += expenses[i].expenseType == 'Income'
        ? 0
        : int.parse(expenses[i].expenseCost);
  }
  return total;
}

List<Expense> today(List<Expense> expenses) {
  List<Expense> a = [];
  DateTime date = new DateTime.now();
  for (var i = 0; i < expenses.length; i++) {
    if (expenses[i].createAt.day == date.day) {
      a.add(expenses[i]);
    }
  }
  return a;
}

List<Expense> week(List<Expense> expenses) {
  List<Expense> a = [];
  DateTime date = new DateTime.now();
  for (var i = 0; i < expenses.length; i++) {
    if (date.day - 7 <= expenses[i].createAt.day &&
        expenses[i].createAt.day <= date.day) {
      a.add(expenses[i]);
    }
  }
  return a;
}

List<Expense> month(List<Expense> expenses) {
  List<Expense> a = [];
  DateTime date = new DateTime.now();
  for (var i = 0; i < expenses.length; i++) {
    if (expenses[i].createAt.month == date.month) {
      a.add(expenses[i]);
    }
  }
  return a;
}

List<Expense> year(List<Expense> expenses) {
  List<Expense> a = [];
  DateTime date = new DateTime.now();
  for (var i = 0; i < expenses.length; i++) {
    if (expenses[i].createAt.year == date.year) {
      a.add(expenses[i]);
    }
  }
  return a;
}

int total_chart(List<Expense> expense) {
  List a = [0, 0];

  for (var i = 0; i < expense.length; i++) {
    a.add(expense[i].expenseType == 'Income'
        ? int.parse(expense[i].expenseCost)
        : int.parse(expense[i].expenseCost) * -1);
  }
  totals = a.reduce((value, element) => value + element);
  return totals;
}

List time(List<Expense> expense, bool hour) {
  List<Expense> a = [];
  List total = [];
  int counter = 0;
  for (var c = 0; c < expense.length; c++) {
    for (var i = c; i < expense.length; i++) {
      if (hour) {
        if (expense[i].createAt.hour == expense[c].createAt.hour) {
          a.add(expense[i]);
          counter = i;
        }
      } else {
        if (expense[i].createAt.day == expense[c].createAt.day) {
          a.add(expense[i]);
          counter = i;
        }
      }
    }
    total.add(total_chart(a));
    a.clear();
    c = counter;
  }
  print(total);
  return total;
}