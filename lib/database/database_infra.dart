import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseInfra {
  static final DatabaseInfra _instance = DatabaseInfra._internal();
  factory DatabaseInfra() => _instance;
  DatabaseInfra._internal();

  static Database? _database;

  final Map<int, String> _createScripts = {
    // 🗂️ Tabelas
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

    // 💳 CONTAS PADRÃO
    4: '''
  INSERT INTO accounts (name, balance, type, color) VALUES
    ('Carteira', 150.00, 'cash', '#FFEB3B'),
    ('Banco Inter', 2500.00, 'bank', '#81D4FA'),
    ('Cartão Nubank', 0.00, 'card', '#BA68C8')
  ''',

    // 💸 CATEGORIAS PADRÃO
    5: '''
  INSERT INTO categories (name, type, color) VALUES
    -- 💸 Despesas
    ('Alimentação', 'expense', '#FFE0B2'),   -- laranja claro
    ('Transporte', 'expense', '#B3E5FC'),    -- azul bebê
    ('Moradia', 'expense', '#D1C4E9'),       -- lilás suave
    ('Lazer', 'expense', '#FFF9C4'),         -- amarelo clarinho
    ('Saúde', 'expense', '#FFCDD2'),         -- rosa claro
    ('Educação', 'expense', '#BBDEFB'),      -- azul pastel
    ('Assinaturas', 'expense', '#CFD8DC'),   -- cinza claro azulado
    ('Outros', 'expense', '#F5F5F5'),        -- cinza quase branco

    -- 💰 Receitas
    ('Salário', 'income', '#C8E6C9'),        -- verde menta
    ('Investimentos', 'income', '#B2DFDB'),  -- verde-água claro
    ('Outros', 'income', '#DCEDC8');         -- verde amarelado claro

  ''',

    // 💰 TRANSAÇÕES DE EXEMPLO
    6: '''
  INSERT INTO transactions (description, amount, date, type, category_id, account_id) VALUES
    ('Compra no supermercado', 350.75, '2025-10-01 14:30:00', 'expense', 1, 1),
    ('Uber para o trabalho', 18.90, '2025-10-02 08:10:00', 'expense', 2, 1),
    ('Conta de energia', 210.35, '2025-10-05 18:00:00', 'expense', 7, 2),
    ('Aluguel', 1500.00, '2025-10-05 10:00:00', 'expense', 3, 2),
    ('Cinema com amigos', 62.00, '2025-10-07 21:40:00', 'expense', 4, 1),
    ('Farmácia', 85.50, '2025-10-09 15:22:00', 'expense', 5, 1),
    ('Netflix', 39.90, '2025-10-10 09:00:00', 'expense', 7, 3),
    ('Lanche rápido', 25.00, '2025-10-12 12:45:00', 'expense', 1, 1),

    ('Salário mensal', 4500.00, '2025-10-01 09:00:00', 'income', 9, 2),
    ('Rendimento de investimento', 235.50, '2025-10-08 10:30:00', 'income', 10, 2);
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
