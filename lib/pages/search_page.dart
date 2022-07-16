import 'package:Islands/pages/search_delegate.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import '../utils/colors.dart';

class SearchPage extends StatelessWidget {

  const SearchPage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade600,
        title: const Text(
          'Buscador de gifs',
          style: TextStyle(
            color: whiteColor
          ),
        ),
        centerTitle: true,
        elevation: 1,
        actions: [
          IconButton(
            onPressed: () => showSearch(context: context, delegate: GifSearchDelegate()),
            icon: const Icon(Icons.search, color: whiteColor)
          )
        ],
      ),
      body: const Center(
        child: Icon(
          Ionicons.skull_outline, color: Colors.black38, size: 130,
        ),
      ),
    );
  }
}