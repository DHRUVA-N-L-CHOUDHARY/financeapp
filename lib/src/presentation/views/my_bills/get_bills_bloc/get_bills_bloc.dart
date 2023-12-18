import 'package:bills_repository/bills_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'get_bills_event.dart';
part 'get_bills_state.dart';

class GetBillsBloc extends Bloc<GetBillsEvent, GetBillsState> {
  BillRepository _billsRepository;
  GetBillsBloc({required BillRepository billsRepository})
      : _billsRepository = billsRepository,
        super(GetBillsInitial()) {
    on<GetBillsData>((event, emit) async {
      emit(GetBillsLoading());
      try {
        List<Bill> billslist = await _billsRepository
            .getBills(FirebaseAuth.instance.currentUser!.uid);
        emit(GetBillsSucess(billslist));
      } catch (e) {
        emit(GetBillsFailure());
      }
    });
  }
}
