import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

import '../data/github_store.dart';
import './widgets/user_card.dart';


class UsersScreen extends StatefulWidget {
  GithubStore githubStore;

  @override
  _UsersScreenState createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {

  @override
  void initState(){ 
    super.initState();
    //_updateData(context);
  }

  ///Update the data or refresh the data
  void _updateData() {
    final reactiveModel = Injector.getAsReactive<GithubStore>();
    reactiveModel.setState((store) => store.getGithubUsers(),);
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

  Widget buildInitialView(){
    return Center(
      child: IconButton(icon: Icon(Icons.sync), onPressed: () => _updateData(),),
    );
  }

  Widget buildListeView(GithubStore store){
    if(store == null) store = Injector.get<GithubStore>();
    if(store.githubUsers != null || store.githubUsers.length == 0) return buildInitialView();
    return ListView.builder(
          itemCount: store.githubUsers.length,
          itemBuilder: (ctxt, index) => ChangeNotifierProvider.value(
                value: store.githubUsers[index],
                child: UserCard(),
              )
          );
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => Future.delayed(Duration(seconds: 0), _updateData),
      //List of Users
      child: StateBuilder<GithubStore>(
        models: [Injector.getAsReactive<GithubStore>()],
        builder: (ctxt, reactiveModel){
          return reactiveModel.whenConnectionState(
            onData: (store){
              //clear box when you fetch data again from Server
              Hive.box('github').clear();
              return buildListeView(store);
            },
            onIdle: () => buildListeView(null),
            onError: (_) => buildShowMessage('Something Wrong Goes on !!'),
            onWaiting: () => buildLoading(),
          );
        },
      ),
    );
  }
}
