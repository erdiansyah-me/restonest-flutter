import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:restonest/common/styles.dart';
import 'package:restonest/presentation/detail_page.dart';
import 'package:restonest/presentation/home_page.dart';
import 'package:restonest/presentation/search_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RESTONEST',
      theme: ThemeData(
        primarySwatch: createMaterialColor(themeColor),
      ),
      initialRoute: HomePage.routeName,
      routes: {
        HomePage.routeName:(context) => const HomePage(),
        SearchPage.routeName:(context) => const SearchPage(),
        DetailPage.routeName:(context) => DetailPage(
          args: ModalRoute.of(context)?.settings.arguments as DetailArguments,
        )
      },
    );
  }
}

