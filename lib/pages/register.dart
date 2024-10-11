import 'package:flutter/material.dart';
import '../services/user_service.dart'; // Ensure your ApiService is properly set up
import 'home.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _NameController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;
  final ApiService apiService = ApiService(
      'https://localhost:7248/api/Users'); // Instantiate the API service

  // Registration function to save the new user
  Future<void> register() async {
    String nama = _NameController.text;
    String userName = _userNameController.text;
    String email = _emailController.text;
    String password = _passwordController.text;

    setState(() {
      _isLoading = true;
    });

    try {
      // Make a POST request to register the new user
      await apiService.registerUser({
        'nama': nama,
        'username': userName,
        'email': email,
        'password': password,
      });

      // After successful registration, navigate to HomeScreen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => HomeScreen(
                  userName: userName,
                  initialPassword: password,
                  userId: '',
                )),
      );
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      // Handle the error appropriately, such as showing a message
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
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    controller: _NameController,
                    decoration: InputDecoration(labelText: 'Nama'),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: _userNameController,
                    decoration: InputDecoration(labelText: 'Username'),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(labelText: 'Email'),
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
                    onPressed: register,
                    child: Text('Register'),
                  ),
                ],
              ),
      ),
    );
  }
}
