import 'package:user_repository/user_repository.dart';

import '../entities/entities.dart';

class Bill {
  String billId;
  String billName;
  String billCost;
  DateTime dueDate;
  DateTime createAt;
  String fcmtoken;
  MyUser myUser;

  Bill({
    required this.billId,
    required this.billName,
    required this.billCost,
    required this.dueDate,
    required this.createAt,
    required this.fcmtoken,
    required this.myUser,
  });

  /// Empty user which represents an unauthenticated user.
  static final empty = Bill(
      billName: '',
      billCost: '',
      billId: '',
      dueDate: DateTime.now(),
      createAt: DateTime.now(),
      fcmtoken: '',
      myUser: MyUser.empty);

  /// Modify MyUser parameters
  Bill copyWith({
    String? billId,
    String? billName,
    String? billCost,
    DateTime? dueDate,
    DateTime? createAt,
    String? fcmtoken,
    MyUser? myUser,
  }) {
    return Bill(
      billId: billId ?? this.billId,
      billName: billName ?? this.billName,
      billCost: billCost ?? this.billCost,
      dueDate: dueDate ?? this.dueDate,
      createAt: createAt ?? this.createAt,
      fcmtoken: fcmtoken ?? this.fcmtoken,
      myUser: myUser ?? this.myUser,
    );
  }

  /// Convenience getter to determine whether the current user is empty.
  bool get isEmpty => this == Bill.empty;

  /// Convenience getter to determine whether the current user is not empty.
  bool get isNotEmpty => this != Bill.empty;

  BillEntity toEntity() {
    return BillEntity(
      billId: billId,
      billName: billName,
      billCost: billCost,
      dueDate: dueDate,
      createAt: createAt,
      fcmtoken: fcmtoken,
      myUser: myUser,
    );
  }

  static Bill fromEntity(BillEntity entity) {
    return Bill(
      billId: entity.billId,
      billName: entity.billName,
      billCost: entity.billCost,
      dueDate: entity.dueDate,
      createAt: entity.createAt,
      fcmtoken: entity.fcmtoken,
      myUser: entity.myUser,
    );
  }

  @override
  String toString() {
    return '''Bill: {
      billId: $billId
      billName: $billName
      billCost: $billCost
      dueDate: $dueDate
      createAt: $createAt
      fcmtoken: $fcmtoken,
      myUser: $myUser
    }''';
  }
}
