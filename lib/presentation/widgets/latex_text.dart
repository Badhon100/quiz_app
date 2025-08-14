import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';

class LatexText extends StatelessWidget {
  final String text;
  final double fontSize;

  const LatexText({super.key, required this.text, this.fontSize = 18});

  @override
  Widget build(BuildContext context) {
    // Detect if the text contains LaTeX delimiters
    final latex = _extractLatex(text);
    if (latex != null) {
      // Render LaTeX
      return Math.tex(
        latex,
        mathStyle: MathStyle.text,
        textStyle: TextStyle(fontSize: fontSize),
        onErrorFallback: (err) =>
            Text(text, style: TextStyle(fontSize: fontSize)),
      );
    } else {
      // Render normal text
      return Text(text, style: TextStyle(fontSize: fontSize));
    }
  }

  /// Returns the LaTeX content if found, otherwise null
  String? _extractLatex(String s) {
    final doubleDollar = RegExp(r"\$\$(.+?)\$\$", dotAll: true);
    final singleDollar = RegExp(r"\$(.+?)\$", dotAll: true);
    final escapedParen = RegExp(r"\\\((.+?)\\\)", dotAll: true);
    final escapedBracket = RegExp(r"\\\[(.+?)\\\]", dotAll: true);

    RegExpMatch? match;
    for (var pattern in [
      doubleDollar,
      singleDollar,
      escapedParen,
      escapedBracket,
    ]) {
      match = pattern.firstMatch(s);
      if (match != null) break;
    }

    if (match != null) return match.group(1);
    return null; // no LaTeX found
  }
}
