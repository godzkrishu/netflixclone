import 'package:flutter/material.dart';
import 'package:netflixclone/main.dart';
import 'package:go_router/go_router.dart';

class CustomAppBar extends StatelessWidget {
  final String word1;
  final String word2;

  CustomAppBar({
    super.key,
    required this.word1,
    required this.word2,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // RichText to display word1 and word2
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: word1,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
              children: [
                TextSpan(
                  text: word2,
                  style: const TextStyle(
                    color: Colors.orangeAccent,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),

          // Search icon button
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black),
            onPressed: () {
              // Navigate to the SearchScreen
              context.go('/search');
            },
          ),
        ],
      ),
    );
  }
}

// Placeholder for the SearchScreen widget
class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search"),
      ),
      body: const Center(
        child: Text("Search Screen"),
      ),
    );
  }
}
