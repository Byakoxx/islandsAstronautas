

import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import '../utils/colors.dart';

class ResultWidget extends StatelessWidget {
  final String title;
  final void Function()? onPressed;
  final String urlImage;
  const ResultWidget({Key? key, required this.title, required this.onPressed, required this.urlImage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20.0),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.2,
      decoration: BoxDecoration(
        color: lightGrayColor,
        borderRadius: BorderRadius.circular(15.0),
        border: Border.all(color: lightGrayColor2),
      ),
      padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
      child: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            child: IconButton(
              onPressed: onPressed,
              icon: const Icon(Icons.more_horiz_outlined),
              color: Colors.grey.shade400,
            )
          ),
          Column(
            children: [
              const SizedBox(height: 15.0),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: FadeInImage.assetNetwork(
                      placeholder: 'assets/images/loading.gif',
                      image: urlImage,
                      height: 117,
                      width: 130,
                      fit: BoxFit.cover,
                    )
                  ),
                  const SizedBox(width: 20.0),
                  Flexible(
                    child: Column(
                      children: [
                        const SizedBox(height: 20.0),
                        Text(
                          title,
                          style: const TextStyle(
                            fontSize: 16.0
                          ),
                        ),
                      ],
                    )
                  ),
                ],
              ),
              const SizedBox(height: 20.0)
            ],
          ),
          Positioned(
            left: 50,
            bottom: 10,
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: whiteColor,
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: grayColor,
                      blurRadius: 10.0,
                      spreadRadius: -8,
                      offset: Offset(0.0, 10)
                  )
                ]
              ),
              padding: const EdgeInsets.all(5.0),
              child: const Icon(Ionicons.heart_sharp, color: orangeColor,)
            ),
          ),
        ],
      )
    );
    
  }
}