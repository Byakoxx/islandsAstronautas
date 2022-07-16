import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import '../helpers/helpers.dart';
import '../model/image_model.dart';
import '../repository/image_repository.dart';


class GifSearchDelegate extends SearchDelegate {

  @override
  String? get searchFieldLabel => "Busca un Gif ;)";

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon( Icons.clear ),
        onPressed: () => query = '',
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => close(context, null), 
      icon: const Icon(Icons.arrow_back)
    );
  }

  @override
  Widget buildResults(BuildContext context) {
   return FutureBuilder(
      future: searchGif(query),
      builder: (BuildContext context, AsyncSnapshot<List<Datum>> snap) {
        if(!snap.hasData) {
          return _EmptyContainer();
        }

        final List<Datum> results = snap.data!;

        return ListView.builder(
          itemCount: results.length,
          itemBuilder: (_, int index) => _MovieItem(gif: results[index],)
        );

      }
    );
  }

  Widget _EmptyContainer() {
    return const Center(
      child: Icon(
        Ionicons.skull_outline, color: Colors.black38, size: 130,
      ),
    ); 
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if(query.isEmpty) {
      return const Center(
        child: Icon(
          Ionicons.skull_outline, color: Colors.black38, size: 130,
        ),
      );
    }

    return FutureBuilder(
      future: searchGif(query),
      builder: (BuildContext context, AsyncSnapshot<List<Datum>> snap) {
        if(!snap.hasData) {
          return _EmptyContainer();
        }

        final List<Datum> results = snap.data!;

        return ListView.builder(
          itemCount: results.length,
          itemBuilder: (_, int index) => _MovieItem(gif: results[index],)
        );

      }
    );
  }

}

class _MovieItem extends StatelessWidget {
  final Datum gif;
  const _MovieItem({Key? key, required this.gif}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: FadeInImage.assetNetwork(
              placeholder: 'assets/images/loading.gif',
              image: gif.images.original.url,
              height: 50,
              width: 100,
              fit: BoxFit.cover,
            )
          ),
        ],
      ),
      title: Text(gif.title),
      onTap: () => Helpers.showMessage("Route a vista completa con el gif", context),
    );
    
  }
}