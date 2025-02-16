import 'package:flutter/material.dart';

void main() {
runApp(const MainApp()); // Run the MainApp widget as the root of the application
}

class MainApp extends StatelessWidget {
const MainApp({super.key}); // Constructor for the MainApp widget

@override
Widget build(BuildContext context) {
    return MaterialApp( // Create a MaterialApp widget
    home: Scaffold(
        body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Center the column vertically
            children: [
            const Text( // Display a text widget with the given text
                'Welcome to Flutter!',
                style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 16),
            Image.asset( // Display an image from the assets folder
                'assets/images/flutter_logo.png',
                width: 200, // Set the width, height of the image
                height: 200,
            ),
            const SizedBox(height: 16),
            Container( // Create a container widget
                width: 200,
                height: 50,
                color: Colors.blue, // Set the background color of the container
                child: const Center(
                child: Text( // Display a text widget
                    'Start',
                    style: TextStyle(color: Colors.white), // Set the text color
                ),
                ),
            ),
            ],
        ),
        ),
    ),
    );
}
}