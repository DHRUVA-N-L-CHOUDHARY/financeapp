import 'dart:developer';
import 'package:bills_repository/bills_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
import 'bills_repo.dart';

class FirebaseBillRepository implements BillRepository {
  final billCollection = FirebaseFirestore.instance.collection('bills');

  @override
  Future<Bill> createBill(Bill bill) async {
    try {
      bill.billId = const Uuid().v1();

      await billCollection
          .doc(bill.billId)
          .set(bill.toEntity().toDocument());

      return bill;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<List<Bill>> getBills(String userId) async {
    try {
      return billCollection
          .where('myUser.userId', isEqualTo: userId)
          .get()
          .then((value) => value.docs
              .map((e) =>
                  Bill.fromEntity(BillEntity.fromDocument(e.data())))
              .toList());
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }
}
