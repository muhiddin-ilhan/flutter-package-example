import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

// Exporting the fl_chart package classes for external use
export 'package:fl_chart/fl_chart.dart';

/// Chart types
enum ChartType { pie, donut, bar, line }

class VCProductChart extends StatefulWidget {
  /// Chart type
  final ChartType type;

  /// Pie chart data
  /// [PieChartSectionData] is a class that holds data for drawing each section in the pie chart.
  final List<PieChartSectionData>? pieChartData;

  /// Pie chart sections space
  /// The space between each section in the pie chart.
  final double? pieChartSectionsSpace;

  /// Pie chart touch data
  /// [PieTouchData] is a class that holds data for handling touch events on the pie chart.
  /// It is used to enable/disable touch events and to handle touch events.
  final PieTouchData? pieTouchData;

  /// Donut chart center space radius
  /// The radius of the center space in the donut chart.
  final double? centerSpaceRadius;

  /// Line chart data
  /// [LineChartBarData] is a class that holds data for drawing each bar in the line chart.
  /// [LineChartBarData] is used to draw each bar in the line chart.
  final List<LineChartBarData> lineChartData;

  /// Min and max values for the chart
  /// [maxY] is the maximum value for the y axis.
  /// [minY] is the minimum value for the y axis.
  /// [maxX] is the maximum value for the x axis.
  /// [minX] is the minimum value for the x axis.
  final double? maxY;
  final double? maxX;
  final double? minY;
  final double? minX;

  /// Baseline values for the chart
  /// [baselineY] is the baseline value for the y axis.
  /// [baselineX] is the baseline value for the x axis.
  final double? baselineX;
  final double? baselineY;

  /// Between bars data
  /// [BetweenBarsData] is a class that holds data for drawing between bars in the line chart.
  final List<BetweenBarsData> betweenBarsData;

  /// Clip data
  /// [FlClipData] is a class that holds data for clipping the line chart.
  final FlClipData? clipData;

  /// Extra lines data
  /// [ExtraLinesData] is a class that holds data for drawing extra lines in the line chart.
  final ExtraLinesData? extraLinesData;

  /// Line touch data
  /// [LineTouchData] is a class that holds data for handling touch events on the line chart.
  final LineTouchData lineTouchData;

  /// Border data
  /// [FlBorderData] is a class that holds data for drawing the border of the line chart.
  final FlBorderData? borderData;

  /// Grid data
  /// [FlGridData] is a class that holds data for drawing the grid of the line chart.
  final FlGridData? gridData;

  /// Range annotations
  /// [RangeAnnotations] is a class that holds data for drawing range annotations in the line chart.
  final RangeAnnotations? rangeAnnotations;

  /// Showing tooltip indicators
  /// You can show some tooltipIndicators (a popup with an information) on top of each [LineChartBarData.spots] using [showingTooltipIndicators], just put line indicator number and spots indices you want to show it on top of them.
  final List<ShowingTooltipIndicators> showingTooltipIndicators;

  /// Titles data
  ///  [FlTitlesData] is a class that holds data for drawing the titles of the line chart.
  /// It is used to draw the titles of the line chart.
  final FlTitlesData titlesData;

  /// Donut chart center space color
  /// [centerSpaceColor] is the color of the center space in the donut chart.
  final Color? centerSpaceColor;

  /// Donut/Pie chart start degree offset
  /// [startDegreeOffset] is the start degree offset for the donut/pie chart.
  final double? startDegreeOffset;

  /// Line chart background color
  /// [backgroundColor] is the background color for the line chart.
  final Color? backgroundColor;

  /// Bar chart data
  /// [BarChartGroupData] is a class that holds data for drawing each group in the bar chart.
  /// [BarChartGroupData] is used to draw each group in the bar chart.
  final List<BarChartGroupData>? barChartData;

  /// Bar touch data
  /// [BarTouchData] is a class that holds data for handling touch events on the bar chart.
  final BarTouchData? barTouchData;

  /// Bar chart alignment
  /// [BarChartAlignment] is a class that holds data for aligning the bars in the bar chart.
  final BarChartAlignment? alignment;

  /// Bar chart groups space
  /// [groupsSpace] is the space between each group in the bar chart.
  final double? groupsSpace;

