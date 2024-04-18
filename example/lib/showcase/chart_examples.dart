import 'package:flutter/material.dart';
import 'package:vc_product_widgets/components/chart/vc_product_chart.dart';

class ChartExamples extends StatefulWidget {
  const ChartExamples({Key? key}) : super(key: key);

  @override
  State<ChartExamples> createState() => _ChartExamplesState();
}

class _ChartExamplesState extends State<ChartExamples> {
  List<PieChartSectionData> pieChartData = [
    PieChartSectionData(
      color: Colors.red,
      value: 40,
      title: "40%",
      radius: 100,
    ),
    PieChartSectionData(
      color: Colors.green,
      value: 30,
      title: "30%",
      radius: 100,
    ),
    PieChartSectionData(
      color: Colors.blue,
      value: 15,
      title: "15%",
      radius: 100,
    ),
    PieChartSectionData(
      color: Colors.yellow,
      value: 15,
      title: "15%",
      radius: 100,
    ),
  ];

  List<PieChartSectionData> donutChartData = [
    PieChartSectionData(
      color: Colors.red,
      value: 40,
      title: "40%",
      radius: 50,
    ),
    PieChartSectionData(
      color: Colors.green,
      value: 30,
      title: "30%",
      radius: 50,
    ),
    PieChartSectionData(
      color: Colors.blue,
      value: 15,
      title: "15%",
      radius: 50,
    ),
    PieChartSectionData(
      color: Colors.yellow,
      value: 15,
      title: "15%",
      radius: 50,
    ),
  ];

  List<LineChartBarData> lineChartData = [
    LineChartBarData(
      spots: [
        const FlSpot(0, 1),
        const FlSpot(1, 4),
        const FlSpot(2, 3.5),
        const FlSpot(3, 5),
        const FlSpot(4, 4),
        const FlSpot(5, 6),
      ],
      isCurved: true,
      barWidth: 5,
    ),
    LineChartBarData(spots: [
      const FlSpot(0, 1),
      const FlSpot(1, 2),
      const FlSpot(2, 1.5),
      const FlSpot(3, 3),
      const FlSpot(4, 2.5),
      const FlSpot(5, 4),
      const FlSpot(6, 3),
    ], isCurved: true, barWidth: 5, color: Colors.red),
  ];

  List<BarChartGroupData> barChartData = [
    BarChartGroupData(
      x: 0,
      barRods: [
        BarChartRodData(
          toY: 8,
          color: Colors.red,
        ),
      ],
    ),
    BarChartGroupData(
      x: 1,
      barRods: [
        BarChartRodData(
          toY: 3,
          color: Colors.yellow,
        ),
      ],
    ),
    BarChartGroupData(
      x: 2,
      barRods: [
        BarChartRodData(
          toY: 5,
          color: Colors.green,
        ),
      ],
    ),
    BarChartGroupData(
      x: 3,
      barRods: [
        BarChartRodData(
          toY: 1,
          color: Colors.blue,
        ),
      ],
    ),
  ];

  @override
  void initState() {
    super.initState();
  }

  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            getTitle("Pie"),
            AspectRatio(
              aspectRatio: 16 / 9,
              child: VCProductChart.pie(
                pieTouchData: PieTouchData(
                  touchCallback: (FlTouchEvent event, pieTouchResponse) {
                    setState(() {
                      if (!event.isInterestedForInteractions ||
                          pieTouchResponse == null ||
                          pieTouchResponse.touchedSection == null) {
                        touchedIndex = -1;
                        return;
                      }
                      touchedIndex =
                          pieTouchResponse.touchedSection!.touchedSectionIndex;

                      pieChartData = List.generate(
                        pieChartData.length,
                        (index) {
                          final isTouched = index == touchedIndex;
                          final double opacity = isTouched ? 1 : 0.6;
                          return pieChartData[index].copyWith(
                            color:
                                pieChartData[index].color.withOpacity(opacity),
                          );
                        },
                      );
                    });
                  },
                ),
                pieChartData: pieChartData,
              ),
            ),
            getTitle("Donut"),
            AspectRatio(
              aspectRatio: 16 / 9,
              child: VCProductChart.donut(
                pieChartData: donutChartData,
                centerSpaceRadius: 50,
              ),
            ),
            getTitle("Line"),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: VCProductChart.line(
                  lineChartData: lineChartData,
                  gridData: const FlGridData(show: false),
                  borderData: FlBorderData(
                    border: const Border(
                      bottom: BorderSide(color: Colors.black, width: 4),
                      left: BorderSide(color: Colors.black, width: 4),
                      right: BorderSide(color: Colors.transparent),
                      top: BorderSide(color: Colors.transparent),
                    ),
                  ),
                  titlesData: const FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles:
                          SideTitles(showTitles: true, reservedSize: 30),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: true),
                    ),
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                ),
              ),
            ),
            getTitle("Bar"),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: VCProductChart.bar(
                  barChartData: barChartData,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8),
      child: Container(
        width: MediaQuery.of(context).size.width,
        color: Colors.grey.shade200,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
