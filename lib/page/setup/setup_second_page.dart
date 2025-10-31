import 'package:flutter/material.dart';
import 'package:piggai/component/setup/question_container.dart';
import 'package:piggai/controller/setup_controller.dart';
import 'package:piggai/page/bottom_navigation_page.dart';

class SetupSecondPage extends StatefulWidget {
  final SetupController controller;
  SetupSecondPage({super.key, required this.controller});

  @override
  State<SetupSecondPage> createState() => _SetupFirstPageState();
}

class _SetupFirstPageState extends State<SetupSecondPage> {

  @override
  void initState() {
    widget.controller.initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Center(
                child: Text("Página 3 de 3", style: TextStyle(fontSize: 12)),
              ),
            ),
          ]
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: widget.controller.formKey,
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        for(int i = (widget.controller.questions.length/2).toInt(); i < widget.controller.questions.length; i++)
                          QuestionContainer(
                              controller: widget.controller,
                              question: widget.controller.questions[i]
                          ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        widget.controller.saveQuestions(false);
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => BottomNavigationPage()),
                                (Route<dynamic> route) { return false;}
                        );
                      },
                      child: Text(
                        "Pular",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),

                    FilledButton(
                      onPressed: () {
                        if(widget.controller.formKey.currentState!.validate()){
                          widget.controller.saveQuestions(false);
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (context) => BottomNavigationPage()),
                                  (Route<dynamic> route) { return false;}
                          );
                        }
                      },
                      child: Text("Avançar"),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