  /// Private constructor
  /// Use the factory constructors instead
  const VCProductChart._(
      {Key? key,
      required this.type,
      this.pieChartData,
      this.pieChartSectionsSpace,
      this.pieTouchData,
      this.centerSpaceRadius,
      this.lineChartData = const [],
      this.maxY,
      this.minY,
      this.maxX,
      this.minX,
      this.centerSpaceColor,
      this.backgroundColor,
      this.baselineX,
      this.baselineY,
      this.betweenBarsData = const [],
      this.clipData,
      this.extraLinesData,
      this.lineTouchData = const LineTouchData(enabled: false),
      this.borderData,
      this.gridData,
      this.rangeAnnotations,
      this.showingTooltipIndicators = const [],
      this.titlesData = const FlTitlesData(),
      this.barChartData,
      this.barTouchData,
      this.alignment,
      this.groupsSpace,
      this.startDegreeOffset})
      : super(key: key);

  /// Pie chart factory constructor
  /// [pieChartData] is a list of [PieChartSectionData] that holds data for drawing each section in the pie chart.
  /// [pieChartSectionsSpace] is the space between each section in the pie chart.
  factory VCProductChart.pie({
    Key? key,

    /// Pie chart data
    /// [PieChartSectionData] is a class that holds data for drawing each section in the pie chart.
    /// [PieChartSectionData] is used to draw each section in the pie chart.
    List<PieChartSectionData>? pieChartData,

    /// Pie chart sections space
    /// The space between each section in the pie chart.
    /// [pieChartSectionsSpace] is the space between each section in the pie chart.
    double? pieChartSectionsSpace = 0,

    /// Pie chart touch data
    /// [PieTouchData] is a class that holds data for handling touch events on the pie chart.
    /// It is used to enable/disable touch events and to handle touch events.
    PieTouchData? pieTouchData,

    /// Border data
    /// [FlBorderData] is a class that holds data for drawing the border of the pie chart.
    FlBorderData? borderData,

    /// Start degree offset
    /// [startDegreeOffset] is the start degree offset for the pie chart.
    double? startDegreeOffset,
  }) =>
      VCProductChart._(
        key: key,
        type: ChartType.pie,
        pieChartData: pieChartData,
        pieChartSectionsSpace: pieChartSectionsSpace,
        pieTouchData: pieTouchData,
        borderData: borderData,
        startDegreeOffset: startDegreeOffset,
      );

  /// Donut chart factory constructor
  /// [pieChartData] is a list of [PieChartSectionData] that holds data for drawing each section in the donut chart.
  /// [pieChartSectionsSpace] is the space between each section in the donut chart.
  /// [centerSpaceRadius] is the radius of the center space in the donut chart.
  /// [pieTouchData] is a class that holds data for handling touch events on the donut chart.
  factory VCProductChart.donut({
    Key? key,

    /// Pie chart data
    /// [PieChartSectionData] is a class that holds data for drawing each section in the donut chart.
    /// [PieChartSectionData] is used to draw each section in the donut chart.
    List<PieChartSectionData>? pieChartData,

    /// Pie chart sections space
    /// The space between each section in the donut chart.
    /// [pieChartSectionsSpace] is the space between each section in the donut chart.
    double? pieChartSectionsSpace = 0,

    /// Pie chart touch data
    /// [PieTouchData] is a class that holds data for handling touch events on the donut chart.
    /// It is used to enable/disable touch events and to handle touch events.
    PieTouchData? pieTouchData,

    /// Donut chart center space radius
    /// The radius of the center space in the donut chart.
    /// [centerSpaceRadius] is the radius of the center space in the donut chart.
    double? centerSpaceRadius = 10,

    /// Donut chart center space color
    /// The color of the center space in the donut chart.
    /// [centerSpaceColor] is the color of the center space in the donut chart.
    Color? centerSpaceColor,

    /// Border data
    /// [FlBorderData] is a class that holds data for drawing the border of the donut chart.
    FlBorderData? borderData,

    /// Start degree offset
    /// [startDegreeOffset] is the start degree offset for the donut chart.
    double? startDegreeOffset,
  }) =>
      VCProductChart._(
        key: key,
        type: ChartType.donut,
        pieChartData: pieChartData,
        pieChartSectionsSpace: pieChartSectionsSpace,
        pieTouchData: pieTouchData,
        centerSpaceRadius: centerSpaceRadius,
        centerSpaceColor: centerSpaceColor,
        borderData: borderData,
        startDegreeOffset: startDegreeOffset,
      );

