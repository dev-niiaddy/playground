import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ScreenItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget screen;

  ScreenItem(this.icon, this.title, {@required this.screen});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _openScreen(context),
      child: Container(
        margin: const EdgeInsets.all(8.0),
        // color: Colors.red,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              icon,
              size: 80,
              color: Colors.red,
            ),
            SizedBox(height: 15),
            Text(
              title,
              style: TextStyle(
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _openScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }
}
