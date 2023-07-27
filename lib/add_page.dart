import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app/database_provider.dart';
import 'package:my_app/meal.dart';

class AddPage extends StatefulWidget
{
  const AddPage({super.key});

  @override
  State<StatefulWidget> createState() => AddPageState();
}

class AddPageState extends State<AddPage> {
  final form = GlobalKey<FormState>();
  final name = TextEditingController();
  final price = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ajout')
      ),
      body: Form(
        key: form,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                controller: name,
                decoration: const InputDecoration(
                  labelText: 'Nom',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0))
                  )
                ),
                validator:(value) {
                  if (value != null && value.isEmpty) {
                    return 'Veuillez saisir un nom';
                  }

                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                controller: price,
                decoration: const InputDecoration(
                  labelText: 'Prix',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0))
                  )
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value != null && value.isEmpty) {
                    return 'Veuillez saisir un prix';
                  }

                  if (value != null && !(int.parse(value) > 0 && int.parse(value) < 100)) {
                    return 'Veuillez saisir un prix entre 1 et 99';
                  }

                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ElevatedButton(
                onPressed: () {
                  if (form.currentState!.validate()) {
                    DatabaseProvider().addMeal(
                      Meal(name.value.text, double.parse(price.value.text), 'https://assets.afcdn.com/recipe/20160519/15342_w600.jpg')
                    );

                    Navigator.pop(context);
                  }
                },
                child: const Text('Save'),
              ),
            ),
          ],
        ),
      )
    );
  }
}
