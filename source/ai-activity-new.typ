#set text(font: "New Computer Modern")
#set page(margin: 1in)
#set heading(numbering: "1.")

#align(center)[
  #text(size: 22pt, weight: "bold")[Train Your Own AI]
  #v(0.1in)
  #text(size: 13pt)[A hands-on project activity]
]

#v(0.3in)

Machine learning is everywhere: it unlocks your phone with your face, filters spam from your inbox, and recommends the next video you watch. In this activity you'll do the same thing those systems do, just with friendlier tools and smaller datasets. You'll *train your own AI model* and put it to work.

*How this works.* Below are several projects. Read the short introductions, pick *one* that interests you, and build it. Each project is self-contained and designed to fit comfortably in a single lesson. If you finish early or want a challenge, try a second project or look at the "Going Further" options.

Don't worry about understanding all the theory first, you'll learn a surprising amount just by experimenting. If you get curious about *how* the AI actually learns, the final chapter has some excellent videos and resources to take you deeper.

#v(0.2in)
#line(length: 100%, stroke: 0.5pt)

= Project A: Image Recognition

*Tool:* Teachable Machine (`teachablemachine.withgoogle.com`) --- no coding, no account needed

== Introduction

Teachable Machine lets you train an image classifier using nothing but your webcam. You show it examples of different categories ("classes"), it learns the patterns, and then it can recognize new examples in real time. Under the hood it's using a real neural network, but you never have to touch the math.

The core idea is simple: the more varied, high-quality examples you give it, the better it performs. This is the single most important lesson in machine learning, and you'll feel it directly.

== Your Assignment

Build an image classifier that can reliably tell apart at least *three* categories of your choosing.

1. Choose "Image Project" then "Standard image model."
2. Create your classes and capture 20--30 webcam images for each. Vary the angle, lighting, and background so the model learns the *real* pattern, not just one fixed pose.
3. Click "Train Model" and test it live.
4. Deliberately try to break it. Find an input it gets wrong, then add training examples to fix that weakness and retrain.

*Ideas:* rock-paper-scissors hand shapes; facial expressions (happy / surprised / neutral); recognizing specific objects on your desk; "is the person wearing glasses or not."

*Challenge yourself:* Can you get it to over 90% confidence on inputs it has never seen? What kinds of mistakes are hardest to fix?

#line(length: 100%, stroke: 0.5pt)

= Project B: Sound & Voice Recognition

*Tool:* Teachable Machine (`teachablemachine.withgoogle.com`) --- no coding, no account needed

== Introduction

The same platform can learn to recognize *sounds* instead of images. This is the technology behind voice assistants that wake up when you say a particular phrase. You'll record short audio samples for each sound you want to detect, and the model learns to tell them apart, even distinguishing them from background noise.

Audio is a bit trickier than images because background noise and timing matter, which makes it a satisfying problem to get right.

== Your Assignment

Train a sound classifier that responds to at least *two* distinct sounds plus a "background noise" class.

1. Choose "Audio Project."
2. First record the required "Background Noise" samples (this teaches it what *silence* sounds like).
3. Add 8--20 samples of each target sound.
4. Train and test it live. Notice how it behaves when sounds overlap or when you change how loudly you make them.

*Ideas:* clap vs. snap vs. silence; simple voice commands ("up" / "down" / "stop"); whistling different pitches; detecting a doorbell or alarm sound.

*Challenge yourself:* Does it still work if someone else makes the sounds? What does that tell you about how representative your training data was?

#line(length: 100%, stroke: 0.5pt)

= Project C: A Model You Can See Inside

*Tool:* Machine Learning for Kids (`machinelearningforkids.co.uk`) --- no coding required (free account)

== Introduction

A common criticism of AI is that it's a "black box", it gives an answer but can't explain why. This project tackles that head-on. You'll train a model and then view the actual *decision tree* it built: a flowchart of yes/no questions the AI learned to ask in order to make its predictions. You can follow the branches yourself and trace exactly how a decision gets made.

This is a great choice if you like understanding *why* something works, not just that it works.

== Your Assignment

Train a classifier, then explain its decision-making in your own words.

1. Create a free account and start a new project (the Quick Start projects are a good way to begin).
2. Collect a solid set of labeled training examples.
3. Train the model, then open the decision-tree visualization.
4. Write a short explanation: what question does the tree ask first, and why do you think that one is most important? Trace one full path from top to a prediction.

*Ideas:* a "guess the animal" classifier from descriptions; sorting messages as friendly vs. unfriendly; a yes/no recommender ("will I like this?").

*Challenge yourself:* Make a deliberately *bad* model by feeding it biased or lopsided training data. How does the tree change? This is exactly how bias creeps into real-world AI.

#line(length: 100%, stroke: 0.5pt)

= Project D: Experiment with a Neural Network

*Tool:* TensorFlow Playground (`playground.tensorflow.org`) --- no coding, nothing to install

== Introduction

This one is less "train a useful gadget" and more "open the hood and tinker." TensorFlow Playground is a live neural network running in your browser. You can add layers and neurons, change how fast it learns, and watch in real time as it figures out how to separate two groups of dots. The colors and curves show you the network "thinking."

It's strangely mesmerizing, and it builds real intuition for what's happening inside the models in the other projects.

== Your Assignment

Solve the hard datasets and document what you discover.

