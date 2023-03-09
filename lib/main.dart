import 'dart:async';

import 'package:bill_splitter/src/shared/repositories/token_auth.dart';
import 'package:bill_splitter/src/views/login/login_page.dart';
import 'package:bill_splitter/src/views/navigation_bar.dart';
import 'package:flutter/material.dart';

void main() {
  return runApp(const BillSplitter());
}

class BillSplitter extends StatefulWidget {
  const BillSplitter({Key? key}) : super(key: key);

  @override
  State<BillSplitter> createState() => _BillSplitterState();
}

class _BillSplitterState extends State<BillSplitter> {
  final _streamController = StreamController<bool>();
  TokenAuth tokenAuthRepository = TokenAuth();

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        darkTheme: ThemeData.from(
          colorScheme: const ColorScheme.dark(
            primary: Color.fromARGB(255, 5, 151, 209),
            onPrimary: Colors.white,
            secondary: Colors.blueGrey,
            onSecondaryContainer: Color.fromARGB(255, 5, 151, 209),
            onSurface: Color.fromARGB(255, 125, 220, 255),
            surfaceVariant: Colors.white,
            onSurfaceVariant: Color.fromARGB(255, 5, 151, 209),
          ),
          useMaterial3: true,
        ),
        theme: ThemeData.from(
            colorScheme: const ColorScheme.light(
              primary: Color.fromARGB(255, 2, 86, 119),
              onPrimary: Colors.white,
              secondary: Colors.blueGrey,
              surface: Color.fromARGB(255, 174, 219, 238),
              onSurface: Color.fromARGB(255, 0, 27, 37),
              surfaceVariant: Colors.white,
              outline: Color.fromARGB(255, 36, 104, 131),
            ),
            useMaterial3: true),
        home: StreamBuilder(
          stream: _streamController.stream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data == true) {
                return const BillNavigationBar();
              }
              if (snapshot.data == false) {
                return const LoginPage();
              }
            }
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          },
        ));
  }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

  Future _fetchData() async {
    bool? data = await tokenAuthRepository.validateToken();
    if (data == null) {
      _streamController.sink.addError("No data, trying again");
      await Future.delayed(const Duration(seconds: 5));
      return await _fetchData();
    }
    _streamController.sink.add(data);
  }
}
