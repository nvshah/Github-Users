import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

import 'users_screen.dart';
import 'bookmarked_users_screen.dart';
import '../data/github_repo.dart';
import '../models/github_user.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  Widget buildShowMessage(String message) {
    return Center(
      child: Text(message),
    );
  }

  Widget buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

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
                return buildShowMessage(snapshot.error.toString());
              else{
                //Let initially show the cached data
                final box = Hive.box('github');
                Provider.of<GithubRepo>(context, listen: false).githubUsers = box.values.map((user) => GithubUser.fromUser(user)).toList();
                return TabBarView(
                  children: <Widget>[
                    //tab1
                    UsersScreen(),
                    //tab2
                    BookmarkedUsersScreen(),
                  ],
                );
              }
            } else
              return buildLoading();
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }
}
