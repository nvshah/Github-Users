import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/github_repo.dart';
import './widgets/user_card.dart';

class UsersScreen extends StatefulWidget {
  @override
  _UsersScreenState createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  
  ///Update the data or refresh the data
  Future<void> _updateData(BuildContext context) async {
    try {
      final githubRepo = Provider.of<GithubRepo>(context, listen: false);
      await githubRepo.fetchGithubUsers();
    } on SocketException catch (_) {
      final alertSnackBar = SnackBar(
        content: Text('Check Internet Connection'),
      );
      Scaffold.of(context).showSnackBar(alertSnackBar);
    } catch (_) {
      final alertSnackBar = SnackBar(
        content: Text('Contact Support team'),
      );
      Scaffold.of(context).showSnackBar(alertSnackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    //github repository to get the data
    final githubRepo = Provider.of<GithubRepo>(context, listen: false);

    return FutureBuilder(
      future: _updateData(context),
      builder: (ctxt, snapshot) =>
          snapshot.connectionState == ConnectionState.waiting
              ? Center(
                  //Till we fetch the users
                  child: CircularProgressIndicator(),
                )
              : RefreshIndicator(
                  onRefresh: () => _updateData(context),
                  //List of Users
                  child: ListView.builder(
                    itemCount: githubRepo.githubUsers.length,
                    itemBuilder: (ctxt, index) =>
                        UserCard(user: githubRepo.githubUsers[index]),
                  ),
                ),
    );
  }
}
