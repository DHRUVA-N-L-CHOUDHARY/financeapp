// ignore_for_file: must_be_immutable

import 'package:expense_repository/expense_repository.dart';
import 'package:financeapp/src/utils/extensions/utlity.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Chart extends StatefulWidget {
  int indexx;
  List<Expense> expense;
  Chart({Key? key, required this.indexx, required this.expense}) : super(key: key);

  @override
  State<Chart> createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  List<Expense>? a;
  var b ;
  bool j = true;
  @override
  Widget build(BuildContext context) {
    switch (widget.indexx) {
      case 0:
        a = today(widget.expense);
        b = (Expense sales, _) => sales.createAt.hour;
        break;
      case 1:
        a = week(widget.expense);
        b = (Expense sales, _) => sales.createAt.day;
        j = true;
        break;
      case 2:
        a = month(widget.expense);
        b = (Expense sales, _) => sales.createAt.weekday;
        j = true;
        break;
      case 3:
        a = year(widget.expense);
        b = (Expense sales, _) => sales.createAt.month;
        j = false;
        break;
      default:
    }
    return Container(
      width: double.infinity,
      height: 300,
      child:  SfCartesianChart(
              primaryXAxis: CategoryAxis(),
              series: <SplineSeries<Expense, int>>[
                SplineSeries<Expense, int>(
                  color:  Color.fromARGB(255, 47, 125, 121),
                  width: 3,
                  dataSource: widget.expense,
                  xValueMapper: b,
                  yValueMapper: (Expense sales, _) => double.parse(sales.expenseCost),
                )
              ],
            ),
    );
  }
}

class SalesData {
  SalesData(this.year, this.expenseCost);
  final String year;
  final int expenseCost;
}
