import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:app/screens/feed_screen.dart';
import 'package:app/screens/create_event_screen.dart';
import 'package:app/screens/map_screen.dart';
import 'package:app/screens/profile_screen.dart';
import 'package:app/screens/search_screen.dart';

class HomeScreen extends StatefulWidget {

  final String userId;

  HomeScreen({this.userId});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentTab = 0;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'normie',
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'syncopate',
            fontWeight: FontWeight.w700,
            fontSize: 20.0,
          ),
        ),
      ),   
      body: PageView(
        controller: _pageController,
        children: <Widget>[
          FeedScreen(),
          SearchScreen(),
          CreateEventScreen(),
          MapScreen(),
          ProfileScreen(userId: widget.userId),
        ],
        onPageChanged: (int index) {
          setState(() {
            _currentTab = index;
          });
        },
      ),
      bottomNavigationBar: CupertinoTabBar(
        currentIndex: _currentTab,
        onTap: (int index) {
          setState(() {
            _currentTab = index;
          });
          _pageController.animateToPage(
            index,
            duration: Duration(milliseconds: 200),
            curve: Curves.easeIn,
          );
        },
        activeColor: Colors.black,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              size: 32.0,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
              size: 32.0,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.whatshot,
              size: 32.0,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.streetview,
              size: 32.0,
            ),
          ),      
          BottomNavigationBarItem(
            icon: Icon(
              Icons.child_care,
              size: 32.0,
            ),
          ),
        ],
      ),
    );
  }
}
