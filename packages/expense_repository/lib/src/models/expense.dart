import 'package:user_repository/user_repository.dart';

import '../entities/entities.dart';

class Expense {
  String expenseId;
  String expenseName;
  String expenseCost;
  String expenseType;
  DateTime createAt;
  MyUser myUser;

  Expense({
    required this.expenseId,
    required this.expenseName,
    required this.expenseCost,
    required this.expenseType,
    required this.createAt,
    required this.myUser,
  });

  /// Empty user which represents an unauthenticated user.
  static final empty = Expense(
      expenseName: '',
      expenseCost: '',
      expenseId: '',
      expenseType: '',
      createAt: DateTime.now(),
      myUser: MyUser.empty);

  /// Modify MyUser parameters
  Expense copyWith({
    String? expenseId,
    String? expenseName,
    String? expenseCost,
    String? expenseType,
    DateTime? createAt,
    MyUser? myUser,
  }) {
    return Expense(
      expenseId: expenseId ?? this.expenseId,
      expenseName: expenseName ?? this.expenseName,
      expenseCost: expenseCost ?? this.expenseCost,
      expenseType: expenseType ?? this.expenseType,
      createAt: createAt ?? this.createAt,
      myUser: myUser ?? this.myUser,
    );
  }

  /// Convenience getter to determine whether the current user is empty.
  bool get isEmpty => this == Expense.empty;

  /// Convenience getter to determine whether the current user is not empty.
  bool get isNotEmpty => this != Expense.empty;

  ExpenseEntity toEntity() {
    return ExpenseEntity(
      expenseId: expenseId,
      expenseName: expenseName,
      expenseCost: expenseCost,
      expenseType: expenseType,
      createAt: createAt,
      myUser: myUser,
    );
  }

  static Expense fromEntity(ExpenseEntity entity) {
    return Expense(
      expenseId: entity.expenseId,
      expenseName: entity.expenseName,
      expenseCost: entity.expenseCost,
      expenseType: entity.expenseType,
      createAt: entity.createAt,
      myUser: entity.myUser,
    );
  }

  @override
  String toString() {
    return '''Expense: {
      expenseId: $expenseId
      expenseName: $expenseName
      expenseCost: $expenseCost
      expenseType: $expenseType
      createAt: $createAt
      myUser: $myUser
    }''';
  }
}
