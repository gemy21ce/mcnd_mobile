import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

void useOnce(Function function) => use(_OnceHook(function));

class _OnceHook extends Hook<void> {
  final Function function;

  const _OnceHook(this.function);

  @override
  __OnceHookState createState() => __OnceHookState();
}

class __OnceHookState extends HookState<void, _OnceHook> {
  @override
  void initHook() {
    super.initHook();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      hook.function();
    });
  }

  @override
  void build(BuildContext context) {}
}
