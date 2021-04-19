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
    final maxSize = min(screenSize.width, screenSize.height);
    final compassSize = maxSize * 0.8;
    final arrowSize = compassSize / 4;
    final k3baSize = compassSize / 6;
    final northSize = compassSize / 6;

    final correctDirection = qiblah.qiblah.round() == 0 || qiblah.qiblah.round() == 360;

    return Stack(
      alignment: Alignment.center,
      children: [
        Transform.rotate(
          angle: qiblah.qiblah.toRadians(),
          child: Container(
            alignment: Alignment.topCenter,
            width: maxSize,
            height: maxSize,
            child: Transform.rotate(
              angle: -qiblah.qiblah.toRadians(),
              child: Assets.images.ka3ba.svg(
                width: k3baSize,
                height: k3baSize,
                color: correctDirection ? Colors.green : null,
              ),
            ),
          ),
        ),
        Transform.rotate(
          angle: qiblah.direction.toRadians(),
          child: Container(
            alignment: Alignment.topCenter,
            width: maxSize,
            height: maxSize,
            child: Transform.rotate(
              angle: -qiblah.direction.toRadians(),
              child: const Text(
                'N',
                textScaleFactor: 1,
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 50,
                ),
              ),
            ),
          ),
        ),
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: correctDirection ? Colors.green.withOpacity(0.8) : null,
          ),
          margin: EdgeInsets.all(k3baSize * 1.1),
          child: Assets.images.compassOutline.svg(
            width: compassSize,
            height: compassSize,
          ),
        ),
        Transform.rotate(
          angle: qiblah.qiblah.toRadians(),
          child: Assets.images.compassArrow.svg(
            width: arrowSize,
            height: arrowSize,
          ),
        ),
      ],
    );
  }
}

extension on num {
  double toRadians() => -2 * pi * (this / 360);
}
