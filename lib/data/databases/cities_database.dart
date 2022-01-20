import 'package:injectable/injectable.dart';
import 'package:path/path.dart';
import 'package:snow_indicator/data/converters/city_converter.dart';
import 'package:sqflite/sqflite.dart';

import '../../domain/entities/city.dart';

@lazySingleton
class CitiesDatabase {
  static const String _citiesDB = 'cities';
  static const _pathToDB = 'cities.db';

  late final CityConverter _cityConverter;
  Database? _databaseNullable;

  CitiesDatabase(CityConverter cityConverter) {
    _cityConverter = cityConverter;
  }

  Future<Database> get _database async {
    if (_databaseNullable != null) {
      return _databaseNullable!;
    }
    _databaseNullable = await _initDB(_pathToDB);
    return _databaseNullable!;
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
      CREATE TABLE $_citiesDB ( 
        ${CityFields.id} $idType, 
        ${CityFields.name} $textType,
        ${CityFields.snowiness} $realType,
        ${CityFields.image} $textOrNullType,
        ${CityFields.time} $textType
        )
      ''');
  }

  Future<City> create(City city) async {
    final db = await _database;
    final id =
        await db.insert(_citiesDB, _cityConverter.toJson(city));
    return city.copy(id: id);
  }

  Future<City> readCity(int id) async {
    final db = await _database;
    final maps = await db.query(
      _citiesDB,
      columns: CityFields.values,
      where: '${CityFields.id} = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return _cityConverter.fromJson(maps.first);
    } else {
      throw Exception('ID $id is not found');
    }
  }

  Future<List<City>> readAllCities() async {
    final db = await _database;
    const orderBy = '${CityFields.time} ASC';
    final result = await db.query(_citiesDB, orderBy: orderBy);
    return result.map((json) => _cityConverter.fromJson(json)).toList();
  }

  Future<int> update(City city) async {
    final db = await _database;
    return db.update(
      _citiesDB,
      _cityConverter.toJson(city),
      where: '${CityFields.id} = ?',
      whereArgs: [city.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await _database;
    return await db.delete(
      _citiesDB,
      where: '${CityFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await _database;
    db.close();
  }
}
