import 'package:flutter/material.dart';
import 'package:piggai/component/custom/custom_text_form_field.dart';
import 'package:piggai/controller/setup_controller.dart';
import 'package:piggai/model/question.dart';

class QuestionContainer extends StatefulWidget {
  final SetupController controller;
  final Question question;

  QuestionContainer({
    super.key,
    required this.controller,
    required this.question,
  });

  @override
  State<QuestionContainer> createState() => _QuestionContainerState();
}

class _QuestionContainerState extends State<QuestionContainer> {
  @override
  Widget build(BuildContext context) {
    bool value = widget.controller.mapAnswers[widget.question]??widget.question.defaultRequiresAnswer;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              setState(() {
                widget.controller.setQuestion(widget.question, !value);
              });
            },
            child: Row(
              children: [
                Expanded(child: Text(widget.question.question)),
                Switch(
                  value: value,
                  onChanged: (v) {
                    setState(() {
                      widget.controller.setQuestion(widget.question, v);
                    });
                  },
                ),

              ],
            ),
          ),
          if(value && widget.question.requiresValue == true)
            CustomTextFormField(
              controller: widget.controller.mapValues[widget.question],
              labelText: widget.question.valueLabel,
            )
        ],
      ),
    );
  }
}
