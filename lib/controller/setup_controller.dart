import 'package:flutter/cupertino.dart';
import 'package:piggai/model/question.dart';

class SetupController{
  Map<Question, bool> mapAnswers = {};
  Map<Question, TextEditingController> mapValues = {};
  final questions = [
    // ✅ Renda
    Question(
      categoryName: "Salário",
      question: "Você recebe salário?",
      requiresValue: true,
      valueLabel: "Qual o valor do seu salário mensal?",
    ),
    Question(
      categoryName: "Renda extra",
      question: "Você recebe outra renda mensal (freelance, pensão etc)?",
      requiresValue: true,
      valueLabel: "Qual o valor médio mensal?",
      defaultRequiresAnswer: false,
    ),

    // ✅ Gastos fixos
    Question(
      categoryName: "Moradia",
      question: "Você gasta com moradia??",
      requiresValue: true,
      valueLabel: "Qual o valor médio mensal?",
    ),
    Question(
      categoryName: "Saúde",
      question: "Você tem gastos com saúde mensalmente?",
      requiresValue: true,
      valueLabel: "Gasto médio mensal com saúde (médico, remédios)?",
      defaultRequiresAnswer: false,
    ),
    Question(
      categoryName: "Assinaturas",
      question: "Você paga assinaturas (Netflix, Spotify, etc)?",
      requiresValue: false,
      defaultRequiresAnswer: false,
    ),
    Question(
      categoryName: "Educação",
      question: "Você paga faculdade, curso ou escola?",
      requiresValue: true,
      valueLabel: "Valor mensal?",
      defaultRequiresAnswer: false,
    ),
    Question(
      categoryName: "Transporte",
      question: "Você gasta com transporte (Uber, ônibus, gasolina)?",
      requiresValue: false,
      valueLabel: "Gasto médio mensal com transporte?",
    ),

    Question(
      categoryName: "Alimentação",
      question: "Você gasta com alimentação no dia a dia?",
      requiresValue: false,
    ),
    Question(
      categoryName: "Comprinhas",
      question: "Você faz compras online / roupas / eletrônicos?",
      requiresValue: false,
      defaultRequiresAnswer: false,
    ),
    Question(
      categoryName: "Lazer",
      question: "Você gasta com lazer (cinema, festas, bares)?",
      requiresValue: false
    ),

    // ✅ Outros perfis
    Question(
      categoryName: "Pets",
      question: "Você tem gastos com pets?",
      requiresValue: false,
      defaultRequiresAnswer: false,
    ),
    Question(
      categoryName: "Filhos",
      question: "Você tem filhos?",
      requiresValue: false,
      defaultRequiresAnswer: false,
    ),
    Question(
      categoryName: "Academia/Esporte",
      question: "Você paga academia / esportes?",
      requiresValue: true,
      valueLabel: "Valor mensal da academia/esportes?",
      defaultRequiresAnswer: false,
    ),
    Question(
      categoryName: "Investimentos",
      question: "Você investe mensalmente (renda fixa/variável)?",
      requiresValue: true,
      valueLabel: "Quanto investe por mês?",
      defaultRequiresAnswer: false,
    ),
  ];

  initialize(){
    questions.forEach((element) {
      if(mapValues[element] == null)
        mapValues[element] = TextEditingController();
    });
  }

  setQuestion(Question question,bool value){
    mapAnswers[question] = value;
  }
}