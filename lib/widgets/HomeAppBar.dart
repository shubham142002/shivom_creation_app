import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shivom_creation/Pages/Cart/HomePageCart.dart';
import 'CategoriesWidget.dart';
import 'ItemsWidget.dart';

class HomeAppBar extends StatelessWidget {

  get imgList => null;

  @override
  Widget build(BuildContext context) {
    List<dynamic> imgList = [
      "images/Laces4.jpg",
      "images/Laces3.jpg",
      "images/Laces939.jpg",
    ]; // Your list of dynamic objects

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
      child: Column(
        children: [
          Container(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                "Popular Products",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ),
          CarouselSlider(
              items: imgList.map((item) => Padding(
                padding: const EdgeInsets.all(2.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Center(
                    child: Image.asset(
                      item,
                      fit: BoxFit.cover,
                      width: 350,
                    ),
                  ),
                ),
              ),)
                  .toList(),
              options: CarouselOptions(
                autoPlay: true,
                aspectRatio: 2.0,
                enlargeCenterPage: true,
              )),
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.symmetric(
              vertical: 12,
              horizontal: 10,
            ),
            child: Text(
              "Categories",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          CategoriesWidget(),

          //Best Items
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
            child: Text(
              "Best Selling",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          HomePageCart(),
        ],
      ),
    );
  }
}
