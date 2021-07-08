import 'package:baby/bottom_bar_tabs/tab_menu_home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _tabSelected = 'tab_home';

  fnChangeTab(String tabName) {
    setState(() {
      _tabSelected = tabName;
    });
  }

  Widget generateContent() {
    switch (_tabSelected) {
      case 'tab_home':
        return TabMenuHome(title: 'HOME');
      case 'tab_favorite':
        return TabMenuHome(title: 'FAVORITE');
      case 'tab_camera':
        return TabMenuHome(title: 'CAMERA');
      case 'tab_setting':
        return TabMenuHome(title: 'SETTINGS');
      default:
        return TabMenuHome(title: 'NOT FOUND');
    }
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    print(_tabSelected);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: AppThemeData.generate(),
      home: Scaffold(
        appBar: AppBarHead.generate(),
        body: AppBody(
          tabSelected: _tabSelected,
        ),
        bottomNavigationBar: AppBottomNavBar(
          fnChangeTab: fnChangeTab,
          tabSelected: _tabSelected,
        ),
        floatingActionButton: AppFloatButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}

class AppFloatButton extends StatelessWidget {
  const AppFloatButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () {
        final SnackBar snackBar = SnackBarItem.onlyText('Yeah yep');
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      },
    );
  }
}

class AppBottomNavBar extends StatelessWidget {
  final String tabSelected;
  final Function(String) fnChangeTab;

  const AppBottomNavBar(
      {Key? key, required this.fnChangeTab, required this.tabSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      notchMargin: 5,
      shape: CircularNotchedRectangle(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          BottomNavBarItems(
            tooltip: 'Home',
            icon: Icons.home_outlined,
            isActive: 'tab_home' == tabSelected,
            onPressed: () {
              fnChangeTab('tab_home');
            },
          ),
          BottomNavBarItems(
            tooltip: 'Favorite',
            icon: Icons.favorite_outline,
            isActive: 'tab_favorite' == tabSelected,
            onPressed: () {
              fnChangeTab('tab_favorite');
            },
          ),
          SizedBox(
            width: 50,
          ),
          BottomNavBarItems(
            tooltip: 'Camera',
            icon: Icons.camera_enhance_outlined,
            isActive: 'tab_camera' == tabSelected,
            onPressed: () {
              fnChangeTab('tab_camera');
            },
          ),
          BottomNavBarItems(
            tooltip: 'Settings',
            icon: Icons.settings_outlined,
            isActive: 'tab_setting' == tabSelected,
            onPressed: () {
              fnChangeTab('tab_setting');
            },
          ),
        ],
      ),
    );
  }
}

class AppBody extends StatelessWidget {
  final String tabSelected;

  const AppBody({Key? key, required this.tabSelected}) : super(key: key);

  Widget generateContent() {
    switch (tabSelected) {
      case 'tab_home':
        return TabMenuHome(title: 'HOME');
      case 'tab_favorite':
        return TabMenuHome(title: 'FAVORITE');
      case 'tab_camera':
        return TabMenuHome(title: 'CAMERA');
      case 'tab_setting':
        return TabMenuHome(title: 'SETTINGS');
      default:
        return TabMenuHome(title: 'NOT FOUND');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Spacer(),
          SnackBarPage(),
          Spacer(),
          Text('body Text2'),
          Spacer(),
          generateContent(),
          Spacer(),
          Text(
            'body Text1',
            style: Theme.of(context).textTheme.bodyText1,
          ),
          Spacer(),
        ],
      ),
    );
  }
}

class AppBarHead {
  static PreferredSizeWidget generate() {
    return AppBar(
      title: Text('Flutter Demo'),
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios),
        onPressed: () {
          print('back');
        },
      ),
      centerTitle: true,
    );
  }
}

class AppThemeData {
  static ThemeData generate() {
    return ThemeData(
      // ElevatedButton color
      primarySwatch: Colors.green,
      // AppBar background
      primaryColor: Colors.cyan,
      // float button color
      accentColor: Colors.red,
      // bottom app bar color
      bottomAppBarColor: Colors.grey,
      // snack bar style
      snackBarTheme: SnackBarThemeData(
        backgroundColor: Colors.deepPurpleAccent,
        actionTextColor: Colors.yellow,
        contentTextStyle: TextStyle(color: Colors.white),
      ),
      // text theme
      textTheme: TextTheme(
        bodyText1: TextStyle(color: Colors.blue),
        bodyText2: TextStyle(color: Colors.orange),
      ),
    );
  }
}

class SnackBarItem {
  static SnackBar onlyText(String text) {
    return SnackBar(content: Text(text));
  }

  static SnackBar withAction(String text, SnackBarAction action) {
    return SnackBar(
      content: Text(text),
      action: action,
    );
  }
}

class SnackBarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        child: Text('Show SnackBar'),
        onPressed: () {
          final SnackBar snackBar = SnackBarItem.onlyText('Yeah yep');
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        },
      ),
    );
  }
}

class BottomNavBarItems extends StatelessWidget {
  final String tooltip;
  final IconData icon;
  final VoidCallback? onPressed;
  final bool isActive;

  const BottomNavBarItems({
    Key? key,
    required this.tooltip,
    required this.icon,
    required this.onPressed,
    this.isActive = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: isActive ? Colors.white : Theme.of(context).bottomAppBarColor,
      child: IconButton(
        tooltip: tooltip,
        icon: Icon(icon),
        onPressed: onPressed,
        color: isActive ? Colors.black : Colors.black54,
      ),
    );
  }
}
