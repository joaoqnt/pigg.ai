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
        -- 💸 DESPESAS
        ('Alimentação', 'expense', '#FFB74D'),       -- laranja (comida)
        ('Transporte', 'expense', '#4FC3F7'),        -- azul claro (movimento)
        ('Moradia', 'expense', '#9575CD'),           -- roxo suave (estabilidade)
        ('Lazer', 'expense', '#FFD54F'),             -- amarelo (diversão)
        ('Saúde', 'expense', '#E57373'),             -- vermelho suave (alerta)
        ('Contas e Serviços', 'expense', '#90A4AE'), -- cinza azulado (rotina)
        ('Outros', 'expense', '#E0E0E0'),            -- cinza claro (genérico)
      
        -- 💰 RECEITAS
        ('Salário', 'income', '#81C784'),            -- verde médio (principal renda)
        ('Freelance', 'income', '#64B5F6'),          -- azul (profissional)
        ('Investimentos', 'income', '#4DB6AC'),      -- verde-água (crescimento)
        ('Reembolso', 'income', '#A5D6A7');          -- verde claro (recuperar dinheiro)
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
