import 'package:bills_repository/bills_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'add_bills_event.dart';
part 'add_bills_state.dart';

// class AddBillsBloc extends Bloc<AddBillsEvent, AddBillsState> {
//   AddBillsBloc() : super(AddBillsInitial()) {
//     on<AddBillsEvent>((event, emit) {
//       // TODO: implement event handler
//     });
//   }
// }
class AddBillsBloc extends Bloc<AddBillsEvent, AddBillsState> {
  BillRepository _billsRepository;
  AddBillsBloc({required BillRepository billsRepository})
      : _billsRepository = billsRepository,
        super(AddBillsInitial()) {
    on<AddBills>((event, emit) async {
      // TODO: implement event handler
      emit(AddBillsLoading());
      try {
        Bill bills = await _billsRepository.createBill(event.bill);
        emit(AddBillsSuccess(bills));
      } catch (e) {
        emit(AddBillsFailure());
      }
    });
  }
}