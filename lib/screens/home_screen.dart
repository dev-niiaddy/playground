import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:playground/screens/google_map_sheet.dart';
import 'package:playground/widgets/screen_item.dart';
import 'package:playground/screens/twitter_profile.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  //animation controller
  AnimationController controller;
  Animation animation;

  bool isOpen = false;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );

    animation = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Center(
          child: GestureDetector(
            onTap: () {
              if (!isOpen) {
                controller.forward();
                setState(() {
                  isOpen = true;
                });
              } else {
                controller.reverse();
                setState(() {
                  isOpen = false;
                });
              }
            },
            child: AnimatedIcon(
              icon: AnimatedIcons.menu_arrow,
              progress: controller,
            ),
          ),
        ),
        title: Text('Playground'),
      ),
      body: Container(
        child: GridView.count(
          crossAxisCount: 2,
          children: <Widget>[
            ScreenItem(
              FontAwesomeIcons.twitter,
              'Twitter Profile',
              screen: TwitterProfile(),
            ),
            ScreenItem(
              FontAwesomeIcons.mapMarker,
              'Google map',
              screen: GoogleMapBottomSheet(),
            )
          ],
        ),
      ),
    );
  }
}
