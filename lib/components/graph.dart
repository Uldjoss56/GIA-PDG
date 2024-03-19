import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:gia_pdg_partenaire/const/colors.dart';

/*
class BarChartSample extends StatelessWidget {
  final List<double> salesData;
  final List<String> periods;

  const BarChartSample({super.key, 
    required this.salesData,
    required this.periods,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.5,
      child: BarChart(
        BarChartData(
          titlesData: FlTitlesData(
            bottomTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                 return periods[value.toInt(),];
              },
              // getTextStyles: (value) => const TextStyle(
              //   color: Colors.black,
              //   fontWeight: FontWeight.bold,
              //   fontSize: 14,
              // ),
              // margin: 10,
              // getTitles: (double value) {
              //   return periods[value.toInt(),];
              // },
            ),
            leftTitles: SideTitles(
              showTitles: true,
              getTextStyles: (value) => const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
              margin: 10,
            ),
          ),
          borderData: FlBorderData(
            show: true,
            border: Border.all(color: Colors.black, width: 1),
          ),
          barGroups: List.generate(
            salesData.length,
            (index) => BarChartGroupData(
              x: index,
              barRods: [
                BarChartRodData(
                  y: salesData[index],
                  colors: [Colors.blue],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
*/

class MyLineChart extends StatelessWidget {
  const MyLineChart({super.key});

  @override
  Widget build(BuildContext context) {
    return LineChart(
      sampleData1,
      duration: const Duration(milliseconds: 250),
    );
  }
}

LineChartData get sampleData1 => LineChartData(
      gridData: gridData,
      titlesData: titlesData,
      borderData: borderData,
      lineBarsData: lineBarsDatas,
      minX: 0,
      maxX: 12,
      minY: 0,
      maxY: 12,
    );

List<LineChartBarData> get lineBarsDatas => [
      lineChartBarData1,
      lineChartBarData2,
    ];

FlTitlesData get titlesData => FlTitlesData(
      bottomTitles: AxisTitles(
        sideTitles: bottomTiles(),
      ),
      rightTitles: const AxisTitles(
        sideTitles: SideTitles(
          showTitles: false,
        ),
      ),
      topTitles: const AxisTitles(
        sideTitles: SideTitles(
          showTitles: false,
        ),
      ),
      leftTitles: AxisTitles(
        sideTitles: leftTiles(),
      ),
    );

Widget leftTilesWidget(double value, TitleMeta meta) {
  const style = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.bold,
    color: Colors.grey,
  );
  String text;
  switch (value.toInt()) {
    case 1:
      text = "1m";
      break;
    case 2:
      text = "2m";
      break;
    case 3:
      text = "3m";
      break;
    case 4:
      text = "4m";
      break;
    case 5:
      text = "5m";
      break;
    case 6:
      text = "6m";
      break;
    case 7:
      text = "7m";
      break;
    case 8:
      text = "8m";
      break;
    case 9:
      text = "9m";
      break;
    case 10:
      text = "10m";
      break;
    case 11:
      text = "11m";
      break;
    case 12:
      text = "12m";
      break;
    default:
      return Container();
  }
  return Text(
    text,
    style: style,
    textAlign: TextAlign.center,
  );
}

SideTitles leftTiles() {
  return const SideTitles(
    getTitlesWidget: leftTilesWidget,
    showTitles: true,
    interval: 1,
    reservedSize: 40,
  );
}

Widget bottomTilesWidget(double value, TitleMeta meta) {
  const style = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.bold,
    color: Colors.grey,
  );
  String text;
  Widget myWidget;
  switch (value.toInt()) {
    case 1:
      text = "jan";
      myWidget = Text(
        text,
        style: style,
        textAlign: TextAlign.center,
      );
      break;
    case 2:
      text = "fev";
      myWidget = Text(
        text,
        style: style,
        textAlign: TextAlign.center,
      );
      break;
    case 3:
      text = "mar";
      myWidget = Text(
        text,
        style: style,
        textAlign: TextAlign.center,
      );
      break;
    case 4:
      text = "avr";
      myWidget = Text(
        text,
        style: style,
        textAlign: TextAlign.center,
      );
      break;
    case 5:
      text = "mai";
      myWidget = Text(
        text,
        style: style,
        textAlign: TextAlign.center,
      );
      break;
    case 6:
      text = "jun";
      myWidget = Text(
        text,
        style: style,
        textAlign: TextAlign.center,
      );
      break;
    case 7:
      text = "jul";
      myWidget = Text(
        text,
        style: style,
        textAlign: TextAlign.center,
      );
      break;
    case 8:
      text = "aug";
      myWidget = Text(
        text,
        style: style,
        textAlign: TextAlign.center,
      );
      break;
    case 9:
      text = "sept";
      myWidget = Text(
        text,
        style: style,
        textAlign: TextAlign.center,
      );
      break;
    case 10:
      text = "oct";
      myWidget = Text(
        text,
        style: style,
        textAlign: TextAlign.center,
      );
      break;
    case 11:
      text = "nov";
      myWidget = Text(
        text,
        style: style,
        textAlign: TextAlign.center,
      );
      break;
    case 12:
      text = "dec";
      myWidget = Text(
        text,
        style: style,
        textAlign: TextAlign.center,
      );
      break;
    default:
      return const Text(
        "",
        style: style,
        textAlign: TextAlign.center,
      );
  }
  return SideTitleWidget(
    axisSide: meta.axisSide,
    space: 10,
    child: myWidget,
  );
}

SideTitles bottomTiles() {
  return const SideTitles(
    getTitlesWidget: bottomTilesWidget,
    showTitles: true,
    interval: 1,
    reservedSize: 32,
  );
}

FlGridData get gridData => const FlGridData(show: false);

FlBorderData get borderData => FlBorderData(
      show: true,
      border: const Border(
        bottom: BorderSide(
          color: Colors.grey,
          width: 4,
        ),
        left: BorderSide(
          color: Colors.grey,
        ),
        right: BorderSide(
          color: Colors.transparent,
        ),
        top: BorderSide(
          color: Colors.transparent,
        ),
      ),
    );

LineChartBarData get lineChartBarData1 => LineChartBarData(
      isCurved: true,
      color: myBlue,
      barWidth: 3,
      isStrokeCapRound: true,
      dotData: const FlDotData(
        show: true,
      ),
      belowBarData: BarAreaData(
        show: false,
      ),
      spots: [
        const FlSpot(1, 2),
        const FlSpot(2, 3),
        const FlSpot(3, 4),
        const FlSpot(5, 8),
        const FlSpot(6, 3),
      ],
    );

LineChartBarData get lineChartBarData2 => LineChartBarData(
      isCurved: true,
      color: myPink,
      barWidth: 3,
      isStrokeCapRound: true,
      dotData: const FlDotData(
        show: true,
      ),
      belowBarData: BarAreaData(
        show: false,
      ),
      spots: [
        const FlSpot(1, 0),
        const FlSpot(2, 6),
        const FlSpot(3, 6),
        const FlSpot(4, 6),
        const FlSpot(4.2, 6),
        const FlSpot(4.5, 6),
        const FlSpot(4.9, 6),
        const FlSpot(6, 6),
        const FlSpot(7, 6),
        const FlSpot(8, 6),
        const FlSpot(9, 12),
        const FlSpot(10, 9),
        const FlSpot(11, 1.3),
        const FlSpot(12, 1),
      ],
    );
