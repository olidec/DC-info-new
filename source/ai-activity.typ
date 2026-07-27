#set text(font: "New Computer Modern")
#set page(margin: 1in)

#align(center)[
  #text(size: 22pt, weight: "bold")[Hands-On AI Training Activity]
  #text(size: 14pt)[Understanding & Building Your Own Machine Learning Models]
]

#v(0.3in)

In this activity, you will research how AI models learn, then build your own working AI project. You'll train a computer to recognize patterns in data or images, just like machine learning engineers do.

*Duration:* 90 minutes total

*What you'll need:* A web browser, webcam (optional, depending on platform choice)

---

== Part 1: Research How AI Training Works (30 minutes)

Before you build anything, you need to understand what happens when a machine learns. Answer these questions by exploring one of the tutorials below.

=== Key Concepts to Understand

#table(
  columns: (1fr, 2fr),
  [*Concept*], [*What it means*],
  [Training Data], [Examples you show the AI to help it learn. The more examples, the better it learns.],
  [Classification], [Teaching AI to sort things into categories. ("Is this a cat or a dog?")],
  [Pattern Recognition], [The AI figures out what features matter. ("Dogs have floppy ears, cats have pointy ears.")],
  [Accuracy/Performance], [How often the AI gets the right answer on new data it hasn't seen before.],
  [Overfitting], [The AI memorizes training examples instead of learning patterns. It fails on new data.],
)

=== Research Options (Choose One)

*Option A: Visual Neural Networks (TensorFlow Playground)*

Go to `playground.tensorflow.org` and follow these steps:

1. *Watch the network train:* Click the Play button and watch the lines change color as the network learns. Blue = positive weight, orange = negative weight.

2. *Understand layers:* Count how many layers the network has. What happens if you add more layers? Try it.

3. *Change the learning rate:* Slow it down (lower value) or speed it up (higher value). What happens to training speed?

4. *Spot overfitting:* Train a network until it gets 100% accuracy on training data. Now check the test accuracy. Do they match? If not, you've found overfitting.

5. *Try different datasets:* Switch to the "Spiral" dataset. Is it harder or easier to learn than the default?

*Reflection questions:*
- What does the background color represent?
- What happened to the decision boundary as the network trained?
- Why might a network overfit? What's the risk?

---

*Option B: Training & Visualization (Decision Tree with ML for Kids)*

Go to `machinelearningforkids.co.uk` and choose one of the Quick Start activities (Pac-Man, Noughts and Crosses, or similar):

1. *Collect training data:* Play the game 10+ times, labeling your choices. The AI is watching and learning.

2. *Train the model:* Click "Train" and wait for the algorithm to process your examples.

3. *See the decision tree:* A tree diagram appears showing exactly how the AI makes decisions. Hover over different paths.

4. *Test on new data:* Try to fool the AI. What strategies work? What doesn't?

5. *Examine the tree:* Do the questions at each branch make sense? Could you follow this tree to make the same decision?

*Reflection questions:*
- What was the first question the tree asked? Why do you think that question came first?
- How many branches did your tree have? More complex or simpler than you expected?
- Were there any decisions that seemed wrong? How would you fix the training data?

---

*Option C: Conceptual Learning (R2D3 Visual Introduction)*

Go to `r2d3.us/visual-intro-to-machine-learning-part-1` and work through the interactive story:

1. *Follow the narrative:* The story uses an example (predicting which Seattle neighborhood a house is in) to teach concepts.

2. *Interact with visualizations:* Hover over and click on elements. Change the decision boundary. See what happens.

3. *Understand the tradeoff:* Part 1 builds intuition; Part 2 shows why perfect accuracy on training data is actually bad.

4. *Explore the playground:* The "Test Set" visualization clearly shows overfitting vs. good generalization.

*Reflection questions:*
- Why does a simple model (one boundary line) sometimes generalize better than a complex model?
- What does "bias-variance tradeoff" mean in your own words?

---

=== Document Your Learning

In a text file or on paper, write 2--3 sentences answering:

1. *What is training data?* Give an example from what you just explored.

2. *What's the difference between accuracy on training data and accuracy on test data?* Why does this matter?

3. *What does "overfitting" mean? When might you have overfitting?*

These notes will help you make better decisions when you build your own model.

---

== Part 2: Build Your Own AI Project (60 minutes)

Now it's time to train an actual AI model and put it to work. Choose a project based on your interests and experience level.

=== Project Option 1: Image Recognition (Teachable Machine)
*Barrier to entry:* Very low | *Time:* 45--60 minutes | *Coding:* None

*What you'll create:* A model that recognizes different images, poses, or objects using your webcam.

*Steps:*

1. Go to `teachablemachine.withgoogle.com`

2. Click "Get Started" and choose "Image Project"

3. *Gather training data:*
   - Create at least 2 classes (categories). Examples: "thumbs up" and "thumbs down", "dog" and "cat", "wearing glasses" and "not wearing glasses"
   - For each class, take 20--30 photos using your webcam
   - Vary the lighting, angle, and background. Don't just repeat the same pose

