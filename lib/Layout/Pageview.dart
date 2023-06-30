import 'package:flutter/material.dart';

class PageViewScreen extends StatefulWidget {
  @override
  _PageViewState createState() => _PageViewState();
}

class _PageViewState extends State<PageViewScreen> {
  PageController _pageController = PageController();
    final List<Widget> pages = [
    Container(
      color: Colors.blue,
      child: Center(
        child: Text('Page 1'),
      ),
    ),
    Container(
      color: Colors.green,
      child: Center(
        child: Text('Page 2'),
      ),
    ),
    Container(
      color: Colors.orange,
      child: Center(
        child: Text('Page 3'),
      ),
    ),
  ];


  int _currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return PageView(
          controller: _pageController,
          children: pages,
        );
     

  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
