import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import '../models/github_user.dart';
import './widgets/user_card.dart';

class BookmarkedUsersScreen extends StatefulWidget {
  @override
  _BookmarkedUsersScreenState createState() => _BookmarkedUsersScreenState();
}

class _BookmarkedUsersScreenState extends State<BookmarkedUsersScreen> {
  @override
  Widget build(BuildContext context) {
    return _buildListView();
  }

  //build the List of BookMarked Users
  Widget _buildListView() {
    return WatchBoxBuilder(
      box: Hive.box('github'),
      builder: (ctxt, githubBox) {
        //List of BookMarked Users
        return githubBox.length == 0
            ? Center(
                child: Text('No BookMarks yet !!!'),
              )
            : ListView.builder(
                itemCount: githubBox.length,
                itemBuilder: (ctxt, index) {
                  final user = githubBox.getAt(index) as GithubUser;
                  return ChangeNotifierProvider.value(
                    value: user,
                    child: UserCard(index: index, useCache: true,),
                  );
                  // return UserCard(
                  //   index: index,
                  // );
                });
      },
    );
  }
}
