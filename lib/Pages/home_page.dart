import 'package:com.mycompany.quizapp/Pages/score_sheet_page.dart';
import 'package:flutter/material.dart';
import 'package:com.mycompany.quizapp/Pages/questions_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool shown = false;
  String name = "";

  void showContainers() {
    Future.delayed(const Duration(milliseconds: 5)).then((value) {
      setState(() {
        shown = true;
      });
    });
  }

  TextEditingController controller = TextEditingController();


  @override
  void initState() {
    showContainers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 15.0, top: 50, bottom: 5),
                child: Text(
                  "Quiz Time",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: Colors.white),
                ),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 600),
                width: shown ? width : 0,
                height: 240,
                margin: const EdgeInsets.only(right: 40, top: 5),
                padding: const EdgeInsets.all(12),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 4, spreadRadius: 2, color: Colors.black45),
                  ],
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: const NeverScrollableScrollPhysics(),
                  child: SizedBox(
                    width: width - 40,
                    child: const Text(
                      "Welcome to the Part of Speech Quiz! Test your understanding of parts of speech in English."
                      "\nYou'll be given words and asked to identify their correct part of speech: verb, adverb, adjective, or noun."
                      "\nChoose the right option from four choices and receive instant feedback. Improve your knowledge and categorization skills."
                      "\nReady to become a part of speech expert? Let's begin! Good luck!",
                      style: TextStyle(fontSize: 15, color: Colors.deepPurple),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 600),
                      width: shown ? width : 0,
                      height: 220,
                      margin: const EdgeInsets.only(left: 40, top: 50),
                      padding: const EdgeInsets.all(12),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          bottomLeft: Radius.circular(30),
                        ),
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 4,
                              spreadRadius: 2,
                              color: Colors.black45),
                        ],
                      ),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        physics: const NeverScrollableScrollPhysics(),
                        child: SizedBox(
                          width: width - 70,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "ENTER YOUR NAME",
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 17,
                                      fontWeight: FontWeight.w900),
                                ),
                                const SizedBox(height: 15),
                                TextFormField(
                                  controller: controller,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 3, color: Colors.blue),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(30)),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 3, color: Colors.blue),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(30)),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 3, color: Colors.blue),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(30)),
                                    ),
                                    hintText: "Type your name here",
                                  ),
                                  onTapOutside: (val) {
                                    FocusScope.of(context).unfocus();
                                  },
                                  onChanged: (value){
                                    name = value;
                                  },
                                ),
                                const SizedBox(height: 15),
                                InkWell(
                                    onTap: () {
                                      if(name.trim().isNotEmpty){
                                        setState(() {
                                          shown = false;
                                        });
                                        Future.delayed(const Duration(milliseconds: 600)).then((value){
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => QuestionsPage(name),)).then((value){
                                            setState(() {
                                              shown = true;
                                              controller.clear();
                                            });
                                          });
                                        });
                                      } else{
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            backgroundColor: Colors.white,
                                            duration: const Duration(seconds: 1),
                                            content:
                                            Center(
                                              child: Text('Name Can Not Be Empty', style: TextStyle(
                                                  fontSize: 14,
                                                  color: Theme.of(context).colorScheme.secondary),),
                                            ),
                                          ),
                                        );
                                      }
                                    },
                                    child: Container(
                                        height: 55,
                                        width: width - 70,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20.0),
                                        decoration: BoxDecoration(
                                          color: Theme.of(context).primaryColor,
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(30)),
                                        ),
                                        child: Center(
                                          child: Text(
                                            "Start Quiz",
                                            style: TextStyle(
                                              color: Theme.of(context).colorScheme.onPrimary,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        )))
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 100),
              Align(
                alignment: Alignment.center,
                child: InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const ScoreSheetPage(),));
                  },
                  child: Container(
                    height: 55,
                    width: width - 70,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0),
                    decoration: const BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.all(
                          Radius.circular(30)),
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 10, spreadRadius: 4, color: Colors.black45, blurStyle: BlurStyle.outer),
                      ],
                    ),
                    child: const Row(
                      children: [
                        Text("Go To Score Sheet",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 25,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,),
                        SizedBox(width: 10),
                        Icon(Icons.arrow_circle_right, color: Colors.white, size: 32,)
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
