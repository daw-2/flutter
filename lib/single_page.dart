import 'package:flutter/material.dart';
import 'package:my_app/meal.dart';
import 'package:transparent_image/transparent_image.dart';

class SinglePage extends StatelessWidget {
  final Meal meal;

  const SinglePage(this.meal, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(meal.name)
      ),
      body: Column(
        children: [
          Stack(children: [
            const SizedBox(
              height: 200,
              child: Center(child: CircularProgressIndicator())
            ),
            Hero(
              tag: 'meal-${meal.id}',
              child: FadeInImage.memoryNetwork(
                placeholder: kTransparentImage,
                image: meal.image,
              ),
            ),
          ]),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(meal.name, style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w900)),
              ]
            ),
          ),
          Text('${meal.price} €', style: const TextStyle(fontSize: 20)),
        ],
      )
    );
  }
}
