import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/movie.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: IntroScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Movie> _movies = [];
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _directorController = TextEditingController();
  TextEditingController _posterController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadMovies();
  }

  _loadMovies() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getStringList('movies') != null) {
      List<String>? movies = prefs.getStringList('movies');
      setState(() {
        _movies = movies!.map((e) => Movie.fromJson(jsonDecode(e))).toList();
      });
    }
  }

  _saveMovies() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList(
        'movies', _movies.map((e) => jsonEncode(e.toJson())).toList());
  }

  _addMovie() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _movies.add(Movie(
            name: _nameController.text,
            director: _directorController.text,
            poster: _posterController.text));
      });
      _saveMovies();
      Navigator.pop(context);
    }
  }

  _deleteMovie(int index) {
    setState(() {
      _movies.removeAt(index);
    });
    _saveMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _movies.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_movies[index].name),
                  subtitle: Text(_movies[index].director),
                  leading: Image.network(_movies[index].poster),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => _deleteMovie(index),
                  ),
                );
              },
            ),
          ),
          ElevatedButton(
            child: Text('Add Movie'),
            onPressed: () => showDialog(
                context: context,
                builder: (context) => AlertDialog(
                      title: Text('Add Movie'),
                      content: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextFormField(
                              controller: _nameController,
                              decoration:
                                  InputDecoration(labelText: 'Movie Name'),
                              validator: (value) =>
                                  value!.isEmpty ? 'Enter a name' : null,
                            ),
                            TextFormField(
                              controller: _directorController,
                              decoration:
                                  InputDecoration(labelText: 'Director'),
                              validator: (value) =>
                                  value!.isEmpty ? 'Enter a director' : null,
                            ),
                            TextFormField(
                              controller: _posterController,
                              decoration:
                                  InputDecoration(labelText: 'Poster URL'),
                              validator: (value) =>
                                  value!.isEmpty ? 'Enter a URL' : null,
                            ),
                          ],
                        ),
                      ),
                      actions: [
                        ElevatedButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text('Cancel')),
                        ElevatedButton(
                            onPressed: _addMovie, child: Text('Add')),
                      ],
                    )),
          ),
        ],
      ),
    );
  }
}

class Movie {
  String name;
  String director;
  String poster;

  Movie({required this.name, required this.director, required this.poster});

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
        name: json['name'], director: json['director'], poster: json['poster']);
  }

  Map<String, dynamic> toJson() =>
      {'name': name, 'director': director, 'poster': poster};
}
