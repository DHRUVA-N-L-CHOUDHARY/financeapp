import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:user_repository/user_repository.dart';

class ExpenseEntity {
  String expenseId;
  String expenseName;
  String expenseCost;
  String expenseType;
  DateTime createAt;
  MyUser myUser;

  ExpenseEntity({
    required this.expenseId,
    required this.expenseName,
    required this.expenseCost,
    required this.expenseType,
    required this.createAt,
    required this.myUser,
  });

  Map<String, Object?> toDocument() {
    return {
      'expenseId': expenseId,
      'expenseName': expenseName,
      'expenseCost': expenseCost,
      'expenseType': expenseType,
      'createAt': createAt,
      'myUser': myUser.toEntity().toDocument(),
    };
  }

  static ExpenseEntity fromDocument(Map<String, dynamic> doc) {
    return ExpenseEntity(
        expenseId: doc['expenseId'] as String,
        expenseName: doc['expenseName'] as String,
        expenseCost: doc['expenseCost'] as String,
        expenseType: doc['expenseType'] as String,
        createAt: (doc['createAt'] as Timestamp).toDate(),
        myUser: MyUser.fromEntity(MyUserEntity.fromDocument(doc['myUser'])));
  }

  List<Object?> get props =>
      [expenseId, expenseName, expenseCost, expenseType, createAt, myUser];

  @override
  String toString() {
    return '''ExpenseEntity: {
      expenseId: $expenseId
      expenseName: $expenseName
      expenseCost: $expenseCost
      expenseType: $expenseType
      createAt: $createAt
      myUser: $myUser
    }''';
  }
}
