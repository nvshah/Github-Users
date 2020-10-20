import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'users_screen.dart';
import 'bookmarked_users_screen.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Dashboard'),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(text: 'Users'),
              Tab(text: 'Bookmarked Users'),
            ],
          ),
        ),
        body: FutureBuilder(
          future: Hive.openBox('github'),
          builder: (ctxt, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError)
                return Text(snapshot.error.toString());
              else
                return TabBarView(
                  children: <Widget>[
                    //tab1
                    UsersScreen(),
                    //tab2
                    BookmarkedUsersScreen(),
                  ],
                );
            }
            else
              //till box is opened
              return Center(
                  child: CircularProgressIndicator(),
                );
          },
        ),
      ),
    );
  }
}
