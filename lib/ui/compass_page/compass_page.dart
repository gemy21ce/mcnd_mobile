import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mcnd_mobile/di/providers.dart';
import 'package:mcnd_mobile/ui/shared/hooks/use_once.dart';

class CompassPage extends HookWidget {
  const CompassPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = useProvider(compassPageViewModelProvider);
    useOnce(() => viewModel.load());
    final state = useProvider(compassPageViewModelProvider.state);

    return state.when(
      initial: () => const SizedBox(),
      permissionNotGranted: () => const _PermissionNotGrantedWidget(),
      permissionPermanentlyDenied: () => const _PermissionNotGrantedWidget(),
      permissionGranted: () => Text('permissionGranted'),
    );
  }
}

class _PermissionNotGrantedWidget extends HookWidget {
  const _PermissionNotGrantedWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = useProvider(compassPageViewModelProvider);
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'To use the compass feature mcnd mobile requires location permissions',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          OutlinedButton(
            onPressed: () {
              viewModel.grantPermission();
            },
            child: const Text('Grant Permission'),
          )
        ],
      ),
    );
  }
}
