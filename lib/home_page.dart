import 'package:flutter/material.dart';
import 'package:my_app/counter.dart';
import 'package:my_app/my_drawer.dart';
import 'package:transparent_image/transparent_image.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Column buildButton(String label, Color color, [IconData? icon]) {
    return Column(
      children: [
        if (icon != null) Icon(icon, color: color),
        Container(
          padding: const EdgeInsetsDirectional.only(top: 10, bottom: 20),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 18,
              color: color,
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Fiorella')
        ),
        body: ListView(
          children: [
            Container(
              padding: const EdgeInsets.all(40),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Text('Fiorella', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Bianca', style: TextStyle(fontSize: 20)),
                      Text('Mina', style: TextStyle(fontSize: 20)),
                    ],
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildButton('Icône 1', Colors.blue, Icons.favorite),
                buildButton('Icône 2', Colors.red, Icons.account_box),
                buildButton('Icône 3', Colors.lightBlue)
              ],
            ),
            // ...
            Image.asset('images/cat.jpg'),
            Stack(children: [
              const SizedBox(
                height: 250,
                child: Center(child: CircularProgressIndicator()),
              ),
              FadeInImage.memoryNetwork(
                placeholder: kTransparentImage,
                image: 'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg',
              ),
            ]),
            const Counter(count: 12),
            const Counter(),
            const Counter(count: 23)
          ],
        ),
        drawer: const MyDrawer(),
      );
  }
}
