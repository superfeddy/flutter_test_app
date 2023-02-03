import 'package:flutter/material.dart';
import './screens/feed_screen.dart';
import './screens/post_screen.dart';
import './screens/profile_screen.dart';

void main() => runApp(const App());

// Main App
class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: NavigationBar(),
    );
  }
}

// Bottom Navigation Bar
class NavigationBar extends StatefulWidget {
  const NavigationBar({Key? key}) : super(key: key);

  @override
  _NavigationBarState createState() => _NavigationBarState();
}

// Navigation Bar Widget State Management
class _NavigationBarState extends State<NavigationBar> {
  int _selectedIndex = 0; // selected screen index
  final List _widgetOptions = [];
  List<String> items = [];

  @override
  void initState() {
    super.initState();
    _widgetOptions.add(const FeedScreen());
    _widgetOptions.add(PostScreen(items, addItem, removeItem));
    _widgetOptions.add(const ProfileScreen());
  }

  // add item
  void addItem(String text) {
    setState(() {
      items.add(text);
    });
  }

  // remove item
  void removeItem(int index) {
    setState(() {
      items.removeAt(index);
    });
  }

  // Nav Item Click Handler
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('GlobeSisters'), backgroundColor: Colors.green),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.feed),
                label: 'Feed',
                backgroundColor: Colors.green),
            BottomNavigationBarItem(
                icon: Icon(Icons.post_add),
                label: 'Post',
                backgroundColor: Colors.deepOrangeAccent),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
              backgroundColor: Colors.blue,
            ),
          ],
          type: BottomNavigationBarType.shifting,
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.black,
          iconSize: 40,
          onTap: _onItemTapped,
          elevation: 5),
    );
  }
}
