import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';
import 'package:piggai/component/custom_snackbar.dart';
import 'package:piggai/database/database_dao.dart';
import 'package:piggai/util/color_util.dart';
import 'package:piggai/util/string_util.dart';

import '../model/category_model.dart';


part 'category_controller.g.dart';

class CategoryController = _CategoryController with _$CategoryController;

abstract class _CategoryController with Store{
  final _dao = DatabaseDAO();
  TextEditingController tecSearch = TextEditingController();
  TextEditingController tecNameCategory = TextEditingController();
  List<CategoryModel> _categories = [];
  final formKey = GlobalKey<FormState>();
  late BuildContext _context;
  @observable
  ObservableList<CategoryModel> categoriesFiltered = ObservableList.of([]);
  @observable
  Color colorSelected = Color(0xFFD6CCFF);
  int offset = 0;
  @observable
  String type = "expense";
  @observable
  bool isInserting = false;
  @observable
  Map<CategoryModel,bool> isDeleting = ObservableMap.of({});

  Future<List<CategoryModel>> initialize(BuildContext context) async{
    _context = context;
    return await getCategories();
  }

  @action
  Future<List<CategoryModel>> getCategories() async{
    List<dynamic> list = await _dao.select("categories",limit: 50,offset: offset,orderBy: "type asc,name asc");
    categoriesFiltered.clear();
    _categories.clear();
    list.forEach((element) {
      CategoryModel category = CategoryModel.fromJson(element);
      _categories.add(category);
    });
    categoriesFiltered.addAll(_categories);
    // offset++;
    return categoriesFiltered;
  }

  @action
  void setColor(Color color) => colorSelected = color;

  @action
  void setIsInserting(bool value) => isInserting = value;

  @action
  void setIsDeleting(bool value,CategoryModel category) => isDeleting[category] = value;

  @action
  void setType(String newType) => type = newType;

  @action
  Future alterCategory({CategoryModel? category, bool isDelete = false}) async {
    if(!isDelete){
      setIsInserting(true);
    } else {
      setIsDeleting(true, category!);
    }

    String action;
    try{
      await Future.delayed(const Duration(milliseconds: 500));
      CategoryModel categoryTmp = _buildCategory(category: category);
      if(isDelete) {
        categoryTmp.name = category!.name;
      }
      if(category == null){
        action = "criou";
        await _dao.insert(
            "categories",
            categoryTmp.toJson()
        );
      } else {
        action = isDelete ? "excluiu" : "editou";
        if(isDelete){
          await _dao.delete(
              "categories",
              "id = ?",
              [categoryTmp.id]
          );
          await _dao.delete(
              "transactions",
              "category_id = ?",
              [categoryTmp.id]
          );
        } else {
          await _dao.update(
              "categories",
              categoryTmp.toJson(),
              "id = ?",
              [categoryTmp.id]
          );
        }
      }
      await getCategories();
      if(!isDelete) {
        Navigator.pop(_context);
      }
      CustomSnackBar.show(
          context: _context,
          message: "Você $action a categoria ${categoryTmp.name}",
          type: AnimatedSnackBarType.success
      );
    } catch(e){
      Navigator.pop(_context);
      CustomSnackBar.show(
          context: _context,
          message: "Erro ao criar a categoria $e",
          type: AnimatedSnackBarType.error
      );
    }
    if(!isDelete){
      setIsInserting(false);
    } else {
      setIsDeleting(false, category!);
    }
  }

  CategoryModel _buildCategory({CategoryModel? category}) {
    final String hexColor = '#${colorSelected.value.toRadixString(16).padLeft(8, '0').substring(2).toUpperCase()}';

    return CategoryModel(
      name: StringUtil().capitalize(tecNameCategory.text.trim()),
      type: type,
      color: hexColor,
      id: category?.id
    );
  }

  setCategory(CategoryModel? category){
    if(category != null){
      tecNameCategory.text = category.name;
      setColor(ColorUtil().formatColor(category.color));
      setType(category.type);
    } else {
      _clearCategory();
    }
  }

  _clearCategory(){
    tecNameCategory.clear();
    setColor(Color(0xFFD6CCFF));
    setType("expense");
  }
}