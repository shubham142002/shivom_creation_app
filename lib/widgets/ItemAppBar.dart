import 'package:flutter/material.dart';

class ItemAppBar extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Container(
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
      padding: EdgeInsets.all(25),
      child: Row(children: [
        InkWell(
          onTap: (){
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back,
              size: 30,
              color: Colors.black),

        ),
        Padding(
          padding: EdgeInsets.only(left: 20),
          child: Text(
            "Product",
            style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        Spacer(),
        Icon(Icons.favorite,
          size: 30,
          color: Colors.red,
        ),
      ],),
    );
  }
}
