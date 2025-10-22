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
      ('Alimentação', 'expense', '#FFAB91'),   -- laranja claro
      ('Transporte', 'expense', '#81D4FA'),    -- azul claro
      ('Moradia', 'expense', '#CE93D8'),       -- roxo claro
      ('Lazer', 'expense', '#FFF59D'),         -- amarelo pastel
      ('Educação', 'expense', '#AED581'),      -- verde claro
      ('Saúde', 'expense', '#EF9A9A'),         -- vermelho suave
      ('Contas e Serviços', 'expense', '#90CAF9'), -- azul pastel
      ('Roupas', 'expense', '#BCAAA4'),        -- marrom suave
      ('Outros', 'expense', '#E0E0E0'),        -- cinza claro
      ('Salário', 'income', '#A5D6A7'),        -- verde suave
      ('Freelance', 'income', '#80CBC4'),      -- azul esverdeado
      ('Investimentos', 'income', '#90CAF9'),  -- azul pastel
      ('Presentes', 'income', '#CE93D8'),      -- roxo claro
      ('Reembolso', 'income', '#FFCC80');      -- laranja pastel
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
