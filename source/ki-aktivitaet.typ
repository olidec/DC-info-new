#set text(font: "New Computer Modern", lang: "de")
#set page(margin: 1in)
#set heading(numbering: "1.")

#align(center)[
  #text(size: 22pt, weight: "bold")[Trainieren Sie Ihre eigene KI]
  #v(0.1in)
  #text(size: 13pt)[Eine praktische Projektaktivität]
]

#v(0.3in)

Maschinelles Lernen ist überall: Es entsperrt Ihr Handy mit Ihrem Gesicht, filtert Spam aus Ihrem Posteingang und empfiehlt Ihnen das nächste Video. In dieser Aktivität tun Sie dasselbe wie diese Systeme, nur mit einfacheren Werkzeugen und kleineren Datensätzen. Sie *trainieren Ihr eigenes KI-Modell* und setzen es ein.

*So funktioniert es.* Unten finden Sie mehrere Projekte. Lesen Sie die kurzen Einführungen, wählen Sie *eines* aus, das Sie interessiert, und bauen Sie es. Jedes Projekt ist in sich geschlossen und so konzipiert, dass es bequem in eine einzige Lektion passt. Wenn Sie früher fertig sind oder eine Herausforderung suchen, probieren Sie ein zweites Projekt aus oder schauen Sie sich die Optionen unter "Weiterführendes" an.

Machen Sie sich keine Sorgen, dass Sie zuerst die ganze Theorie verstehen müssen, Sie werden überraschend viel allein durch Ausprobieren lernen. Falls Sie neugierig werden, *wie* die KI tatsächlich lernt, enthält das letzte Kapitel einige ausgezeichnete Videos und Ressourcen, um tiefer einzutauchen.

#v(0.2in)
#line(length: 100%, stroke: 0.5pt)

= Projekt A: Bilderkennung

*Werkzeug:* Teachable Machine (`teachablemachine.withgoogle.com`) --- ohne Programmierung, ohne Konto

== Einführung

Mit Teachable Machine können Sie einen Bildklassifikator allein mit Ihrer Webcam trainieren. Sie zeigen ihm Beispiele verschiedener Kategorien ("Klassen"), es lernt die Muster und kann anschliessend neue Beispiele in Echtzeit erkennen. Im Hintergrund verwendet es ein echtes neuronales Netz, aber Sie müssen die Mathematik nie anrühren.

Die Grundidee ist einfach: Je vielfältiger und hochwertiger die Beispiele sind, die Sie ihm geben, desto besser arbeitet es. Dies ist die wichtigste Lektion im maschinellen Lernen, und Sie werden sie direkt erleben.

== Ihre Aufgabe

Bauen Sie einen Bildklassifikator, der mindestens *drei* Kategorien Ihrer Wahl zuverlässig unterscheiden kann.

1. Wählen Sie "Image Project" und dann "Standard image model".
2. Erstellen Sie Ihre Klassen und nehmen Sie für jede 20--30 Webcam-Bilder auf. Variieren Sie Winkel, Beleuchtung und Hintergrund, damit das Modell das *echte* Muster lernt und nicht nur eine feste Pose.
3. Klicken Sie auf "Train Model" und testen Sie es live.
4. Versuchen Sie bewusst, es zu überlisten. Finden Sie eine Eingabe, die es falsch erkennt, fügen Sie dann Trainingsbeispiele hinzu, um diese Schwäche zu beheben, und trainieren Sie erneut.

*Ideen:* Schere-Stein-Papier-Handformen; Gesichtsausdrücke (glücklich / überrascht / neutral); das Erkennen bestimmter Gegenstände auf Ihrem Pult; "trägt die Person eine Brille oder nicht".

*Fordern Sie sich heraus:* Können Sie eine Sicherheit von über 90% bei Eingaben erreichen, die es noch nie gesehen hat? Welche Arten von Fehlern sind am schwierigsten zu beheben?

#line(length: 100%, stroke: 0.5pt)

= Projekt B: Geräusch- und Spracherkennung

*Werkzeug:* Teachable Machine (`teachablemachine.withgoogle.com`) --- ohne Programmierung, ohne Konto

== Einführung

Dieselbe Plattform kann lernen, *Geräusche* anstelle von Bildern zu erkennen. Dies ist die Technologie hinter Sprachassistenten, die aufwachen, wenn Sie einen bestimmten Satz sagen. Sie nehmen kurze Audioproben für jedes Geräusch auf, das Sie erkennen möchten, und das Modell lernt, sie zu unterscheiden, sogar von Hintergrundgeräuschen.

Audio ist etwas kniffliger als Bilder, weil Hintergrundgeräusche und Timing eine Rolle spielen, was es zu einem befriedigenden Problem macht, wenn man es richtig hinbekommt.

