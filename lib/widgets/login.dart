
/*import 'package:flutter/material.dart';
import '../controllers/AuthenticationController.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          children: <Widget>[
            SizedBox(height: 80.0),
            Column(
              children: <Widget>[
                Image.asset('asset/nba.png', width: 70, height: 60,),
                SizedBox(height: 16.0),
                Text('NBA'),
              ],
            ),
            SizedBox(height: 120.0),
            SizedBox(height: 12.0),
            Consumer<ApplicationState>(
              builder: (context, appState, _) => ElevatedButton(
                onPressed: () => {
                  appState.signInWithGoogle(context)
                },
                child: Text(
                  "Google",
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.redAccent,
                ),
              ),
            ),
            SizedBox(height: 12.0),
            Consumer<ApplicationState>(
              builder: (context, appState, _) => ElevatedButton(
                onPressed: () => {
                  appState.loginWithAnonymous(context),
                },
                child: Text(
                  "Guest",
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}*/
