import 'package:amazon_clone/model/product_model.dart';
import 'package:amazon_clone/resources/cloudfirestore_methods.dart';
import 'package:amazon_clone/screens/payment_done.dart';
import 'package:amazon_clone/utils/color_theme.dart';
import 'package:amazon_clone/utils/constants.dart';
import 'package:amazon_clone/utils/utils.dart';
import 'package:flutter/material.dart';

class PaymentScreen extends StatefulWidget {
  final double price;
  final bool orderAll;
  ProductModel? model;
  PaymentScreen(
      {super.key, required this.price, this.orderAll = false, this.model});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  PaymentMethod selectedMethod = PaymentMethod.googlePay;

  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Payment',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            vertical: 15.0, horizontal: screenSize.width * 0.05),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                paymentMethodWidget(screenSize, 'assets/images/gpayicon.jpg',
                    'Google Pay', PaymentMethod.googlePay),
                paymentMethodWidget(
                    screenSize,
                    'assets/images/phonepayicon.jpg',
                    'Phone Pay',
                    PaymentMethod.phonePay),
                paymentMethodWidget(screenSize, 'assets/images/cardicon.jpg',
                    'Card', PaymentMethod.card),
                paymentMethodWidget(screenSize, 'assets/images/codicon.jpg',
                    'Cash on Delivery', PaymentMethod.cashOnDelivery),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Total   ",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      '₹ ',
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      widget.price.toString(),
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ],
            ),
            // Button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: yellowColor,
                  fixedSize: Size(
                    screenSize.width * 0.8,
                    45,
                  )),
              onPressed: () {
                if (widget.orderAll) {
                  CloudFirestoreMethods().addAllToOrders();
                }
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => const PaymentDone(),
                ));
              },
              child: const Text(
                'Place Your Order and Pay',
                style: TextStyle(color: Colors.black),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget paymentMethodWidget(Size screenSize, String imageUrl,
      String paymentMethodTittle, PaymentMethod method) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedMethod = method;
          });
        },
        child: Container(
          height: 60,
          width: screenSize.width * 0.9,
          decoration: BoxDecoration(
              color: backgroundColor,
              border: Border.all(
                color: Colors.black54,
              )),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset(
                    imageUrl,
                    width: screenSize.width * 0.2,
                    height: 60,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Text(
                      paymentMethodTittle,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
              Radio(
                value: method,
                groupValue: selectedMethod,
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      selectedMethod = value;
                    });
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
