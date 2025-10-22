import 'package:flutter/material.dart';
import 'package:piggai/component/category/category_color_picker.dart';
import 'package:piggai/component/category/category_type_selector.dart';
import 'package:piggai/component/custom_text_form_field.dart';
import 'package:piggai/controller/category_controller.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:piggai/model/category_model.dart';

class CategoryModalBottom {
  void show(BuildContext context,CategoryController controller,{CategoryModel? category}) {
    controller.setCategory(category);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Observer(
          builder: (context) {
            return Form(
              key: controller.formKey,
              child: Padding(
                padding: EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 20,
                  bottom: MediaQuery.of(context).viewInsets.bottom + 30,
                ),
                child: SafeArea(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 10,
                    children: [
                      Row(
                        children: [
                          const Expanded(
                            child: Text(
                              "Criar categoria",
                              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                            ),
                          ),
                          IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: const Icon(Icons.close, size: 18),
                          ),
                        ],
                      ),
                      const Text(
                        "Organize suas finanças criando categorias",
                        style: TextStyle(fontSize: 12),
                      ),
                      Row(
                        spacing: 10,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: CustomTextFormField(
                              maxLength: 25,
                              hintText: "Nome da categoria",
                              controller: controller.tecNameCategory,
                              required: true,
                            ),
                          ),
                          CategoryColorPicker(controller: controller)
                        ],
                      ),
                      CategoryTypeSelector(controller: controller),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () async{
                          if(controller.formKey.currentState!.validate()){
                            await controller.createCategory();
                          }
                        },
                        child: controller.isInserting ? Center(
                            child: SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(color: Colors.white)
                            )
                        ) : Text("Criar categoria"),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        );
      },
    );
  }

}
