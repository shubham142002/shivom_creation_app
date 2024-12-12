import 'package:flutter/material.dart';
import 'package:shivom_creation/AuthScreen/login_tab_page.dart';
import 'package:shivom_creation/AuthScreen/register_tab_page.dart';


class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xffFFF3D4),
                    Color(0xffB68C1E),
                  ],
                  begin: FractionalOffset(0.0,0.0),
                  end: FractionalOffset(1.0,0.0),
                  stops: [0.0,1.0],
                  tileMode: TileMode.clamp,
                ),
              ),
            ),
            title: const Text(
              "SHIV OM",
              style: TextStyle(
                fontSize: 30,
                letterSpacing: 2,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
            bottom: const TabBar(
              indicatorColor: Colors.black54,
              indicatorWeight: 6,
              tabs: [
                Tab(
                    text: "Login",
                    icon: Icon(
                      Icons.lock,
                      color: Colors.black,
                    ),
                ),
                Tab(
                    text: "Register",
                    icon: Icon(
                      Icons.person,
                      color: Colors.black,
                    ),
                ),
              ],
            ),
          ),
          body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xffFFF3D4),
                  Color(0xffB68C1E),
                ],
                begin: FractionalOffset(0.0,0.0),
                end: FractionalOffset(1.0,0.0),
                stops: [0.0,1.0],
                tileMode: TileMode.clamp,
              ),
            ),
            child: TabBarView(
              children: [
                LoginTabPage(),
                RegisterTabPage(),
              ],
            ),
          ),
        ),
    );
  }
}
