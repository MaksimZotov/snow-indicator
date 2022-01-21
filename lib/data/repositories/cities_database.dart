import 'package:injectable/injectable.dart';
import 'package:path/path.dart';
import 'package:snow_indicator/data/converters/city_converter.dart';
import 'package:sqflite/sqflite.dart';

import '../../domain/entities/city.dart';

@singleton
class CitiesDatabase {
  final String _citiesDB = 'cities';
  final _pathToDB = 'cities.db';

  late final CityConverter _cityConverter;
  late final CityFields _cityFields;
  CitiesDatabase(this._cityConverter, this._cityFields);

  Database? _databaseNullable;

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
        ${_cityFields.id} $idType, 
        ${_cityFields.name} $textType,
        ${_cityFields.snowiness} $realType,
        ${_cityFields.image} $textOrNullType
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
      columns: _cityFields.values,
      where: '${_cityFields.id} = ?',
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
    final orderBy = '${_cityFields.id} ASC';
    final result = await db.query(_citiesDB, orderBy: orderBy);
    return result.map((json) => _cityConverter.fromJson(json)).toList();
  }

  Future<int> update(City city) async {
    final db = await _database;
    return db.update(
      _citiesDB,
      _cityConverter.toJson(city),
      where: '${_cityFields.id} = ?',
      whereArgs: [city.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await _database;
    return await db.delete(
      _citiesDB,
      where: '${_cityFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await _database;
    db.close();
  }
}
