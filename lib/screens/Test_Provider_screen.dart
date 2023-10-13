import 'package:flutter/material.dart';
import 'package:flutter_application_3/provider/test_Provider.dart';
import 'package:provider/provider.dart';

class TestProviderScreen extends StatelessWidget {
  const TestProviderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final UserProvider = Provider.of<TestProvider>(context);
    return Scaffold(
      body: Center(
        child: Text(UserProvider.user),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        UserProvider.user = 'hola:) xdxdxdxdxdx';
      }),
    );
  }
}
