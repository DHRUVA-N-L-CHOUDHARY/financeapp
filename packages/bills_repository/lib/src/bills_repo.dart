import 'models/models.dart';

abstract class BillRepository {

	Future<Bill> createBill(Bill expense);

	Future<List<Bill>> getBills(String userId);


}