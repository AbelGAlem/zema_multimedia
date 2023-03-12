import 'package:flutter/material.dart';
import 'package:zema_multimedia/Screens/TopNavigationBar.dart';
import 'package:zema_multimedia/Shared/Themes.dart';

class splashScreenPage extends StatelessWidget {
  const splashScreenPage({super.key});

  @override
  Widget build(BuildContext context) {

    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: splashScreen(),
    );
  }
}

class splashScreen extends StatefulWidget {
  const splashScreen({super.key});

  @override
  State<splashScreen> createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen> {

  void initState() {
    super.initState();
    //DynamicLinksServices.initDynamicLink(context);
    _navigatehome();
  }

//wrapper here
  _navigatehome() async {
    await Future.delayed(Duration(milliseconds: 3000), () {});
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => TopNavigationBar()));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        color: BackgroundColor,
        child: Center(
          child: Image.asset('assets/images/splash.png',width: getScreenWidthOfContext(context) * 0.6,fit: BoxFit.contain,),
        ),
      ),
    ) ;
  }
}