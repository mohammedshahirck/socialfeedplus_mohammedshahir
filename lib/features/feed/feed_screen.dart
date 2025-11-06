import 'package:flutter/material.dart';
import 'package:socialfeedplus_mohammedshahir/features/auth/controllers/auth_controller.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Social Feed Plus'),
        actions: [
          IconButton(
            onPressed: () {
              AuthController.to.logout();
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
    );
  }
}
