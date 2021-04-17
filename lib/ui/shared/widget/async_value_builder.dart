import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AsyncValueBuilder<T> extends StatelessWidget {
  final AsyncValue<T> value;

  final Widget Function(T data) builder;
  final Widget Function(Object error, StackTrace? stackTrace)? errorBuilder;
  final Widget Function()? loadingBuilder;

  const AsyncValueBuilder({
    required this.value,
    required this.builder,
    this.errorBuilder,
    this.loadingBuilder,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return value.when(
      data: builder,
      loading: loadingBuilder ??
          () => const Center(
                child: CircularProgressIndicator(),
              ),
      error: errorBuilder ??
          (error, stk) => Center(
                child: Text(
                  error.toString(),
                  style: const TextStyle(color: Colors.red),
                ),
              ),
    );
  }
}
