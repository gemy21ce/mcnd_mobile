import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:mcnd_mobile/gen/assets.gen.dart';

const k3baLat = 21.4225;
const k3baLng = 39.8262;

class CompassWidget extends HookWidget {
  const CompassWidget();

  @override
  Widget build(BuildContext context) {
    final snapshot = useStream(FlutterQiblah.qiblahStream, initialData: null);
    if (snapshot.hasError) {
      return Center(
        child: Text(
          snapshot.error?.toString() ?? 'Error',
          style: const TextStyle(color: Colors.red),
        ),
      );
    }
    if (!snapshot.hasData || snapshot.data == null) return const Center(child: Text('Loading'));
    final QiblahDirection qiblah = snapshot.data!;

    final screenSize = MediaQuery.of(context).size;
    final compassSize = min(screenSize.width, screenSize.height) * 0.8;
    final arrowSize = compassSize / 4;

    final correctDirection = qiblah.qiblah.round() == 0 || qiblah.qiblah.round() == 360;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: correctDirection ? Colors.yellow.withOpacity(0.5) : null,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Assets.images.compassOutline.svg(
            width: compassSize,
            height: compassSize,
          ),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            child: correctDirection
                ? Assets.images.ka3ba.svg(
                    width: arrowSize,
                    height: arrowSize,
                  )
                : Transform.rotate(
                    angle: qiblah.qiblah.toRadians(),
                    child: Assets.images.compassArrow.svg(
                      width: arrowSize,
                      height: arrowSize,
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

extension on num {
  double toRadians() => -2 * pi * (this / 360);
}
