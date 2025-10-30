import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:piggai/component/custom/button/custom_choice_button.dart';
import 'package:piggai/component/custom/custom_text_form_field.dart';

class CustomDatePicker extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final bool required;
  final Icon? prefixIcon;

  const CustomDatePicker({
    super.key,
    required this.controller,
    this.labelText = "Data",
    this.hintText = "Selecione uma data",
    this.required = false,
    this.prefixIcon,
  });

  @override
  State<CustomDatePicker> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  final DateFormat _formatter = DateFormat('dd/MM/yyyy');

  Map<String, bool> mapDateSelected = {
    "Hoje": true,
    "Ontem": false,
    "Outro": false,
  };

  void _updateSelection(String key) {
    setState(() {
      // Marca apenas a opção clicada
      mapDateSelected.updateAll((k, v) => k == key);

      final now = DateTime.now();

      if (key == "Hoje") {
        _setDate(now);
      } else if (key == "Ontem") {
        _setDate(now.subtract(const Duration(days: 1)));
      } else if (key == "Outro") {
        _selectDate(context);
      }
    });
  }

  void _setDate(DateTime date) {
    setState(() {
      widget.controller.text = _formatter.format(date);

      // Atualiza seleção automaticamente conforme a data
      final now = DateTime.now();
      final hojeStr = _formatter.format(now);
      final ontemStr = _formatter.format(now.subtract(const Duration(days: 1)));

      mapDateSelected.updateAll((key, value) {
        if (widget.controller.text == hojeStr && key == "Hoje") return true;
        if (widget.controller.text == ontemStr && key == "Ontem") return true;
        if (key == "Outro" &&
            widget.controller.text != hojeStr &&
            widget.controller.text != ontemStr) return true;
        return false;
      });
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final now = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(now.year - 5),
      lastDate: DateTime(now.year + 5),
      // locale: const Locale('pt', 'BR'),
    );

    if (picked != null) {
      _setDate(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextFormField(
          controller: widget.controller,
          readOnly: true,
          onTap: () => _selectDate(context),
          labelText: widget.labelText,
          hintText: widget.hintText,
          prefixIcon: widget.prefixIcon ?? const Icon(Icons.calendar_month),
          required: widget.required,
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          children: mapDateSelected.keys.map((key) {
            return CustomChoiceButton(
              text: key,
              selected: mapDateSelected[key]!,
              onSelected: (_) => _updateSelection(key),
            );
          }).toList(),
        ),
      ],
    );
  }
}
