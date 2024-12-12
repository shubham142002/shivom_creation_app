import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shivom_creation/AuthScreen/authscreen.dart';
import 'package:shivom_creation/SplashScreen/splashscreen.dart';
import '../global/global.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.black54,
      child: ListView(
        children: [
          //header
          Container(
            padding: const EdgeInsets.only(top: 26,bottom: 12),
            child: Column(
              children: [
                SizedBox(
                  height: 140,
                  width: 140,
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                        sharedPreferences!.getString("photoUrl")!,
                    ),
                  ),
                ),
                const SizedBox(height: 12,),
                Text(
                  sharedPreferences!.getString("name")!,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          //body
          Container(
            padding: const EdgeInsets.only(top: 1),
            child: Column(
              children: [
                const Divider(
                  height: 10,
                  color: Colors.grey,
                  thickness: 2,
                ),
                
                //home
                ListTile(
                  leading: const Icon(Icons.home, color: Colors.grey,),
                  title: const Text("Home",style: TextStyle(color: Colors.grey,),),
                  onTap: (){

                  },
                ),
                const Divider(
                  height: 10,
                  color: Colors.grey,
                  thickness: 2,
                ),

                //my orders
                ListTile(
                  leading: const Icon(Icons.reorder, color: Colors.grey,),
                  title: const Text("My Orders",style: TextStyle(color: Colors.grey,),),
                  onTap: (){

                  },
                ),
                const Divider(
                  height: 10,
                  color: Colors.grey,
                  thickness: 2,
                ),

                //not yet received orders
                ListTile(
                  leading: const Icon(Icons.picture_in_picture_alt_rounded, color: Colors.grey,),
                  title: const Text("Not Yet Received Orders",style: TextStyle(color: Colors.grey,),),
                  onTap: (){

                  },
                ),
                const Divider(
                  height: 10,
                  color: Colors.grey,
                  thickness: 2,
                ),

                //history
                ListTile(
                  leading: const Icon(Icons.history, color: Colors.grey,),
                  title: const Text("History",style: TextStyle(color: Colors.grey,),),
                  onTap: (){

                  },
                ),
                const Divider(
                  height: 10,
                  color: Colors.grey,
                  thickness: 2,
                ),

                //Search
                ListTile(
                  leading: const Icon(Icons.search, color: Colors.grey,),
                  title: const Text("Search ",style: TextStyle(color: Colors.grey,),),
                  onTap: (){

                  },
                ),
                const Divider(
                  height: 10,
                  color: Colors.grey,
                  thickness: 2,
                ),

                //logout
                ListTile(
                  leading: const Icon(Icons.exit_to_app, color: Colors.grey,),
                  title: const Text(
                    "Sign Out",
                    style: TextStyle(color: Colors.grey,),),
                  onTap: ()
                  {
                    FirebaseAuth.instance.signOut();
                    Navigator.push(context, MaterialPageRoute(builder: (c)=> splashscreen()));
                  },
                ),
                const Divider(
                  height: 10,
                  color: Colors.grey,
                  thickness: 2,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

