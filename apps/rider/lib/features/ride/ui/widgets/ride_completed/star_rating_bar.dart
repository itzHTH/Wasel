import 'package:flutter/material.dart';
import 'package:wasel_core/wasel_core.dart';

class StarRatingBar extends StatefulWidget {
  const StarRatingBar({
    super.key,
    required this.onRatingChanged,
    this.initialRating = 0,
  });

  final ValueChanged<int> onRatingChanged;
  final int initialRating;

  @override
  State<StarRatingBar> createState() => _StarRatingBarState();
}

class _StarRatingBarState extends State<StarRatingBar> {
  late int _rating = widget.initialRating;

  void _select(int value) {
    setState(() => _rating = value);
    widget.onRatingChanged(value);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        final value = index + 1;
        final selected = value <= _rating;
        return IconButton(
          onPressed: () => _select(value),
          icon: Icon(
            selected ? Icons.star_rounded : Icons.star_outline_rounded,
            color: selected
                ? context.colors.alertWarning500
                : context.colors.neutral400,
            size: AppDimens.icon36,
          ),
        );
      }),
    );
  }
}
