import 'package:flutter/material.dart';

class RatingStars extends StatelessWidget {
  final int rating;
  final ValueChanged<int>? onRate;
  final double size;
  final double spacing;

  const RatingStars({
    super.key,
    required this.rating,
    this.onRate,
    this.size = 36,
    this.spacing = 4,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        final starIndex = index + 1;
        final filled = rating >= starIndex;

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: spacing / 2),
          child: GestureDetector(
            onTap: onRate != null ? () => onRate!(starIndex) : null,
            child: Icon(
              filled ? Icons.star : Icons.star_border,
              color: Colors.orange,
              size: size,
            ),
          ),
        );
      }),
    );
  }
}
