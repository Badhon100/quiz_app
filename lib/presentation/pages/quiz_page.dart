import 'dart:async';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/quiz/quiz_bloc.dart';
import '../widgets/latex_text.dart';
import '../widgets/option_tile.dart';
import 'result_page.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final Map<int, List<int>> _shuffledIndices = {};
  static const int _maxTime = 10;
  int _timeLeft = _maxTime;
  Timer? _timer;
  bool _timeUp = false;

  List<int> _getShuffledIndices(int questionIndex, int length) {
    if (!_shuffledIndices.containsKey(questionIndex)) {
      final indices = List.generate(length, (i) => i);
      indices.shuffle(Random());
      _shuffledIndices[questionIndex] = indices;
    }
    return _shuffledIndices[questionIndex]!;
  }

  void _startTimer() {
    _timer?.cancel();
    setState(() {
      _timeLeft = _maxTime;
      _timeUp = false;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timeLeft > 1) {
        setState(() => _timeLeft--);
      } else {
        setState(() {
          _timeLeft = 0;
          _timeUp = true;
        });
        _timer?.cancel();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _nextQuestion(BuildContext context) {
    _timer?.cancel();
    context.read<QuizBloc>().add(NextQuestion());
    _startTimer();
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
          'Quiz',
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
      ),
      body: BlocConsumer<QuizBloc, QuizState>(
        listener: (context, state) {
          if (state.isFinished) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (_) => ResultsPage(
                  score: state.score,
                  total: state.questions.length,
                ),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.error != null) {
            return Center(child: Text('Error: ${state.error}'));
          }
          if (state.questions.isEmpty) {
            return const Center(child: Text('No questions found.'));
          }

          final q = state.questions[state.currentIndex];
          final shuffledOrder = _getShuffledIndices(
            state.currentIndex,
            q.options.length,
          );

          return Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Top progress row
                    Row(
                      children: [
                        Text(
                          'Q${state.currentIndex + 1}/${state.questions.length}',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: LinearProgressIndicator(
                            value: _timeLeft / _maxTime,
                            color: _timeUp ? Colors.red : Colors.green,
                            backgroundColor: Colors.grey.shade300,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '$_timeLeft s',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: _timeUp ? Colors.red : Colors.green,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    // Question card
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 6,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 500),
                          transitionBuilder: (child, anim) => SlideTransition(
                            position: Tween<Offset>(
                              begin: const Offset(1, 0),
                              end: Offset.zero,
                            ).animate(anim),
                            child: FadeTransition(opacity: anim, child: child),
                          ),
                          child: LatexText(
                            key: ValueKey(q.question),
                            text: q.question,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Options
                    ...shuffledOrder.asMap().entries.map((entry) {
                      final displayPosition = entry.key;
                      final originalIndex = entry.value;

                      final disabled = state.selectedIndex != null || _timeUp;
                      final isSelected = state.selectedIndex == originalIndex;
                      final isCorrect = q.answerIndex == originalIndex;

                      return OptionTile(
                        index: displayPosition,
                        text: q.options[originalIndex],
                        state: disabled
                            ? (isCorrect
                                  ? OptionState.correct
                                  : isSelected
                                  ? OptionState.incorrect
                                  : OptionState.disabled)
                            : OptionState.normal,
                        onTap: disabled
                            ? null
                            : () => context.read<QuizBloc>().add(
                                SelectAnswer(originalIndex),
                              ),
                      );
                    }),

                    const Spacer(),

                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 6,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 32,
                            vertical: 14,
                          ),
                        ),
                        onPressed: () => _nextQuestion(context),
                        child: Text(
                          state.currentIndex + 1 < state.questions.length
                              ? 'Next'
                              : 'Finish',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
