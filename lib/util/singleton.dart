import 'package:piggai/controller/category_controller.dart';
import 'package:piggai/controller/transaction_controller.dart';

class Singleton {
  static final Singleton _instance = Singleton._internal();

  Singleton._internal()
      : _transactionController = TransactionController(),
        _categoryController = CategoryController();

  factory Singleton() {
    return _instance;
  }

  final TransactionController _transactionController;
  final CategoryController _categoryController;

  TransactionController get transactionController => _transactionController;
  CategoryController get categoryController => _categoryController;
}