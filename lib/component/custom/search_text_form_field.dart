import 'package:flutter/material.dart';

import 'custom_text_form_field.dart';

class SearchTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final Function(String)? onChanged;

  const SearchTextFormField({
    super.key,
    required this.controller,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40, // altura do campo
      child: CustomTextFormField(
        controller: controller,
        hintText: "Buscar...",
        obscureText: false,
        prefixIcon: const Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20), // cantos arredondados
          borderSide: BorderSide.none, // sem borda externa
        ),
        filled: true,
          fillColor: Theme.of(context).colorScheme.tertiaryContainer,
          onChanged: onChanged
      ),
    );
  }
}
