import 'package:flutter/material.dart';
import 'package:login_logout_tutor/services/user_service.dart';

class EditUserPage extends StatefulWidget {
  final String userId; // Add a userId parameter
  final String initialUserName;
  final String initialPassword;

  const EditUserPage({
    Key? key,
    required this.userId,
    required this.initialUserName,
    required this.initialPassword,
  }) : super(key: key);

  @override
  State<EditUserPage> createState() => _EditUserPageState();
}

class _EditUserPageState extends State<EditUserPage> {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;
  late ApiService apiService; // Declare the ApiService

  @override
  void initState() {
    super.initState();
    // Initialize controllers with the existing user data
    _userNameController.text = widget.initialUserName;
    _passwordController.text = widget.initialPassword;

    // Initialize the ApiService
    apiService = ApiService('https://localhost:7248/api/Users');
  }

  // Update user function
  Future<void> updateUser() async {
    String newUserName = _userNameController.text;
    String newPassword = _passwordController.text;

    if (newUserName.isEmpty || newPassword.isEmpty) {
      // Show error if fields are empty
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Username and password cannot be empty.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          );
        },
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // Call the API service to update the user using userId
      final success = await apiService.updateUser(widget.userId, newUserName, newPassword);

      setState(() {
        _isLoading = false;
      });

      if (success) {
        // If the update is successful, navigate back or show success message
        Navigator.pop(context, true); // You can also use a success message
      } else {
        // Show error if update fails
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Update Failed'),
              content: Text('Could not update the user. Please try again.'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('OK'),
                )
              ],
            );
          },
        );
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });

      // Handle error appropriately
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('An error occurred: $e'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              )
            ],
          );
        },
      );
    }
  }

  // Delete user function
  Future<void> deleteUser() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final success = await apiService.deleteUser(widget.userId); // Call the delete method
      setState(() {
        _isLoading = false;
      });

      if (success) {
        // If deletion is successful, navigate back or show success message
        Navigator.pushNamed(context, '/login');
      } else {
        // Show error if deletion fails
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Deletion Failed'),
              content: Text('Could not delete the user. Please try again.'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('OK'),
                )
              ],
            );
          },
        );
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });

      // Handle error appropriately
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('An error occurred: $e'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              )
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
        title: Text('Edit User'),
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
                    keyboardType: TextInputType.text,
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(labelText: 'Password'),
                    obscureText: true,
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: updateUser, // Call the update function on button press
                    child: Text('Update'),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      // Show confirmation dialog before deleting
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('Confirm Deletion'),
                            content: Text('Are you sure you want to delete this user?'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context); // Close the dialog
                                },
                                child: Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context); // Close the dialog
                                  deleteUser(); // Call the delete function
                                },
                                child: Text('Delete'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Text('Delete User'),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red), // Style to indicate danger
                  ),
                ],
              ),
      ),
    );
  }
}
