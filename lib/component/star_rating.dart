import 'package:flutter/material.dart';

class StarRating extends StatelessWidget {
  final double rating;
  final double size;

  const StarRating({super.key, this.rating = 0, this.size = 24});

  Widget buildStar(BuildContext context, int index) {
    IconData icon;
    Color color;

    if (index >= rating) {
      icon = Icons.star_border;
      color = Colors.grey;
    } else if (index > rating - 1 && index < rating) {
      icon = Icons.star_half;
      color = Colors.amber;
    } else {
      icon = Icons.star;
      color = Colors.amber;
    }

    return Icon(icon, color: color, size: size);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) => buildStar(context, index)),
    );
  }
}