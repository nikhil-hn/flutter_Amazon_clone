import 'package:flutter/material.dart';
import 'package:amazon_clone/widget/search_bar_widget.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: SearchBarWidget(isReadOnly: false, hasBackButton: true),
      ),
    );
  }
}
