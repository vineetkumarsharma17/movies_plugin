import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:movies_plugin/movies_plugin.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map _info = {};
  bool _isLoading = false;
  final _moviesPlugin = MoviesPlugin();
  final titleCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> searchMovies(String title) async {
    setState(() {
      _isLoading = true;
    });
    var info = await _moviesPlugin.searchMovies(title);
    if (info != null) {
      setState(() {
        _isLoading = false;
        _info = jsonDecode(info);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Column(
                      children: [
                        TextField(
                          controller: titleCtrl,
                          decoration: const InputDecoration(
                              hintText: "Enter movie title"),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              if (titleCtrl.text.isEmpty) return;
                              searchMovies(titleCtrl.text.trim());
                              titleCtrl.clear(); // CLEAR THE TEXTFIELD
                              FocusScope.of(context)
                                  .unfocus(); // HIDE THE KEYBOARD
                            },
                            child: const Text("Search")),
                        if (_info.isNotEmpty)
                          Card(
                              child: Column(children: [
                            ListTile(
                                title: Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            _info['Title'],
                                          ),
                                          Text(
                                            'Released: ${_info['Released']}',
                                          ),
                                          Text(
                                            'Actors: ${_info['Actors']}',
                                          ),
                                        ],
                                      ),
                                    ),
                                    Image.network(
                                      _info['Poster'],
                                      height: 100,
                                    )
                                  ],
                                ),
                                subtitle: Text(_info['Plot']))
                          ]))
                      ],
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
