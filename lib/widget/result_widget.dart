import 'package:amazon_clone/model/product_model.dart';
import 'package:amazon_clone/resources/cloudfirestore_methods.dart';
import 'package:amazon_clone/screens/product_screen.dart';
import 'package:amazon_clone/utils/color_theme.dart';
import 'package:amazon_clone/utils/utils.dart';
import 'package:amazon_clone/widget/custom_button.dart';
import 'package:flutter/material.dart';

class ResultWidget extends StatelessWidget {
  final ProductModel model;
  const ResultWidget({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize(context);
    return Container(
      decoration: const BoxDecoration(color: backgroundColor),
      height: screenSize.height * 0.30,
      width: screenSize.width,
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ProductScreen(model: model),
          ));
        },
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                width: screenSize.width * 0.38,
                height: screenSize.height * 0.28,
                decoration: const BoxDecoration(color: backgroundColor),
                child: Image.asset(model.image),
              ),
            ),
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          model.productName,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                        Row(
                          children: [
                            const Text(
                              "₹ ",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 16),
                            ),
                            Text(
                              model.cost.toString(),
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                          ],
                        ),
                      ],
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
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
