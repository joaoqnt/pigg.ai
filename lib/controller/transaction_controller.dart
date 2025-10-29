import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:piggai/component/custom_snackbar.dart';
import 'package:piggai/database/database_dao.dart';
import 'package:piggai/model/transaction_model.dart';
import 'package:piggai/util/date_util.dart';
import 'package:piggai/util/string_util.dart';

import '../model/category_model.dart';

part 'transaction_controller.g.dart';

class TransactionController = _TransactionController with _$TransactionController;

abstract class _TransactionController with Store{
  final _dao = DatabaseDAO();
  TextEditingController tecSearch = TextEditingController();
  TextEditingController tecDescriptionTransaction = TextEditingController();
  TextEditingController tecAmountTransaction = TextEditingController();
  TextEditingController tecDateTransaction = TextEditingController();
  TextEditingController tecHourTransaction = TextEditingController();
  List<CategoryModel> categories = [];
  List<TransactionModel> _transactions = [];
  final formKey = GlobalKey<FormState>();
  late BuildContext _context;
  int offset = 0;
  @observable
  ObservableList<DateTime> datesOfTransactions = ObservableList.of([]);
  @observable
  String type = "expense";
  @observable
  bool isInserting = false;
  @observable
  Map<TransactionModel,bool> isDeleting = ObservableMap.of({});
  @observable
  CategoryModel? categoryFilterSelected;
  @observable
  CategoryModel? categorySelected;
  @observable
  ObservableList<TransactionModel> transactionsFiltered = ObservableList.of([]);
  Map<String,String> mapFilterDateTransaction = {};
  String? filterDateQuery;
  @observable
  Map<String,double> mapAmountIncExp = ObservableMap.of({});

  Future<List<TransactionModel>> initialize(BuildContext context) async{
    _context = context;
    _generateMonthFilters();
    await _getCategories();
    return await getTransactions();
  }

  @action
  Future<List<TransactionModel>> getTransactions() async {
    try {
      // Faz o JOIN para trazer a categoria junto


      List<Map<String, dynamic>> list = await _dao.rawQuery(_buildQuery());

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
      _getDistinctDates();
      _getAmountIncomeExpense();
      return transactionsFiltered;
    } catch (e, stacktrace) {
      print('Erro ao buscar transações: $e');
      print(stacktrace);
      return [];
    }
  }

  @action
  Future<List<CategoryModel>> _getCategories() async{
    List<dynamic> list = await _dao.select("categories",orderBy: "name asc");
    categories.clear();
    categories.add(CategoryModel(name: "Todos", type: "none", color: '',id: -1));
    list.forEach((element) {
      CategoryModel category = CategoryModel.fromJson(element);
      categories.add(category);
    });
    setCategoryFilter(categories.first);
    return categories;
  }

  _getDistinctDates(){
    datesOfTransactions.clear();
    transactionsFiltered.forEach((element) {
      if(!datesOfTransactions.contains(element.date)){
        datesOfTransactions.add(element.date);
      }
    });
  }

  _getAmountIncomeExpense(){
    mapAmountIncExp["income"] = 0;
    mapAmountIncExp["expense"] = 0;
    transactionsFiltered.forEach((element) {
      if(element.type == "income") {
        mapAmountIncExp["income"] = mapAmountIncExp["income"]! + element.amount;
      } else {
        mapAmountIncExp["expense"] = mapAmountIncExp["expense"]! + element.amount;
      }
    });
  }

  @action
  Future alterTransaction({TransactionModel? transaction, bool isDelete = false}) async {
    if(!isDelete){
      setIsInserting(true);
    } else {
      setIsDeleting(true, transaction!);
    }

    String action;
    try{
      await Future.delayed(const Duration(milliseconds: 500));
      TransactionModel transactionTmp = _buildTransaction(transaction: transaction);
      if(isDelete) {
        transactionTmp.description = transaction!.description;
      }
      if(transaction == null){
        action = "criou";
        await _dao.insert(
            "transactions",
            transactionTmp.toJson()
        );
      } else {
        action = isDelete ? "excluiu" : "editou";
        if(isDelete){
          await _dao.delete(
              "transactions",
              "id = ?",
              [transactionTmp.id]
          );
        } else {
          await _dao.update(
              "transactions",
              transactionTmp.toJson(),
              "id = ?",
              [transactionTmp.id]
          );
        }
      }
      await getTransactions();
      if(!isDelete) {
        Navigator.pop(_context);
      }
      CustomSnackBar.show(
          context: _context,
          message: "Você $action a ${transactionTmp.type == "income" ? "receita" : "despesa"} ${transactionTmp.description}",
          type: AnimatedSnackBarType.success
      );
    } catch(e){
      // Navigator.pop(_context);
      CustomSnackBar.show(
          context: _context,
          message: "Erro $e",
          type: AnimatedSnackBarType.error
      );
    }
    if(!isDelete){
      setIsInserting(false);
    } else {
      setIsDeleting(false, transaction!);
    }
  }

  @action
  void setIsInserting(bool value) => isInserting = value;

