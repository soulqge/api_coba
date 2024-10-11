import 'package:flutter/material.dart';
import 'package:login_logout_tutor/pages/edit_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatelessWidget {
  final String userId; // Variable to store the user's ID
  final String userName; // Variable to store the user's name
  final String initialPassword; // Variable to store the user's password

  // Constructor to accept the user's ID, name, and password
  HomeScreen({
    required this.userId,
    required this.userName,
    required this.initialPassword,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        leading: IconButton(
          icon: Icon(Icons.logout),
          onPressed: () {
            logout(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditUserPage(
                    userId: userId, 
                    initialUserName: userName, 
                    initialPassword: initialPassword, 
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Text("Welcome, $userName! You are logged in."),
      ),
    );
  }

  Future<void> logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Remove the token from storage
    await prefs.remove('token');

    // Navigate back to the login screen
    Navigator.pushReplacementNamed(context, '/login');
  }
}
