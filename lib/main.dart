import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_app/add_page.dart';
import 'package:my_app/home_page.dart';
import 'package:my_app/list_http.dart';
import 'package:my_app/list_page.dart';
import 'package:my_app/meal.dart';
import 'package:my_app/single_page.dart';

void main() {
  // runApp(const MyApp2());
  runApp((MaterialApp(debugShowCheckedModeBanner: false, home: ProfileWidget())));
}

class ProfileWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ProfileWidgetShape();
  }
}

class _ProfileWidgetShape extends State<ProfileWidget> {
  var theme1 = Colors.white;
  var theme2 = Color(0xff2E324F);
  var white = Colors.white;
  var black = Colors.black;
  bool switchColor = false;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: theme1,
      appBar: AppBar(
        backgroundColor: theme1,
        elevation: 0.0,
        leading: Icon(
          Icons.arrow_back,
          color: black,
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.favorite_border,
              color: black,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 8.0, 12.0, 8.0),
            child: Icon(
              Icons.more_vert,
              color: black,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _profilePic(),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 4.0),
              child: Text("Matthieu Mota",
                  style: TextStyle(
                      color: black,
                      fontSize: 26.0,
                      fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 8.0),
              child: Text(
                "Développeur web et formateur",
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Text("Créer de belles applications web",
                style: TextStyle(
                    color: black,
                    fontSize: 15.0,
                    fontWeight: FontWeight.normal)),
            Text("@Boxydev",
                style: TextStyle(
                    color: black,
                    decoration: TextDecoration.underline,
                    fontSize: 15.0,
                    fontWeight: FontWeight.normal)),
            _networkingLinks(),
            _hireButton(),
            Padding(
              padding: const EdgeInsets.fromLTRB(40.0, 8.0, 40.0, 0.0),
              child: Divider(
                color: Color(0xff78909c),
                height: 50.0,
              ),
            ),
            _followers()
          ],
        ),
      ),
    );
  }

  Row _followers() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _followerDetails("images/dribble.png", '3'),
          _followerDetails("images/behance.png", '6'),
        ],
      );

  Column _followerDetails(String image, String number) => Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(45.0, 16.0, 40.0, 16.0),
            child: Container(
              width: 50.0,
              height: 50.0,
              child: Image.asset(
                image,
              ),
            ),
          ),
          Text(number+"k",
              style: TextStyle(
                  color: black, fontWeight: FontWeight.bold, fontSize: 20.0)),
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Text("Followers",
                style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0)),
          ),
        ],
      );

  MaterialButton _hireButton() => MaterialButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0)),
        onPressed: () {
          debugPrint("Recrutez moi");
          setState(() {
            if (switchColor == false) {
              black = Colors.white;
              white = Colors.black;
              theme1 = Color(0xff2E324F);
              switchColor = true;
            } else {
              black = Colors.black;
              white = Colors.white;
              theme1 = Colors.white;
              switchColor = false;
            }
          });
        },
        height: 40.0,
        minWidth: 140.0,
        child: Text(
          "Recrutez moi",
          style: TextStyle(color: Colors.white, fontSize: 18.0),
        ),
        color: Colors.blue,
      );

  Row _networkingLinks() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _networkIcon("images/twitter.png"),
          _networkIcon("images/medium.png"),
          _networkIcon("images/linkedin.png"),
        ],
      );

  Padding _networkIcon(String image) => Padding(
        padding: const EdgeInsets.fromLTRB(8.0, 15.0, 8.0, 15.0),
        child: Container(height: 25.0, width: 25.0, child: Image.asset(image)),
      );

  Container _profilePic() => Container(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(50.0, 30.0, 50.0, 15.0),
          child: Stack(
            alignment: const Alignment(0.9, 0.9),
            children: <Widget>[
              CircleAvatar(
                backgroundImage: AssetImage("images/cat.jpg"),
                radius: 50.0,
              ),
              Container(
                height: 30.0,
                width: 30.0,
                child: Image.asset("images/verified.jpg"),
                alignment: Alignment.bottomRight,
              ),
            ],
          ),
        ),
      );
}

class MyApp2 extends StatelessWidget {
  const MyApp2({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const Home(),
      theme: ThemeData(
        brightness: Brightness.dark,
        appBarTheme: const AppBarTheme(color: Colors.transparent)
      )
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List movies = [];

  @override
  void initState() {
    super.initState();

    fetchMovies();
  }

  fetchMovies() async {
    final response = await http.get(Uri.parse('https://api.vueflix.boxydev.com/movies'));

    setState(() {
      movies = jsonDecode(response.body);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('FluFix')),
      body: GridView.builder(
        padding: const EdgeInsetsDirectional.symmetric(vertical: 10),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 250,
          mainAxisExtent: 370,
        ),
        itemCount: movies.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              InkWell(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(movies[index]['poster_path'], height: 300, width: 175, fit: BoxFit.cover),
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Single(movies[index])
                  ));
                },
              ),
              const SizedBox(height: 10),
              Text(movies[index]['title'], textAlign: TextAlign.center),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(DateTime.parse(movies[index]['release_date']).year.toString()),
                  const SizedBox(width: 40),
                  const Icon(Icons.star, size: 15, color: Colors.yellow),
                  const SizedBox(width: 5),
                  Text(movies[index]['vote_average'].toStringAsFixed(1) + '/10')
                ],
              )
            ]
          );
        },
      ),
    );
  }
}

class Single extends StatelessWidget {
  final Map movie;

  const Single(this.movie, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(movie['title'])),
      body: ListView(children: [
        Container(
          child: Stack(children: [
            Container(child: Image.network(movie['backdrop_path'], height: 300, fit: BoxFit.cover)),
            Positioned(
              bottom: 10,
              left: 10,
              child: Text('⭐ Note : ' + movie['vote_average'].toStringAsFixed(1) + '/10'),
            )
          ]),
        ),
        SizedBox(height: 15),
        Container(
          padding: EdgeInsets.all(10),
          child: Text(movie['title'], style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        ),
        Container(
          padding: EdgeInsets.only(left: 10),
          child: Text('Sortie le ' + movie['release_date'])
        ),
        Row(
          children: [
            Container(
              height: 300,
              width: 200,
              child: Image.network(movie['poster_path']),
            ),
            Flexible(
              child: Container(
                padding: EdgeInsets.all(10),
                child: Text(movie['overview'])
              ),
            ),
          ],
        )
      ]),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fiorella',
      onGenerateRoute: (settings) => Router.generate(settings),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue)
      ),
      // home: const HomePage(),
      // ou bien
      initialRoute: '/',
      routes: {
        '/': (_) => const HomePage(),
        '/meals': (_) => const ListPage(),
        '/meal/new': (_) => const AddPage(),
        '/api': (_) => const ListHttp(),
      },
    );
  }
}

class Router {
  static Route<Object> generate(RouteSettings route) {
    return MaterialPageRoute(
      builder: (context) {
        if (route.name == '/') {
          return const HomePage();
        } else if (route.name == '/meals') {
          return const ListPage();
        } else if (route.name == '/meal') {
          return SinglePage(route.arguments as Meal);
        } else if (route.name == '/meal/new') {
          return const AddPage();
        } else if (route.name == '/api') {
          return const ListHttp();
        }

        return const HomePage();
      }
    );
  }
}
