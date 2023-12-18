import 'package:expense_repository/expense_repository.dart';
import 'package:financeapp/src/presentation/views/auth/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:financeapp/src/presentation/views/charts/chart_page_bloc/chart_page_bloc.dart';
import 'package:financeapp/src/utils/constants/app_constants.dart';
import 'package:financeapp/src/utils/extensions/utlity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child:
          BlocBuilder<ChartPageBloc, ChartPageState>(builder: (context, state) {
        if (state is ChartPageSucess) {
          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: SizedBox(
                    height: 340.h,
                    child: _head(
                        state.salesData,
                        state.salesData.isEmpty
                            ? FirebaseAuth.instance.currentUser!.email
                                .toString()
                            : state.salesData[0].myUser.name,
                        context)),
              ),
               SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  child: Text(
                    'Transactions History',
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
                    List<Expense> expenselist = state.salesData.toList();
                    return getList(expenselist, index);
                  },
                  childCount: state.salesData.length,
                ),
              )
            ],
          );
        } else {
          return const CircularProgressIndicator();
        }
      })),
    );
  }

  Widget getList(List<Expense> expense, int index) {
    return Dismissible(
        key: UniqueKey(),
        onDismissed: (direction) {
          expense.removeAt(index);
        },
        child: get(index, expense[index]));
  }

  ListTile get(int index, Expense expense) {
    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child:
            Image.asset('assets/images/${expense.expenseName}.png', height: 40.h),
      ),
      title: Text(
        expense.expenseName,
        style:  TextStyle(
          fontSize: 17.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(
        '${day[expense.createAt.weekday - 1]}  ${expense.createAt.year}-${expense.createAt.day}-${expense.createAt.month}',
        style: const TextStyle(
          fontWeight: FontWeight.w600,
        ),
      ),
      trailing: Text(
        expense.expenseCost,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 19.sp,
          color: expense.expenseType == 'Income' ? Colors.green : Colors.red,
        ),
      ),
    );
  }

  Widget _head(
      List<Expense> transactions, String username, BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Container(
              width: double.infinity,
              height: 240.h,
              decoration: BoxDecoration(
                color: const Color(0xff368983),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20.r),
                  bottomRight: Radius.circular(20.r),
                ),
              ),
              child: Stack(
                children: [
                  Padding(
                    padding:  EdgeInsets.only(top: 35.h, left: 10.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding:  EdgeInsets.only(right: 8.0.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                               Text(
                                'Hello,',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16.sp,
                                  color: const Color.fromARGB(255, 224, 223, 223),
                                ),
                              ),
                              IconButton(
                                  onPressed: () {
                                    FirebaseAuth.instance.signOut();
                                    Navigator.pushReplacementNamed(
                                        context, "/welcome", arguments: {
                                      "userRepository": context
                                          .read<AuthenticationBloc>()
                                          .userRepository
                                    });
                                  },
                                  icon: const Icon(
                                    Icons.logout,
                                    color: Colors.white,
                                  ))
                            ],
                          ),
                        ),
                        Text(
                          username,
                          style:  TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 20.sp,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
        Positioned(
          top: 140.h,
          left: 20.w,
          child: Container(
            height: 170.h,
            width: 320.w,
            decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                  color: Color.fromRGBO(47, 125, 121, 0.3),
                  offset: Offset(0, 6),
                  blurRadius: 12,
                  spreadRadius: 6,
                ),
              ],
              color: const Color.fromARGB(255, 47, 125, 121),
              borderRadius: BorderRadius.circular(15.r),
            ),
            child: Column(
              children: [
                 SizedBox(height: 10.h),
                 Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total Balance',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16.sp,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 7.h),
                Padding(
                  padding:  EdgeInsets.only(left: 15.w),
                  child: Row(
                    children: [
                      Text(
                        '\$ ${calculateBalance(transactions)}',
                        style:  TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25.sp,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 25.h),
               Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 13.r,
                            backgroundColor: const Color.fromARGB(255, 85, 145, 141),
                            child: Icon(
                              Icons.arrow_downward,
                              color: Colors.white,
                              size: 19.sp,
                            ),
                          ),
                          SizedBox(width: 7.w),
                          Text(
                            'Income',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16.sp,
                              color: const Color.fromARGB(255, 216, 216, 216),
                            ),
                          ),
                        ],
                      ),
                       Row(
                        children: [
                          CircleAvatar(
                            radius: 13.r,
                            backgroundColor: const Color.fromARGB(255, 85, 145, 141),
                            child: Icon(
                              Icons.arrow_upward,
                              color: Colors.white,
                              size: 19.sp,
                            ),
                          ),
                          SizedBox(width: 7.w),
                          Text(
                            'Expenses',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16.sp,
                              color: const Color.fromARGB(255, 216, 216, 216),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 6.h),
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 30.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$ ${calculateIncome(transactions)}',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 17.sp,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        '\$ ${calculateExpenses(transactions)}',
                        style:  TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 17.sp,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
