import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shivom_creation/Pages/Cart/CartProvider.dart';
import 'package:shivom_creation/Pages/Cart/CartScreen.dart';
import 'package:shivom_creation/Pages/Cart/Cart_Model.dart';
import 'package:shivom_creation/Pages/Cart/DB_helper.dart';
import 'package:badges/badges.dart' as badges;

class CatLatkan extends StatelessWidget {

  List<String> productName = ['Laces', 'Patches', 'Latkan',];
  List<String> productUnit = ['Meter', 'Roll', 'Meter',];
  List<int> productPrice = [10, 20, 30,];
  List<String> productImages = [
    'images/Laces1.jpg',
    'images/Laces939.jpg',
    'images/Laces3.jpg',
  ];

  DBHelper? dbHelper = DBHelper();

  var cart;

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
        title: Text(
          "Latkan",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: <Widget>[
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
      body: Expanded(
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
                      Navigator.push(context, MaterialPageRoute(builder: (c)=> CatLatkan()));
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
