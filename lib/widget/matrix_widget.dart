

import 'package:flutter/material.dart';
import 'package:Islands/helpers/helpers.dart';
import 'package:provider/provider.dart';

import '../provider/islands_provider.dart';

class Matrix extends StatefulWidget {
  const Matrix({Key? key}) : super(key: key);


  @override
  State<Matrix> createState() => _MatrixState();
}

class _MatrixState extends State<Matrix> {
  @override
  Widget build(BuildContext context) {
    final islandsProvider = Provider.of<IslandsProvider>(context);
    return Container(  
      margin: const EdgeInsets.all(20),  
      child: Table(  
        border: TableBorder.all(  
            color: Colors.black,  
            style: BorderStyle.solid,  
            width: 0),  
        children: islandsProvider.primerGrid.entries.map((filaGrid) {
          int fila = filaGrid.key;
          Map<int, int> segundoGrid = filaGrid.value.asMap();
          return TableRow(
            children: segundoGrid.entries.map((celdaGrid) {

              int celda = celdaGrid.key;

              return GestureDetector(
                onTap: () {
                  setState(() {
                    islandsProvider.grid[fila][celda] = celdaGrid.value == 1 ? 0 : 1;
                    Helpers.generateMatrix(islandsProvider);
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: celdaGrid.value == 1 ? Colors.green.shade200 : Colors.blue.shade200
                  ),
                  alignment: Alignment.center,
                  height: 40,
                  child: Text('${celdaGrid.value}')
                )
              );
            }).toList()
          );
        } 
        ).toList()
      ),
    );
  }
}