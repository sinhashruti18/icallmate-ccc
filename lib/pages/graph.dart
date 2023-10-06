// import 'package:charts_flutter/flutter.dart' as charts;
// import 'package:flutter/material.dart';

// class PopulationData {
//   int year;
//   int? population;
//   charts.Color barColor;
//   PopulationData({required this.year, this.population, required this.barColor});
// }

// class MyGraph extends StatefulWidget {
//    MyGraph({Key? key}) : super(key: key);

//   @override
//   State<MyGraph> createState() => _MyGraphState();
// }

// class _MyGraphState extends State<MyGraph> {
//   final List<PopulationData> data = [
//     PopulationData(
//         year: 1880,
//         population: 0,
//         barColor: charts.ColorUtil.fromDartColor(Colors.lightBlue)),
//     PopulationData(
//         year: 1890,
//         population: 0,
//         barColor: charts.ColorUtil.fromDartColor(Colors.lightBlue)),
//     PopulationData(
//         year: 1900,
//         population: 0,
//         barColor: charts.ColorUtil.fromDartColor(Colors.lightBlue)),
//     PopulationData(
//         year: 1910,
//         population: 92228496,
//         barColor: charts.ColorUtil.fromDartColor(Colors.lightBlue)),
//     PopulationData(
//         year: 1920,
//         population: 0,
//         barColor: charts.ColorUtil.fromDartColor(Colors.blue)),
//     PopulationData(
//         year: 1930,
//         population: 123202624,
//         barColor: charts.ColorUtil.fromDartColor(Colors.blue)),
//     PopulationData(
//         year: 1940,
//         population: 0,
//         barColor: charts.ColorUtil.fromDartColor(Colors.blue)),
//     PopulationData(
//         year: 1950,
//         population: 0,
//         barColor: charts.ColorUtil.fromDartColor(Colors.blue)),
//     PopulationData(
//         year: 1960,
//         population: 0,
//         barColor: charts.ColorUtil.fromDartColor(Colors.blue)),
//     PopulationData(
//         year: 1970,
//         population: 0,
//         barColor: charts.ColorUtil.fromDartColor(Colors.purple)),
//     PopulationData(
//         year: 1980,
//         population: 0,
//         barColor: charts.ColorUtil.fromDartColor(Colors.purple)),
//     PopulationData(
//         year: 1990,
//         population: 0,
//         barColor: charts.ColorUtil.fromDartColor(Colors.purple)),
//     PopulationData(
//         year: 2000,
//         population: 0,
//         barColor: charts.ColorUtil.fromDartColor(Colors.purple)),
//     PopulationData(
//         year: 2010,
//         population: 0,
//         barColor: charts.ColorUtil.fromDartColor(Colors.black)),
//     PopulationData(
//         year: 2017,
//         population: 0,
//         barColor: charts.ColorUtil.fromDartColor(Colors.black)),
//   ];
//   _getSeriesData() {
//     List<charts.Series<PopulationData, String>> series = [
//       charts.Series(
//           id: "Population",
//           data: data,
//           domainFn: (PopulationData series, _) => series.year.toString(),
//           measureFn: (PopulationData series, _) => series.population,
//           colorFn: (PopulationData series, _) => series.barColor)
//     ];
//     return series;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Bar Chart Example'),
//         centerTitle: true,
//       ),
//       body: Center(
//         child: Container(
//           height: 400,
//           padding: EdgeInsets.all(20),
//           child: Card(
//             child: Padding(
//               padding:  EdgeInsets.all(8.0),
//               child: Column(
//                 children: <Widget>[
//                    Text(
//                     "Population of U.S. over the years",
//                     style: TextStyle(fontWeight: FontWeight.bold),
//                   ),
//                    SizedBox(
//                     height: 20,
//                   ),
//                   Expanded(
//                     child: charts.BarChart(
//                       _getSeriesData(),
//                       animate: true,
//                       domainAxis: charts.OrdinalAxisSpec(
//                           renderSpec:
//                               charts.SmallTickRendererSpec(labelRotation: 60)),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
