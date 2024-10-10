import 'package:anime_base/data/utils.dart';
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String variant;
  final IconData icon;
  final String text;

  const Button({
    super.key,
    required this.variant,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        width: getDeviceWidth(context) * 0.45,
        padding: const EdgeInsets.symmetric(
          vertical: 4,
          horizontal: 10,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          border: variant == "outline"
              ? Border.all(
                  color: Colors.deepOrange.shade600,
                )
              : null,
          color: variant == "filled"
              ? Colors.deepOrange.shade600
              : Colors.transparent,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(
              icon,
              color: variant == 'filled'
                  ? Colors.white
                  : Colors.deepOrange.shade600,
            ),
            Text(
              text,
              style: TextStyle(
                color: variant == 'filled'
                    ? Colors.white
                    : Colors.deepOrange.shade600,
              ),
            )
          ],
        ),
      ),
    );
  }
}
