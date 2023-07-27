import 'package:flutter/material.dart';
import 'package:my_app/meal.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider {
  static final DatabaseProvider _instance = DatabaseProvider._internal();
  DatabaseProvider._internal();

  // DatabaseProvider() n'est instancié qu'une seule fois.
  factory DatabaseProvider() {
    return _instance;
  }

  // Ici, on peut récupérer la connexion à la base de données si nécessaire et
  // elle se fait une seule fois
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database as Database;

    WidgetsFlutterBinding.ensureInitialized();

    // Pour les tests
    // await deleteDatabase('my_app.db');

    return _database = await openDatabase(
      'my_app.db',
      onCreate: (db, version) => db.execute('CREATE TABLE meal (id INTEGER PRIMARY KEY, name VARCHAR(255), price DOUBLE, image VARCHAR(255))'),
      version: 1
    );
  }

  // Sert à initialiser la DB
  List<Meal> defaultMeals = [
    const Meal('Pizza', 8.99, 'https://assets.afcdn.com/recipe/20160519/15342_w600.jpg'),
    const Meal('Burger', 6.99, 'https://cac.img.pmdstatic.net/fit/http.3A.2F.2Fprd2-bone-image.2Es3-website-eu-west-1.2Eamazonaws.2Ecom.2Fcac.2F2018.2F09.2F25.2F03ab5e89-bad7-4a44-b952-b30c68934215.2Ejpeg/748x372/quality/90/crop-from/center/burger-maison.jpeg'),
    const Meal('Crêpe', 4.99, 'https://cac.img.pmdstatic.net/fit/http.3A.2F.2Fprd2-bone-image.2Es3-website-eu-west-1.2Eamazonaws.2Ecom.2Fcac.2F2018.2F09.2F25.2F830851b1-1f2a-4871-8676-6c06b0962938.2Ejpeg/748x372/quality/90/crop-from/center/crepes-comme-chez-nous.jpeg'),
    const Meal('Cake', 3.99, 'https://cac.img.pmdstatic.net/fit/http.3A.2F.2Fprd2-bone-image.2Es3-website-eu-west-1.2Eamazonaws.2Ecom.2FCAC.2Fvar.2Fcui.2Fstorage.2Fimages.2Fdossiers-gourmands.2Ftendance-cuisine.2Fles-gateaux-du-gouter-45-recettes-gourmandes-en-diaporama-187414.2F1637287-1-fre-FR.2Fles-gateaux-du-gouter-45-recettes-gourmandes-en-diaporama.2Ejpg/748x372/quality/90/crop-from/center/cake-nature-sucre.jpeg'),
    const Meal('Donuts', 2.99, 'https://cac.img.pmdstatic.net/fit/http.3A.2F.2Fprd2-bone-image.2Es3-website-eu-west-1.2Eamazonaws.2Ecom.2Fcac.2F2018.2F09.2F25.2F80586d11-1f17-40ad-80ae-4cd9b5c42182.2Ejpeg/748x372/quality/90/crop-from/center/donuts-avec-appareil-a-donuts.jpeg'),
  ];

  // Permet de retrouver la liste des plats en BDD ou dans un tableau si vide
  Future<List<Meal>> meals() async {
    List<Map<String, dynamic>> maps = await (await database).query('meal');

    List<Meal> meals = List.generate(maps.length, (i) {
      return Meal.fromMap(maps[i]);
    });

    if (meals.isEmpty) {
      for (Meal meal in defaultMeals) {
        addMeal(meal);
      }

      meals = await this.meals();
    }

    return meals;
  }

  // Ajoute un plat dans la BDD
  void addMeal(Meal meal) async {
    await (await database).insert('meal', meal.toMap());
  }

  // Supprime un plat de la BDD
  void removeMeal(int id) async {
    await (await database).delete('meal', where: 'id = ?', whereArgs: [id]);
  }
}
