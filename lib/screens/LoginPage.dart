import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          children: <Widget>[
            const SizedBox(height: 80.0),
            Column(
              children: <Widget>[
                Image.asset(
                    'assets/logo.png',
                    height: MediaQuery.of(context).size.height*0.14
                ),
                const SizedBox(height: 16.0),
              ],
            ),
            const SizedBox(height: 120.0),
            ElevatedButton(
                onPressed: null,
                child: Text("Google Login")
            ),
            ElevatedButton(
                onPressed: null,
                child: Text("Anonymous Login")
            )
          ],
        ),
      ),
    );
  }
}
