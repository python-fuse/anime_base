import 'package:anime_base/models/anime_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('anime_list.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute("""
      CREATE TABLE animes(
      id integer primary key,
      title TEXT,
      imageUrl TEXT,
      description TEXT,
      score REAL
)
      """);
  }

  Future<int> saveAnime(Anime anime) async {
    final db = await instance.database;
    return await db.insert(
        'animes',
        {
          'id': anime.id,
          'title': anime.title,
          'imageUrl': anime.imageUrl,
          'description': anime.description,
          'score': anime.score,
        },
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Anime>> getSavedAnimes() async {
    final db = await instance.database;
    final maps = await db.query('animes');
    return List.generate(maps.length, (i) {
      return Anime(
        id: maps[i]['id'] as int,
        title: maps[i]['title'] as String,
        imageUrl: maps[i]['imageUrl'] as String,
        description: maps[i]['description'] as String,
        score: maps[i]['score'] as double,
        // Add other fields with default values or null
        largeImageUrl: '',
        rating: '',
        type: '',
        episodes: 0,
        status: '',
        aired: '',
        duration: '',
        trailerUrl: '',
        rank: 0,
        popularity: 0,
        members: 0,
        favorites: 0,
        premiered: '',
        genres: '',
      );
    });
  }

  Future<bool> isAnimeSaved(int animeId) async {
    final db = await instance.database;
    final result = await db.query(
      'animes',
      where: 'id = ?',
      whereArgs: [animeId],
      limit: 1,
    );
    return result.isNotEmpty;
  }

  Future<int> deleteAnime(int id) async {
    final db = await instance.database;
    return await db.delete(
      'animes',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
