import 'package:amazon_clone/utils/utils.dart';
import 'package:flutter/material.dart';

class ProductInformationWidget extends StatelessWidget {
  final String productName;
  final double cost;
  const ProductInformationWidget(
      {super.key, required this.productName, required this.cost});

  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize(context);
    return SizedBox(
      width: screenSize.width / 2,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              productName,
              style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                  letterSpacing: 0.4,
                  overflow: TextOverflow.ellipsis),
            ),
            Row(
              children: [
                const Text(
                  "₹ ",
                  style: TextStyle(color: Colors.black, fontSize: 14),
                ),
                Text(
                  cost.toString(),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
