import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List userList = [];

  String url = 'https://jsonplaceholder.typicode.com/users';

  Future<void> getUser() async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      setState(() {
        userList.addAll(json.decode(response.body));
      });
    } else {
      throw Exception('Failed to load users');
    }
  }

  @override
  void initState() {
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home Page')),
      // Show a spinner if the list is still empty
      body: userList.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: userList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(userList[index]['name']),
                  subtitle: Text(userList[index]['email']),
                  leading: CircleAvatar(
                    child: Text(userList[index]['name'][0].toString()),
                  ),
                );
              },
            ),
    );
  }
}
