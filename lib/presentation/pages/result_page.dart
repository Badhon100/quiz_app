import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_page.dart';

class ResultsPage extends StatefulWidget {
  final int score;
  final int total;

  const ResultsPage({super.key, required this.score, required this.total});

  @override
  State<ResultsPage> createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final name = (_controller.text).trim().isEmpty
        ? 'Player'
        : _controller.text.trim();
    final entry = {
      'name': name,
      'score': widget.score,
      'createdAt': DateTime.now().toIso8601String(),
    };

    final prefs = await SharedPreferences.getInstance();
    final String? data = prefs.getString('leaderboard');
    List<Map<String, dynamic>> entries = [];

    if (data != null) {
      final List decoded = jsonDecode(data);
      entries = decoded.map((e) => Map<String, dynamic>.from(e)).toList();
    }

    entries.add(entry);

    // Save back to SharedPreferences
    await prefs.setString('leaderboard', jsonEncode(entries));

    // Navigate back to home
    if (mounted) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const HomePage()),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final percent = (widget.score / widget.total * 100).toStringAsFixed(0);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(CupertinoIcons.back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Results',
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0, end: 1),
                  duration: const Duration(seconds: 1),
                  builder: (context, value, child) =>
                      Opacity(opacity: value, child: child),
                  child: Text(
                    'Score: ${widget.score}/${widget.total}',
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text('You got $percent%'),
                const SizedBox(height: 24),
                TextField(
                  controller: _controller,
                  textInputAction: TextInputAction.done,
                  decoration: const InputDecoration(
                    labelText: 'Enter your name',
                    border: OutlineInputBorder(),
                  ),
                  onSubmitted: (_) => _save(),
                ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      vertical: 14,
                      horizontal: 24,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    backgroundColor: Colors.deepPurple,
                    elevation: 6,
                  ),
                  onPressed: _save,
                  icon: const Icon(Icons.save, color: Colors.white),
                  label: const Text(
                    'Save to Leaderboard',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
