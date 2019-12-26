import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TwitterProfile extends StatefulWidget {
  @override
  _TwitterProfileState createState() => _TwitterProfileState();
}

class _TwitterProfileState extends State<TwitterProfile>
    with TickerProviderStateMixin {
  TabController _tabController;
  ScrollController _scrollController;

  AnimationController animationController;

  Animation<double> profileAnimation;
  Animation<double> positionTopAnimation;
  Animation<double> positionLeftAnimation;

  bool isScrollUp;

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

    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 100),
    );

    profileAnimation = Tween<double>(
      begin: 90,
      end: 50,
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Interval(0.0, 1.0, curve: Curves.easeIn),
      ),
    );

    positionTopAnimation = Tween<double>(
      begin: 104.0,
      end: 144.0,
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Interval(0.0, 1.0, curve: Curves.easeIn),
      ),
    );

    positionLeftAnimation = Tween<double>(
      begin: 10,
      end: 30,
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Interval(0.0, 1.0, curve: Curves.easeIn),
      ),
    );

    _scrollController = ScrollController()
      ..addListener(() {
        var direction = _scrollController.position.userScrollDirection;
        isScrollUp = direction == ScrollDirection.forward;
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
                              child: buildProfilePhoto(1),
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
          buildProfilePhoto(0)
        ],
      ),
    );
  }

  Widget buildProfilePhoto(int index) {
    if (index == 0) {
      double defaultTop = positionTopAnimation.value; //144.0; //104
      double positionTop = defaultTop;

      double animStartOffset = 1.0;
      double animEndOffset = 86.0;

      if (_scrollController.hasClients) {
        double scrollOffset = _scrollController.offset;
        positionTop -= scrollOffset;

        // print('offset? $scrollOffset');

        if (scrollOffset > animStartOffset &&
            scrollOffset < animEndOffset &&
            !isScrollUp) {
          animationController.forward();
        } else if (isScrollUp &&
            scrollOffset > animStartOffset &&
            scrollOffset < animEndOffset) {
          animationController.reverse();
        }
      }

      return Positioned(
          top: positionTop,
          // height: 90,
          left: positionLeftAnimation.value,
          // width: 90,
          child: (profileAnimation.value != 50)
              ? Container(
                  height: profileAnimation.value,
                  width: profileAnimation.value,
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

  void onScrollNotification(ScrollNotification notification) {
    if (notification is ScrollUpdateNotification) {}
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
