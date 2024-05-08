import 'package:amazon_clone/model/product_model.dart';
import 'package:amazon_clone/resources/cloudfirestore_methods.dart';
import 'package:amazon_clone/screens/payment_screen.dart';
import 'package:amazon_clone/utils/color_theme.dart';
import 'package:amazon_clone/utils/utils.dart';
import 'package:amazon_clone/widget/custom_button.dart';
import 'package:amazon_clone/widget/search_bar_widget.dart';
import 'package:amazon_clone/widget/user_details_bar.dart';
import 'package:flutter/material.dart';

class ProductScreen extends StatelessWidget {
  final ProductModel model;
  const ProductScreen({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize(context);
    return SafeArea(
      child: Scaffold(
        appBar: SearchBarWidget(isReadOnly: true, hasBackButton: true),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const UserDetailsBar(offset: 0, screen: 'product'),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 4),
                child: Text(
                  model.descrption,
                  style: const TextStyle(fontSize: 15),
                ),
              ),
              Image.asset(
                model.image,
                width: screenSize.width * 0.7,
                height: screenSize.height * 0.4,
              ),
              Text(
                model.productName,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      '₹ ',
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      model.cost.toString(),
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ),
              CustomMainButton(
                color: Colors.orange,
                isLoading: false,
                onPressed: () {
                  CloudFirestoreMethods().addToOrders(model);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PaymentScreen(
                          price: model.cost,
                          orderAll: false,
                        ),
                      ));
                },
                child: const Text(
                  'Buy Now',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              CustomMainButton(
                color: yellowColor,
                isLoading: false,
                onPressed: () async {
                  await CloudFirestoreMethods().addtoCart(model, context);
                },
                child: const Text(
                  'Add to cart',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
