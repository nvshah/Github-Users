import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:states_rebuilder/states_rebuilder.dart';


import './data/github_repo.dart';
import './services/github_service.dart';
import './pages/dashboard.dart';
import './models/user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); 
  final appDocumentDir = await getApplicationDocumentsDirectory();
  // Door for Hive
  Hive.init(appDocumentDir.path);
  Hive.registerAdapter(UserAdapter(), 0);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.pink,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Provider<GithubRepo>(
        create: (_) => GithubRepo(githubService: GithubService()),
        child: Dashboard(),
      ),
      ////
      // home: Injector(
      //   inject: [
      //     Inject<GithubStore>(() => GithubStore(githubService: GithubService())),
      //   ],
      //   builder: (context) => Dashboard(),
      // ),
      ////
      //home: Dashboard(),
    );
  }
}
