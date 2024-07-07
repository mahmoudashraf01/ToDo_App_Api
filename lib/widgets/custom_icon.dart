import 'package:flutter/material.dart';

class CustomIcon extends StatelessWidget {
  const CustomIcon({
    super.key,
    required this.icon,
    required this.color,
    this.onPressed,
  });
  final IconData icon;
  final Color color;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        icon,
        size: 30,
        color: color,
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }
}

class HomeButton extends StatelessWidget {
  const HomeButton({
    super.key,
    required this.icon,
    required this.color,
    this.onPressed,
  });
  final IconData icon;
  final Color color;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      size: 30,
      color: color,
    );
  }
}
