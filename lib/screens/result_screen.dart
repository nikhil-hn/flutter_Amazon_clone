import 'package:amazon_clone/model/product_model.dart';
import 'package:amazon_clone/utils/product_list.dart';
import 'package:amazon_clone/widget/result_widget.dart';
import 'package:amazon_clone/widget/search_bar_widget.dart';
import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  final String query;
  final String screen;
  const ResultScreen({super.key, required this.query, this.screen = ''});

  @override
  Widget build(BuildContext context) {
    List<ProductModel> list = getList(query);

    return SafeArea(
      child: Scaffold(
        appBar: SearchBarWidget(isReadOnly: false, hasBackButton: true),
        body: Column(
          children: [
            screen != 'home'
                ? Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: RichText(
                        text: TextSpan(
                          children: [
                            const TextSpan(
                              text: 'Showing results for   ',
                              style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700),
                            ),
                            TextSpan(
                              text: query,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 17,
                                  fontStyle: FontStyle.italic),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                : const SizedBox(
                    height: 0,
                    width: 0,
                  ),
            Expanded(
                child: ListView.separated(
              itemCount: list.length,
              itemBuilder: (context, index) {
                return ResultWidget(model: list[index]);
              },
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(
                  height: 8,
                );
              },
            ))
          ],
        ),
      ),
    );
  }

  List<ProductModel> getList(String query) {
    List<ProductModel> newList = [];

    for (var model in productList) {
      String categoryLowerCase = model.category.toLowerCase();
      String productName = model.productName.toLowerCase();
      if (categoryLowerCase.contains(query.toLowerCase()) ||
          productName.contains(query.toLowerCase())) {
        newList.add(model);
      }
    }
    return newList;
  }
}
