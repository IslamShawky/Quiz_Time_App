import 'package:com.mycompany.quizapp/bloc/word_list/word_list_cubit.dart';
import 'package:com.mycompany.quizapp/data/models/word_model.dart';
import 'package:com.mycompany.quizapp/data/repo/quiz_repository.dart';
import 'package:flutter/material.dart';
import 'package:com.mycompany.quizapp/Pages/question_page_view_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'score_page.dart';

enum Answers { verb, noun, adverb, adjective, noneSelected }

class QuestionsPage extends StatefulWidget {
  const QuestionsPage(this.name, {Key? key}) : super(key: key);
  final String name;

  @override
  State<QuestionsPage> createState() => _QuestionsPageState();
}

class _QuestionsPageState extends State<QuestionsPage> {
  int _activePage = 0;
  final PageController _pageController = PageController(initialPage: 0);
  Answers selectedAnswer = Answers.noneSelected;
  int score = 0;
  List<WordList> wordList = [];

  bool checkAnswer() {
    switch (selectedAnswer) {
      case Answers.noneSelected:
        {
          return false;
        }
      case Answers.verb:
        {
          return wordList[_activePage].pos!.toLowerCase() == "verb"
              ? true
              : false;
        }
      case Answers.adverb:
        {
          return wordList[_activePage].pos!.toLowerCase() == "adverb"
              ? true
              : false;
        }
      case Answers.noun:
        {
          return wordList[_activePage].pos!.toLowerCase() == "noun"
              ? true
              : false;
        }
      case Answers.adjective:
        {
          return wordList[_activePage].pos!.toLowerCase() == "adjective"
              ? true
              : false;
        }
    }
  }

  void select(Answers answer) {
    if (selectedAnswer == Answers.noneSelected) {
      setState(() {
        selectedAnswer = answer;
        if (checkAnswer()) {
          score += 10;
        }
      });

    }
  }
  bool pop = false;

