import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';

final Theme_setting=StateProvider<bool>((ref)=>false);

class setting extends ConsumerStatefulWidget {
  const setting({super.key});

  @override
  ConsumerState<setting> createState() => _settingState();
}

class _settingState extends ConsumerState<setting> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
