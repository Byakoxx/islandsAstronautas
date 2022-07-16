import 'package:Islands/helpers/helpers.dart';
import 'package:Islands/model/image_model.dart';
import 'package:Islands/provider/islands_provider.dart';
import 'package:Islands/widget/landscape_menu_widget.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:Islands/utils/colors.dart';
import 'package:Islands/widget/result_widget.dart';
import 'package:provider/provider.dart';
import 'package:skeleton_text/skeleton_text.dart';

import '../repository/image_repository.dart';

// ignore: must_be_immutable
class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);


  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  int uno = 1;
  int dos = 0;
  int tres = 1;
  int cuatro = 0;

  List<List<int>> grid = [[1,1],[1,0]];

  @override
  Widget build(BuildContext context) {
    final islandsProvider = Provider.of<IslandsProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/images/nasa_logo.png',
                      width: 100.0,
                    ),
                    const Expanded(child: SizedBox()),
                    GestureDetector(
                      onTap: () => Helpers.showMessage("Route vista notificaciones", context),
                      child: Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: whiteColor,
                          boxShadow: [
                            BoxShadow(
                                color: grayColor,
                                blurRadius: 10.0,
                                spreadRadius: -8,
                                offset: Offset(0.0, 10)
                            )
                          ],
                        ),
                        padding: const EdgeInsets.all(6.0),
                        child: Image.asset(
                          'assets/images/bell.png',
                          width: 20.0,
                        ),
                      ),
                    ),
                    const SizedBox(width: 5.0),
                    GestureDetector(
                      onTap: () => Helpers.showMessage("Route vista configuración", context),
                      child: Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: whiteColor,
                          boxShadow: [
                            BoxShadow(
                                color: grayColor,
                                blurRadius: 10.0,
                                spreadRadius: -8,
                                offset: Offset(0.0, 10)
                            )
                          ],
                        ),
                        padding: const EdgeInsets.all(5.0),
                        child: Image.asset(
                          'assets/images/settings.png',
                          width: 25.0,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Favorites",
                      style: TextStyle(
                        fontSize: 36.0
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Helpers.showMessage("Agregar a favoritos", context),
                      child: Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: whiteColor,
                          boxShadow: [
                            BoxShadow(
                                color: grayColor,
                                blurRadius: 10.0,
                                spreadRadius: -8,
                                offset: Offset(0.0, 10)
                            )
                          ],
                        ),
                        padding: const EdgeInsets.all(5.0),
                        child: const Icon(Ionicons.add_outline)
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 25.0),
              const LandscapeMenu(),
              const SizedBox(height: 40.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      islandsProvider.query,
                      style: const TextStyle(
                        fontSize: 25.0
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Helpers.showMessage("Eliminar lista", context),
                      child: Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: whiteColor,
                          boxShadow: [
                            BoxShadow(
                                color: grayColor,
                                blurRadius: 10.0,
                                spreadRadius: -8,
                                offset: Offset(0.0, 10)
                            )
                          ],
                        ),
                        padding: const EdgeInsets.all(5.0),
                        child: Image.asset(
                          'assets/images/trash.png',
                          width: 25.0,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 30.0),
              FutureBuilder(
                future: fetchImages(islandsProvider),
                builder: (BuildContext context, AsyncSnapshot snap) {
                  if( snap.connectionState == ConnectionState.waiting) {

                    return _loading();

                  } else if ( snap.hasError ) {
                    return _errorMessage('Hubo un error en cargar los resultados, vuelve a intentarlo');
                  } else {

                    Map<String, dynamic> response = snap.data;

                    if(response['status']) {

                      return _resultList(response);

                    } else {
                      if(response['error'] == "TIME_OUT") {
                        return _errorMessage('Los resultados están tomando un poco más de tiempo en llegar, vuelve a intentarlo');
                      } else {
                        return _errorMessage('Hubo un error en cargar los resultados, vuelve a intentarlo');
                      }
                    }

                  }
                }
              )
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _errorMessage(String message) {

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          Icon(
            Ionicons.alert_circle_outline,
            color: Colors.red.shade400,
            size: 45.0
          ),
          const SizedBox(height: 15.0),
          Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: 'TypoGrotesk',
              fontSize: 16.0
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _resultList(Map<String, dynamic> response) {

    ImageModel imageModel = response['body'];

    int size = imageModel.data.length;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.55,
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: size, 
          itemBuilder: (_, int index) {
            return ResultWidget(
              onPressed: () {
                Helpers.showMessage("Acción detalle", context);
              },
              title: imageModel.data[index].title,
              urlImage: imageModel.data[index].images.original.url,
            );
          }
        ),
      ),
    );
  }
  
  Widget _loading() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.55,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: 3,
        itemBuilder: (_, int index) {
          return _skeleton();
        }
      ),
    );
  }

  Widget _skeleton() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20.0, left: 20.0, right: 20.0),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.2,
      decoration: BoxDecoration(
        color: lightGrayColor,
        borderRadius: BorderRadius.circular(15.0),
        border: Border.all(color: lightGrayColor2),
      ),
      padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10.0),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SkeletonAnimation(
                shimmerDuration: 1000,
                curve: Curves.easeInQuad,
                borderRadius: BorderRadius.circular(5.0),
                shimmerColor: Colors.grey.withOpacity(0.2),
                child: Container(
                  height: 117.0,
                  width: 130.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      color: Colors.grey.withOpacity(0.3)),
                ),
              ),
              const SizedBox(width: 20.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20.0),
                  SkeletonAnimation(
                    shimmerDuration: 1000,
                    curve: Curves.easeInQuad,
                    borderRadius: BorderRadius.circular(5.0),
                    shimmerColor: Colors.grey.withOpacity(0.2),
                    child: Container(
                      height: 16.0,
                      width: 120.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          color: Colors.grey.withOpacity(0.3)),
                    ),
                  ),
                  const SizedBox(height: 10.0,),
                  SkeletonAnimation(
                    shimmerDuration: 1000,
                    curve: Curves.easeInQuad,
                    borderRadius: BorderRadius.circular(5.0),
                    shimmerColor: Colors.grey.withOpacity(0.2),
                    child: Container(
                      height: 16.0,
                      width: 140.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          color: Colors.grey.withOpacity(0.3)),
                    ),
                  ),
                  const SizedBox(height: 10.0,),
                  SkeletonAnimation(
                    shimmerDuration: 1000,
                    curve: Curves.easeInQuad,
                    borderRadius: BorderRadius.circular(5.0),
                    shimmerColor: Colors.grey.withOpacity(0.2),
                    child: Container(
                      height: 16.0,
                      width: 100.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          color: Colors.grey.withOpacity(0.3)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}