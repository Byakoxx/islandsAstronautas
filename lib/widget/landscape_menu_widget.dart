import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/islands_provider.dart';
import '../utils/colors.dart';

class LandscapeMenu extends StatelessWidget {
  const LandscapeMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final islandsProvider = Provider.of<IslandsProvider>(context);
    return SizedBox(
      height: 45.0,
      child: SingleChildScrollView(
        // shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        child:
          Row(
            children: [
              const SizedBox(width: 20.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: islandsProvider.query == "Astronautas" ? orangeColor : whiteColor,
                  shape: const StadiumBorder()
                ),
                onPressed: () => islandsProvider.query = 'Astronautas',
                child: Text(
                  'Astronautas',
                  style: TextStyle(
                    color: islandsProvider.query == "Astronautas" ? whiteColor : blackColor
                  ),
                )
              ),
              const SizedBox(width: 15.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: islandsProvider.query == "Happy Hours" ? orangeColor : whiteColor,
                  shape: const StadiumBorder()
                ),
                onPressed: () => islandsProvider.query = 'Happy Hours',
                child: Text(
                  'Happy Hours',
                  style: TextStyle(
                    color: islandsProvider.query == "Happy Hours" ? whiteColor : blackColor
                  ),
                )
              ),
              const SizedBox(width: 15.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: islandsProvider.query == "Drinks" ? orangeColor : whiteColor,
                  shape: const StadiumBorder()
                ),
                onPressed: () => islandsProvider.query = 'Drinks',
                child: Text(
                  'Drinks',
                  style: TextStyle(
                    color: islandsProvider.query == "Drinks" ? whiteColor : blackColor
                  ),
                )
              ),
              const SizedBox(width: 15.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: islandsProvider.query == "Beer" ? orangeColor : whiteColor,
                  shape: const StadiumBorder()
                ),
                onPressed: () => islandsProvider.query = 'Beer',
                child: Text(
                  'Beer',
                  style: TextStyle(
                    color: islandsProvider.query == "Beer" ? whiteColor : blackColor
                  ),
                )
              ),
              const SizedBox(width: 15.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: islandsProvider.query == "Restaurant" ? orangeColor : whiteColor,
                  shape: const StadiumBorder()
                ),
                onPressed: () => islandsProvider.query = 'Restaurant',
                child: Text(
                  'Restaurant',
                  style: TextStyle(
                    color: islandsProvider.query == "Restaurant" ? whiteColor : blackColor
                  ),
                )
              ),
              const SizedBox(width: 20.0),
            ],
          ),
      ),
    );
    
  }
}