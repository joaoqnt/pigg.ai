import 'package:flutter/material.dart';
import 'package:piggai/component/setup/question_container.dart';
import 'package:piggai/controller/setup_controller.dart';

class SetupFirstPage extends StatefulWidget {
  final SetupController controller;
  SetupFirstPage({super.key, required this.controller});

  @override
  State<SetupFirstPage> createState() => _SetupFirstPageState();
}

class _SetupFirstPageState extends State<SetupFirstPage> {

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
          Text("Pagina 2 de 3",
              style: TextStyle(fontSize: 12,)
          ),
        ]
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              for(int i = 0; i < widget.controller.questions.length/2; i++)
                QuestionContainer(
                    controller: widget.controller,
                    question: widget.controller.questions[i]
                )
            ],
          ),
        ),
      ),
    );
  }
}
