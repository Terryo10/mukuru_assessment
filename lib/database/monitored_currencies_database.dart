import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class CurrencyMonitor {
  final int? id;
  final String monitoredCurrency;
  final String rate;
  final String updates;

  CurrencyMonitor(
      {this.id,
      required this.monitoredCurrency,
      required this.rate,
      required this.updates});

  factory CurrencyMonitor.fromMap(Map<String, dynamic> json) => CurrencyMonitor(
        id: json['id'],
        monitoredCurrency: json['monitoredCurrency'],
        rate: json['rate'],
        updates: json['updates'],
      );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'rate': rate,
      'monitoredCurrency': monitoredCurrency,
      'updates': updates
    };
  }
}

class DatabaseHelper {
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;
  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'monitored_currencies.db');
    return await openDatabase(
      path,
      version: 4,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE currency_monitor (
        id INTEGER PRIMARY KEY,
         monitoredCurrency TEXT,
          rate TEXT,
          updates TEXT)
      ''');
  }

  Future<List<CurrencyMonitor>> getMonitoredCurrencies() async {
    Database db = await instance.database;
    var monitoredCurrencies = await db.query('currency_monitor', orderBy: 'id');
    List<CurrencyMonitor> currencyList = monitoredCurrencies.isNotEmpty
        ? monitoredCurrencies.map((c) => CurrencyMonitor.fromMap(c)).toList()
        : [];

    return currencyList;
  }

  Future<int> addCurrency({required CurrencyMonitor currencyMonitor}) async {
    Database db = await instance.database;
    return await db.insert('currency_monitor', currencyMonitor.toMap());
  }

  Future<int> removeCurrency({required int id}) async {
    Database db = await instance.database;
    return await db
        .delete('currency_monitor', where: 'id = ?', whereArgs: [id]);
  }
}
