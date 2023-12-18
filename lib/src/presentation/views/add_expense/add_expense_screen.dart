// ignore_for_file: non_constant_identifier_names

import 'dart:developer';

import 'package:expense_repository/expense_repository.dart';
import 'package:financeapp/src/presentation/blocs/my_user_bloc/my_user_bloc.dart';
import 'package:financeapp/src/presentation/views/add_expense/add_expense_bloc/add_expense_bloc.dart';
import 'package:financeapp/src/utils/constants/app_constants.dart';
import 'package:financeapp/src/utils/extensions/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:user_repository/user_repository.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({super.key});

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  DateTime date = new DateTime.now();
  String? selctedItem;
  String? selctedItemi;
  final TextEditingController amount_c = TextEditingController();
  FocusNode amount_ = FocusNode();
  final _addexpensekey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    amount_.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    amount_c.dispose();
    amount_.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddExpenseBloc, AddExpenseState>(
      listener: (context, state) {
        if (state is AddExpenseSuccess) {
          showSuccessSnackBar(context, "Succesfull");
        } else if(state is AddExpenseFailure){
          showSuccessSnackBar(context, "Server Error", issuc: false);
        }
      },
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        body: SafeArea(
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              background_container(context),
              Positioned(
                top: 120.h,
                child: main_container(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container main_container() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        color: Colors.white,
      ),
      height: 550.h,
      width: 340.w,
      child: Form(
        key: _addexpensekey,
        child: Column(
          children: [
             SizedBox(height: 60.h),
            name(),
             SizedBox(height: 35.h),
            amount(),
           SizedBox(height: 35.h),
            How(),
            SizedBox(height: 35.h),
            date_time(),
             Spacer(),
            save(_addexpensekey),
            SizedBox(height: 40.h),
          ],
        ),
      ),
    );
  }

  Widget save(GlobalKey<FormState> formkey) {
    return BlocConsumer<MyUserBloc, MyUserState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state.status == MyUserStatus.success) {
          return GestureDetector(
            onTap: () {
              log("djldkfj");
              if (formkey.currentState!.validate() && selctedItem != null && selctedItemi != null) {
                Expense add = Expense(
                    expenseId: '',
                    expenseType: selctedItemi!,
                    expenseName: selctedItem!,
                    expenseCost: amount_c.text,
                    createAt: date,
                    myUser: MyUser(
                        userId: state.user!.userId,
                        email: state.user!.email,
                        name: state.user!.name));
                // expenselist.add(add);
                setState(() {
                  context.read<AddExpenseBloc>().add(AddExpense(add));
                  selctedItemi = null;
                  selctedItem = null;
                });
                amount_c.clear();

              } else {
                showSuccessSnackBar(
                    context, "Please Check all the fields Carefully",
                    issuc: false);
              }
              // Navigator.of(context).pop();
            },
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.r),
                color: const Color(0xff368983),
              ),
              width: 120.w,
              height: 50.h,
              child:  Text(
                'Save',
                style: TextStyle(
                  fontFamily: 'f',
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  fontSize: 17.sp,
                ),
              ),
            ),
          );
        } else {
          return GestureDetector(
            onTap: () {
              print("Please Login to the application");
            },
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: const Color(0xff368983),
              ),
              width: 120.w,
              height: 50.h,
              child:  Text(
                'Save',
                style: TextStyle(
                  fontFamily: 'f',
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  fontSize: 17.sp,
                ),
              ),
            ),
          );
        }
      },
    );
  }

  Widget date_time() {
    return Container(
      alignment: Alignment.bottomLeft,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 2.w, color: const Color(0xffC5C5C5))),
      width: 300,
      child: TextButton(
        onPressed: () async {
          DateTime? newDate = await showDatePicker(
              context: context,
              initialDate: date,
              firstDate: DateTime(2020),
              lastDate: DateTime(2100));
          if (newDate == Null) return;
          setState(() {
            date = newDate!;
          });
        },
        child: Text(
          'Date : ${date.year} / ${date.day} / ${date.month}',
          style: TextStyle(
            fontSize: 15.sp,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  Padding How() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        width: 300.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            width: 2.w,
            color: const Color(0xffC5C5C5),
          ),
        ),
        child: DropdownButton<String>(
          value: selctedItemi,
          onChanged: ((value) {
            setState(() {
              selctedItemi = value!;
            });
          }),
          items: itemei
              .map((e) => DropdownMenuItem(
                    value: e,
                    child: Container(
                      alignment: Alignment.center,
                      child: Row(
                        children: [
                          Text(
                            e,
                            style: TextStyle(fontSize: 18.sp),
                          )
                        ],
                      ),
                    ),
                  ))
              .toList(),
          selectedItemBuilder: (BuildContext context) => itemei
              .map((e) => Row(
                    children: [Text(e)],
                  ))
              .toList(),
          hint:  Padding(
            padding: EdgeInsets.only(top: 12.h),
            child: const Text(
              'Type',
              style: TextStyle(color: Colors.grey),
            ),
          ),
          dropdownColor: Colors.white,
          isExpanded: true,
          underline: Container(),
        ),
      ),
    );
  }

  Padding amount() {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 20.h),
      child: TextField(
        keyboardType: TextInputType.number,
        focusNode: amount_,
        controller: amount_c,
        decoration: InputDecoration(
          contentPadding:
               EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
          labelText: 'amount',
          labelStyle: TextStyle(fontSize: 17.sp, color: Colors.grey.shade500),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(width: 2.w, color: Color(0xffC5C5C5))),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(width: 2.w, color: Color(0xff368983))),
        ),
      ),
    );
  }

  Padding name() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        width: 300.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            width: 2.w,
            color: const Color(0xffC5C5C5),
          ),
        ),
        child: DropdownButton<String>(
          value: selctedItem,
          onChanged: ((value) {
            setState(() {
              selctedItem = value!;
            });
          }),
          items: item
              .map((e) => DropdownMenuItem(
                    value: e,
                    child: Container(
                      alignment: Alignment.center,
                      child: Row(
                        children: [
                          SizedBox(
                            width: 40.w,
                            child: Image.asset('assets/images/${e}.png'),
                          ),
                           SizedBox(width: 10.w),
                          Text(
                            e,
                            style:  TextStyle(fontSize: 18.sp),
                          )
                        ],
                      ),
                    ),
                  ))
              .toList(),
          selectedItemBuilder: (BuildContext context) => item
              .map((e) => Row(
                    children: [
                      SizedBox(
                        width: 42.w,
                        child: Image.asset('assets/images/${e}.png'),
                      ),
                      SizedBox(width: 5.w),
                      Text(e)
                    ],
                  ))
              .toList(),
          hint: Padding(
            padding: EdgeInsets.only(top: 12.h),
            child: const Text(
              'Name',
              style: TextStyle(color: Colors.grey),
            ),
          ),
          dropdownColor: Colors.white,
          isExpanded: true,
          underline: Container(),
        ),
      ),
    );
  }

  Column background_container(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 240.w,
          decoration:   BoxDecoration(
            color:const Color(0xff368983),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20.r),
              bottomRight: Radius.circular(20.r),
            ),
          ),
          child:  Column(
            children: [
              SizedBox(height: 40.h),
               Padding(
                padding: EdgeInsets.only(left: 16.0.w),
                child: Text(
                  'Add Transaction',
                  style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