  factory VCProductChart.line({
    Key? key,

    /// Line chart data
    /// [LineChartBarData] is a class that holds data for drawing each bar in the line chart.
    /// [LineChartBarData] is used to draw each bar in the line chart.
    required List<LineChartBarData> lineChartData,

    /// Min and max values for the chart
    /// [maxY] is the maximum value for the y axis.
    /// [minY] is the minimum value for the y axis.
    /// [maxX] is the maximum value for the x axis.
    /// [minX] is the minimum value for the x axis.
    double? maxY,
    double? maxX,
    double? minY,
    double? minX,

    /// Background color
    /// [backgroundColor] is the background color for the line chart.
    Color? backgroundColor,

    /// Baseline values for the chart
    /// [baselineY] is the baseline value for the y axis.
    /// [baselineX] is the baseline value for the x axis.
    double? baselineX,
    double? baselineY,

    /// Between bars data
    /// [BetweenBarsData] is a class that holds data for drawing between bars in the line chart.
    /// Fills area between two [LineChartBarData] with a color or gradient.
    List<BetweenBarsData> betweenBarsData = const [],

    /// Clip data
    /// [FlClipData] is a class that holds data for clipping the line chart.
    FlClipData? clipData,

    /// Extra lines data
    /// [ExtraLinesData] is a class that holds data for drawing extra lines in the line chart.
    ExtraLinesData? extraLinesData,

    /// Line touch data
    /// [LineTouchData] is a class that holds data for handling touch events on the line chart.
    LineTouchData lineTouchData = const LineTouchData(),

    /// Border data
    /// [FlBorderData] is a class that holds data for drawing the border of the line chart.
    FlBorderData? borderData,

    /// Grid data
    /// [FlGridData] is a class that holds data for drawing the grid of the line chart.
    FlGridData? gridData,

    /// Range annotations
    /// [RangeAnnotations] is a class that holds data for drawing range annotations in the line chart.
    RangeAnnotations? rangeAnnotations,

    /// Showing tooltip indicators
    /// You can show some tooltipIndicators (a popup with an information) on top of each [LineChartBarData.spots] using [showingTooltipIndicators], just put line indicator number and spots indices you want to show it on top of them.
    List<ShowingTooltipIndicators> showingTooltipIndicators = const [],

    /// Titles data
    /// [FlTitlesData] is a class that holds data for drawing the titles of the line chart.
    FlTitlesData titlesData = const FlTitlesData(),
  }) =>
      VCProductChart._(
        key: key,
        type: ChartType.line,
        lineChartData: lineChartData,
        maxY: maxY,
        maxX: maxX,
        minY: minY,
        minX: minX,
        backgroundColor: backgroundColor,
        baselineX: baselineX,
        baselineY: baselineY,
        betweenBarsData: betweenBarsData,
        clipData: clipData,
        extraLinesData: extraLinesData,
        lineTouchData: lineTouchData,
        borderData: borderData,
        gridData: gridData,
        rangeAnnotations: rangeAnnotations,
        showingTooltipIndicators: showingTooltipIndicators,
        titlesData: titlesData,
      );

  factory VCProductChart.bar(
          {Key? key,

          /// Bar chart data
          /// [BarChartGroupData] is a class that holds data for drawing each group in the bar chart.
          /// [BarChartGroupData] is used to draw each group in the bar chart.
          List<BarChartGroupData>? barChartData,

          /// Background color
          /// [backgroundColor] is the background color for the bar chart.
          Color? backgroundColor,

          /// Titles data
          /// [FlTitlesData] is a class that holds data for drawing the titles of the bar chart.
          FlTitlesData titlesData = const FlTitlesData(),

          /// Border data
          /// [FlBorderData] is a class that holds data for drawing the border of the bar chart.
          FlBorderData? borderData,

          /// Grid data
          /// [FlGridData] is a class that holds data for drawing the grid of the bar chart.
          FlGridData? gridData,

          /// Min and max values for the chart
          /// [maxY] is the maximum value for the y axis.
          /// [minY] is the minimum value for the y axis.
          double? maxY,
          double? minY,

          /// Baseline values for the chart
          /// [baselineY] is the baseline value for the y axis.
          double? baselineY,

          /// Bar touch data
          /// [BarTouchData] is a class that holds data for handling touch events on the bar chart.
          BarTouchData? barTouchData,

          /// Bar chart alignment
          /// [BarChartAlignment] is a class that holds data for aligning the bars in the bar chart.
          BarChartAlignment? alignment,

          /// Bar chart groups space
          /// [groupsSpace] is the space between each group in the bar chart.
          double? groupsSpace,

          /// Extra lines data
          /// [ExtraLinesData] is a class that holds data for drawing extra lines in the bar chart.
          ExtraLinesData? extraLinesData,

          /// Range annotations
          /// [RangeAnnotations] is a class that holds data for drawing range annotations in the bar chart.
          RangeAnnotations? rangeAnnotations}) =>
      VCProductChart._(
        key: key,
        type: ChartType.bar,
        barChartData: barChartData,
        backgroundColor: backgroundColor,
        titlesData: titlesData,
        borderData: borderData,
        gridData: gridData,
        maxY: maxY,
        minY: minY,
        baselineY: baselineY,
        barTouchData: barTouchData,
        alignment: alignment,
        groupsSpace: groupsSpace,
        extraLinesData: extraLinesData,
        rangeAnnotations: rangeAnnotations,
      );

