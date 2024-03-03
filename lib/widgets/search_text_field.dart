import 'package:flutter/material.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context)
            .colorScheme
            .onInverseSurface, // Background color based on theme
        borderRadius: BorderRadius.circular(10.0), // Border radius
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        children: [
          const Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search',
                hintStyle: TextStyle(fontWeight: FontWeight.w100),
                border: InputBorder.none, // No border
              ),
            ),
          ),
          Icon(
            Icons.search,
            color: Theme.of(context)
                .colorScheme
                .secondary, // Search icon color based on theme
          ),
        ],
      ),
    );
  }
}
