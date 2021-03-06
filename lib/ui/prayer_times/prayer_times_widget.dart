import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mcnd_mobile/di/providers.dart';
import 'package:mcnd_mobile/gen/assets.gen.dart';
import 'package:mcnd_mobile/ui/prayer_times/prayer_times_model.dart';
import 'package:mcnd_mobile/ui/shared/styles/app_colors.dart';

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
      buildItemRow(
        const PrayerTimesModelItem(prayerName: 'Prayer', azan: 'Azan', iqamah: 'Iqamah'),
        color: AppColors.prayerTimeHerderColor,
        topRow: true,
      ),
      ...viewData.times.map(
        (time) => buildItemRow(
          time,
          color: !time.highlight ? null : AppColors.upcomingPrayerColor,
          bottomRow: time == viewData.times.last,
        ),
      )
    ];
    final size = MediaQuery.of(context).size;
    return SizedBox.expand(
      child: Column(
        children: [
          Flexible(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Container(
                  constraints: BoxConstraints(
                    maxHeight: size.height * 0.25,
                  ),
                  padding: EdgeInsets.all(constraints.maxHeight * 0.15),
                  child: Assets.images.logoLarge.image(),
                );
              },
            ),
          ),
          MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: size.width * (2.5 / 1000)),
            child: Column(
              children: [
                const Text(
                  'PRAYER TIME',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.all(size.width * 0.1).copyWith(top: 0),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        border: Border.all(color: AppColors.prayerTimeHerderColor),
                        borderRadius: BorderRadius.circular(5)),
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        Text(viewData.date),
                        const SizedBox(height: 10),
                        Text(
                          viewData.hijriDate,
                          style: const TextStyle(fontStyle: FontStyle.italic),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          viewData.upcommingSalah,
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 10),
                        Text(viewData.timeToUpcommingSalah),
                        const SizedBox(height: 10),
                        DefaultTextStyle.merge(
                          textAlign: TextAlign.center,
                          child: Column(
                            children: rows,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget buildItemRow(
    PrayerTimesModelItem item, {
    Color? color,
    bool topRow = false,
    bool bottomRow = false,
  }) {
    return DefaultTextStyle.merge(
      style: TextStyle(color: color == null ? Colors.black : Colors.white),
      child: Container(
        color: color,
        child: Row(
          children: [
            buildCell(
              item.prayerName,
              topRow: topRow,
              bottomRow: bottomRow,
              firstCol: true,
            ),
            buildCell(
              item.azan,
              twoCols: item.iqamah == null,
              topRow: topRow,
              bottomRow: bottomRow,
              lastCol: item.iqamah == null,
            ),
            if (item.iqamah != null)
              buildCell(
                item.iqamah!,
                topRow: topRow,
                bottomRow: bottomRow,
                lastCol: true,
              ),
          ],
        ),
      ),
    );
  }

  Widget buildCell(
    String text, {
    bool twoCols = false,
    bool topRow = false,
    bool bottomRow = false,
    bool firstCol = false,
    bool lastCol = false,
  }) {
    const border = BorderSide(color: AppColors.prayerTimeHerderColor);
    return Expanded(
      flex: twoCols ? 2 : 1,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border(
            left: firstCol ? BorderSide.none : border,
            top: border,
          ),
        ),
        child: Text(text),
      ),
    );
  }
}
