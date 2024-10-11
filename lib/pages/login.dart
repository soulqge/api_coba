import 'package:flutter/material.dart';
import '../services/user_service.dart';
import 'home.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  List<dynamic> _users = [];
  bool _isLoading = false;
  final ApiService apiService = ApiService(
      'https://localhost:7248/api/Users'); 

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  
  Future<void> fetchData() async {
    setState(() {
      _isLoading = true;
    });

    try {
      _users =
          await apiService.fetchUsers(); 
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
     
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text(e.toString()),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  void login() {
    String userName = _userNameController.text;
    String password = _passwordController.text;

    final matchingUser = _users.firstWhere(
      (user) => user['username'] == userName && user['password'] == password,
      orElse: () => null,
    );

    if (matchingUser != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => HomeScreen(
                  userName: matchingUser['username'],
                  userId: matchingUser['id'].toString(),
                  initialPassword: matchingUser['password'],
                )),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Login Failed'),
            content: Text('Invalid email or password.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    controller: _userNameController,
                    decoration: InputDecoration(labelText: 'Username'),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(labelText: 'Password'),
                    obscureText: true,
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: login,
                    child: Text('Login'),
                  ),
                ],
              ),
      ),
    );
  }
}
