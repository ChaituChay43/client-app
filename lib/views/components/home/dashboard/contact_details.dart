// ignore: file_names
import 'package:flutter/material.dart';


class ContactDetail extends StatelessWidget {
  final String label;
  final String value;
  final IconData? icon; // Optional icon
  final String? text;   // Optional text
  final VoidCallback onTap;
  final bool isWideScreen;
  final double gapWidth;

  const ContactDetail({
    super.key,
    required this.label,
    required this.value,
    this.icon,             // Icon is now optional
    this.text,             // Text is now optional
    required this.onTap,
    required this.isWideScreen,
    this.gapWidth = 10.0,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(label),
        SizedBox(width: gapWidth),
        Text(
          value,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(width: gapWidth),
        GestureDetector(
          onTap: onTap,
          child: icon != null
              ? CircleAvatar(
                  backgroundColor: Colors.blue,
                  maxRadius: 10.0,
                  child: Icon(icon, color: Colors.white, size: 10.0), // Display icon
                )
              : Text(text ?? '', style: const TextStyle(color: Colors.black, fontSize: 12.0)), 
        ),
        if (!isWideScreen) const SizedBox(height: 10.0),
      ],
    );
  }
}

