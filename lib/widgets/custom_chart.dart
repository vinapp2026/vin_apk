import 'package:VIN/models/custom_model.dart';
import 'package:VIN/utilites/constants.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
class CustomChart extends StatefulWidget {
  const CustomChart({Key? key}) : super(key: key);

  @override
  State<CustomChart> createState() => _CustomChartState();
}

class _CustomChartState extends State<CustomChart> {

  late List<CustomModel> _chartData;
  var  rangeController;
  @override
  void initState() {
    super.initState();
    _chartData = profileScreenGraphList;
  }

  Widget lineChat(){
    // List<_ChartData> chartData = dailyTemperature.map((val)=>_ChartData.fromMap(val)).toList();
    return Container(
      child: SfCartesianChart(
          plotAreaBorderWidth: 0,
          selectionType: SelectionType.point,
          // Enable legend
          legend: Legend(isVisible: false),
          primaryXAxis: CategoryAxis(
            rangeController: rangeController,
            isVisible: true,
            majorGridLines: MajorGridLines(width: 0),
            //Hide the axis line of x-axis
            axisLine: AxisLine(width: 0),
          ),
          primaryYAxis: CategoryAxis(
            rangeController: rangeController,
            isVisible: true,
            majorGridLines: MajorGridLines(width: 0),
            //Hide the axis line of x-axis
            axisLine: AxisLine(width: 0),
          ),
          // Enable tooltip
          tooltipBehavior: TooltipBehavior(enable: true),
          series:
          <ChartSeries<CustomModel, String>>[
            StackedColumnSeries<CustomModel, String>(
                color: blueColor.withOpacity(0.7),
                dataSource: _chartData,
                xValueMapper: (CustomModel chartData, _)=>  chartData.months,
                yValueMapper: (CustomModel chartData, _) => chartData.streak,
                //name: 'DailyMoisture',
                animationDuration: 1000,
                markerSettings: MarkerSettings(isVisible: false),
                dataLabelSettings: DataLabelSettings(isVisible: false))
          ]),
    );
  }
  @override
  Widget build(BuildContext context) {
    return lineChat();
  }
}
