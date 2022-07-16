import 'package:flutter/material.dart';
import 'package:Islands/helpers/helpers.dart';
import 'package:Islands/provider/islands_provider.dart';
import 'package:Islands/widget/matrix_widget.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final islandsProvider = Provider.of<IslandsProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ListView(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            children: [
              SizedBox(height: islandsProvider.isGenerated ? 30.0 : 0.0),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: const Color.fromARGB(255, 49, 49, 49),
                    shape: const StadiumBorder()
                  ),
                  onPressed: () => Helpers.modalGenerate(islandsProvider, context),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text( 
                      islandsProvider.isGenerated ? 'Generar nueva matriz' : 'Generar matriz', 
                      style: const TextStyle(
                        fontFamily: 'TypoGrotesk',
                        color: Colors.white,
                        fontSize: 16.0,
                        fontWeight: FontWeight.normal
                      )
                    ),
                  ),
                ),
              ),
              islandsProvider.isGenerated ? Column(
                children: <Widget>[
                  const SizedBox(height: 30.0),
                  Text(
                    'El número de Islas es ${islandsProvider.counterIslands}',
                    style: TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: 18.0
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: islandsProvider.isGenerated ? 20.0 : 0.0,),
                  islandsProvider.isGenerated ? const Divider() : const SizedBox(),
                ],
              ) : const SizedBox(),
              islandsProvider.isGenerated ? const Matrix() : const SizedBox(),
            ],
          ),
        ),
      )
    );
  }
}