  @override
  State<VCProductChart> createState() => _VCProductChartState();
}

class _VCProductChartState extends State<VCProductChart> {
  @override
  Widget build(BuildContext context) {
    return getChart(widget.type);
  }

  /// Get chart
  /// [selectionMode] is the chart type
  /// [getChart] returns the chart widget based on the chart type
  Widget getChart(ChartType selectionMode) {
    switch (selectionMode) {
      case ChartType.pie:
        return getPieChart();
      case ChartType.donut:
        return getDonutChart();
      case ChartType.bar:
        return getBarChart();
      case ChartType.line:
        return getLineChart();
      default:
        return getPieChart();
    }
  }

  /// Get pie chart
  /// [getPieChart] returns the pie chart widget
  Widget getPieChart() {
    return PieChart(
      PieChartData(
        startDegreeOffset: widget.startDegreeOffset,
        borderData: widget.borderData,
        pieTouchData: widget.pieTouchData,
        sections: widget.pieChartData,
        centerSpaceRadius: 0,
        sectionsSpace: widget.pieChartSectionsSpace,
      ),
    );
  }

  /// Get donut chart
  /// [getDonutChart] returns the donut chart widget
  Widget getDonutChart() {
    return PieChart(
      PieChartData(
        startDegreeOffset: widget.startDegreeOffset,
        borderData: widget.borderData,
        centerSpaceColor: widget.centerSpaceColor,
        pieTouchData: widget.pieTouchData,
        sections: widget.pieChartData,
        centerSpaceRadius: widget.centerSpaceRadius,
        sectionsSpace: widget.pieChartSectionsSpace,
      ),
    );
  }

  /// Get bar chart
  /// [getBarChart] returns the bar chart widget
  Widget getBarChart() {
    return BarChart(
      BarChartData(
        barGroups: widget.barChartData,
        backgroundColor: widget.backgroundColor,
        titlesData: widget.titlesData,
        borderData: widget.borderData,
        gridData: widget.gridData,
        maxY: widget.maxY,
        minY: widget.minY,
        baselineY: widget.baselineY,
        barTouchData: widget.barTouchData,
        alignment: widget.alignment,
        extraLinesData: widget.extraLinesData,
        rangeAnnotations: widget.rangeAnnotations,
        groupsSpace: widget.groupsSpace,
      ),
      swapAnimationDuration: const Duration(milliseconds: 150), // Optional
      swapAnimationCurve: Curves.linear, // Optional
    );
  }

  /// Get line chart
  /// [getLineChart] returns the line chart widget
  Widget getLineChart() {
    return LineChart(
      LineChartData(
          lineBarsData: widget.lineChartData,
          minY: widget.minY,
          minX: widget.minX,
          maxX: widget.maxX,
          maxY: widget.maxY,
          backgroundColor: widget.backgroundColor,
          baselineX: widget.baselineX,
          baselineY: widget.baselineY,
          betweenBarsData: widget.betweenBarsData,
          clipData: widget.clipData,
          extraLinesData: widget.extraLinesData,
          lineTouchData: widget.lineTouchData,
          borderData: widget.borderData,
          gridData: widget.gridData,
          rangeAnnotations: widget.rangeAnnotations,
          showingTooltipIndicators: widget.showingTooltipIndicators,
          titlesData: widget.titlesData // Remove titles
          ),
    );
  }
}
