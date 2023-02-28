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
      theme: ThemeData.from(
        colorScheme: const ColorScheme.dark(
            primary: Colors.amber,
            secondary: Colors.amberAccent,
            onSecondaryContainer: Colors.amber,
            onSurface: Colors.amber,
            onSurfaceVariant: Colors.amber),
        useMaterial3: true,
      ),
      home: const BillNavigationBar(),
    );
  }
}
