import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  // Singleton pattern
  DatabaseHelper._internal();

  factory DatabaseHelper() {
    return _instance;
  }

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'app_database.db');

    return await openDatabase(
      path,
      version: 3,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        email TEXT NOT NULL UNIQUE,
        password TEXT NOT NULL,
        cpf TEXT NOT NULL,
        birth_date TEXT NOT NULL,
        phone TEXT,
        cns TEXT,
        address TEXT,
        health_unit TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE consultas (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        usuario_id INTEGER,
        data TEXT NOT NULL,
        horario TEXT NOT NULL,
        tipo TEXT NOT NULL,
        FOREIGN KEY (usuario_id) REFERENCES users (id) ON DELETE CASCADE
      )
    ''');

    await db.execute('''
      CREATE TABLE agendamentos_vacinas (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        usuario_id INTEGER,
        vacina TEXT NOT NULL,
        data TEXT NOT NULL,
        horario TEXT NOT NULL,
        FOREIGN KEY (usuario_id) REFERENCES users (id) ON DELETE CASCADE
      )
    ''');
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute('''
        CREATE TABLE consultas (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          usuario_id INTEGER,
          data TEXT NOT NULL,
          horario TEXT NOT NULL,
          tipo TEXT NOT NULL,
          FOREIGN KEY (usuario_id) REFERENCES users (id) ON DELETE CASCADE
        )
      ''');
    }
    if (oldVersion < 3) {
      await db.execute('''
        CREATE TABLE agendamentos_vacinas (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          usuario_id INTEGER,
          vacina TEXT NOT NULL,
          data TEXT NOT NULL,
          horario TEXT NOT NULL,
          FOREIGN KEY (usuario_id) REFERENCES users (id) ON DELETE CASCADE
        )
      ''');
    }
  }

  Future<int> insertUser(Map<String, dynamic> user) async {
    final db = await database;
    return await db.insert('users', user);
  }

  Future<Map<String, dynamic>?> getUserByEmail(String email) async {
    final db = await database;
    final result = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [email],
    );
    return result.isNotEmpty ? result.first : null;
  }

  Future<bool> validateUser(String email, String password) async {
    final db = await database;
    final result = await db.query(
      'users',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );
    return result.isNotEmpty;
  }

  Future<int> insertAppointment(Map<String, dynamic> consulta) async {
    final db = await database;
    return await db.insert('consultas', consulta);
  }

  Future<int> insertVaccineAppointment(
      Map<String, dynamic> agendamentoVacina) async {
    final db = await database;
    return await db.insert('agendamentos_vacinas', agendamentoVacina);
  }

  Future<List<Map<String, dynamic>>> getUserAppointments(int userId) async {
    final db = await database;
    return await db.query(
      'consultas',
      where: 'usuario_id = ?',
      whereArgs: [userId],
    );
  }

  Future<List<Map<String, dynamic>>> getUserVaccineAppointments(
      int userId) async {
    final db = await database;
    return await db.query(
      'agendamentos_vacinas',
      where: 'usuario_id = ?',
      whereArgs: [userId],
    );
  }

  Future<List<Map<String, dynamic>>> getAppointmentsByDate(String date) async {
    final db = await database;
    return await db.query(
      'consultas',
      where: 'data = ?',
      whereArgs: [date],
    );
  }

  Future<List<Map<String, dynamic>>> getVaccinesByDate(String date) async {
    final db = await database;
    return await db.query(
      'agendamentos_vacinas',
      where: 'data = ?',
      whereArgs: [date],
    );
  }
}