  @action
  void setIsDeleting(bool value,TransactionModel transaction) => isDeleting[transaction] = value;

  @action
  void setType(String newType) => type = newType;

  @action
  setCategoryFilter(CategoryModel category) {
    categoryFilterSelected = category;
    getTransactions();
  }

  @action
  setCategory(CategoryModel? category) => categorySelected = category;

  addAmount(double amount){
    try{
      tecAmountTransaction.text = UtilBrasilFields.obterReal(UtilBrasilFields.converterMoedaParaDouble(tecAmountTransaction.text) + amount);
    } catch(e){
      tecAmountTransaction.text = UtilBrasilFields.obterReal(amount);
    }
  }

  removeAmount(double amount) {
    try {
      // Obtém o valor atual do campo
      double currentValue = UtilBrasilFields.converterMoedaParaDouble(tecAmountTransaction.text);

      // Se o valor for nulo, zero ou negativo, não faz nada
      if (currentValue <= 0) return;

      // Calcula o novo valor
      double newValue = currentValue - amount;

      // Garante que não fique negativo
      if (newValue < 0) newValue = 0;

      // Atualiza o campo com o valor formatado
      tecAmountTransaction.text = UtilBrasilFields.obterReal(newValue);
    } catch (e) {
      // Se der erro e amount for válido, apenas mostra o valor formatado
      if (amount > 0) {
        tecAmountTransaction.text = UtilBrasilFields.obterReal(amount);
      }
    }
  }

  setTransaction(TransactionModel? transaction, String type, {bool isClone = false}){
    if(transaction != null){
      tecDescriptionTransaction.text = transaction.description;
      tecAmountTransaction.text = UtilBrasilFields.obterReal(transaction.amount);
      DateTime date = isClone ? DateTime.now() : transaction.date;
      tecDateTransaction.text = DateUtil.formatDate(date);
      tecHourTransaction.text = DateUtil.formatHour(date);
      this.type = transaction.type;
      setCategory(transaction.category);
    } else {
      _clearTransaction(type);
    }
  }

  _clearTransaction(String type){
    tecDescriptionTransaction.clear();
    tecAmountTransaction.clear();
    tecDateTransaction.text = DateUtil.formatDate(DateTime.now());
    tecHourTransaction.text = DateUtil.formatHour(DateTime.now());
    this.type = type;
    setCategory(categories.where((element) => element.type == type).firstOrNull);
  }

  TransactionModel _buildTransaction({TransactionModel? transaction}) {
    return TransactionModel(
      description: StringUtil().capitalize(tecDescriptionTransaction.text.trim()),
      type: type,
      id: transaction?.id,
      category: categorySelected == null ? transaction!.category : categorySelected!,
      amount: tecAmountTransaction.text.isNotEmpty
          ? UtilBrasilFields.converterMoedaParaDouble(tecAmountTransaction.text)
          : transaction!.amount,
      date: tecDateTransaction.text.isNotEmpty
          ? DateUtil.parse(tecDateTransaction.text)
          : transaction!.date,

    );
  }

  Map<String, String> _generateMonthFilters({int monthsBack = 12}) {
    final now = DateTime.now();
    final Map<String, String> monthFilters = {};

    for (int i = 0; i < monthsBack; i++) {
      final date = DateTime(now.year, now.month - i, 1);
      final year = date.year;
      final month = date.month;

      final lastDay = DateTime(year, month + 1, 0).day;

      const monthNames = [
        "Janeiro",
        "Fevereiro",
        "Março",
        "Abril",
        "Maio",
        "Junho",
        "Julho",
        "Agosto",
        "Setembro",
        "Outubro",
        "Novembro",
        "Dezembro"
      ];
      final monthName = monthNames[month - 1];

      final key = "$monthName de $year";
      final value = "t.date BETWEEN '$year-${month.toString().padLeft(2, '0')}-01' "
          "AND '$year-${month.toString().padLeft(2, '0')}-$lastDay'";

      monthFilters[key] = value;
    }

    mapFilterDateTransaction = monthFilters;
    setDateFilter(mapFilterDateTransaction.values.first);

    return monthFilters;
  }

  setDateFilter(String date){
    filterDateQuery = date;
    getTransactions();
  }

  String _buildQuery(){
    List<String> whereArgs = [];
    String whereQuery;

    if(filterDateQuery != null){
      whereArgs.add(filterDateQuery!);
    }

    if(categoryFilterSelected!= null && categoryFilterSelected!.id != -1){
      whereArgs.add("t.category_id = ${categoryFilterSelected?.id}");
    }

    if(whereArgs.isNotEmpty){
      whereQuery = "where ${whereArgs.join(" and ")}";
    } else {
      whereQuery = '';
    }

    final String query = '''
      SELECT t.id as t_id, t.description, t.amount, t.type as t_type, t.date,
             c.id as c_id, c.name as c_name, c.type as c_type, c.color as c_color
      FROM transactions t
      LEFT JOIN categories c ON t.category_id = c.id
      $whereQuery
      ORDER BY t.date DESC
    ''';
    return query;
  }
}