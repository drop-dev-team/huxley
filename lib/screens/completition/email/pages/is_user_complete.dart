import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/page_state_controller.dart';  // Assumed path

class UserCompletePage extends StatefulWidget {
  const UserCompletePage({super.key});

  @override
  State<UserCompletePage> createState() => _UserCompletePageState();
}

class _UserCompletePageState extends State<UserCompletePage> {
  bool _isLoading = true;
  final List<String> _messages = ["Checking data...", "Updating profile...", "Finalizing..."];
  int _currentMessageIndex = 0;
  Timer? _messageTimer;

  @override
  void initState() {
    super.initState();
    _simulateLoadingProcess();
    _startDisplayMessages();
  }

  @override
  void dispose() {
    _messageTimer?.cancel();  // Make sure to cancel the timer to prevent memory leaks
    super.dispose();
  }

  void _simulateLoadingProcess() async {
    final profileCompletionController = Get.find<ProfileCompletionController>();
    // Wait for the profile update process and a 5 second delay
    await Future.delayed(const Duration(seconds: 5)); // Ensure a minimum of 5 seconds loading time
    await profileCompletionController.triggerTransition(context); // Assuming this is a future that completes when done

    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _startDisplayMessages() {
    _messageTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_currentMessageIndex < _messages.length) {
        if (mounted) {
          setState(() {
            _currentMessageIndex++;
          });
        }
      } else {
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _isLoading
            ? _buildLoadingState()
            : _buildLoadedState(),
      ),
    );
  }

  Widget _buildLoadingState() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const CircleAvatar(
          radius: 100,
          backgroundImage: NetworkImage('https://cdn.dribbble.com/users/722246/screenshots/4400319/media/8854b69f794471a100c85577859e9c5e.gif'),
        ),
        const SizedBox(height: 20),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          child: Text(
            _messages[_currentMessageIndex % _messages.length],
            key: ValueKey<int>(_currentMessageIndex),
            style: const TextStyle(fontSize: 16, color: Colors.black54),
          ),
        ),
      ],
    );
  }

  Widget _buildLoadedState() {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(Icons.check_circle, color: Colors.green, size: 50),
        SizedBox(height: 20),
        Text("All information has been updated! Welcome!",
          style: TextStyle(fontSize: 18, color: Colors.green),
        ),
      ],
    );
  }
}
