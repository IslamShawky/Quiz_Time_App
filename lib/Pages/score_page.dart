import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:com.mycompany.quizapp/bloc/score_sheet/score_sheet_cubit.dart';
import 'package:com.mycompany.quizapp/data/models/score_model.dart';
import 'package:com.mycompany.quizapp/data/repo/quiz_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class ScorePage extends StatefulWidget {
  const ScorePage(this.score, this.name, {Key? key}) : super(key: key);
  final int score;
  final String name;

  @override
  State<ScorePage> createState() => _ScorePageState();
}

class _ScorePageState extends State<ScorePage> {


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      width: width,
      height: height,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [Colors.purple, Colors.blue],
        ),
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: SizedBox(
            width: width,
            height: height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 15.0, top: 50, right: 15),
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(Icons.exit_to_app_rounded,
                          color: Colors.white, size: 30),
                    ),
                  ),
                ),
                const Spacer(),
                Container(
                    height: 250,
                    width: 250,
                    margin: const EdgeInsets.only(bottom: 40),
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(130)),
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
                        width: 220,
                        height: 220,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(130)),
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
                            child: Text(
                          widget.score >= 30 ? "PASSED" : "FAILED",
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 40,
                            color:
                                widget.score >= 30 ? Colors.green : Colors.red,
                          ),
                        )),
                      ),
                    )),
                Text(
                  widget.score >= 30 ? "Congratulations" : "Sorry",
                  style: const TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 30,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "Your score is\n${widget.score}/50",
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 25,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                const Spacer(),
                BlocProvider(
                  create: (context) => ScoreSheetCubit(QuizRepository()),
                  child: BlocBuilder<ScoreSheetCubit, ScoreSheetState>(
                    builder: (context, state) {
                      return Align(
                        alignment: Alignment.center,
                        child: InkWell(
                          onTap: state is ScoreSheetLoaded ? (){} :() {
                            BlocProvider.of<ScoreSheetCubit>(context).addToScoreSheet(Score(
                              name: widget.name,
                              score: widget.score,
                              time: Timestamp.fromDate(DateTime.now()),
                            ));
                          },
                          child: Container(
                            height: 55,
                            width: width - 70,
                            decoration: const BoxDecoration(
                              color: Colors.transparent,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30)),
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 10,
                                    spreadRadius: 4,
                                    color: Colors.black45,
                                    blurStyle: BlurStyle.outer),
                              ],
                            ),
                            child:  Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    state is ScoreSheetLoading ? "Saving ..." : state is ScoreSheetLoaded ? "Saved" : "Save To Score Sheet",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 24,
                                      color: Colors.white,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(width: 10),
                                  if (state is ScoreSheetInitial) const Icon(
                                    Icons.save,
                                    color: Colors.white,
                                    size: 28,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
