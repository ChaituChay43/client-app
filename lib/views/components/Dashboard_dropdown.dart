import 'package:flutter/material.dart';

class DropdownIconButton extends StatelessWidget {
  final Icon icon;
  final List<String> items;
  final ValueChanged<String> onSelected;
  final double maxHeight;  // Limit height to trigger scroll

  DropdownIconButton({
    required this.icon,
    required this.items,
    required this.onSelected,
    this.maxHeight = 150.0, // Max height for the dropdown
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: icon,  // Icon to trigger the dropdown
      onSelected: (String value) {
        onSelected(value);  // Callback on selection
      },
      color: Colors.white,
      elevation: 10.0,
      itemBuilder: (BuildContext context) {
        return [
          PopupMenuItem<String>(
            enabled: false,
            child: Container(
              height: maxHeight,
              width: 200, 
              child: SingleChildScrollView(
                child: Column(
                  children: items.map((String item) {
                    return PopupMenuItem<String>(
                      value: item,
                      child: Text(item),
                    );
                  }).toList(),
                ),
              ),
            ),
          )
        ];
      },
    );
  }
}


