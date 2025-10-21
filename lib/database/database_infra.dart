import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseInfra {
  static final DatabaseInfra _instance = DatabaseInfra._internal();
  factory DatabaseInfra() => _instance;
  DatabaseInfra._internal();

  static Database? _database;

  final Map<int, String> _createScripts = {
    0: '''
      CREATE TABLE categories (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        type TEXT NOT NULL, -- 'income' or 'expense'
        color TEXT
      )
    ''',
    1: '''
      CREATE TABLE accounts (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        balance REAL DEFAULT 0,
        type TEXT, -- 'cash', 'bank', 'card'
        color TEXT
      )
    ''',
    2: '''
      CREATE TABLE transactions (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        description TEXT,
        amount REAL NOT NULL,
        date TEXT NOT NULL, -- ISO 8601 'YYYY-MM-DD HH:MM:SS'
        type TEXT NOT NULL, -- 'income' or 'expense'
        category_id INTEGER,
        account_id INTEGER,
        FOREIGN KEY (category_id) REFERENCES categories(id),
        FOREIGN KEY (account_id) REFERENCES accounts(id)
      )
    ''',
    3: '''
      CREATE TABLE goals (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        total_amount REAL NOT NULL,
        current_amount REAL DEFAULT 0,
        start_date TEXT,
        end_date TEXT,
        category_id INTEGER,
        FOREIGN KEY (category_id) REFERENCES categories(id)
      )
    ''',
    4: '''
    INSERT INTO categories (name, type, color) VALUES
    ('Alimentação', 'expense', '#FF7043'),
    ('Transporte', 'expense', '#29B6F6'),
    ('Moradia', 'expense', '#8E24AA'),
    ('Lazer', 'expense', '#FBC02D'),
    ('Educação', 'expense', '#7CB342'),
    ('Saúde', 'expense', '#E53935'),
    ('Contas e Serviços', 'expense', '#5C6BC0'),
    ('Roupas', 'expense', '#8D6E63'),
    ('Outros', 'expense', '#BDBDBD'),
    ('Salário', 'income', '#43A047'),
    ('Freelance', 'income', '#26A69A'),
    ('Investimentos', 'income', '#1E88E5'),
    ('Presentes', 'income', '#9C27B0'),
    ('Reembolso', 'income', '#F57C00')
  '''
  };

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'piggai.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    for (int key in _createScripts.keys) {
      await db.execute(_createScripts[key]!);
    }
  }

  Future<void> close() async {
    final db = await database;
    await db.close();
    _database = null;
  }
}
