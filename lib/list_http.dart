import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ListHttp extends StatefulWidget {
  const ListHttp({super.key});

  @override
  State<StatefulWidget> createState() => ListHttpState();
}

class ListHttpState extends State<ListHttp> {
  List<dynamic> users = [];

  Future<List<dynamic>> fetchUsers() async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));

    return response.statusCode == 200
      ? jsonDecode(response.body)
      : throw Exception('Fail');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Liste API')
      ),
      body: FutureBuilder(
        future: fetchUsers(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());

          users = snapshot.data as List<dynamic>;

          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              dynamic user = users[index];

              return Card(
                margin: const EdgeInsets.all(8),
                elevation: 2,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: Text(user['name'], style: const TextStyle(fontSize: 20))
                )
              );
            },
          );
        },
      )
    );
  }
}
