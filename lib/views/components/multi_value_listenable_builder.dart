import 'package:flutter/foundation.dart' show Listenable, ValueListenable;
import 'package:flutter/material.dart'
    show AnimatedBuilder, BuildContext, StatelessWidget, Widget;

/// This widget listens to multiple [ValueListenable]s and
/// calls given builder function if any one of them changes.
class MultiValueListenableBuilder extends StatelessWidget {
  /// List of [ValueListenable]s to listen to.
  final List<ValueListenable> valueListenable;

  /// The builder function to be called when value of any of the [ValueListenable] changes.
  /// The order of values list will be same as [valueListenables] list.
  final Widget Function(
      BuildContext context, List<dynamic> values, Widget? child) builder;

  /// An optional child widget which will be avaliable as child parameter in [builder].
  final Widget? child;

  // The const constructor.
  const MultiValueListenableBuilder({
    super.key,
    required this.valueListenable,
    required this.builder,
    this.child,
  }) : assert(valueListenable.length != 0);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge(valueListenable),
      builder: (context, child) {
        final list = valueListenable.map((listenable) => listenable.value);
        return builder(context, List<dynamic>.unmodifiable(list), child);
      },
      child: child,
    );
  }
}
