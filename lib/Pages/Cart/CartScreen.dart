import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shivom_creation/Pages/Cart/CartProvider.dart';
import 'package:badges/badges.dart' as badges;
import 'package:shivom_creation/Pages/Cart/Cart_Model.dart';
import 'package:shivom_creation/Pages/Cart/DB_helper.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {

  DBHelper? dbHelper = DBHelper();

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
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
          "My Products",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: <Widget>[
          Center(
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
          SizedBox(width: 20,)
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            FutureBuilder(
                future: cart.getData(),
                builder: (context, AsyncSnapshot<List<Cart>> snapshot){
                  if(snapshot.hasData){
                    if(snapshot.data!.isEmpty){
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset("images/Empty_Cart.png",),
                          SizedBox(height: 20,),
                          Text('Cart is Empty'),
                        ],
                      );
                    }else{
                      return Expanded(
                        child: ListView.builder(
                            itemCount: snapshot.data!.length,
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
                                            snapshot.data![index].image.toString(),
                                            width: 70,
                                          ),
                                          SizedBox(width: 10,),
                                          Expanded(
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text(snapshot.data![index].productName.toString(),
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.w500,
                                                      ),
                                                    ),
                                                    InkWell(
                                                        onTap: (){
                                                          dbHelper!.delete(snapshot.data![index].id!);
                                                          cart.removeCounter();
                                                          cart.removeTotalPrice(double.parse(snapshot.data![index].productPrice.toString()));
                                                        },
                                                        child: Icon(Icons.delete,)
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 5,),
                                                Text(snapshot.data![index].unitTag.toString() +" "+r"$"+snapshot.data![index].productPrice.toString(),
                                                  style: TextStyle(
                                                    fontSize: 16,fontWeight: FontWeight.w500,),
                                                ),
                                                SizedBox(height: 5,),
                                                Align(
                                                  alignment : Alignment.centerRight,
                                                  child : InkWell(
                                                    onTap: (){

                                                    },
                                                    child: Container(
                                                      height: 35,
                                                      width: 100,
                                                      decoration:BoxDecoration(
                                                        color: Color(0xffB68C1E),
                                                        borderRadius: BorderRadius.circular(5),
                                                      ),
                                                      child: Padding(
                                                        padding: const EdgeInsets.all(4.0),
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            InkWell(
                                                                onTap: (){
                                                                  int quantity = snapshot.data![index].quantity!;
                                                                  int price = snapshot.data![index].initialPrice!;
                                                                  quantity--;
                                                                  int? newPrice = price * quantity;

                                                                  if(quantity > 0){
                                                                    dbHelper!.updateQuantity(
                                                                        Cart(
                                                                          id: snapshot.data![index].id,
                                                                          productId: snapshot.data![index].id.toString(),
                                                                          image: snapshot.data![index].image.toString(),
                                                                          initialPrice: snapshot.data![index].initialPrice!,
                                                                          productPrice: newPrice,
                                                                          productName: snapshot.data![index].productName!,
                                                                          quantity: quantity,
                                                                          unitTag: snapshot.data![index].unitTag.toString(),)
                                                                    ).then((value){
                                                                      newPrice = 0;
                                                                      quantity = 0;
                                                                      cart.removeTotalPrice(double.parse(snapshot.data![index].initialPrice!.toString()));
                                                                    }).onError((error, stackTrace){
                                                                      print(error.toString());
                                                                    });
                                                                  }
                                                                },
                                                                child: Icon(Icons.remove, color: Colors.white,)),
                                                            Text(snapshot.data![index].quantity.toString(),style: TextStyle(color: Colors.white),),
                                                            InkWell(
                                                              onTap: (){
                                                                int quantity = snapshot.data![index].quantity!;
                                                                int price = snapshot.data![index].initialPrice!;
                                                                quantity++;
                                                                int? newPrice = price * quantity;

                                                                dbHelper!.updateQuantity(
                                                                    Cart(
                                                                      id: snapshot.data![index].id,
                                                                      productId: snapshot.data![index].id.toString(),
                                                                      image: snapshot.data![index].image.toString(),
                                                                      initialPrice: snapshot.data![index].initialPrice!,
                                                                      productPrice: newPrice,
                                                                      productName: snapshot.data![index].productName!,
                                                                      quantity: quantity,
                                                                      unitTag: snapshot.data![index].unitTag.toString(),)
                                                                ).then((value){
                                                                  newPrice = 0;
                                                                  quantity = 0;
                                                                  cart.addTotalPrice(double.parse(snapshot.data![index].initialPrice!.toString()));
                                                                }).onError((error, stackTrace){
                                                                  print(error.toString());
                                                                });
                                                              },
                                                              child: Icon(Icons.add, color: Colors.white,),
                                                            ),
                                                          ],
                                                        ),
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
                              );}
                        ),
                      );
                    }
                  }
                  return Text('');
            }),
            Consumer<CartProvider>(builder: (context, value, child){
              return Visibility(
                visible: value.getTotalPrice().toStringAsFixed(2) == "0.00" ? false : true,
                child: Column(
                  children: [
                    ReusableWidget(title: 'Sub Total', value: r'$'+value.getTotalPrice().toStringAsFixed(2),),
                    ReusableWidget(title: 'Discount 5%', value: r'$'+'20',),
                    ReusableWidget(title: 'Total', value: r'$'+value.getTotalPrice().toStringAsFixed(2),),
                  ],
                ),
              );
            })
          ],
        ),
      ),
    );
  }
}

class ReusableWidget extends StatelessWidget {
  final String title, value;
  const ReusableWidget({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: Theme.of(context).textTheme.subtitle2,),
          Text(value.toString(), style: Theme.of(context).textTheme.subtitle2,),
        ],
      ),
    );
  }
}

