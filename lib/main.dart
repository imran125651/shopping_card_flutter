import 'package:flutter/material.dart';

import 'Widgets/ShoppingUI.dart';

void main() {
  runApp(const ShoppingCard());
}

class ShoppingCard extends StatelessWidget {
  const ShoppingCard({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const ShoppingUI(),
    );
  }
}


