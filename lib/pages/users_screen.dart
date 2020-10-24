import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

import '../data/github_repo.dart';
import './widgets/user_card.dart';
import '../models/github_user.dart';

class UsersScreen extends StatefulWidget {
  @override
  _UsersScreenState createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {

  ///Update the data or refresh the data
  Future<void> _updateData() async {
    try {
      final repo = Provider.of<GithubRepo>(context, listen: false);
      await repo.fetchGithubUsers();
      //Currently celaring all cached data on fetching new data from server
      final box = Hive.box('github');
      box.clear();
      setState(() { 
      });
    } on SocketException {
      print('Socket Exception');
    } catch (e) {
      print(e.toString());
    }
  }

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

  Widget buildInitialView() {
    return Center(
      child: Text('Drag down to load data ... '),
    );
  }

  Widget buildListeView() {
   final repo = Provider.of<GithubRepo>(context, listen: false);
   return ListView.builder(
        itemCount: repo.githubUsers?.length ?? 0,
        itemBuilder: (ctxt, index) => ChangeNotifierProvider.value(
              value: repo.githubUsers[index],
              child: UserCard(),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => _updateData(),
      child: buildListeView(),
    );
  }
}
