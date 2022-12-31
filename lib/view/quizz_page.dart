import 'package:flutter/material.dart';
import 'package:quizz_app/model/result.dart';
import 'package:quizz_app/service/quizz_service.dart';
// ignore: depend_on_referenced_packages
import 'package:cached_network_image/cached_network_image.dart';

class QuizzPage extends StatefulWidget {
  const QuizzPage({super.key});

  @override
  _QuizzPageState createState() => _QuizzPageState();
}

class _QuizzPageState extends State<QuizzPage>
    with SingleTickerProviderStateMixin {
  int _score = 0;

  late AnimationController controller;
  late Animation animation;
  double begin = 0.0;
  double end = 1.0;
  QuizzService quizzService = QuizzService();

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 10));

    animation = Tween<double>(begin: begin, end: end).animate(controller)
      ..addListener(() {
        setState(() {
          // the state that has changed here is the animation object’s value
        });
      });

    controller.forward();

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        if (quizzService.indexLessThanLength()) {
          addCloseIconIfNotPressed();

          quizzService.nextQuestion;
          controller.reset();
          controller.forward();
        } else {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => QuizzResult(score: _score)));
        }
      }
    });
  }

  void nextQuestion() {
    if (quizzService.indexLessThanLength()) {
      quizzService.nextQuestion;
      controller.reset();
      controller.forward();
    } else {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => QuizzResult(score: _score)));
    }
    setState(() {
      _isPressed = false;
    });
  }

  List<Icon> scoreKeeper = [];
  bool _isPressed = false;

  void validateAnswer(bool userEntry) {
    if (quizzService.answerIsCorrect(userEntry)) {
      scoreKeeper.add(const Icon(
        Icons.check,
        color: Colors.green,
      ));
    } else {
      scoreKeeper.add(const Icon(
        Icons.close,
        color: Colors.red,
      ));
    }
    nextQuestion();
  }

  void addCloseIconIfNotPressed() {
    if (!_isPressed) {
      setState(() {
        scoreKeeper.add(const Icon(
          Icons.close,
          color: Colors.red,
        ));
      });
    }
    ;
  }

  void calculateScore(bool answer) {
    if (quizzService.answerIsCorrect(answer)) _score += 10;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Quizz : questions et réponses"),
        backgroundColor: Colors.grey[850],

      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  // child: Row(
                  children: [
                    Text(
                      quizzService.getCurrentQuestion().questionText,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 20.0,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    LinearProgressIndicator(
                      value: animation.value,
                    ),
                    CachedNetworkImage(
                      imageUrl: quizzService.getCurrentQuestion().questionImage,
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                      fit: BoxFit.fitWidth,
                      width: MediaQuery.of(context).size.width - 12,
                      height: MediaQuery.of(context).size.height / 2,
                    ),
                  ],
                  //  )
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.green),
                ),
                child: const Text(
                  'Vrai',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                  ),
                ),
                onPressed: () {
                  setState(() {
                    _isPressed = true;
                    calculateScore(true);
                    validateAnswer(true);
                  });
                },
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.red),
                ),
                child: const Text(
                  'Faux',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.black,
                  ),
                ),
                onPressed: () {
                  setState(() {
                    calculateScore(false);
                    validateAnswer(false);
                  });
                  //The user picked false.
                },
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: scoreKeeper,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
