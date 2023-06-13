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
    const headingTextStyle =
        TextStyle(fontSize: 12, fontWeight: FontWeight.w800);
    const dataTextStyle = TextStyle(fontSize: 12);

    return DataTable(
      dataRowMaxHeight: 20,
      dataRowMinHeight: 15,
      horizontalMargin: 30,
      dividerThickness: 0.5,
      headingRowHeight: 20,
      // TODO: check why it is not render properly on Windows desktop, but Android and Web
      // dataTextStyle: dataTextStyle,
      // headingTextStyle: headingTextStyle,
      columns: const [
        // TODO: remove style settings when dataTextStyle and headingTextStyle issue is resolved
        DataColumn(label: Text('#', style: headingTextStyle)),
        DataColumn(label: Text('Lap', style: headingTextStyle)),
        DataColumn(label: Text('Difference', style: headingTextStyle)),
      ],
      rows: List.generate(
        laps.length,
        (index) => DataRow(cells: [
          // TODO: remove style settings when dataTextStyle and headingTextStyle issue is resolved
          DataCell(
            Text(index.toString(), style: dataTextStyle),
          ),
          DataCell(
            Text(laps[index].formatElapsed(), style: dataTextStyle),
          ),
          DataCell(
            Text(laps[index].formatPreviousLapDifference(),
                style: dataTextStyle),
          ),
        ]),
      ),
    );
  }
}