4. *Train the model:* Click "Train Model". It takes 10--30 seconds.

5. *Test it:* Show the camera different examples. What accuracy do you get? Does it ever make mistakes?

6. *Export (optional):* You can download this model or embed it in a website.

*Project ideas:*
- Detect hand gestures (peace sign, rock, paper, scissors)
- Classify facial expressions (happy, sad, surprised)
- Identify objects (water bottle, phone, pencil)
- Recognize poses (standing, sitting, jumping)
- Sort items by category (organized desk vs. messy desk)

*Reflection:*
- Which class was harder for the AI to learn? Why?
- How many examples did you need before it worked well?
- What happens if the background changes? Why?

---

=== Project Option 2: Sound/Audio Recognition (Teachable Machine)
*Barrier to entry:* Very low | *Time:* 45--60 minutes | *Coding:* None

*What you'll create:* A model that recognizes different sounds and responds.

*Steps:*

1. Go to `teachablemachine.withgoogle.com`

2. Click "Get Started" and choose "Audio Project"

3. *Gather training data:*
   - Create 2--3 classes. Examples: "clapping", "snapping", "silence" or "laughter", "silence", "door knocking"
   - Record 10--20 samples of each sound using your microphone
   - Vary the loudness and the exact sound slightly

4. *Train the model:* Click "Train Model"

5. *Test it:* Make each sound in front of your microphone. How accurate is it?

6. *Think about real applications:* Where might this be useful?

*Project ideas:*
- Detect voice commands ("yes", "no", "start", "stop")
- Recognize household sounds (water running, door slam, phone ring)
- Identify musical instruments in recordings
- Classify dog/cat sounds
- Create a "quiet indicator" that detects silence vs. noise

*Reflection:*
- Was it harder to train audio or image recognition? Why?
- Did background noise cause problems? How could you fix that?

---

=== Project Option 3: Decision Tree Classifier (ML for Kids)
*Barrier to entry:* Low | *Time:* 45--60 minutes | *Coding:* None

*What you'll create:* Train a model through interaction and see the exact decision tree it creates.

*Steps:*

1. Go to `machinelearningforkids.co.uk`

2. Create an account (free)

3. Choose or create a project. Options:
   - Use a Quick Start (Pac-Man classifier, Noughts and Crosses)
   - Create your own game in Scratch, then train a model from your gameplay

4. *Collect training data:* Play the game or activity 15--25 times, letting the AI learn your patterns

5. *Train the model:* The system builds a decision tree from your examples

6. *Visualize the tree:* See the exact questions the AI learned to ask

7. *Test and iterate:* Test on new data. If accuracy is low, gather more training examples and retrain

*Project ideas:*
- Create a simple Scratch game, then train AI to predict your next move
- Manual activity: describe objects; train a classifier to recognize them
- Create a personality quiz; train a model to recognize patterns in answers

*Reflection:*
- Did the decision tree make sense? Could you explain it to someone else?
- What training examples were most helpful for the AI?

---

=== Project Option 4: Interactive Neural Network (TensorFlow Playground)
*Barrier to entry:* Low--Medium | *Time:* 60--75 minutes | *Coding:* None

*What you'll create:* Experiment with a neural network to solve a classification problem. Document what you learn.

*Steps:*

1. Go to `playground.tensorflow.org`

2. *Pick a dataset:* Start with "Circle" or "XOR". These are classic problems.

3. *Understand the data:* Blue and orange dots are two classes you want to separate.

4. *Build your network:* Add layers and neurons. Start simple (2 layers, 4 neurons) and gradually increase complexity.

5. *Train it:* Click Play and watch the network learn.

6. *Document your experiment:*
   - What architecture (number of layers/neurons) solved the problem best?
   - How many training steps did it take?
   - Did you encounter overfitting? How did you know?

7. *Try the Spiral dataset:* This is much harder. What did you have to change?

*Reflection:*
- Why did some networks learn faster than others?
- What was the relationship between network complexity and training time?
- Can you explain overfitting to someone else?

---

=== Project Option 5: Pre-Trained Models (Runway ML)
*Barrier to entry:* Very low | *Time:* 45--60 minutes | *Coding:* None | *What it teaches:* What modern AI can do

*What you'll create:* Use state-of-the-art models (already trained) to create something interesting.

*Steps:*

1. Go to `runwayml.com`

2. Create a free account

3. Explore available models. Some popular ones:
   - *Real-ESRGAN:* Upscale and improve low-quality images
   - *Pose Detection:* Detect body positions from video
   - *Stable Diffusion:* Generate images from text descriptions
   - *Style Transfer:* Apply artistic styles to photos

4. *Create a project:* Choose a model and use it on your own images/video/text

5. *Experiment:* Try different inputs. What works well? What breaks?

6. *Document results:* Take screenshots or save outputs

*Reflection:*
- These models were trained on massive datasets. How is that different from your training?
- What surprised you about what the AI could do?
- Where might this technology be used in the real world?

---

=== Stretch Option A: ML5.js (For Students with JavaScript Experience)
*Barrier to entry:* Medium | *Time:* 90 minutes | *Coding:* Yes (JavaScript) | *What it teaches:* Bridging AI and code

