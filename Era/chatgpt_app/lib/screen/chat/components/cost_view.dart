import 'package:chatgpt_app/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CostView extends ConsumerStatefulWidget {
  const CostView({Key? key}) : super(key: key);

  @override
  ConsumerState<CostView> createState() => _CostViewState();
}

class _CostViewState extends ConsumerState<CostView> {
  @override
  Widget build(BuildContext context) {
    final isCostView = ref.watch(costViewProvider);

    String text;
    if (isCostView) {
      final costTotal = ref.watch(costTotalProvider);
      text = '\$ ${costTotal.toStringAsFixed(3)} (${(costTotal * 1300).toInt()}원)';
    } else {
      text = '비용보기';
    }
    return Row(
      children: [
        Text(text, style: TextStyle(fontSize: 16, color: Colors.black54)),
        Switch(
            value: isCostView,
            onChanged: (value) {
              setState(() {
                ref.read(costViewProvider.notifier).state = value;
              });
            }),
      ],
    );
  }
}
