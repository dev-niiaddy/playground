import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:playground/util/constants.dart';

/// The [ScrollController] [offset] at which the animation of the
/// profile photo [Container] size and [Stack] position is stopped.
const double ANIM_END_OFFSET = 65.0;

const double PROFILE_DIM_LARGE = 90.0;

const double PROFILE_DIM_SMALL = 50.0;

const double POSITION_TOP_START = 104.0;

const double POSITION_LEFT_START = 10.0;

class TwitterProfile extends StatefulWidget {
  @override
  _TwitterProfileState createState() => _TwitterProfileState();
}

class _TwitterProfileState extends State<TwitterProfile>
    with TickerProviderStateMixin {
  ///
  /// Tab controller to control tabs
  TabController _tabController;

  /// Controller for [CustomScrollView] to detect
  /// user scroll events
  ScrollController _scrollController;

  /// List of tab String titles
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

    /// Initialize Scroll Controller and add
    /// a listener
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

              /// Widget to create a stick-to-top effect for its delegate
              /// when [pinned] is set to true. [TabBar] shouldn't scroll out of
              /// view when the remaining content scrolls off.
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

              /// A very long [Container] in a [Sliver] to demonstrate
              /// stick-to-top effect of the [TabBar]
              SliverToBoxAdapter(
                child: Container(
                  height: 1000,
                  color: Colors.yellow,
                ),
              ),
            ],
          ),
          buildProfilePhoto(StackPosition.TOP),
        ],
      ),
    );
  }

  /// Return a profile photo [Container] of appropriate dimension depending
  /// on which position we are in the [Stack] and the [ScrollController] [offset].
  /// An insignificant [SizedBox] of zero height and zero width is returned
  Widget buildProfilePhoto(StackPosition pos) {
    double animEndOffset = ANIM_END_OFFSET;

    double multiplier = 0.0;

    /// Initial state values for the
    /// [proDim] profile dimension
    /// [posLeft] position left
    /// [posTop] position top
    double proDim = PROFILE_DIM_LARGE;
    double posLeft = POSITION_LEFT_START;
    double posTop = POSITION_TOP_START;

    if (_scrollController.hasClients) {
      // How far has the user scrolled
      double scrollOffset = _scrollController.offset;

      /// A ratio of how close user has scrolled to the end state
      /// The ratio cannot be negative or greater than one
      multiplier = (scrollOffset / animEndOffset).clamp(0.0, 1.0);

      /// Final [proDim] is 50. A fraction of 40 is computed to
      /// subtract from the initial 90 to get close to 50, as the ratio
      /// increases or gets closer to one.
      proDim -= (40 * multiplier);

      /// Final [posTop] is 144. A fraction of 40 is computed to
      /// add to the initial 104 to get close to 144, as the ratio
      /// increases or gets closer to one. The offset is subtracted to
      /// keep the profile photo in sync with the scroll.
      posTop += (40 * multiplier) - scrollOffset;

      /// Final [posLef] is 30. A fraction of 20 is computed to
      /// add to the initial 10 to get close to 30, as the ratio
      /// increases or gets closer to one.
      posLeft += (20 * multiplier);
    }

    ///Check if the required profile photo [Container] is supposed to be at
    ///the top of the Stack.
    if (pos == StackPosition.TOP) {
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
              ),
      );
    }

    /// If the profile photo dimension [proDim] is
    /// equal to [PROFILE_DIM_SMALL] then show image
    /// in underlying [Container] else show a [SizedBox]
    /// of equivalent height and width
    return (proDim == PROFILE_DIM_SMALL)
        ? Container(
            height: PROFILE_DIM_SMALL,
            width: PROFILE_DIM_SMALL,
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
            height: PROFILE_DIM_SMALL,
            width: PROFILE_DIM_SMALL,
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
