import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/cupertino.dart';
import 'package:piggai/model/category_model.dart';
import 'package:piggai/model/question.dart';
import 'package:piggai/model/transaction_model.dart';
import 'package:piggai/util/singleton.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqlite_api.dart';

class SetupController{
  final formKey = GlobalKey<FormState>();
  Map<Question, bool> mapAnswers = {};
  Map<Question, TextEditingController> mapValues = {};
  final questions = [

    // 💰 Receitas
    Question(
      categoryName: "Salário",
      categoryType: "income",
      categoryColor: "#A5D6A7",
      question: "Você recebe salário?",
      requiresValue: true,
      valueHint: "Qual o valor do seu salário mensal?",
      valueLabel: "Valor do seu salário mensal",
    ),

    Question(
      categoryName: "Renda extra",
      categoryType: "income",
      categoryColor: "#C5E1A5", // Outros income
      question: "Você recebe outra renda mensal (freelance, pensão etc)?",
      requiresValue: true,
      valueHint: "Qual o valor médio mensal?",
      valueLabel: "Valor médio mensal",
      defaultRequiresAnswer: false,
    ),

    // 💸 Despesas
    Question(
      categoryName: "Moradia",
      categoryType: "expense",
      categoryColor: "#B39DDB",
      question: "Você gasta com moradia?",
      requiresValue: true,
      valueHint: "Qual o valor médio mensal?",
      valueLabel: "Valor médio mensal",
    ),

    Question(
      categoryName: "Saúde",
      categoryType: "expense",
      categoryColor: "#F48FB1",
      question: "Você tem gastos com saúde mensalmente?",
      requiresValue: true,
      valueHint: "Gasto médio mensal com saúde (médico, remédios)?",
      valueLabel: "Gasto médio mensal com saúde",
      defaultRequiresAnswer: false,
    ),

    Question(
      categoryName: "Assinaturas",
      categoryType: "expense",
      categoryColor: "#90A4AE",
      question: "Você paga assinaturas (Netflix, Spotify, etc)?",
      requiresValue: false,
      defaultRequiresAnswer: false,
    ),

    Question(
      categoryName: "Financiamentos",
      categoryType: "expense",
      categoryColor: "#CE93D8",
      question: "Você possui algum financiamento (casa, carro, estudantil)?",
      requiresValue: false,
      defaultRequiresAnswer: false,
    ),


    Question(
      categoryName: "Educação",
      categoryType: "expense",
      categoryColor: "#64B5F6",
      question: "Você paga faculdade, curso ou escola?",
      requiresValue: true,
      valueHint: "Valor mensal?",
      valueLabel: "Valor mensal",
      defaultRequiresAnswer: false,
    ),

    Question(
      categoryName: "Transporte",
      categoryType: "expense",
      categoryColor: "#81D4FA",
      question: "Você gasta com transporte (Uber, ônibus, gasolina)?",
      requiresValue: false,
      valueHint: "Gasto médio mensal com transporte?",
      valueLabel: "Gasto médio mensal com transporte",
    ),

    Question(
      categoryName: "Alimentação",
      categoryType: "expense",
      categoryColor: "#FFAB91",
      question: "Você gasta com alimentação no dia a dia?",
      requiresValue: false,
    ),

    Question(
      categoryName: "Comprinhas",
      categoryType: "expense",
      categoryColor: "#E0E0E0", // Outros
      question: "Você faz compras online / roupas / eletrônicos?",
      requiresValue: false,
      defaultRequiresAnswer: false,
    ),

    Question(
      categoryName: "Lazer",
      categoryType: "expense",
      categoryColor: "#FFF176",
      question: "Você gasta com lazer (cinema, festas, bares)?",
      requiresValue: false,
    ),

    Question(
      categoryName: "Pets",
      categoryType: "expense",
      categoryColor: "#E0E0E0", // Outros
      question: "Você tem gastos com pets?",
      requiresValue: false,
      defaultRequiresAnswer: false,
    ),

    Question(
      categoryName: "Filhos",
      categoryType: "expense",
      categoryColor: "#E0E0E0", // Outros
      question: "Você tem filhos?",
      requiresValue: false,
      defaultRequiresAnswer: false,
    ),

    Question(
      categoryName: "Academia/Esporte",
      categoryType: "expense",
      categoryColor: "#E0E0E0", // Outros
      question: "Você paga academia / esportes?",
      requiresValue: true,
      valueHint: "Valor mensal da academia/esportes?",
      valueLabel: "Valor mensal da academia/esportes",
      defaultRequiresAnswer: false,
    ),

    Question(
      categoryName: "Investimentos",
      categoryType: "income",
      categoryColor: "#80CBC4",
      question: "Você investe mensalmente (renda fixa/variável)?",
      requiresValue: true,
      valueHint: "Quanto investe por mês?",
      valueLabel: "Quanto investe por mês",
      defaultRequiresAnswer: false,
    ),
  ];


  initialize(){
    questions.forEach((element) {
      if(mapValues[element] == null)
        mapValues[element] = TextEditingController();
    });
  }

  Future<void> setFirstAcess() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("first_access_done", true);
  }

  setQuestion(Question question,bool value){
    mapAnswers[question] = value;
  }

  saveQuestions(bool isHalf) async{
    setFirstAcess();
    final start = isHalf ? 0 : (questions.length / 2).toInt();
    final end = isHalf ? (questions.length / 2).toInt() : questions.length;

    for (int i = start; i < end; i++) {
      final q = questions[i];
      q.answered = true;

      final controller = mapValues[q];
      if (controller != null && controller.text.isNotEmpty) {
        q.labelAnswer = UtilBrasilFields.converterMoedaParaDouble(controller.text);
      }

      q.requiresAnswer = mapAnswers[q]??q.defaultRequiresAnswer;
      if(q.requiresAnswer == true){
        CategoryModel categoryModel = CategoryModel(
          name: q.categoryName,
          type: q.categoryType,
          color: q.categoryColor,
        );

        int? id = await Singleton().categoryController.alterCategory(
          category: categoryModel,
          useProvidedCategory: true,
          showSnackbar: false
        );

        categoryModel.id = id;

        if(q.requiresValue == true || q.labelAnswer != null){
          TransactionModel transaction = TransactionModel(
              amount: UtilBrasilFields.converterMoedaParaDouble(controller!.text),
              description: q.categoryName,
              type: q.categoryType,
              date: DateTime.now(),
              category: categoryModel
          );
          print(transaction.toJson());
          await Singleton().transactionController.alterTransaction(transaction: transaction,showSnackbar: false,useProvidedTransaction: true);
        }
      }
    }
  }


}