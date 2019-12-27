import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:playground/util/constants.dart';

class TwitterProfile extends StatefulWidget {
  @override
  _TwitterProfileState createState() => _TwitterProfileState();
}

class _TwitterProfileState extends State<TwitterProfile>
    with TickerProviderStateMixin {
  TabController _tabController;
  ScrollController _scrollController;

  List<String> tabs = [
    'Tweet',
    'Tweets & Replies',
    'Media',
    'Likes',
  ];

  @override
  void initState() {
    super.initState();

    _tabController = TabController(
      vsync: this,
      length: tabs.length,
    );

    _scrollController = ScrollController()
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController?.dispose();
    _tabController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          CustomScrollView(
            controller: _scrollController,
            slivers: <Widget>[
              SliverAppBar(
                expandedHeight: 120,
                pinned: true,
                floating: false,
                flexibleSpace: FlexibleSpaceBar(
                  background: Image.network(
                    'http://lorempixel.com/output/fashion-q-c-1920-1080-3.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: buildProfilePhoto(StackPosition.BOTTOM),
                            ),
                            GestureDetector(
                              onTap: onEditProfile,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 8),
                                margin: EdgeInsets.only(right: 15),
                                child: Text(
                                  'Edit Profile',
                                  style: TextStyle(color: Colors.grey),
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey,
                                  ),
                                  borderRadius: BorderRadius.circular(50),
                                ),
                              ),
                            )
                          ],
                        ),
                        Text(
                          'he that codes',
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(height: 8),
                        Text(
                          '@virtualmachyne',
                          style: TextStyle(color: Colors.blueGrey),
                        ),
                        SizedBox(height: 12),
                        Text(
                          'I develop solutions using if-else statements.',
                          style: TextStyle(color: Colors.black),
                        ),
                        SizedBox(height: 15),
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.location_on,
                              size: 16,
                              color: Colors.blueGrey,
                            ),
                            SizedBox(width: 5),
                            Text(
                              'Server Room',
                              style: TextStyle(color: Colors.blueGrey),
                            ),
                            SizedBox(width: 10),
                            Icon(
                              Icons.calendar_today,
                              size: 16,
                              color: Colors.blueGrey,
                            ),
                            SizedBox(width: 5),
                            Text(
                              'Joined February 2018',
                              style: TextStyle(color: Colors.blueGrey),
                            ),
                          ],
                        ),
                        SizedBox(height: 15),
                        Row(
                          children: <Widget>[
                            Text(
                              '374',
                              style: TextStyle(color: Colors.black),
                            ),
                            SizedBox(width: 3),
                            Text(
                              'Following',
                              style: TextStyle(color: Colors.blueGrey),
                            ),
                            SizedBox(width: 20),
                            Text(
                              '222',
                              style: TextStyle(color: Colors.black),
                            ),
                            SizedBox(width: 3),
                            Text(
                              'Followers',
                              style: TextStyle(color: Colors.blueGrey),
                            ),
                          ],
                        ),
                        SizedBox(height: 20)
                      ],
                    ),
                  ),
                ),
              ),
              SliverPersistentHeader(
                pinned: true,
                delegate: StickyTabBarDelegate(
                  child: TabBar(
                    labelPadding: EdgeInsets.symmetric(horizontal: 20),
                    unselectedLabelColor: Colors.blueGrey,
                    labelColor: Colors.blue,
                    indicatorColor: Colors.blue,
                    isScrollable: true,
                    controller: _tabController,
                    tabs: tabs.map((s) => Center(child: Text(s))).toList(),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  height: 1000,
                  color: Colors.yellow,
                ),
              ),
              // SliverPersistentHeader(
              //   pinned: true,
              //   floating: true,
              //   delegate: null,
              // )
            ],
          ),
          buildProfilePhoto(StackPosition.TOP),
        ],
      ),
    );
  }

  Widget buildProfilePhoto(StackPosition pos) {
    if (pos == StackPosition.TOP) {
      double animEndOffset = 65.0;

      double multiplier = 0.0;
      double proDim = 90;
      double posLeft = 10;
      double posTop = 104;

      if (_scrollController.hasClients) {
        double scrollOffset = _scrollController.offset;

        multiplier = (scrollOffset / animEndOffset).clamp(0.0, 1.0);

        proDim -= (40 * multiplier);
        posTop += (40 * multiplier) - scrollOffset;
        posLeft += (20 * multiplier);
      }

      return Positioned(
          top: posTop,
          // height: 90,
          left: posLeft,
          // width: 90,
          child: (proDim != 50)
              ? Container(
                  height: proDim,
                  width: proDim,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage('assets/images/profile_lady.jpg'),
                      fit: BoxFit.cover,
                    ),
                    border: Border.all(
                      color: Colors.blue,
                      width: 3.0,
                    ),
                  ),
                )
              : SizedBox(
                  height: 0,
                  width: 0,
                ));
    }

    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: AssetImage('assets/images/profile_lady.jpg'),
          fit: BoxFit.cover,
        ),
        border: Border.all(
          color: Colors.blue,
          width: 3.0,
        ),
      ),
    );
  }

  void onEditProfile() {}
}

class StickyTabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar child;

  StickyTabBarDelegate({@required this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Material(
      child: this.child,
    );
  }

  @override
  double get maxExtent => this.child.preferredSize.height;

  @override
  double get minExtent => this.child.preferredSize.height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
