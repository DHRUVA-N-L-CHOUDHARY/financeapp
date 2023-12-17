import 'package:expense_repository/expense_repository.dart';
import 'package:financeapp/src/presentation/blocs/chart_page_bloc/chart_page_bloc.dart';
import 'package:financeapp/src/presentation/widgets/chart.dart';
import 'package:financeapp/src/utils/extensions/utlity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChartScreen extends StatefulWidget {
  const ChartScreen({super.key});

  @override
  State<ChartScreen> createState() => _ChartScreenState();
}

class _ChartScreenState extends State<ChartScreen> {
  List day = ['Day', 'Week', 'Month', 'Year'];
  int index_color = 0;
  List<Expense> a = [];

  void _onPeriodChange(int index, List<Expense> expense) {
    setState(() {
      index_color = index;
      if (index_color == 0) {
        a = today(expense);
      } else if (index_color == 1) {
        a = week(expense);
      } else if (index_color == 2) {
        a = month(expense);
      } else {
        a = year(expense);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChartPageBloc, ChartPageState>(
      builder: (context, state) {
        if (state is ChartPageSucess) {
          return Scaffold(
            body: SafeArea(
              child: custom(state.salesData),
            ),
          );
        } else if (state is ChartPostLoading) {
          return CircularProgressIndicator();
        } else if (state is ChartPostFailure) {
          return Text("Error");
        } else {
          return Text("");
        }
      },
    );
  }

  CustomScrollView custom(List<Expense> expense) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Center(
                child: Text(
                  'Statistics',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ...List.generate(
                      4,
                      (index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              index_color = index;
                            });
                            _onPeriodChange(index, expense);
                          },
                          child: Container(
                            height: 40,
                            width: 80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: index_color == index
                                  ? Color.fromARGB(255, 47, 125, 121)
                                  : Colors.white,
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              day[index],
                              style: TextStyle(
                                color: index_color == index
                                    ? Colors.white
                                    : Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Chart(
                indexx: index_color,
                expense: a,
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  'Top Spending',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
        SliverList(
            delegate: SliverChildBuilderDelegate(
          (context, index) {
            return ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.asset('assets/images/${a[index].expenseName}.png',
                    height: 40),
              ),
              title: Text(
                a[index].expenseName,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
              ),
              subtitle: Text(
                ' ${a[index].createAt.year}-${a[index].createAt.day}-${a[index].createAt.month}',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              trailing: Text(
                a[index].expenseCost,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 19,
                  color: a[index].expenseType == 'Income'
                      ? Colors.green
                      : Colors.red,
                ),
              ),
            );
          },
          childCount: a.length,
        ))
      ],
    );
  }
}
