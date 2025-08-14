# 📚 Flutter Quiz App

A mobile quiz application built with **Flutter** and **BLoC architecture**.  
Supports LaTeX rendering for math/science questions, persistent leaderboard storage, and smooth quiz flow.

---

## 🛠 Flutter/Dart Version
- **Flutter**: 3.22.0 or higher  
- **Dart**: 3.4.0 or higher  

---

## 🚀 Setup Steps

**Clone the repository**

    1. git clone https://github.com/Badhon100/quiz_app.git
    2. cd flutter_quiz_app


Install dependencies

    flutter pub get

Run the app

    flutter run


Assets

Ensure your quiz questions file exists at:

    assets/questions.json


Example JSON structure:

[
  {
    "question": "What is $\\frac{1}{2} + \\frac{1}{3}$?",
    "options": ["$\\frac{5}{6}$", "$\\frac{2}{5}$", "$\\frac{1}{5}$", "$\\frac{1}{6}$"],
    "answerIndex": 0
  }
]


Add assets to pubspec.yaml:

flutter:
  assets:
    - assets/questions.json


🏗 Architecture Overview
The app follows BLoC (Business Logic Component) + Repository pattern:

Presentation Layer

    pages/ – Screens for Home, Quiz, Results, and Leaderboard

    widgets/ – Reusable UI components (e.g., OptionTile, LatexText)

Business Logic Layer

    blocs/quiz/ – QuizBloc, QuizState, QuizEvent

Data Layer

    Loads questions from local JSON (assets)

    Stores leaderboard scores in persistent storage (Shared Preference)

LaTeX Support

    Implemented with flutter_math_fork for rendering equations in both questions and options.

✅ What’s Implemented (MVP)
Home Screen:

1. App title

2. Start Quiz button

3. Leaderboard button

4. Quiz Flow:

    1. Loads questions from assets/questions.json

    2. LaTeX rendering for questions and answers

    3. One question at a time with 4 multiple-choice answers

    4. Answer locks after selection

    5. Next button to go to next question

    6. Progress indicator (Q2/10)

    7. Randomized option order

5. Results Screen:

    1. Shows score

    2. Player name entry

    3. Saves score to leaderboard

6. Leaderboard:

    1. Shows top scores sorted by highest first

    2. Persistent storage with Hive

⚠️ Skipped / Not Implemented (Nice-to-Have)

    1. Category selection before quiz

    2. Dark mode toggle

    4. Unit tests for score calculation

    5. GitHub Actions CI
