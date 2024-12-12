import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shivom_creation/AuthScreen/authscreen.dart';
import 'package:shivom_creation/Pages/Homescreen.dart';

class splashscreen extends StatefulWidget {
  const splashscreen({super.key});

  @override
  State<splashscreen> createState() => _splashscreenState();
}

class _splashscreenState extends State<splashscreen>
{
  splashscreenTimer()
  {
    Timer(const Duration(seconds: 4), () async
    {
      //user is already logged-in
      if(FirebaseAuth.instance.currentUser != null)
      {
        Navigator.push(context, MaterialPageRoute(builder: (c)=> HomeScreen()));
      }
      else
      {
        Navigator.push(context, MaterialPageRoute(builder: (c)=> AuthScreen()));
      }
    });
  }
  @override
  void initState()
  {
    super.initState();

    splashscreenTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.white,
              Color(0xffB68C1E),
            ],
            begin: FractionalOffset(0.0,0.0),
            end: FractionalOffset(1.0,0.0),
            stops: [0.0,1.0],
            tileMode: TileMode.clamp,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(padding: const EdgeInsets.all(12.0),
              child: Image.asset('images/D1 Circle.png',
                width: 300, // Set the desired width
                height: 300,),
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Welcome To ',
                      style: TextStyle(
                        color: Color(0xffB68C1E),
                        fontSize: 30,
                        letterSpacing: 2,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: 'ShivOm',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        letterSpacing: 2,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const Text(
                "Creation ",
                style: TextStyle(
                  fontSize: 30,
                  letterSpacing: 2,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
