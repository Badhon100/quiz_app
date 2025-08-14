import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LeaderboardPage extends StatefulWidget {
  const LeaderboardPage({super.key});

  @override
  State<LeaderboardPage> createState() => _LeaderboardPageState();
}

class _LeaderboardPageState extends State<LeaderboardPage> {
  List<Map<String, dynamic>> _entries = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadLeaderboard();
  }

  Future<void> _loadLeaderboard() async {
    setState(() => _loading = true);
    final prefs = await SharedPreferences.getInstance();
    final String? data = prefs.getString('leaderboard');
    if (data != null) {
      final List decoded = jsonDecode(data);
      _entries = decoded.map((e) => Map<String, dynamic>.from(e)).toList();
    } else {
      _entries = [];
    }
    // Sort by score descending
    _entries.sort((a, b) => (b['score'] as int).compareTo(a['score'] as int));
    setState(() => _loading = false);
  }

  String formatDateTime(String isoString) {
    final dt = DateTime.parse(isoString);
    return DateFormat('hh:mm a dd-MMM-yy').format(dt);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(CupertinoIcons.back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Leaderboard',
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
        backgroundColor: Colors.deepPurple,
      ),
      body: RefreshIndicator(
        color: Colors.deepPurple,
        onRefresh: _loadLeaderboard,
        child: _loading
            ? const Center(child: CircularProgressIndicator())
            : _entries.isEmpty
            ? const Center(child: Text('No scores yet. Play a quiz!'))
            : ListView.separated(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(12),
                itemCount: _entries.length,
                separatorBuilder: (_, __) => const SizedBox(height: 8),
                itemBuilder: (context, i) {
                  final e = _entries[i];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 4,
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.deepPurple,
                        child: Text(
                          '${i + 1}',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      title: Text(
                        e['name'],
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      trailing: Text(
                        '${e['score']}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      subtitle: Text(formatDateTime(e['createdAt'])),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
