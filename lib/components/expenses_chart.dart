import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:personalexpenses/classes/expenses_data.dart';
import 'package:personalexpenses/constants.dart';
import 'package:provider/provider.dart';

class ExpensesChartBar extends StatelessWidget {
  final double value;
  final String label;
  final double maxValue;

  ExpensesChartBar({this.value, this.maxValue, this.label});

  static const kBarHeight = 100.0;
  static const kBarWidth = 20.0;

  @override
  Widget build(BuildContext context) {
    print('$value : ${(value / maxValue) * kBarHeight}');
    return Column(
      children: [
        Text('\$$value'),
        Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            Container(
              width: kBarWidth,
              height: kBarHeight,
              decoration: BoxDecoration(
                color: kThemeColor.withOpacity(0.3),
                borderRadius: BorderRadius.all(Radius.circular(kBarWidth / 2)),
              ),
            ),
            Container(
              width: kBarWidth,
              height: (value / maxValue) * kBarHeight,
              decoration: BoxDecoration(
                color: kThemeColor,
                borderRadius: BorderRadius.all(Radius.circular(kBarWidth / 2)),
              ),
            )
          ],
        ),
        Text('$label'),
      ],
    );
  }
}

class ExpensesChart extends StatelessWidget {
  String dayLabel(int dayNumber) {
    switch (dayNumber) {
      case 1:
        return 'MO';
        break;
      case 2:
        return 'Tu';
        break;
      case 3:
        return 'We';
        break;
      case 4:
        return 'Th';
        break;
      case 5:
        return 'Fr';
        break;
      case 6:
        return 'Sa';
        break;
      case 7:
        return 'Su';
        break;
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10.0),
      elevation: 5.0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<ExpensesData>(
          builder: (context, expensesData, child) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List<ExpensesChartBar>.generate(7, (index) {
                return ExpensesChartBar(
                  value: expensesData.dayExpenses(index + 1),
                  label: dayLabel(index + 1),
                  maxValue: expensesData.maxDayExpenses(),
                );
              }),
            );
          },
        ),
      ),
    );
  }
}

/*
class ExpensesChart extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ExpensesChartState();
}

class ExpensesChartState extends State<ExpensesChart> {
  final Color barBackgroundColor = kThemeColor;
  final Duration animDuration = const Duration(milliseconds: 250);

  int touchedIndex;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        color: Colors.white,
        elevation: 5.0,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: BarChart(
                    mainBarData(),
                    swapAnimationDuration: animDuration,
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
            ],
          ),
        ),
      ),
    );
  }

  BarChartGroupData makeGroupData(
    int x,
    double y, {
    bool isTouched = false,
    Color barColor = Colors.white70,
    Color touchedBarColor = Colors.white10,
    double width = 22,
    List<int> showTooltips = const [],
  }) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          y: isTouched ? y + 1 : y,
          color: isTouched ? touchedBarColor : barColor,
          width: width,
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            y: 20,
            color: barBackgroundColor,
          ),
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }

  List<BarChartGroupData> showingGroups() => List.generate(7, (i) {
        switch (i) {
          case 0:
            return makeGroupData(0, 5, isTouched: i == touchedIndex);
          case 1:
            return makeGroupData(1, 6.5, isTouched: i == touchedIndex);
          case 2:
            return makeGroupData(2, 5, isTouched: i == touchedIndex);
          case 3:
            return makeGroupData(3, 7.5, isTouched: i == touchedIndex);
          case 4:
            return makeGroupData(4, 9, isTouched: i == touchedIndex);
          case 5:
            return makeGroupData(5, 11.5, isTouched: i == touchedIndex);
          case 6:
            return makeGroupData(6, 6.5, isTouched: i == touchedIndex);
          default:
            return null;
        }
      });

  BarChartData mainBarData() {
    return BarChartData(
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
            tooltipBgColor: Colors.blueGrey,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              String weekDay;
              switch (group.x.toInt()) {
                case 0:
                  weekDay = 'Monday';
                  break;
                case 1:
                  weekDay = 'Tuesday';
                  break;
                case 2:
                  weekDay = 'Wednesday';
                  break;
                case 3:
                  weekDay = 'Thursday';
                  break;
                case 4:
                  weekDay = 'Friday';
                  break;
                case 5:
                  weekDay = 'Saturday';
                  break;
                case 6:
                  weekDay = 'Sunday';
                  break;
              }
              return BarTooltipItem(weekDay + '\n' + (rod.y - 1).toString(), TextStyle(color: Colors.yellow));
            }),
        touchCallback: (barTouchResponse) {
          setState(() {
            if (barTouchResponse.spot != null &&
                barTouchResponse.touchInput is! FlPanEnd &&
                barTouchResponse.touchInput is! FlLongPressEnd) {
              touchedIndex = barTouchResponse.spot.touchedBarGroupIndex;
            } else {
              touchedIndex = -1;
            }
          });
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          textStyle: TextStyle(color: kThemeColor, fontWeight: FontWeight.bold, fontSize: 14),
          margin: 16,
          getTitles: (double value) {
            switch (value.toInt()) {
              case 0:
                return 'M';
              case 1:
                return 'T';
              case 2:
                return 'W';
              case 3:
                return 'T';
              case 4:
                return 'F';
              case 5:
                return 'S';
              case 6:
                return 'S';
              default:
                return '';
            }
          },
        ),
        leftTitles: SideTitles(
          showTitles: false,
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: showingGroups(),
    );
  }
}
*/

/*
class ExpensesChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
          barGroups: List.generate(7, (index) {
        return makeGroupData(index * 5, index * 10.0 + 1);
      })),
    );
  }
}

BarChartGroupData makeGroupData(
  int x,
  double y, {
  bool isTouched = false,
  Color barColor = kThemeColor,
  double width = 22,
  List<int> showTooltips = const [],
}) {
  return BarChartGroupData(
    x: x,
    barRods: [
      BarChartRodData(
        y: isTouched ? y + 1 : y,
        color: isTouched ? Colors.yellow : barColor,
        width: width,
        backDrawRodData: BackgroundBarChartRodData(
          show: true,
          y: ,
          color: Colors.grey,
        ),
      ),
    ],
    showingTooltipIndicators: showTooltips,
  );
}
*/
