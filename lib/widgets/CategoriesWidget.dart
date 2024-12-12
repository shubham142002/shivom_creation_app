import 'package:flutter/material.dart';
import 'package:shivom_creation/Pages/CatList/CatLaces.dart';
import 'package:shivom_creation/Pages/CatList/CatPatches.dart';
import '../Pages/CatList/CatLatkan.dart';

class CategoriesWidget extends StatelessWidget {
  const CategoriesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          InkWell(
            onTap:() {
              Navigator.push(context, MaterialPageRoute(builder: (c)=> CatLaces()));
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 4,),
              padding: EdgeInsets.symmetric(vertical: 3,horizontal: 10,),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xffB68C1E),
                    Color(0xffFFE39B),
                  ],
                  begin: FractionalOffset(0.0,0.0),
                  end: FractionalOffset(1.0,0.0),
                  stops: [0.0,1.0],
                  tileMode: TileMode.clamp,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset("images/1.png",
                    width: 40,
                    height: 40,
                  ),
                  Text(
                    "Laces",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (c)=> CatLatkan()));
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10,),
              padding: EdgeInsets.symmetric(vertical: 3,horizontal: 10,),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xffB68C1E),
                    Color(0xffFFE39B),
                  ],
                  begin: FractionalOffset(0.0,0.0),
                  end: FractionalOffset(1.0,0.0),
                  stops: [0.0,1.0],
                  tileMode: TileMode.clamp,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset("images/2.png",
                    width: 40,
                    height: 40,
                  ),
                  Text(
                    "Latkan",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (c)=> CatPatches()));
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 4,),
              padding: EdgeInsets.symmetric(vertical: 3,horizontal: 10,),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xffB68C1E),
                    Color(0xffFFE39B),
                  ],
                  begin: FractionalOffset(0.0,0.0),
                  end: FractionalOffset(1.0,0.0),
                  stops: [0.0,1.0],
                  tileMode: TileMode.clamp,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset("images/3.png",
                    width: 40,
                    height: 40,
                  ),
                  Text(
                    "Patches",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
