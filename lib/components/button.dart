import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final IconData? icon;
  final String text;
  final Color buttonColor;
  final Color textColor;
  final double fontSize;
  final double height;
  final VoidCallback onPressed;

  const Button({
    super.key,
    this.icon,
    required this.text,
    required this.buttonColor,
    required this.textColor,
    required this.fontSize,
    required this.onPressed,
    this.height = 45,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: height,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          decoration: BoxDecoration(
            color: buttonColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              if (icon != null)
                Icon(icon, color: textColor, size: fontSize * 1.5),
              if (icon != null) const SizedBox(width: 8),
              Expanded(
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: textColor,
                    fontSize: fontSize,
                    fontWeight: FontWeight.bold,
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
