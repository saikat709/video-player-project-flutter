import 'package:flutter/material.dart';

class SelectionCard extends StatelessWidget {
  final IconData? icon;
  final String text;
  const SelectionCard({super.key,
      required this.icon,
      required this.text
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15),
      width: 140,
      height: 140,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        border: Border.all(
          width: 5,
          color: Colors.transparent,
       ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 60,
          ),
          Text(text,
              textAlign: TextAlign.center,
              style: const TextStyle(
                   fontSize: 18,
              ),
            ),
        ],
      ),
    );
  }
}
