// Lesson 7 — script.js
// Minimal JS — just provides feedback when the form button is clicked.
// The visual demos (flexbox, transitions, animation) are pure CSS.

function handleForm() {
  const name = document.getElementById("name").value.trim();
  const feedback = document.getElementById("form-feedback");

  if (name === "") {
    feedback.textContent = "Please enter your name before sending.";
    feedback.style.color = "#c0392b";
  } else {
    feedback.textContent = "Thanks, " + name + "! Your message was received.";
    feedback.style.color = "#2E6DA4";
  }
}
