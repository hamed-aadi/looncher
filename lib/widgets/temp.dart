import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Edge Scrolling to Next Page')),
        body: PageViewWithScroll(),
      ),
    );
  }
}

class PageViewWithScroll extends StatefulWidget {
  @override
  _PageViewWithScrollState createState() => _PageViewWithScrollState();
}

class _PageViewWithScrollState extends State<PageViewWithScroll> {
  PageController _pageController = PageController();
  bool _scrollingToNextPage = false;

  @override
  Widget build(BuildContext context) {
    return PageView(
      scrollDirection: Axis.vertical,
      controller: _pageController,
      children: [
        _buildScrollablePage(Colors.red, 0),
        _buildScrollablePage(Colors.blue, 1),
        _buildScrollablePage(Colors.green, 2),
      ],
    );
  }

  Widget _buildScrollablePage(Color color, int pageIndex) {
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification scrollInfo) {
        if (
          scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent &&
          !_scrollingToNextPage
        ) {
          _scrollingToNextPage = true;
          _pageController.nextPage(
            duration: Duration(milliseconds: 300),
            curve: Curves.easeIn,
          ).then((value) => _scrollingToNextPage = false);
        }
        return true;
      },
      child: Container(
        color: color,
        child: ListView.builder(
          itemCount: 20,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text('Item $index on Page $pageIndex'),
            );
          },
        ),
      ),
    );
  }
}
