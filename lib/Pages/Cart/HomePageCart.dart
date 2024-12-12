import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shivom_creation/Pages/Cart/CartProvider.dart';
import 'package:shivom_creation/Pages/Cart/CartScreen.dart';
import 'package:shivom_creation/Pages/Cart/Cart_Model.dart';
import 'package:shivom_creation/Pages/Cart/DB_helper.dart';
import 'package:shivom_creation/widgets/CategoriesWidget.dart';
import 'package:shivom_creation/widgets/appdrawer.dart';
import 'package:badges/badges.dart' as badges;

class HomePageCart extends StatefulWidget {

  @override
  State<HomePageCart> createState() => _HomePageCartState();
}

class _HomePageCartState extends State<HomePageCart> {

  List<dynamic> imgList = [
    "images/Laces4.jpg",
    "images/Laces3.jpg",
    "images/Laces939.jpg",
    'images/Laces5.jpg',
    'images/Patches2.jpg',
    'images/Latkan4.jpg',
    'images/Latkan5.jpg',
    'images/Patches3.jpg',
    'images/Patches4.jpg',
  ];

  List<String> productName = ['Laces', 'Patches', 'Latkan','Laces', 'Patches', 'Latkan',];
  List<String> productUnit = ['Meter', 'Roll', 'Meter','Meter', 'Roll', 'Meter',];
  List<int> productPrice = [10, 20, 30,50,200,44];
  List<String> productImages = [
    'images/Laces1.jpg',
    'images/Laces939.jpg',
    'images/Laces3.jpg',
    'images/Laces5.jpg',
    'images/Patches2.jpg',
    'images/Latkan4.jpg',
  ];

  DBHelper? dbHelper = DBHelper();

  var cart;

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return WillPopScope(
      onWillPop: () async{
        final value = await showDialog<bool>(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Alert'),
                content: const Text('Do you want to Exit App?'),
                actions: [
                  ElevatedButton(onPressed: () => Navigator.of(context).pop(false),
                    child: const Text('No'),
                  ),
                  ElevatedButton(onPressed: () => Navigator.of(context).pop(true),
                    child: const Text('Yes'),
                  ),
                ],
              );
            }
        );
        if(value != null) {
          return Future.value(value);
        }else {
          return Future.value(false);
        }
      },
      child: Scaffold(
        drawer: AppDrawer(),
        appBar: AppBar(
          flexibleSpace: Container(
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
          ),
          title: Text(
            "Shiv Om",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              color: Colors.black,
              onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => SearchPage())),
            ),
            InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => CartScreen()));
              },
              child: Center(
                child: badges.Badge(
                  badgeContent: Consumer<CartProvider>(
                      builder: (context, value, child,){
                        return Text(value.getCounter().toString(),style: TextStyle(color: Colors.white),);
                      }
                  ),
                  child: Icon(
                    Icons.shopping_bag_outlined,
                    color: Colors.black,
                  ), // Bag icon
                ),
              ),
            ),
            SizedBox(width: 20,)
          ],
        ),
        body: Column(
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
              margin: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
              child: Text(
                "Categories",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            CategoriesWidget(),
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
              child: Text(
                "Products",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: productName.length,
                itemBuilder: (context, index){
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Image.asset(
                                productImages[index].toString(),
                                width: 70,
                              ),
                              SizedBox(width: 10,),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(productName[index].toString(),
                                      style: TextStyle(
                                        fontSize: 16,fontWeight: FontWeight.w500,),
                                    ),
                                    SizedBox(height: 5,),
                                    Text(productUnit[index].toString() +" "+r"$"+productPrice[index].toString(),
                                      style: TextStyle(
                                        fontSize: 16,fontWeight: FontWeight.w500,),
                                    ),
                                    SizedBox(height: 5,),
                                    Align(
                                      alignment : Alignment.centerRight,
                                      child : InkWell(
                                        onTap: (){
                                          print(index);
                                          print(index);
                                          print(productName[index].toString());
                                          print(productPrice[index]);
                                          print('1');
                                          print(productUnit[index].toString());
                                          print(productImages[index].toString());

                                          dbHelper!.insert(
                                              Cart(
                                                id: index,
                                                productId: index.toString(),
                                                productName: productName[index].toString(),
                                                initialPrice: productPrice[index],
                                                productPrice: productPrice[index],
                                                quantity: 1,
                                                unitTag: productUnit[index].toString(),
                                                image: productImages[index].toString(),)
                                          ).then((value){
                                            print("Product is added to cart");
                                            cart.addTotalPrice(double.parse(productPrice[index].toString()));
                                            cart.addCounter();
                                          }).onError((error, stackTrace){
                                            print(error.toString());
                                          });
                                        },
                                        child: Container(
                                          height: 35,
                                          width: 100,
                                          decoration:BoxDecoration(
                                            color: Color(0xffB68C1E),
                                            borderRadius: BorderRadius.circular(5),
                                          ),
                                          child: Center(
                                            child: Text("Add To Cart",style: TextStyle(color: Colors.white),),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
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
        ),
        title: Container(
          width: double.infinity,
          height: 40,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5)
          ),
          child: Center(
            child: TextField(
              decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (c)=> HomePageCart()));
                    },
                  ),
                  hintText: 'Search...',
                  border: InputBorder.none
              ),
            ),
          ),
        ),
      ),
    );
  }
}