  Future<bool> leaveAlert() async {
    !pop
        ? await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 20,
            ),
            Text(
              "Are you sure you want to leave ?\nYour answers will be lost.",
              style: TextStyle(),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: [
          ElevatedButton(
              child: const Text("YES"),
              onPressed: () {
                Navigator.of(context).pop(true);
              }),
          ElevatedButton(
              child: const Text("NO"),
              onPressed: () {
                Navigator.of(context).pop(false);
              }),
        ],
      ),
    ).then((value) => pop = value)
        : null;
    return pop;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () async {
        return await leaveAlert();
      },
      child: Container(
        width: width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [Colors.purple, Colors.blue],
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SizedBox(
            height: height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15.0, top: 50, right: 15),
                    child: InkWell(
                      onTap: (){
                        leaveAlert().then((value){
                          if(pop) {
                            Navigator.pop(context);
                          }
                        });
                      },
                      child: const Icon(Icons.exit_to_app_rounded, color: Colors.white, size: 30),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, bottom: 5),
                  child: Text(
                    "Good Luck, ${capitalizeNames(widget.name.split(" ").first)}",
                    maxLines: 2,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: Colors.white),
                  ),
                ),
                BlocProvider(
                  create: (context) => WordListCubit(QuizRepository()),
                  child: BlocBuilder<WordListCubit, WordListState>(
                    builder: (context, state) {
                      if (state is WordListInitial) {
                        BlocProvider.of<WordListCubit>(context).getWordLists();
                        return const SizedBox();
                      } else if (state is WordListFailed) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.white,
                            duration: const Duration(seconds: 1),
                            content: Center(
                              child: Text(
                                'Loading Failed',
                                style: TextStyle(
                                    fontSize: 14,
                                    color:
                                        Theme.of(context).colorScheme.secondary),
                              ),
                            ),
                          ),
                        );
                        return const SizedBox();
                      } else if (state is WordListLoading) {
                        return QuestionPageViewPage(WordList());
                      } else if (state is WordListLoaded) {
                        wordList = state.wordLists;
                        return Column(
                          children: [
                            SizedBox(
                              height: 210,
                              child: PageView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                controller: _pageController,
                                scrollDirection: Axis.horizontal,
                                itemCount: wordList.length,
                                onPageChanged: (int page) {
                                  setState(() {
                                    _activePage = page;
                                  });
                                },
                                itemBuilder: (context, index) =>
                                    QuestionPageViewPage(wordList[index]),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List<Widget>.generate(
                                  wordList.length,
                                  (index) => Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Container(
                                          width: 15,
                                          height: 15,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(8)),
                                              color: _activePage < index
                                                  ? Colors.transparent
                                                  : Colors.white,
                                              border: Border.all(
                                                  width: 3, color: Colors.white)),
                                        ),
                                      )),
                            ),
                            SizedBox(
                              height: 210,
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: GridView(
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: 3,
                                    crossAxisSpacing: 15,
                                  ),
                                  children: [
                                    RadioListTile(
                                        title: const Text(
                                          "Verb",
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                        contentPadding: const EdgeInsets.all(0),
                                        value: Answers.verb,
                                        activeColor: Colors.white,
                                        groupValue: selectedAnswer,
                                        onChanged: (value) {
                                          select(value!);
                                        }),
                                    RadioListTile(
                                        title: const Text(
                                          "Adverb",
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                        contentPadding: const EdgeInsets.all(0),
                                        value: Answers.adverb,
                                        activeColor: Colors.white,
                                        groupValue: selectedAnswer,
                                        onChanged: (value) {
                                          select(value!);
                                        }),
                                    RadioListTile(
                                        title: const Text(
                                          "Noun",
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                        contentPadding: const EdgeInsets.all(0),
                                        value: Answers.noun,
                                        activeColor: Colors.white,
                                        groupValue: selectedAnswer,
                                        onChanged: (value) {
                                          select(value!);
                                        }),
                                    RadioListTile(
                                      title: const Text(
                                        "Adjective",
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                      contentPadding: const EdgeInsets.all(0),
                                      value: Answers.adjective,
                                      activeColor: Colors.white,
                                      groupValue: selectedAnswer,
                                      onChanged: (value) {
                                        select(value!);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      } else {
                        return const SizedBox();
                      }
                    },
                  ),
                ),
                const Spacer(),
                if (selectedAnswer != Answers.noneSelected)
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                        height: 150,
                        width: 150,
                        // padding: const EdgeInsets.symmetric(
                        //     horizontal: 20.0),
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(100)),
                            gradient: const LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [Colors.blue, Colors.purple],
                            ),
                            boxShadow: const [
                              BoxShadow(
                                  color: Colors.black45,
                                  spreadRadius: 5,
                                  blurRadius: 2),
                              BoxShadow(
                                  color: Colors.black26,
                                  spreadRadius: 10,
                                  blurRadius: 4),
                            ]),
                        child: Center(
                          child: Container(
                            width: 120,
                            height: 120,
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(100)),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black45,
                                      spreadRadius: 5,
                                      blurRadius: 2),
                                  BoxShadow(
                                      color: Colors.black26,
                                      spreadRadius: 10,
                                      blurRadius: 4),
                                ]),
                            child: Center(
                              child: checkAnswer()
                                  ? const Icon(
                                      Icons.check_rounded,
                                      color: Colors.green,
                                      size: 100,
                                    )
                                  : const Icon(
                                      Icons.close_rounded,
                                      color: Colors.red,
                                      size: 100,
                                    ),
                            ),
                          ),
                        )),
                  ),
                const Spacer(),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30.0, vertical: 35),
                    child: InkWell(
                      onTap: () {
                        if (selectedAnswer != Answers.noneSelected) {
                          if (_activePage != wordList.length - 1) {
                            selectedAnswer = Answers.noneSelected;
                            _pageController.animateToPage(_activePage + 1,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeIn);
                          } else {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ScorePage(score, widget.name),
                                ));
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.white,
                              duration: const Duration(seconds: 1),
                              content: Center(
                                child: Text(
                                  'You have to pick an answer',
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary),
                                ),
                              ),
                            ),
                          );
                        }
                      },
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Next",
                            style: TextStyle(color: Colors.white, fontSize: 22),
                          ),
                          Icon(
                            Icons.navigate_next_outlined,
                            color: Colors.white,
                            size: 30,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
