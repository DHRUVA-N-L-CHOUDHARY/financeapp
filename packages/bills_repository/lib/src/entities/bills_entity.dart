import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:user_repository/user_repository.dart';

class BillEntity {
  String billId;
  String billName;
  String billCost;
  DateTime dueDate;
  DateTime createAt;
  String fcmtoken;
  MyUser myUser;

  BillEntity({
    required this.billId,
    required this.billName,
    required this.billCost,
    required this.dueDate,
    required this.createAt,
    required this.fcmtoken,
    required this.myUser,
  });

  Map<String, Object?> toDocument() {
    return {
      'billId': billId,
      'billName': billName,
      'billCost': billCost,
      'dueDate': dueDate,
      'createAt': createAt,
      'fcmtoken':fcmtoken,
      'myUser': myUser.toEntity().toDocument(),
    };
  }

  static BillEntity fromDocument(Map<String, dynamic> doc) {
    return BillEntity(
        billId: doc['billId'] as String,
        billName: doc['billName'] as String,
        billCost: doc['billCost'] as String,
        dueDate: (doc['dueDate'] as Timestamp).toDate(),
        createAt: (doc['createAt'] as Timestamp).toDate(),
        fcmtoken: doc['fcmtoken'] as String,
        myUser: MyUser.fromEntity(MyUserEntity.fromDocument(doc['myUser'])));
  }

  List<Object?> get props =>
      [billId, billName, billCost, dueDate, createAt, myUser];

  @override
  String toString() {
    return '''BillEntity: {
      billId: $billId
      billName: $billName
      billCost: $billCost
      dueDate: $dueDate
      fcmtoken:$fcmtoken
      createAt: $createAt
      myUser: $myUser
    }''';
  }
}
