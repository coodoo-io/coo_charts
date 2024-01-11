import 'package:coo_charts_example/linechart_demo.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
      home: Scaffold(
    body: LineChartDemo(),
    backgroundColor: Colors.black,
  )));
}

class LineChartScrollAndTabDemo extends StatefulWidget {
  const LineChartScrollAndTabDemo({super.key});

  @override
  State<LineChartScrollAndTabDemo> createState() => _LineChartScrollAndTabDemoState();
}

class _LineChartScrollAndTabDemoState extends State<LineChartScrollAndTabDemo> {
  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.center, children: [
      Container(
        color: Colors.blue,
        child: const SizedBox(
          height: 50,
          child: Row(),
        ),
      ),
      // Container(
      //   width: double.infinity,
      //   height: 600,
      //   color: Colors.black,
      //   CooLineChart(dataSeries: dataSeries),
      // )
    ]);
  }
}
