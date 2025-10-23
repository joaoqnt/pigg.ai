import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';
import 'package:piggai/component/custom_snackbar.dart';
import 'package:piggai/database/database_dao.dart';
import 'package:piggai/model/transaction_model.dart';
import 'package:piggai/util/color_util.dart';
import 'package:piggai/util/string_util.dart';

import '../model/category_model.dart';

part 'transaction_controller.g.dart';

class TransactionController = _TransactionController with _$TransactionController;

abstract class _TransactionController with Store{
  final _dao = DatabaseDAO();
  TextEditingController tecSearch = TextEditingController();
  TextEditingController tecDescriptionTransaction = TextEditingController();
  TextEditingController tecAmountTransaction = TextEditingController();
  List<CategoryModel> categories = [];
  List<TransactionModel> _transactions = [];
  final formKey = GlobalKey<FormState>();
  late BuildContext _context;
  int offset = 0;
  @observable
  String type = "expense";
  @observable
  bool isInserting = false;
  @observable
  Map<TransactionModel,bool> isDeleting = ObservableMap.of({});
  @observable
  Map<CategoryModel,bool> categorySelected = ObservableMap.of({});
  @observable
  ObservableList<TransactionModel> transactionsFiltered = ObservableList.of([]);

  Future<List<TransactionModel>> initialize(BuildContext context) async{
    _context = context;
    _getCategories();
    return await getTransactions();
  }

  @action
  Future<List<TransactionModel>> getTransactions() async {
    try {
      // Faz o JOIN para trazer a categoria junto
      final String query = '''
      SELECT t.id as t_id, t.description, t.amount, t.type as t_type, t.date,
             c.id as c_id, c.name as c_name, c.type as c_type, c.color as c_color
      FROM transactions t
      LEFT JOIN categories c ON t.category_id = c.id
      ORDER BY t.date DESC
      LIMIT 50 OFFSET $offset
    ''';

      List<Map<String, dynamic>> list = await _dao.rawQuery(query);

      transactionsFiltered.clear();
      _transactions.clear();

      for (var element in list) {
        // Cria o objeto CategoryModel
        final category = CategoryModel(
          id: element['c_id'],
          name: element['c_name'],
          type: element['c_type'],
          color: element['c_color'],
        );

        // Cria o TransactionModel já com a categoria associada
        final transaction = TransactionModel(
          id: element['t_id'],
          amount: (element['amount'] as num).toDouble(),
          description: element['description'],
          type: element['t_type'],
          date: DateTime.parse(element['date']),
          category: category,
        );

        _transactions.add(transaction);
      }

      transactionsFiltered.addAll(_transactions);
      return transactionsFiltered;
    } catch (e, stacktrace) {
      print('Erro ao buscar transações: $e');
      print(stacktrace);
      return [];
    }
  }

  @action
  Future<List<CategoryModel>> _getCategories() async{
    List<dynamic> list = await _dao.select("categories",limit: 50,offset: offset,orderBy: "name asc");
    categories.clear();
    list.forEach((element) {
      CategoryModel category = CategoryModel.fromJson(element);
      categories.add(category);
    });
    // offset++;
    return categories;
  }

  @action
  void setIsInserting(bool value) => isInserting = value;

  @action
  void setIsDeleting(bool value,TransactionModel transaction) => isDeleting[transaction] = value;

  @action
  void setType(String newType) => type = newType;

  @action
  setCategory(CategoryModel category) => categorySelected[category] = !(categorySelected[category]??false);

  addAmount(double amount){
    try{
      tecAmountTransaction.text = UtilBrasilFields.obterReal(UtilBrasilFields.converterMoedaParaDouble(tecAmountTransaction.text) + amount);
    } catch(e){
      tecAmountTransaction.text = UtilBrasilFields.obterReal(amount);
    }
  }

  setTransaction(TransactionModel? transaction){
    if(transaction != null){
      tecDescriptionTransaction.text = transaction.description;
      tecAmountTransaction.text = UtilBrasilFields.obterReal(transaction.amount);
    } else {
      _clearTransaction();
    }
  }

  _clearTransaction(){
    tecDescriptionTransaction.clear();
    tecAmountTransaction.clear();
  }
}