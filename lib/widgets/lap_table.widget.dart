import 'package:flutter/material.dart';
import 'package:stopwatch/classes/stopwatch_lap.dart';

class LapTableWidget extends StatelessWidget {
  const LapTableWidget({
    super.key,
    required this.laps,
  });

  final List<StopwatchLap> laps;

  @override
  Widget build(BuildContext context) {
    return DataTable(
      dataRowMaxHeight: 20,
      dataRowMinHeight: 15,
      horizontalMargin: 30,
      dividerThickness: 0.5,
      headingRowHeight: 20,
      dataTextStyle: const TextStyle(fontSize: 12),
      headingTextStyle:
          const TextStyle(fontSize: 12, fontWeight: FontWeight.w800),
      columns: const [
        DataColumn(label: Text('#')),
        DataColumn(label: Text('Lap')),
        DataColumn(label: Text('Difference')),
      ],
      rows: List.generate(
        laps.length,
        (index) => DataRow(cells: [
          DataCell(
            Text(index.toString()),
          ),
          DataCell(
            Text(laps[index].formatElapsed()),
          ),
          DataCell(
            Text(laps[index].formatPreviousLapDifference()),
          ),
        ]),
      ),
    );
  }
}