== Ihre Aufgabe

Trainieren Sie einen Geräuschklassifikator, der auf mindestens *zwei* unterschiedliche Geräusche sowie eine Klasse "Hintergrundgeräusch" reagiert.

1. Wählen Sie "Audio Project".
2. Nehmen Sie zuerst die erforderlichen "Background Noise"-Proben auf (dies bringt ihm bei, wie *Stille* klingt).
3. Fügen Sie 8--20 Proben jedes Zielgeräuschs hinzu.
4. Trainieren und testen Sie es live. Beachten Sie, wie es sich verhält, wenn sich Geräusche überlappen oder wenn Sie deren Lautstärke verändern.

*Ideen:* Klatschen vs. Schnipsen vs. Stille; einfache Sprachbefehle ("hoch" / "runter" / "stopp"); Pfeifen in verschiedenen Tonhöhen; das Erkennen einer Türklingel oder eines Alarmtons.

*Fordern Sie sich heraus:* Funktioniert es auch, wenn jemand anderes die Geräusche macht? Was sagt Ihnen das darüber, wie repräsentativ Ihre Trainingsdaten waren?

#line(length: 100%, stroke: 0.5pt)

= Projekt C: Ein Modell, in das Sie hineinsehen können

*Werkzeug:* Machine Learning for Kids (`machinelearningforkids.co.uk`) --- ohne Programmierung (kostenloses Konto)

== Einführung

Eine häufige Kritik an KI ist, dass sie eine "Blackbox" sei, sie gibt eine Antwort, kann aber nicht erklären, warum. Dieses Projekt geht das direkt an. Sie trainieren ein Modell und betrachten dann den tatsächlichen *Entscheidungsbaum*, den es gebaut hat: ein Flussdiagramm von Ja/Nein-Fragen, die die KI gelernt hat zu stellen, um ihre Vorhersagen zu treffen. Sie können den Verzweigungen selbst folgen und genau nachvollziehen, wie eine Entscheidung getroffen wird.

Dies ist eine ausgezeichnete Wahl, wenn Sie gerne verstehen, *warum* etwas funktioniert, und nicht nur, dass es funktioniert.

== Ihre Aufgabe

Trainieren Sie einen Klassifikator und erklären Sie dann seine Entscheidungsfindung in Ihren eigenen Worten.

1. Erstellen Sie ein kostenloses Konto und beginnen Sie ein neues Projekt (die Quick-Start-Projekte sind ein guter Einstieg).
2. Sammeln Sie einen soliden Satz beschrifteter Trainingsbeispiele.
3. Trainieren Sie das Modell und öffnen Sie dann die Entscheidungsbaum-Visualisierung.
4. Schreiben Sie eine kurze Erklärung: Welche Frage stellt der Baum zuerst, und warum denken Sie, dass diese am wichtigsten ist? Verfolgen Sie einen vollständigen Pfad von oben bis zu einer Vorhersage.

*Ideen:* ein Klassifikator "Errate das Tier" anhand von Beschreibungen; das Einsortieren von Nachrichten als freundlich vs. unfreundlich; ein Ja/Nein-Empfehlungssystem ("wird mir das gefallen?").

*Fordern Sie sich heraus:* Erstellen Sie absichtlich ein *schlechtes* Modell, indem Sie es mit verzerrten oder einseitigen Trainingsdaten füttern. Wie verändert sich der Baum? Genau so schleicht sich Verzerrung (Bias) in reale KI ein.

#line(length: 100%, stroke: 0.5pt)

= Projekt D: Experimentieren Sie mit einem neuronalen Netz

*Werkzeug:* TensorFlow Playground (`playground.tensorflow.org`) --- ohne Programmierung, nichts zu installieren

== Einführung

Bei diesem Projekt geht es weniger darum, "ein nützliches Gerät zu trainieren", als vielmehr darum, "die Motorhaube zu öffnen und herumzubasteln". TensorFlow Playground ist ein neuronales Netz, das live in Ihrem Browser läuft. Sie können Schichten und Neuronen hinzufügen, die Lerngeschwindigkeit ändern und in Echtzeit beobachten, wie es herausfindet, zwei Gruppen von Punkten zu trennen. Die Farben und Kurven zeigen Ihnen das Netz beim "Denken".

Es ist seltsam fesselnd und baut ein echtes Gespür dafür auf, was im Inneren der Modelle der anderen Projekte geschieht.

== Ihre Aufgabe

Lösen Sie die schwierigen Datensätze und dokumentieren Sie, was Sie entdecken.

