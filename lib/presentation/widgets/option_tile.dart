import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'latex_text.dart';

enum OptionState { normal, disabled, correct, incorrect }

class OptionTile extends StatelessWidget {
  final int index;
  final String text;
  final OptionState state;
  final VoidCallback? onTap;

  const OptionTile({
    super.key,
    required this.index,
    required this.text,
    required this.state,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Color? bg;
    switch (state) {
      case OptionState.correct:
        bg = Colors.green.withOpacity(0.15);
        break;
      case OptionState.incorrect:
        bg = Colors.red.withOpacity(0.15);
        break;
      case OptionState.disabled:
        bg = Theme.of(context).disabledColor.withOpacity(0.06);
        break;
      case OptionState.normal:
        bg = Theme.of(context).colorScheme.surfaceContainerHighest;
        break;
    }

    return Card(
      color: bg,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          child: Row(
            children: [
              CircleAvatar(
                radius: 14,
                child: Math.tex(String.fromCharCode(65 + index)),
              ),
              const SizedBox(width: 12),
              Expanded(child: LatexText(text: text,)),
            ],
          ),
        ),
      ),
    );
  }
}