*What you'll create:* A web page that uses machine learning with code.

*Steps:*

1. Go to `thecodingtrain.com` and find the "ML5.js Beginner's Guide"

2. Watch "Train Your Own Neural Network" (video 6-1)

3. Follow along with the code examples. You can use the browser console or a code editor like Glitch

4. *Train a simple model:* Use mouse position as input, musical note as output

5. *Modify the example:* Change the inputs, outputs, or training data

*What you'll learn:*
- How to import ML5 library into a web page
- How to collect training data programmatically
- How to make predictions with your trained model
- How to integrate ML into interactive applications

*Example projects:*
- Train a model on your mouse movements to predict direction
- Create a simple game that learns from your playing style
- Detect poses and trigger animations based on body position

*Resources:*
- The Coding Train: Excellent video tutorials, beginner-friendly
- ML5.js documentation: ml5js.org

---

=== Stretch Option B: Python & Jupyter Notebooks (For Students with Python Experience)
*Barrier to entry:* Medium--High | *Time:* 90 minutes | *Coding:* Yes (Python) | *What it teaches:* Real data science workflow

*What you'll create:* A Python notebook that trains a real ML model on data.

*Steps:*

1. Go to `kaggle.com/code` and look for beginner-friendly notebooks about classification or neural networks

2. Find a simple dataset (Iris flowers, Titanic survival, MNIST digits)

3. Follow a notebook that:
   - Loads data
   - Splits into training and test sets
   - Trains a model
   - Evaluates accuracy

4. *Modify the notebook:* Change parameters, add more data, or try a different algorithm

5. *Run it and interpret results*

*What you'll learn:*
- Real ML workflow: data → training → evaluation
- Using libraries like scikit-learn or TensorFlow
- How to evaluate models properly
- How to prevent overfitting in practice

*Resources:*
- Kaggle Learn (free micro-courses on ML concepts)
- Fast.ai (excellent for beginners, practical approach)
- Google Colab (free Jupyter notebooks in the cloud)

---

=== Stretch Option C: TensorFlow.js (JavaScript + Deep Learning)
*Barrier to entry:* Medium--High | *Time:* 90 minutes | *Coding:* Yes (JavaScript) | *What it teaches:* Deep learning in the browser

*Similar to ML5.js but gives you more control and flexibility. More complex, but more powerful.*

*Resources:*
- TensorFlow.js official tutorials: tensorflow.org/js
- Examples include image classification, pose detection, text generation

---

== Documenting Your Project

Whatever you choose, create a simple write-up (1--2 pages) that includes:

1. *What you built:* Clear description of your AI project

2. *Training data:* How much data did you use? What kind? How did you collect it?

3. *Results:* What accuracy did you achieve? Did it work well?

4. *Challenges:* What was hard? What surprised you?

5. *What you learned:* In 2--3 sentences, what did you learn about how AI learns?

6. *Real-world applications:* Where could your model be used? What would be a real-world version of this?

---

== Reflection Questions (For Discussion or Journaling)

- *Training data matters.* How would your model change if you used different training data?

- *Speed vs. accuracy.* Did you find that more training improved accuracy? At what point did more training stop helping (overfitting)?

- *Bias in data.* If you trained on only your own face, would the model work well on someone else's face? Why or why not?

- *Real-world AI.* The models that power face recognition, content filters, and recommendation systems started exactly like yours. What could go wrong if training data isn't diverse?

---

== Quick Reference: Platform Comparison

#table(
  columns: (1.2fr, 0.8fr, 0.9fr, 0.9fr, 1.1fr),
  [*Platform*], [*Easiest?*], [*Best for*], [*Time*], [*Learning*],
  [Teachable Machine], [★★★★★], [Images, sounds], [45--60m], [Quick wins],
  [TensorFlow Playground], [★★★★☆], [Understanding NNs], [60--75m], [Deep concepts],
  [ML for Kids], [★★★★☆], [Decision trees], [45--60m], [Interpretability],
  [Runway ML], [★★★★★], [Creative use], [45--60m], [What AI can do],
  [ML5.js], [★★★☆☆], [Web + ML], [90m], [Code + concepts],
  [Python/Jupyter], [★★☆☆☆], [Real data science], [90m], [Professional workflow],
)

---

== Tips for Success

1. *Start simple.* Even with low-barrier platforms, begin with a small problem (2 classes, not 5).

2. *Gather enough data.* The most common mistake is training on too few examples. Aim for 20+ per class minimum.

3. *Test on unseen data.* Don't just test on the same examples you trained on. Try new angles, new backgrounds, new situations.

4. *Iterate.* If accuracy is low, don't give up. Get more training data and retrain.

5. *Understand errors.* When the model fails, it's teaching you something. Look at what it got wrong and why.

6. *Explain your thinking.* You should be able to explain your project to someone who's never done this before.

---

*Have fun exploring the cutting edge of AI. You're doing the exact same thing that machine learning engineers do---just with simpler tools and smaller datasets!*
