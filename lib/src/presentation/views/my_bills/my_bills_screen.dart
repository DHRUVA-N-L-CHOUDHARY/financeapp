import 'package:bills_repository/bills_repository.dart';
import 'package:financeapp/src/presentation/views/my_bills/get_bills_bloc/get_bills_bloc.dart';
import 'package:financeapp/src/utils/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyBillsScreen extends StatelessWidget {
  const MyBillsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetBillsBloc, GetBillsState>(
      builder: (context, state) {
        if (state is GetBillsSucess) {
          return Scaffold(
            body: SafeArea(
              child: CustomScrollView(
                slivers: [
                   SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.only(left: 15.w,right:15.w,top: 30.h),
                      child: Text(
                        'Upcoming Bills',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 19.sp,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        List<Bill> billList = state.bills.toList();
                        return getUpcomingList(billList, index);
                      },
                      childCount: state.bills.length,
                    ),
                  ),
                   SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.only(left: 15.w,right:15.w,top: 60.h),
                      child: Text(
                        'Past Bills',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 19.sp,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        List<Bill> billList = state.bills.toList();
                        return getfinishedList(billList, index);
                      },
                      childCount: state.bills.length,
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }

  Widget getUpcomingList(List<Bill> bill, int index) {
    return Dismissible(
        key: UniqueKey(),
        onDismissed: (direction) {
          bill.removeAt(index);
        },
        child: (bill[index].dueDate).isAfter(DateTime.now())
            ? get(index, bill[index])
            : const SizedBox(
                height: 0,
                width: 0,
              ));
  }

  Widget getfinishedList(List<Bill> bill, int index) {
    return (bill[index].dueDate).isBefore(DateTime.now())
        ? get(index, bill[index])
        : const SizedBox(
            height: 0,
            width: 0,
          );
  }

  Widget get(
    int index,
    Bill bill,
  ) {
    return ListTile(
      title: Text(
        bill.billName,
        style:  TextStyle(
          fontSize: 17.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(
        '${day[bill.dueDate.weekday - 1]}  ${bill.dueDate.year}-${bill.dueDate.day}-${bill.dueDate.month}',
        style: const TextStyle(
          fontWeight: FontWeight.w600,
        ),
      ),
      trailing: Text(
        bill.billCost,
        style:  TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 19.sp,
          color: Colors.red,
        ),
      ),
    );
  }
}
