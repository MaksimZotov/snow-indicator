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
  late final Database _database;

  CitiesDatabase(CityConverter cityConverter) {
    _cityConverter = cityConverter;
    _initDB(_pathToDB);
  }

  Future _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    _database = await openDatabase(path, version: 1, onCreate: _createDB);
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
    final id =
        await _database.insert(_citiesDB, _cityConverter.toJson(city));
    return city.copy(id: id);
  }

  Future<City> readCity(int id) async {
    final maps = await _database.query(
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
    const orderBy = '${CityFields.time} ASC';
    final result = await _database.query(_citiesDB, orderBy: orderBy);
    return result.map((json) => _cityConverter.fromJson(json)).toList();
  }

  Future<int> update(City city) async {
    return _database.update(
      _citiesDB,
      _cityConverter.toJson(city),
      where: '${CityFields.id} = ?',
      whereArgs: [city.id],
    );
  }

  Future<int> delete(int id) async {
    return await _database.delete(
      _citiesDB,
      where: '${CityFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    _database.close();
  }
}
