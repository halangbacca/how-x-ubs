import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:gestao_ubs/db/database_helper.dart';

void main() {
  sqfliteFfiInit();

  late DatabaseHelper dbHelper;

  setUpAll(() async {
    databaseFactory = databaseFactoryFfi;
    dbHelper = DatabaseHelper();
  });

  tearDownAll(() async {
    // Feche e delete o banco de dados para limpar após os testes
    final db = await dbHelper.database;
    await db.close();
  });

  group('Database Tests', () {
    setUp(() async {
      // Limpa a tabela de usuários antes de cada teste
      final db = await dbHelper.database;
      await db.delete('users');
    });

    test('Deve inserir um novo usuário sem erros', () async {
      final user = {
        'name': 'Test User',
        'email': 'test@example.com',
        'password': 'password123',
        'cpf': '12345678900',
        'birth_date': '1990-01-01',
        'phone': '123456789',
        'cns': '123456789123456',
        'address': '123 Main St',
        'health_unit': 'Centro',
      };

      final userId = await dbHelper.insertUser(user);
      expect(userId, isNotNull); // Verifica se o ID foi retornado
    });

    test('Deve falhar ao inserir usuário com e-mail duplicado', () async {
      final user1 = {
        'name': 'Test User 1',
        'email': 'duplicate@example.com',
        'password': 'password123',
        'cpf': '12345678901',
        'birth_date': '1990-01-01',
        'phone': '123456789',
        'cns': '123456789123456',
        'address': '123 Main St',
        'health_unit': 'Centro',
      };

      final user2 = {
        'name': 'Test User 2',
        'email': 'duplicate@example.com', // E-mail duplicado
        'password': 'password456',
        'cpf': '12345678902',
        'birth_date': '1991-01-01',
        'phone': '987654321',
        'cns': '654321987654321',
        'address': '456 Elm St',
        'health_unit': 'Fazenda',
      };

      // Insere o primeiro usuário com sucesso
      await dbHelper.insertUser(user1);

      // Tenta inserir o segundo usuário e verifica se lança uma exceção de unicidade
      expect(
            () async => await dbHelper.insertUser(user2),
        throwsA(isA<DatabaseException>().having(
                (e) => e.toString(), 'description', contains('UNIQUE constraint failed'))),
      );
    });
  });

  group('DatabaseHelper', () {

    test('validar usuário por e-mail e senha', () async {
      const email = 'john@example.com';
      const password = 'password123';

      await dbHelper.insertUser({
        'name': 'John Doe',
        'email': email,
        'password': password,
        'cpf': '12345678900',
        'birth_date': '1990-01-01',
        'phone': '123456789',
        'cns': '123456789123456',
        'address': '123 Main St',
        'health_unit': 'Centro'
      });

      final isValid = await dbHelper.validateUser(email, password);
      expect(isValid, isTrue);
    });

    test('inserir consulta', () async {
      final consulta = {
        'usuario_id': 1,
        'data': '2024-11-25',
        'horario': '10:00',
        'tipo': 'Consulta Médica'
      };

      final id = await dbHelper.insertAppointment(consulta);
      expect(id, isNonZero);
    });

    test('inserir agendamento de vacina', () async {
      final agendamentoVacina = {
        'usuario_id': 1,
        'vacina': 'COVID-19',
        'data': '2024-11-25',
        'horario': '15:00'
      };

      final id = await dbHelper.insertVaccineAppointment(agendamentoVacina);
      expect(id, isNonZero);
    });

    test('obter consultas do usuário', () async {
      const userId = 1;
      final consulta = {
        'usuario_id': userId,
        'data': '2024-11-25',
        'horario': '10:00',
        'tipo': 'Consulta Médica'
      };

      await dbHelper.insertAppointment(consulta);
      final consultas = await dbHelper.getUserAppointments(userId);
      expect(consultas, isNotEmpty);
    });

    test('obter agendamentos de vacina do usuário', () async {
      const userId = 1;
      final agendamentoVacina = {
        'usuario_id': userId,
        'vacina': 'COVID-19',
        'data': '2024-11-25',
        'horario': '15:00'
      };

      await dbHelper.insertVaccineAppointment(agendamentoVacina);
      final agendamentos = await dbHelper.getUserVaccineAppointments(userId);
      expect(agendamentos, isNotEmpty);
    });

    test('obter consultas por data', () async {
      const date = '2024-11-25';
      final consulta = {
        'usuario_id': 1,
        'data': date,
        'horario': '10:00',
        'tipo': 'Consulta Médica'
      };

      await dbHelper.insertAppointment(consulta);
      final consultas = await dbHelper.getAppointmentsByDate(date);
      expect(consultas, isNotEmpty);
    });

    test('obter vacinas por data', () async {
      const date = '2024-11-25';
      final agendamentoVacina = {
        'usuario_id': 1,
        'vacina': 'COVID-19',
        'data': date,
        'horario': '15:00'
      };

      await dbHelper.insertVaccineAppointment(agendamentoVacina);
      final vacinas = await dbHelper.getVaccinesByDate(date);
      expect(vacinas, isNotEmpty);
    });
  });
}