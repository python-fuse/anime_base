import 'package:flutter/material.dart';

class GenreCard extends StatelessWidget {
  const GenreCard({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 1,
        horizontal: 4,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          width: 2,
          color: Colors.deepOrange.shade600,
        ),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12,
          color: Colors.deepOrange.shade600,
        ),
      ),
    );
  }
}