1. Beginnen Sie mit dem Datensatz "Circle". Drücken Sie auf Play und beobachten Sie, wie es lernt. Versuchen Sie dann, ihn mit dem *kleinstmöglichen* Netz zu lösen.
2. Wechseln Sie zum Datensatz "Spiral", dem schwierigsten. Die meisten einfachen Netze scheitern daran. Experimentieren Sie mit mehr Schichten, mehr Neuronen und verschiedenen Merkmalen, bis Sie ihn knacken.
3. Trainieren Sie ein Netz, bis es bei den Trainingsdaten nahezu perfekt abschneidet, und schauen Sie dann auf den Testverlust (Test Loss). Wenn der Testverlust deutlich schlechter ist, haben Sie soeben *Overfitting* (Überanpassung) beobachtet.

Notieren Sie die Konfiguration, die die Spirale schliesslich gelöst hat, und einen Satz darüber, wie das Overfitting aussah, als Sie es sahen.

*Fordern Sie sich heraus:* Was ist das einfachste Netz (mit den wenigsten Neuronen/Schichten), das die Spirale immer noch löst? Einfachere Modelle, die funktionieren, sind oft besser, finden Sie das Minimum.

#line(length: 100%, stroke: 0.5pt)

= Projekt E: Bauen Sie mit Modellen, die die Profis verwenden

*Werkzeug:* Runway ML (`runwayml.com`) --- ohne Programmierung (kostenloses Konto)

== Einführung

Anstatt ein Modell von Grund auf zu trainieren, können Sie in diesem Projekt leistungsstarke Modelle *verwenden*, die bereits auf riesigen Datensätzen trainiert wurden, dieselbe Art von Werkzeugen, die von Künstlern, Filmemachern und Designern genutzt werden. Sie erkunden, was modernste KI heute tatsächlich leisten kann, und erstellen etwas damit.

Dies passt gut, wenn Sie sich mehr für die kreative und praktische Seite der KI interessieren als für die Trainingsmechanik.

== Ihre Aufgabe

Wählen Sie ein vortrainiertes Modell aus, erstellen Sie etwas damit und reflektieren Sie dann über seine Grenzen.

1. Erstellen Sie ein kostenloses Konto und durchstöbern Sie die verfügbaren Modelle (Bilderzeugung, Stilübertragung, Hintergrundentfernung, Posenerkennung und mehr).
2. Wählen Sie eines aus und wenden Sie es auf Ihre eigenen Eingaben an. Experimentieren Sie mit verschiedenen Eingaben.
3. Finden Sie seine Grenzen: Geben Sie ihm etwas Ungewöhnliches und sehen Sie, wo es scheitert oder etwas Seltsames produziert.

*Ideen:* einen künstlerischen Stil auf Ihre eigenen Fotos anwenden; Bilder aus Textbeschreibungen erzeugen; Körperhaltungen in einem kurzen Videoclip erkennen; ein Bild mit niedriger Qualität hochskalieren.

*Fordern Sie sich heraus:* Diese Modelle haben aus Millionen von Beispielen gelernt, die aus dem Internet zusammengetragen wurden. Wo könnten diese Daten verzerrt oder unausgewogen gewesen sein, und wie könnte sich das in Ihren Ergebnissen zeigen?

#line(length: 100%, stroke: 0.5pt)

= Weiterführendes: Für starke Programmiererinnen und Programmierer

Sie haben dieses Jahr ein wenig Python und JavaScript kennengelernt. Wenn Sie über die No-Code-Werkzeuge hinausgehen und KI schreiben möchten, die *Sie* steuern, sind dies die natürlichen nächsten Schritte. Wählen Sie diese nur, wenn Sie sich mit dem Programmieren wohlfühlen, sie sind deutlich anspruchsvoller, aber weitaus leistungsfähiger.

== ML5.js (JavaScript)

Eine anfängerfreundliche Bibliothek, die maschinelles Lernen direkt im Browser ausführt und für Künstler und Studierende konzipiert wurde. Mit wenigen Zeilen JavaScript können Sie ein neuronales Netz trainieren, Bilder klassifizieren oder Körperhaltungen erkennen und dies mit visueller Ausgabe über p5.js kombinieren.

*Wo Sie beginnen:* Der "ML5.js Beginner's Guide" von The Coding Train (`thecodingtrain.com`) ist eine hervorragende kostenlose Videoserie. Versuchen Sie, ein Modell zu trainieren, das Ihre Mausposition auf eine Ausgabe abbildet, und bauen Sie darauf etwas Interaktives auf.

== Python mit Jupyter Notebooks

