import 'package:flutter/material.dart';

class ShoppingUI extends StatefulWidget {
  const ShoppingUI({super.key});

  @override
  State<ShoppingUI> createState() => _ShoppingUIState();
}

class _ShoppingUIState extends State<ShoppingUI> {

  int _polloverDressCount = 1;
  int _tShirtDressCount = 1;
  int _sportDressCount = 1;
  int _totalAmount = 124;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Shopping Cart"),
      ),
      body: Column(
        children: [
          dressCard(
            dressType: 1,
            dressImage: "https://m.media-amazon.com/images/I/B1pppR4gVKL._CLa%7C2140%2C2000%7C616mtWb4SkL.png%7C0%2C0%2C2140%2C2000%2B0.0%2C0.0%2C2140.0%2C2000.0_AC_UY1000_.png",
            dressName: "Pullover",
            dressColor: "Black",
            size: "L",
            dressPrice: 51,
          ),

          dressCard(
            dressType: 2,
            dressImage: "https://www.teez.in/cdn/shop/products/Flutter-Framework-T-Shirt-For-Men-2_large.jpg",
            dressName: "T-Shirt",
            dressColor: "Grey",
            size: "L",
            dressPrice: 30,
          ),

          dressCard(
            dressType: 3,
            dressImage: "https://stonefieldbd.com/public/uploads/products/photos/h407CJECqkKUSDmr8EnZLTbW8DsCHtE684zL2FUw.jpeg",
            dressName: "Sport Dress",
            dressColor: "Black",
            size: "M",
            dressPrice: 43,
          ),

        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Total amount: ", style: TextStyle(color: Colors.grey),),
                    Text("$_totalAmount\$", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                  ],
                ),
              ),

              const SizedBox(width: 60),


              Container(
                margin: const EdgeInsets.only(bottom: 5, right: 5, left: 5),
                width: double.infinity,
                child: FloatingActionButton.extended(
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                  backgroundColor: Colors.red,
                  onPressed: (){
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Congratulating", style: TextStyle(fontSize: 15)),
                      behavior: SnackBarBehavior.fixed,
                      backgroundColor: Colors.green,
                    ));
                  },
                  label: const Text("CHECK OUT", style: TextStyle(color: Colors.white),),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget dressCard({
    required int dressType,
    required String dressImage,
    required String dressName,
    required String dressColor,
    required String size,
    required int dressPrice
  }){
    return Card(
      color: Colors.white,
      elevation: 2,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _imageWidget(imageUrl: dressImage),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(dressName, style: const TextStyle(fontWeight: FontWeight.bold)),
                  RichText(
                    text: TextSpan(
                        children: [
                          const TextSpan(
                            text: "Color: ",
                            style: TextStyle(color: Colors.grey),
                          ),
                          TextSpan(
                            text: "$dressColor     ",
                            style: const TextStyle(color: Colors.black),
                          ),


                          const  TextSpan(
                            text: "Size: ",
                            style: TextStyle(color: Colors.grey),
                          ),
                          TextSpan(
                            text: size,
                            style: const TextStyle(color: Colors.black),
                          )
                        ]
                    ),
                  ),

                  const SizedBox(height: 10),
                  _incrementDecrementButtonWidgets(dressType: dressType, dressPrice: dressPrice),
                ],
              ),
            ],
          ),

          Container(
            padding: const EdgeInsets.only(right: 10),
            height: 80,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(Icons.more_vert, color: Colors.black26,),

                Text("$dressPrice\$"),
              ],
            ),
          )
        ],
      ),
    );
  }


  void incrementTotalCount(int dressType){
    if(dressType == 1){
      _polloverDressCount++;
    }
   else if(dressType == 2){
      _tShirtDressCount++;
    }
    else {
      _sportDressCount++;
    }
  }

  void decrementTotalCount(int dressType){
    if(dressType == 1){
      _polloverDressCount--;
    }
    else if(dressType == 2){
      _tShirtDressCount--;
    }
    else {
      _sportDressCount--;
    }
  }

  Widget _imageWidget({required imageUrl}){
    return Image.network(
      imageUrl,
      width: 130,
      height: 80,
    );
  }

  Widget _incrementDecrementButtonWidgets({required int dressType, required int dressPrice}){
    int count = 1;
    if(dressType == 1){
      count = _polloverDressCount;
    }
    else if(dressType == 2){
      count = _tShirtDressCount;
    }
    else {
      count = _sportDressCount;
    }

    return Row(
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              elevation: 3
          ),
          onPressed: (){
            if(dressType == 1 && _polloverDressCount == 1){
              return;
            }
            if(dressType == 2 && _tShirtDressCount == 1){
              return;
            }
            else if(dressType == 3 && _sportDressCount == 1) {
              return;
            }

            //isAdditionPrice => add = true | minus = false
            _calculateTotalAmount(
              dressType: dressType,
              price: dressPrice,
              isAdditionPrice: false // for minus
            );
            setState(() {
              decrementTotalCount(dressType);
            });
          },
          child: const Icon(Icons.remove),
        ),

        Text("$count"),

        ElevatedButton(
          style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              elevation: 3
          ),
          onPressed: (){
            //isAdditionPrice => add = true | minus = false
            _calculateTotalAmount(
                dressType: dressType,
                price: dressPrice,
                isAdditionPrice: true // for add
            );
            setState(() {
              incrementTotalCount(dressType);
            });
          },
          child: const Icon(Icons.add),
        )
      ],
    );
  }

  void _calculateTotalAmount({required int dressType, required int price, required bool isAdditionPrice}){
    if(dressType == 1){
      if(isAdditionPrice){
        _totalAmount += price;
      }
      else{
        _totalAmount -= price;
      }
    }
    else if(dressType == 2){
      if(isAdditionPrice){
        _totalAmount += price;
      }
      else{
        _totalAmount -= price;
      }
    }
    else{
      if(isAdditionPrice){
        _totalAmount += price;
      }
      else{
        _totalAmount -= price;
      }
    }
  }



}
