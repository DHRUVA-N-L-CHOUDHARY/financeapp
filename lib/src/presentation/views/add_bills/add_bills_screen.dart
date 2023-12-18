import 'package:bills_repository/bills_repository.dart';
import 'package:financeapp/src/presentation/blocs/my_user_bloc/my_user_bloc.dart';
import 'package:financeapp/src/presentation/views/add_bills/add_bills_bloc/add_bills_bloc.dart';
import 'package:financeapp/src/utils/extensions/custom_snackbar.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:user_repository/user_repository.dart';

class AddBillsScreen extends StatefulWidget {
  const AddBillsScreen({super.key});

  @override
  State<AddBillsScreen> createState() => _AddBillsScreenState();
}

class _AddBillsScreenState extends State<AddBillsScreen> {
  DateTime date = new DateTime.now();
  DateTime duedate = new DateTime.now();
  final TextEditingController amount_c = TextEditingController();
  FocusNode amount_ = FocusNode();
  final TextEditingController name_c = TextEditingController();
  FocusNode name_ = FocusNode();
  final _addbillkey = GlobalKey<FormState>();
  String? fcmtoken;

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
    // TODO: implement initState
    super.dispose();
    amount_c.dispose();
    amount_.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddBillsBloc, AddBillsState>(
      listener: (context, state) {
        if (state is AddBillsSuccess) {
          showSuccessSnackBar(context, "Succesful");
        } else if (state is AddBillsFailure) {
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
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      height: 550,
      width: 340,
      child: Form(
        key: _addbillkey,
        child: Column(
          children: [
            SizedBox(height: 60.h),
            name(),
            SizedBox(height: 35.h),
            amount(),
            SizedBox(height: 35.h),
            dueDate(),
            SizedBox(height: 35.h),
            date_time(),
            const Spacer(),
            save(_addbillkey),
            SizedBox(height: 40.h),
          ],
        ),
      ),
    );
  }

  Widget save(GlobalKey<FormState> formkey) {
    return BlocConsumer<MyUserBloc, MyUserState>(
      listener: (context, state) async {
        fcmtoken = await FirebaseMessaging.instance.getToken();
      },
      builder: (context, state) {
        if (state.status == MyUserStatus.success) {
          return GestureDetector(
            onTap: () {
              if (formkey.currentState!.validate() && amount_c.text != "" && name_c.text != "") {
                Bill add = Bill(
                    billId: '',
                    dueDate: duedate,
                    billName: name_c.text,
                    billCost: amount_c.text,
                    createAt: date,
                    fcmtoken: fcmtoken ?? "",
                    myUser: MyUser(
                        userId: state.user!.userId,
                        email: state.user!.email,
                        name: state.user!.name));
                setState(() {
                  context.read<AddBillsBloc>().add(AddBills(add));
                });
                amount_c.clear();
                name_c.clear();
              } else {
                showSuccessSnackBar(
                    context, "Please Check all the fields Carefully",
                    issuc: false);
              }
            },
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: const Color(0xff368983),
              ),
              width: 120.w,
              height: 50.h,
              child: Text(
                'Add to List',
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
                borderRadius: BorderRadius.circular(15.r),
                color: const Color(0xff368983),
              ),
              width: 120.w,
              height: 50.h,
              child:  Text(
                'Add to List',
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
      width: 300.w,
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
          style:  TextStyle(
            fontSize: 15.sp,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  Widget dueDate() {
    return Container(
      alignment: Alignment.bottomLeft,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 2.w, color: const Color(0xffC5C5C5))),
      width: 300.w,
      child: TextButton(
        onPressed: () async {
          DateTime? newDate = await showDatePicker(
              context: context,
              initialDate: duedate,
              firstDate: DateTime(2020),
              lastDate: DateTime(2100));
          if (newDate == Null) return;
          setState(() {
            duedate = newDate!;
          });
        },
        child: Text(
          'Due Date : ${duedate.year} / ${duedate.day} / ${duedate.month}',
          style: TextStyle(
            fontSize: 15.sp,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  Padding amount() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        keyboardType: TextInputType.number,
        focusNode: amount_,
        controller: amount_c,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          labelText: 'Amount',
          labelStyle: TextStyle(fontSize: 17, color: Colors.grey.shade500),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: const BorderSide(width: 2, color: Color(0xffC5C5C5))),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: const BorderSide(width: 2, color: Color(0xff368983))),
        ),
      ),
    );
  }

  Padding name() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        keyboardType: TextInputType.name,
        focusNode: name_,
        controller: name_c,
        decoration: InputDecoration(
          contentPadding:
              EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
          labelText: 'Bill Name',
          labelStyle: TextStyle(fontSize: 17.sp, color: Colors.grey.shade500),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide:  BorderSide(width: 2.w, color: Color(0xffC5C5C5))),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(width: 2.w, color: Color(0xff368983))),
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
          decoration: BoxDecoration(
            color:  Color(0xff368983),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20.r),
              bottomRight: Radius.circular(20.r),
            ),
          ),
          child: Column(
            children: [
              SizedBox(height: 40.h),
              Padding(
                padding: EdgeInsets.only(left: 16.0.w),
                child: Text(
                  'Add Bill',
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
