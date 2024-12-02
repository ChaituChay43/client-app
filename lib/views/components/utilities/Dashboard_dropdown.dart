import 'package:flutter/material.dart';

class DropdownIconButton extends StatefulWidget {
  final Icon icon;
  final List<String> items;
  final ValueChanged<String> onSelected;
  final double maxHeight;

  const DropdownIconButton({
    super.key,
    required this.icon,
    required this.items,
    required this.onSelected,
    this.maxHeight = 150.0,
  });

  @override
  _DropdownIconButtonState createState() => _DropdownIconButtonState();
}

class _DropdownIconButtonState extends State<DropdownIconButton> {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: widget.icon,
      onSelected: (String value) {
        widget.onSelected(value);
      },
      color: Colors.white, // Set the background color to white for the main menu
      itemBuilder: (BuildContext context) {
        return widget.items.map((String item) {
          return PopupMenuItem<String>(
            value: item,
            child: Text(item, style: TextStyle(fontSize: 11.0),),
          );
        }).toList();
      },
    );
  }
}
