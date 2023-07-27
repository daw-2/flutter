import 'package:flutter/material.dart';
import 'package:my_app/database_provider.dart';
import 'package:my_app/meal.dart';
import 'package:my_app/my_drawer.dart';
import 'package:transparent_image/transparent_image.dart';

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<StatefulWidget> createState() => ListPageState();
}

class ListPageState extends State<ListPage> {
  List<Meal> meals = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Liste')
      ),
      body: FutureBuilder(
        future: DatabaseProvider().meals(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Text('No data');

          meals = snapshot.data as List<Meal>;

          return ListView.builder(
            itemCount: meals.length,
            itemBuilder: (context, index) {
              Meal meal = meals[index];

              return Dismissible(
                key: Key(meal.name),
                onDismissed: (direction) {
                  DatabaseProvider().removeMeal(meal.id as int);

                  ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text('${meal.name} dismissed')));
                },
                background: Container(color: Colors.red),
                child: ListItem(meal)
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).pushNamed('/meal/new').then((value) => setState(() {})),
        child: const Icon(Icons.add),
      ),
      drawer: const MyDrawer(),
    );
  }
}

class ListItem extends StatelessWidget {
  final Meal meal;

  const ListItem(this.meal, {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed('/meal', arguments: meal),
      child: Card(
        margin: const EdgeInsets.all(8),
        elevation: 2,
        child: Row(
          children: [
            Stack(children: [
              const SizedBox(
                height: 100, width: 150,
                child: Center(child: CircularProgressIndicator())
              ),
              Hero(
                tag: 'meal-${meal.id}',
                child: FadeInImage.memoryNetwork(
                  placeholder: kTransparentImage,
                  image: meal.image,
                  height: 100, width: 150, fit: BoxFit.cover,
                )
              ),
            ]),
            Container(
              padding: const EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${meal.name} ${meal.id}', style: const TextStyle(fontSize: 24)),
                  Container(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text('${meal.price} €', style: const TextStyle(fontSize: 14)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
