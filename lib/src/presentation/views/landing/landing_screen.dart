import 'package:bills_repository/bills_repository.dart';
import 'package:expense_repository/expense_repository.dart';
import 'package:financeapp/src/presentation/blocs/add_bills_bloc/add_bills_bloc.dart';
import 'package:financeapp/src/presentation/blocs/add_expense_bloc/add_expense_bloc.dart';
import 'package:financeapp/src/presentation/blocs/chart_page_bloc/chart_page_bloc.dart';
import 'package:financeapp/src/presentation/blocs/get_bills_bloc/get_bills_bloc.dart';
import 'package:financeapp/src/presentation/blocs/landing_page_bloc/landing_page_bloc.dart';
import 'package:financeapp/src/presentation/views/add_bills/add_bills_screen.dart';
import 'package:financeapp/src/presentation/views/add_expense/add_expense_screen.dart';
import 'package:financeapp/src/presentation/views/charts/charts_screen.dart';
import 'package:financeapp/src/presentation/views/home/home_screen.dart';
import 'package:financeapp/src/presentation/views/my_bills/my_bills_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

List<BottomNavigationBarItem> bottomNavItems = const <BottomNavigationBarItem>[
  BottomNavigationBarItem(
    icon: Icon(Icons.home_outlined),
    label: 'Home',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.money),
    label: 'Add Expense',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.list),
    label: 'Add Bills',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.list_rounded),
    label: 'My Bills',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.auto_graph),
    label: 'Statistics',
  ),
];

List<Widget> bottomNavScreen = <Widget>[
  BlocProvider<ChartPageBloc>(
    create: (context) => ChartPageBloc(
      expenseRepository: FirebaseExpenseRepository(),
    )..add(GetChartData()),
    child: const HomeScreen(),
  ),
  BlocProvider<AddExpenseBloc>(
    create: (context) => AddExpenseBloc(
      expenseRepository: FirebaseExpenseRepository(),
    ),
    child: const AddExpenseScreen(),
  ),
  BlocProvider<AddBillsBloc>(
    create: (context) =>
        AddBillsBloc(billsRepository: FirebaseBillRepository()),
    child: const AddBillsScreen(),
  ),
  BlocProvider<GetBillsBloc>(
    create: (context) => GetBillsBloc(
      billsRepository: FirebaseBillRepository(),
    )..add(GetBillsData()),
    child: const MyBillsScreen(),
  ),
  BlocProvider<ChartPageBloc>(
    create: (context) => ChartPageBloc(
      expenseRepository: FirebaseExpenseRepository(),
    )..add(GetChartData()),
    child: const ChartScreen(),
  ),
  // Text('Index 2: Search'),
];

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LandingPageBloc, LandingPageState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            body: Center(child: bottomNavScreen.elementAt(state.tabIndex)),
            bottomNavigationBar: BottomNavigationBar(
              items: bottomNavItems,
              currentIndex: state.tabIndex,
              selectedItemColor: Theme.of(context).colorScheme.primary,
              unselectedItemColor: Colors.grey,
              onTap: (index) {
                context.read<LandingPageBloc>().add(TabChange(tabIndex: index));
              },
            ),
          );
        });
  }
}
