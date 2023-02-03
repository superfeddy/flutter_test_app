import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'dart:async';
import 'dart:convert';
import 'dart:math';

const apiUrl = 'https://reqres.in/api/users/';
const userCount = 12;

class User {
  final int id;
  final String email;
  final String firstName;
  final String lastName;
  final String avatar;

  const User({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.avatar,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['data']['id'],
      email: json['data']['email'],
      firstName: json['data']['first_name'],
      lastName: json['data']['last_name'],
      avatar: json['data']['avatar'],
    );
  }
}

Future<User> fetchUser() async {
  final response = await http
      .get(Uri.parse('$apiUrl${Random().nextInt(userCount - 1) + 1}'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return User.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load user');
  }
}

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late Future<User> futureUser;

  @override
  void initState() {
    super.initState();
    futureUser = fetchUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<User>(
        future: futureUser,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Container(
                padding: const EdgeInsets.all(10),
                child: Column(children: [
                  Center(
                      child: CircleAvatar(
                          backgroundImage: NetworkImage(snapshot.data!.avatar),
                          radius: 70)),
                  Container(
                      child: Row(children: [
                    Expanded(
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Column(children: [
                              const Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text('First Name',
                                      style: TextStyle(
                                        fontSize: 20,
                                      ))),
                              Container(
                                  margin: const EdgeInsets.only(left: 10),
                                  child: Text(
                                    snapshot.data!.firstName,
                                    style: const TextStyle(fontSize: 20),
                                  ))
                            ]))),
                    Expanded(
                        child: Column(children: [
                      const Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Last Name',
                              style: TextStyle(fontSize: 20))),
                      Container(
                          margin: const EdgeInsets.only(left: 10),
                          child: Text(
                            snapshot.data!.lastName,
                            style: const TextStyle(fontSize: 20),
                          ))
                    ])),
                  ])),
                  Container(
                      margin: const EdgeInsets.only(top: 30),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Column(children: [
                            const Align(
                                alignment: Alignment.centerLeft,
                                child: Text('Email',
                                    style: TextStyle(
                                      fontSize: 20,
                                    ))),
                            Container(
                                margin: const EdgeInsets.only(left: 10),
                                child: Text(
                                  snapshot.data!.email,
                                  style: const TextStyle(fontSize: 20),
                                ))
                          ])))
                ]));
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }

          // By default, show a loading spinner.
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
