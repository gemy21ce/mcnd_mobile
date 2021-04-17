import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';

class CompassWidget extends StatelessWidget {
  const CompassWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<CompassEvent>(
      stream: FlutterCompass.events,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text(
              snapshot.error?.toString() ?? 'Error',
              style: const TextStyle(color: Colors.red),
            ),
          );
        }
        if (!snapshot.hasData) return const SizedBox();
        final double degree = snapshot.data!.heading!;

        return Text(degree.toString());
      },
    );
  }
}
