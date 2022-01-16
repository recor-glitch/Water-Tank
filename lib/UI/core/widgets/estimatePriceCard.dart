import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



Widget CustomCard(
    {required int item1_price, required int item2_price, required int item3_price, required int dilevery, required int item1_quantity, required int item2_quantity, required int item3_quantity}) {
  return Card(
    color: Colors.white,
    elevation: 5.0,
    clipBehavior: Clip.antiAlias,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(24),
    ),
    child: Padding(
      padding: EdgeInsets.all(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Text('Estimated price',
              style: TextStyle(
                  color: Colors.black, fontSize: 20),),
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Text('Total:',
                        style: TextStyle(
                            color: Colors.black, fontSize: 15),),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Text('Delivery charge:', style: TextStyle(
                          color: Colors.black, fontSize: 15),),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Text('Total payable amount:', style: TextStyle(
                          color: Colors.black, fontSize: 15),),
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Text('${item1_price*item1_quantity + item2_price*item2_quantity + item3_price*item3_quantity} Rupees', style: TextStyle(
                          color: Colors.black, fontSize: 15),),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Text('(+)$dilevery Rupees', style: TextStyle(
                          color: Colors.black, fontSize: 15),),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Text('${item1_price*item1_quantity + item2_price*item2_quantity + item3_price*item3_quantity + dilevery} Rupees', style: TextStyle(
                          color: Colors.black, fontSize: 15),),
                    ),
                  ],
                ),
              ]
          ),
        ],
      ),
    ),
  );
}