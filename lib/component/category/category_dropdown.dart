import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:piggai/model/category_model.dart';

class CategoryDropdown extends StatelessWidget {
  final List<CategoryModel> categories;
  final Function(CategoryModel?)? onChanged;
  final CategoryModel? categorySelected;

  CategoryDropdown({
    super.key,
    required this.categories,
    this.onChanged,
    this.categorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownSearch<CategoryModel>(
      items: (filter, loadProps) => categories,
      compareFn: (item1, item2) => item1.id == item2.id,
      itemAsString: (item) => item.name,
      onChanged: (value) => onChanged,
      selectedItem: categorySelected,
      validator: (value) {
        if(value == null)
          return "Categoria é obrigatório";
        return null;
      },
      decoratorProps: DropDownDecoratorProps(
          decoration: InputDecoration(
              hintText: "Categoria",
              labelText: "Categoria",
              isDense: true,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12)
              )
          )
      ),
    );
  }
}
