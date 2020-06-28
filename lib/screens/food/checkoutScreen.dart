import 'package:eatwat/screens/food/status.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class CheckoutScreen extends StatefulWidget {
  List cart;
  double sum;

  CheckoutScreen(this.cart, this.sum);

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> { 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.separated(
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index){
            return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        child: Row(
          children: <Widget>[
            Container(
              height: 75.0,
              width: 45.0,
              decoration: BoxDecoration(
                border: Border.all(width: 2.0, color: Color(0xFFD3D3D3)),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                children: <Widget>[
                  InkWell(
                    onTap:(){
                      setState(() {
                        widget.cart[index].quantity = widget.cart[index].quantity + 1;
                        widget.sum = widget.sum + widget.cart[index].price;
                      });
                    } ,
                    child: Icon(Icons.keyboard_arrow_up, color: Color(0xFFD3D3D3))
                    ),
                  Text('${widget.cart[index].quantity}', style: TextStyle(fontSize: 18.0),),
                  InkWell(
                    onTap:(){
                      setState(() {
                         //阿颖 有没有听到我讲话 我说 我觉得我们能行了！！！
                         if (widget.cart[index].quantity > 0){
                            widget.cart[index].quantity = widget.cart[index].quantity - 1;
                            widget.sum = widget.sum - widget.cart[index].price;
                         }
                      });
                    } ,
                    child: Icon(Icons.keyboard_arrow_down, color: Color(0xFFD3D3D3)))
                ],
              )
            ),
            SizedBox(width: 20.0,),
            Container(
              width: 180.0,
              margin: EdgeInsets.all(10),
              child: Text(
                widget.cart[index].name,
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
            SizedBox(width: 20.0,),
            Container(
              width: 50.0,
              child: Text(
                "\$${widget.cart[index].price}",
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
            Spacer(),
            InkWell(
              onTap: (){ 
                setState(() {
                  if (widget.sum <= 0){} else {
                  widget.sum = widget.sum - widget.cart[index].price * widget.cart[index].quantity;}
                  widget.cart.remove(widget.cart[index]);
                });},
              child: Icon(Icons.cancel, color: Colors.grey,),
            )
  
          ],
        ),
      );
          },
          separatorBuilder: (context, index){
            return Divider();
          },
          itemCount: widget.cart.length,
          shrinkWrap: true,
      ),
    bottomNavigationBar: Container(
      height: 140.0,
      margin: EdgeInsets.only(top: 20.0),
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        children: <Widget>[
          ListTile(
            leading: Text(
              "Total :",
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),),
            trailing: Text(
              "\$${widget.sum}",
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),),
          ),
    
          SizedBox(),

          RaisedButton(
            onPressed: () {createData();
            Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Status()));
              },
            textColor: Colors.white,
            padding: const EdgeInsets.all(0.0),
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xFFEF9A9A),
              ),
              padding: const EdgeInsets.all(15.0),
              child:
                  const Text('Checkout', style: TextStyle(fontSize: 21),),
            ),
          ),
        ],
      )
    )
    );
  }

   void createData() async {
    
    String foodStoreId = widget.cart[0].id;
    List<Map> dishes = [];
    widget.cart.forEach((e) {
        dishes.add(e.toMap());
        print(dishes);
        print(FirebaseAuth.instance.currentUser());
    });

final FirebaseUser user = await FirebaseAuth.instance.currentUser();
final email = user.email;
   Firestore.instance.collection('Order').add(
           {'dishes': dishes,
            'foodStoreId': foodStoreId,
            'status': 1,
            'time': DateTime.now(),
            'totalPrice': widget.sum,
            'userId': email,
            }
         );
       
     }
  }