So wird maschinelles Lernen professionell betrieben. Mit kostenlosen Notebooks (keine Einrichtung erforderlich) können Sie einen echten Datensatz laden, ihn in Trainings- und Testdaten aufteilen, ein Modell mit einer Bibliothek wie scikit-learn trainieren und richtig auswerten, wie gut es verallgemeinert.

*Wo Sie beginnen:* "Kaggle Learn" (`kaggle.com/learn`) bietet kurze, kostenlose, praktische Kurse an. Klassische Anfänger-Datensätze sind Iris (Blumenklassifikation), Titanic (Überlebensvorhersage) und MNIST (handgeschriebene Ziffern). Mit Google Colab (`colab.research.google.com`) können Sie Python-Notebooks kostenlos in der Cloud ausführen.

== TensorFlow.js (JavaScript)

Wie ML5.js, aber auf einer tieferen Ebene und leistungsfähiger, dies ist Googles Bibliothek für Deep Learning im Browser. Mehr zu lernen, aber Sie erhalten feinkörnige Kontrolle über das Erstellen und Trainieren von Netzen.

*Wo Sie beginnen:* Die offiziellen Tutorials unter `tensorflow.org/js`.

#line(length: 100%, stroke: 0.5pt)

= Verstehen, wie es wirklich funktioniert

Sie haben nun Modelle durch Experimentieren trainiert. Falls das die Neugier geweckt hat, was *tatsächlich* geschieht, wenn eine KI "lernt", erklären diese Ressourcen die zugrunde liegenden Ideen wunderschön, ganz ohne fortgeschrittenes Mathematikstudium. Sie sind optional, aber wirklich Ihre Zeit wert.

== Videos

*3Blue1Brown --- Serie "Neural Networks".* Der Goldstandard. Grant Sanderson nutzt wunderschöne Animationen, um ein tiefes Verständnis dafür aufzubauen, wie neuronale Netze funktionieren, angefangen bei einem einzelnen Neuron bis hin dazu, wie sie lernen. Beginnt mit "But what is a neural network?" und führt weiter über Gradientenabstieg und Backpropagation. Suchen Sie "3Blue1Brown Neural Networks" auf YouTube oder besuchen Sie `3blue1brown.com`. Die Serie passt perfekt zu dem, was Sie in Projekt D gesehen haben.

*StatQuest mit Josh Starmer.* Freundliche, klare und leicht alberne Erklärungen der Statistik und Konzepte hinter dem maschinellen Lernen. Hervorragend, wenn Sie ein einzelnes Konzept (wie Entscheidungsbäume oder Gradientenabstieg) Schritt für Schritt aufgeschlüsselt haben möchten. Suchen Sie "StatQuest" auf YouTube.

*The Coding Train.* Energiegeladene, anfängerfreundliche Programmier-Tutorials, einschliesslich einer ganzen Reihe über maschinelles Lernen mit ML5.js. Ideal, wenn Sie am besten lernen, indem Sie gemeinsam mit jemandem etwas bauen. (`thecodingtrain.com`)

== Interaktiv & zum Lesen

*R2D3 --- "A Visual Introduction to Machine Learning".* Eine beeindruckende Scroll-Geschichte, die Entscheidungsbäume, Trainings- vs. Testdaten und Overfitting mithilfe interaktiver Grafiken erklärt. (`r2d3.us`)

*Googles "Machine Learning Crash Course".* Ein strukturierterer, kostenloser Kurs von Google mit Texten, Visualisierungen und Übungen, für den Fall, dass Sie etwas möchten, das eher einem Lehrbuch ähnelt. (`developers.google.com/machine-learning/crash-course`)

*Elements of AI.* Ein kostenloser, beliebter Online-Kurs, der KI-Konzepte in einfacher Sprache erklärt, ohne Programmierung. Ideal für die übergeordneten Fragen "Was ist KI und was kann sie?". (`elementsofai.com`)

== Einige Konzepte, die einen Blick wert sind

Während Sie schauen und lesen, sind dies die Ideen, die alles miteinander verbinden, und denen Sie in Ihren Projekten bereits begegnet sind:

- *Trainingsdaten* --- die Beispiele, aus denen ein Modell lernt (Sie haben diese selbst zusammengestellt).
- *Neuronales Netz* --- Schichten einfacher Einheiten, die zusammenwirken, um komplexe Muster zu erkennen (Sie haben in Projekt D eines beim Lernen beobachtet).
- *Klassifikation* --- das Einsortieren von Eingaben in Kategorien (Projekte A, B, C).
- *Overfitting (Überanpassung)* --- das Auswendiglernen der Trainingsdaten, anstatt das allgemeine Muster zu lernen.
- *Verzerrung in Daten (Bias)* --- wenn nicht repräsentative Trainingsdaten zu unfairen oder falschen Ergebnissen führen.
