import 'package:com.mycompany.quizapp/bloc/score_sheet/score_sheet_cubit.dart';
import 'package:com.mycompany.quizapp/data/repo/quiz_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ScoreSheetPage extends StatefulWidget {
  const ScoreSheetPage({Key? key}) : super(key: key);

  @override
  State<ScoreSheetPage> createState() => _ScoreSheetPageState();
}

class _ScoreSheetPageState extends State<ScoreSheetPage> {
  final dateFormat = DateFormat('MMM-dd-yy\nHH:mm a');

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
              crossAxisAlignment: CrossAxisAlignment.start,
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
                const Padding(
                  padding: EdgeInsets.only(left: 15.0, bottom: 5),
                  child: Text(
                    "Score Sheet",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: Colors.white),
                  ),
                ),
                BlocProvider(
                  create: (context) => ScoreSheetCubit(QuizRepository()),
                  child: BlocBuilder<ScoreSheetCubit, ScoreSheetState>(
                    builder: (context, state) {
                      if (state is ScoreSheetInitial) {
                        BlocProvider.of<ScoreSheetCubit>(context)
                            .getScoreSheets();
                        return const SizedBox();
                      } else if (state is ScoreSheetLoading) {
                        return const Padding(
                          padding: EdgeInsets.only(top: 100),
                          child: Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          ),
                        );
                      } else if (state is ScoreSheetLoaded) {
                        return Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Table(
                            border: TableBorder.all(
                              borderRadius: const BorderRadius.all(Radius.circular(20)),
                              color: Colors.white,
                            ),
                            columnWidths: const {
                              0: FlexColumnWidth(3),
                              1: FlexColumnWidth(2),
                              2: FlexColumnWidth(3),
                            },
                            children: [
                              scoreTitleTableRow(),
                              for (var score in state.scoreSheet)
                                scoreBodyTableRow(
                                    score.name ?? "",
                                    score.score ?? 0,
                                    score.time != null
                                        ? dateFormat
                                            .format(score.time!.toDate())
                                        : "")
                            ],
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.white,
                            duration: const Duration(seconds: 1),
                            content: Center(
                              child: Text(
                                'Loading Failed',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary),
                              ),
                            ),
                          ),
                        );
                        return const SizedBox();
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  TableRow scoreTitleTableRow() {
    return const TableRow(

        children: [
          TableCell(
            verticalAlignment: TableCellVerticalAlignment.middle,
            child: Text(
              "Name",
              style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          TableCell(
            verticalAlignment: TableCellVerticalAlignment.middle,
            child: Text("Score",
              style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,),
          ),
          TableCell(
            verticalAlignment: TableCellVerticalAlignment.middle,
            child: Padding(
              padding: EdgeInsets.symmetric( vertical: 10.0),
              child: Text("Date/Time",
                style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,),
            ),
          )
        ]);
  }
  TableRow scoreBodyTableRow(String name, int score, String time) {
    return TableRow(

        children: [
      TableCell(
        verticalAlignment: TableCellVerticalAlignment.middle,
        child: Text(
          name,
          style: const TextStyle(color: Colors.white, fontSize: 16),
          textAlign: TextAlign.center,
        ),
      ),
      TableCell(
        verticalAlignment: TableCellVerticalAlignment.middle,
        child: Text(score.toString(),
          style: const TextStyle(color: Colors.white, fontSize: 16),
          textAlign: TextAlign.center,),
      ),
      TableCell(
        verticalAlignment: TableCellVerticalAlignment.middle,
        child: Padding(
          padding: const EdgeInsets.symmetric( vertical: 10.0),
          child: Text(time,
            style: const TextStyle(color: Colors.white, fontSize: 16),
            textAlign: TextAlign.center,),
        ),
      )
    ]);
  }
}
