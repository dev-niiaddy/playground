import 'package:flutter/material.dart';

class GoogleMapBottomSheet extends StatefulWidget {
  @override
  _GoogleMapBottomSheetState createState() => _GoogleMapBottomSheetState();
}

class _GoogleMapBottomSheetState extends State<GoogleMapBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DraggableScrollableSheet(
        initialChildSize: 0.09,
        minChildSize: 0.09,
        maxChildSize: 0.9,
        builder: _buildScrollableSheet,
      ),
    );
  }

  Widget _buildScrollableSheet(
      BuildContext context, ScrollController scrollController) {
    return SingleChildScrollView(
      controller: scrollController,
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 8,
        ),
        child: Column(
          children: <Widget>[
            Text('Explore Nearby'),
          ],
        ),
      ),
    );
  }
}
