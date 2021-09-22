import 'package:flutter/material.dart';
import 'package:trending_on_github/constants/constants.dart';
import 'package:trending_on_github/features/home/presentation/pages/settings_page.dart';
import 'package:trending_on_github/features/home/presentation/pages/trending_page.dart';
import 'package:trending_on_github/features/home/presentation/widgets/navigation_bar_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<NavigationBarItem> _navigationBarItems = const [
    NavigationBarItem(
      title: Strings.trendingRepos,
      iconData: Icons.star,
      widget: TrendingPage(),
    ),
    NavigationBarItem(
      title: Strings.settings,
      iconData: Icons.settings,
      widget: SettingsPage(),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      initialIndex: 0,
      length: _navigationBarItems.length,
      vsync: this,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
      bottomNavigationBar: _bottomNavigationBar(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      centerTitle: true,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      title: Text(
        _navigationBarItems[_tabController.index].title,
        style: const TextStyle(color: Colors.black),
      ),
    );
  }

  Widget _buildBody() {
    return TabBarView(
      physics: const NeverScrollableScrollPhysics(),
      controller: _tabController,
      children: _navigationBarItems.map((e) => e.widget).toList(),
    );
  }

  Widget _bottomNavigationBar() {
    return BottomNavigationBar(
      onTap: (index) => setState(() => _tabController.animateTo(index)),
      currentIndex: _tabController.index,
      items: _navigationBarItems
          .map(
            (e) => BottomNavigationBarItem(
              icon: Icon(e.iconData),
              label: e.title,
            ),
          )
          .toList(),
    );
  }
}
