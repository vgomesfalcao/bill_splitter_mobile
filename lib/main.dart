import 'package:bill_splitter/src/views/navigation_bar.dart';
import 'package:flutter/material.dart';

void main() {
  return runApp(const BillSplitter());
}

class BillSplitter extends StatelessWidget {
  const BillSplitter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: ThemeData.from(
        colorScheme: const ColorScheme.dark(
            primary: Colors.amber,
            secondary: Colors.amberAccent,
            onSecondaryContainer: Colors.amber,
            onSurface: Colors.amber,
            onSurfaceVariant: Colors.amber),
        useMaterial3: true,
      ),
      theme: ThemeData.from(
          colorScheme: const ColorScheme.light(
              primary: Color.fromARGB(255, 0, 65, 90),
              onPrimary: Colors.white,
              secondary: Colors.blueGrey,
              surface: Colors.blueGrey,
              onSurface: Colors.white,
              surfaceVariant: Colors.white,
              outline: Color.fromARGB(255, 0, 65, 90)),
          useMaterial3: true,
          textTheme: Typography.dense2014),
      home: const BillNavigationBar(),
    );
  }
}
