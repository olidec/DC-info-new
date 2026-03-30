// Lesson 5 — script.js
// Demonstrates: variables, getElementById, textContent, onclick, classList

// ── Demo 1: Changing text content ────────────────────────────────────────────

function changeGreeting() {
  const greeting = document.getElementById("greeting");
  greeting.textContent = "Hello from JavaScript!";
}

// ── Demo 2: Click counter ─────────────────────────────────────────────────────

let clickCount = 0;   // let because it changes

function increment() {
  clickCount = clickCount + 1;
  const display = document.getElementById("count");
  display.textContent = clickCount;
}

function resetCount() {
  clickCount = 0;
  const display = document.getElementById("count");
  display.textContent = clickCount;
}

// ── Demo 3: Toggling a CSS class ──────────────────────────────────────────────

function toggleHighlight() {
  const box = document.getElementById("color-box");
  box.classList.toggle("highlighted");
}
