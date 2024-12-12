class Cart {

  late final int? id;
  final String? productId;
  final String? productName;
  final int? initialPrice;
  final int? productPrice;
  final int? quantity;
  final String? unitTag;
  final String? image;

  Cart({
    required this.id,
    required this.productId,
    required this.image,
    required this.initialPrice,
    required this.productPrice,
    required this.productName,
    required this.quantity,
    required this.unitTag,
  });
  Cart.fromMap(Map<dynamic,dynamic> res) :
        id = res['id'],
        initialPrice = res['initialPrice'],
        productPrice = res['productPrice'],
        productName = res['productName'],
        productId = res['productId'],
        quantity = res['quantity'],
        unitTag = res['unitTag'],
        image = res['image'];

  Map<String, Object?> toMap(){
    return {
      'id' : id,
      'initialPrice' : initialPrice,
      'productPrice' : productPrice,
      'productName' : productName,
      'productId' : productId,
      'quantity' : quantity,
      'unitTag' : unitTag,
      'image' : image,
    };
  }
}