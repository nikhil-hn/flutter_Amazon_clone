import 'package:amazon_clone/model/product_model.dart';
import 'package:amazon_clone/resources/cloudfirestore_methods.dart';
import 'package:amazon_clone/screens/product_screen.dart';
import 'package:amazon_clone/utils/color_theme.dart';
import 'package:amazon_clone/utils/utils.dart';
import 'package:amazon_clone/widget/custom_square_button.dart';
import 'package:amazon_clone/widget/product_infromation_widget.dart';
import 'package:flutter/material.dart';

class CartItemWidget extends StatefulWidget {
  final ProductModel model;
  int itemCount;
  final BuildContext cartScreenctx;

  CartItemWidget(
      {super.key,
      required this.model,
      required this.itemCount,
      required this.cartScreenctx});

  @override
  State<CartItemWidget> createState() => _CartItemWidgetState();
}

class _CartItemWidgetState extends State<CartItemWidget> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize(context);
    return Container(
      height: screenSize.height * 0.4,
      width: screenSize.width,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey,
            width: 1,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 4,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ProductScreen(model: widget.model),
                ));
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    //Product Image
                    Align(
                      alignment: Alignment.topCenter,
                      child: SizedBox(
                        width: screenSize.width * 0.4,
                        height: screenSize.height * 0.3,
                        child: Image.asset(widget.model.image),
                      ),
                    ),
                    // Product Information
                    ProductInformationWidget(
                        productName: widget.model.productName,
                        cost: widget.model.cost),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Row(
                children: [
                  //Reduce product Count
                  CustomSquareButton(
                    onPressed: () {
                      if (widget.itemCount > 1) {
                        setState(() {
                          widget.itemCount = widget.itemCount - 1;
                          CloudFirestoreMethods().uppdatetoCart(
                              widget.model.uid,
                              widget.itemCount,
                              widget.cartScreenctx);
                        });
                      } else {
                        CloudFirestoreMethods()
                            .deleteFromCart(widget.model, widget.cartScreenctx);
                      }
                    },
                    color: Colors.grey[500]!,
                    dimension: 40,
                    child: const Icon(Icons.remove),
                  ),
                  //Product Count Display
                  CustomSquareButton(
                    onPressed: () {},
                    color: Colors.grey[200]!,
                    dimension: 40,
                    child: Text(
                      widget.itemCount.toString(),
                      style: const TextStyle(color: activeCyanColor),
                    ),
                  ),
                  //Add Product Count
                  CustomSquareButton(
                      onPressed: () {
                        setState(() {
                          widget.itemCount = widget.itemCount + 1;
                          CloudFirestoreMethods().uppdatetoCart(
                              widget.model.uid,
                              widget.itemCount,
                              widget.cartScreenctx);
                        });
                      },
                      color: Colors.grey[500]!,
                      dimension: 40,
                      child: const Icon(Icons.add))
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.only(left: 15.0, bottom: 5, top: 4),
              child: GestureDetector(
                onTap: () {
                  CloudFirestoreMethods()
                      .deleteFromCart(widget.model, widget.cartScreenctx);
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.grey, width: 1),
                  ),
                  child: const Text('Delete'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