1. Start with the "Circle" dataset. Press play and watch it learn. Then try to solve it with the *smallest* network you can.
2. Switch to the "Spiral" dataset, the hardest one. Most simple networks fail on it. Experiment with more layers, more neurons, and different features until you crack it.
3. Train one network until it scores nearly perfectly on the training data, then look at the test loss. If the test loss is much worse, you've just witnessed *overfitting*.

Record the configuration that finally solved the spiral, and a sentence on what overfitting looked like when you saw it.

*Challenge yourself:* What's the simplest network (fewest neurons/layers) that still solves the spiral? Simpler models that work are often better --- find the minimum.

#line(length: 100%, stroke: 0.5pt)

= Project E: Build With Models the Pros Use

*Tool:* Runway ML (`runwayml.com`) --- no coding (free account)

== Introduction

Instead of training a model from scratch, this project lets you *use* powerful models that have already been trained on enormous datasets, the same class of tools used by artists, filmmakers, and designers. You'll explore what state-of-the-art AI can actually do today and create something with it.

This is a good fit if you're interested in the creative and practical side of AI more than the training mechanics.

== Your Assignment

Pick a pre-trained model and produce something with it, then reflect on its limits.

1. Create a free account and browse the available models (image generation, style transfer, background removal, pose detection, and more).
2. Choose one and run it on your own inputs. Experiment with several different inputs.
3. Find its limits: give it something unusual and see where it breaks or produces something strange.

*Ideas:* apply an artistic style to your own photos; generate images from text prompts; detect body poses in a short video clip; upscale a low-quality image.

*Challenge yourself:* These models learned from millions of examples scraped from the internet. Where might that data have been biased or unbalanced, and how could that show up in your results?

#line(length: 100%, stroke: 0.5pt)

= Going Further: For Strong Programmers

You've touched a little Python and JavaScript this year. If you want to push beyond the no-code tools and write AI that *you* control, these are the natural next steps. Pick these only if you're comfortable coding --- they're meaningfully harder, but far more powerful.

== ML5.js (JavaScript)

A beginner-friendly library that runs machine learning right in the browser, designed for artists and students. With a few lines of JavaScript you can train a neural network, classify images, or detect body poses, and combine it with visual output using p5.js.

*Where to start:* The Coding Train's "ML5.js Beginner's Guide" (`thecodingtrain.com`) is an outstanding free video series. Try training a model that maps your mouse position to an output, then build something interactive on top of it.

== Python with Jupyter Notebooks

This is how machine learning is done professionally. Using free notebooks (no setup required) you can load a real dataset, split it into training and test sets, train a model with a library like scikit-learn, and properly evaluate how well it generalizes.

*Where to start:* "Kaggle Learn" (`kaggle.com/learn`) offers short, free, hands-on courses. Classic beginner datasets include Iris (flower classification), Titanic (survival prediction), and MNIST (handwritten digits). Google Colab (`colab.research.google.com`) lets you run Python notebooks in the cloud for free.

== TensorFlow.js (JavaScript)

Like ML5.js but lower-level and more capable, this is Google's library for deep learning in the browser. More to learn, but you get fine-grained control over building and training networks.

*Where to start:* The official tutorials at `tensorflow.org/js`.

#line(length: 100%, stroke: 0.5pt)

= Understanding How It Really Works

You've now trained models by experimenting. If that sparked curiosity about what's *actually* happening when an AI "learns," these resources explain the underlying ideas beautifully --- no advanced math degree required. They're optional, but genuinely worth your time.

== Videos

*3Blue1Brown --- "Neural Networks" series.* The gold standard. Grant Sanderson uses gorgeous animations to build deep intuition for how neural networks work, starting from a single neuron and working up to how they learn. Begins with "But what is a neural network?" and continues through gradient descent and backpropagation. Search "3Blue1Brown Neural Networks" on YouTube, or visit `3blue1brown.com`. The series pairs perfectly with what you saw in Project D.

*StatQuest with Josh Starmer.* Friendly, clear, slightly goofy explanations of the statistics and concepts behind machine learning. Excellent when you want a single concept (like decision trees or gradient descent) broken down step by step. Search "StatQuest" on YouTube.

*The Coding Train.* Energetic, beginner-friendly coding tutorials, including a whole track on machine learning with ML5.js. Great if you learn best by building alongside someone. (`thecodingtrain.com`)

== Interactive & Reading

*R2D3 --- "A Visual Introduction to Machine Learning."* A stunning scroll-through story that explains decision trees, training vs. test data, and overfitting using interactive graphics. (`r2d3.us`)

*Google's "Machine Learning Crash Course."* A more structured, free course from Google with readings, visualizations, and exercises --- for when you want something more like a textbook. (`developers.google.com/machine-learning/crash-course`)

*Elements of AI.* A free, popular online course explaining AI concepts in plain language, no coding required. Great for the big-picture "what is AI and what can it do" questions. (`elementsofai.com`)

== A Few Concepts Worth Looking Up

As you watch and read, these are the ideas that tie everything together, and that you've already met in your projects:

- *Training data* --- the examples a model learns from (you curated this yourself).
- *Neural network* --- layers of simple units that combine to recognize complex patterns (you watched one learn in Project D).
- *Classification* --- sorting inputs into categories (Projects A, B, C).
- *Overfitting* --- memorizing the training data instead of learning the general pattern.
- *Bias in data* --- when unrepresentative training data leads to unfair or wrong results.

#v(0.3in)
#align(center)[#text(style: "italic")[You just did real machine learning. The tools the professionals use are bigger, but the ideas are exactly the same ones you experimented with today.]]
