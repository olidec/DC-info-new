// Lesson 8 — script.js
// Demonstrates: functions with parameters, return values,
//               if/else conditionals, for loop, arrays of objects

// ── Demo 1: Functions with parameters and return values ───────────────────────

// A function that takes two parameters and RETURNS their sum
function add(a, b) {
  return a + b;
}

function showSum() {
  const a = Number(document.getElementById("num-a").value);
  const b = Number(document.getElementById("num-b").value);
  const result = add(a, b);   // call the function, store the return value
  document.getElementById("sum-result").textContent = result;
}

// ── Demo 2: Conditionals ──────────────────────────────────────────────────────

// A function that uses if/else if/else to convert a score to a grade
function getGrade(score) {
  if (score >= 90) {
    return "6 — Excellent";
  } else if (score >= 75) {
    return "5 — Good";
  } else if (score >= 60) {
    return "4 — Satisfactory";
  } else if (score >= 50) {
    return "3 — Pass";
  } else {
    return "2 — Not yet";
  }
}

function showGrade() {
  const score = Number(document.getElementById("score-input").value);
  const grade = getGrade(score);   // returns a string
  document.getElementById("grade-result").textContent = grade;
}

// ── Demo 3: Quiz with arrays and loops ────────────────────────────────────────

// Array of question objects
const questions = [
  { question: "What does HTML stand for?",
    answer: "hypertext markup language" },
  { question: "Which CSS property sets the text color?",
    answer: "color" },
  { question: "Which JavaScript keyword declares a changing variable?",
    answer: "let" },
  { question: "What method selects an element by its ID?",
    answer: "getelementbyid" },
];

let currentQuestion = 0;
let score = 0;

function loadQuestion() {
  const q = questions[currentQuestion];
  document.getElementById("question-text").textContent =
    "Q" + (currentQuestion + 1) + " of " + questions.length + ": " + q.question;
  document.getElementById("answer-input").value = "";
  document.getElementById("feedback").textContent = "";
}

function checkAnswer(userAnswer, correctAnswer) {
  // Normalize both to lowercase and remove extra spaces
  return userAnswer.toLowerCase().trim() === correctAnswer.toLowerCase().trim();
}

function submitAnswer() {
  const input = document.getElementById("answer-input").value;
  const correct = questions[currentQuestion].answer;

  if (checkAnswer(input, correct)) {
    score++;
    document.getElementById("feedback").textContent = "✓ Correct!";
    document.getElementById("feedback").style.color = "#27ae60";
  } else {
    document.getElementById("feedback").textContent =
      "✗ Not quite — the answer was: " + correct;
    document.getElementById("feedback").style.color = "#c0392b";
  }

  currentQuestion++;

  if (currentQuestion < questions.length) {
    setTimeout(loadQuestion, 1400);
  } else {
    setTimeout(showResult, 1400);
  }
}

function showResult() {
  document.getElementById("question-box").style.display = "none";
  document.getElementById("result-box").style.display = "block";
  document.getElementById("final-score").textContent =
    "You scored " + score + " out of " + questions.length + ".";

  // Use a loop to calculate a percentage, then a conditional for the message
  const percent = (score / questions.length) * 100;
  let message = "";

  if (percent === 100) {
    message = "Perfect score!";
  } else if (percent >= 75) {
    message = "Well done!";
  } else if (percent >= 50) {
    message = "Good effort — review the ones you missed.";
  } else {
    message = "Keep practicing — you'll get there.";
  }

  document.getElementById("score-message").textContent = message;
}

function restartQuiz() {
  currentQuestion = 0;
  score = 0;
  document.getElementById("question-box").style.display = "block";
  document.getElementById("result-box").style.display = "none";
  loadQuestion();
}

// Start the quiz when the page loads
loadQuestion();
