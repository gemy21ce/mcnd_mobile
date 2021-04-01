import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mcnd_mobile/di/providers.dart';
import 'package:mcnd_mobile/ui/prayer_times/prayer_times_model.dart';
import './prayer_times_model.dart';

class PrayerTimesWidget extends HookWidget {
  final PrayerTimesModelData viewData;

  const PrayerTimesWidget(this.viewData, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vm = useProvider(prayerTimesViewModelProvider);
    useEffect(() {
      vm.startTicker();
      return () => vm.stopTicker();
    }, []);
    final rows = [
      buildTableRow(
        texts: ["Prayer", "Begins", "Iqamah"],
        backgroundColor: Colors.green,
        bottomBorder: true,
      ),
      ...viewData.times.map(
        (time) => buildTableRow(
            texts: [time.prayerName, time.begins, time.iqamah],
            backgroundColor: !time.highlight ? null : Colors.amber),
      )
    ];
    return SizedBox.expand(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 30),
            Text(
              "PRAYER TIME",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Container(
                padding: const EdgeInsets.all(12),
                width: double.infinity,
                decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(5)),
                child: Column(
                  children: [
                    Text(viewData.date),
                    SizedBox(height: 10),
                    Text(
                      viewData.hijriDate,
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                    SizedBox(height: 10),
                    Text(
                      viewData.upcommingSalah,
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 10),
                    Text(viewData.timeToUpcommingSalah),
                    SizedBox(height: 15),
                    DefaultTextStyle.merge(
                      textAlign: TextAlign.center,
                      child: Table(
                        columnWidths: const <int, TableColumnWidth>{
                          0: IntrinsicColumnWidth(),
                          1: FlexColumnWidth(),
                          2: FlexColumnWidth(),
                        },
                        defaultVerticalAlignment:
                            TableCellVerticalAlignment.middle,
                        border: TableBorder.symmetric(outside: BorderSide()),
                        children: rows,
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  TableRow buildTableRow({
    required List<String> texts,
    Color? backgroundColor,
    bool bottomBorder = false,
  }) {
    BoxDecoration decoration = BoxDecoration(
      color: backgroundColor,
      border: !bottomBorder ? null : Border(bottom: BorderSide(width: 2)),
    );
    return TableRow(
      decoration: decoration,
      children: texts
          .map((cell) => Padding(
                padding: const EdgeInsets.all(8),
                child: Text(cell),
              ))
          .toList(),
    );
  }
}
