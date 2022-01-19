import 'package:path/path.dart';
import 'package:snow_indicator/data/converters/city_converter.dart';
import 'package:sqflite/sqflite.dart';

import '../../domain/entities/city.dart';

class Tables {
  static const String cities = 'cities';
}

class CitiesDatabase {
  static final CitiesDatabase instance = CitiesDatabase._init();

  static Database? _database;

  CitiesDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('cities.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const realType = 'REAL NOT NULL';
    const textOrNullType = 'TEXT';

    await db.execute('''
      CREATE TABLE ${Tables.cities} ( 
        ${CityFields.id} $idType, 
        ${CityFields.name} $textType,
        ${CityFields.snowiness} $realType,
        ${CityFields.image} $textOrNullType,
        ${CityFields.time} $textType
        )
      ''');
  }

  Future<City> create(City city) async {
    final db = await instance.database;
    final id = await db.insert(Tables.cities, CityConverter.toJson(city));
    return city.copy(id: id);
  }

  Future<City> readCity(int id) async {
    final db = await instance.database;
    final maps = await db.query(
      Tables.cities,
      columns: CityFields.values,
      where: '${CityFields.id} = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return CityConverter.fromJson(maps.first);
    } else {
      throw Exception('ID $id is not found');
    }
  }

  Future<List<City>> readAllCities() async {
    final db = await instance.database;
    const orderBy = '${CityFields.time} ASC';
    final result = await db.query(Tables.cities, orderBy: orderBy);
    return result.map((json) => CityConverter.fromJson(json)).toList();
  }

  Future<int> update(City city) async {
    final db = await instance.database;
    return db.update(
      Tables.cities,
      CityConverter.toJson(city),
      where: '${CityFields.id} = ?',
      whereArgs: [city.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;
    return await db.delete(
      Tables.cities,
      where: '${CityFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
