import 'dart:collection';
import 'dart:math';

import 'package:flutter/material.dart';

import '../provider/islands_provider.dart';

class Helpers {

  static List<List<int>> directions = [[-1, 0], [0, -1], [1, 0], [0, 1]];

  // Direcciones para poder calcular las 8 posiciones y validar si hay que anexar a la isla
  // static List<List<int>> directions = [[-1, 0], [0, -1], [1, 0], [0, 1], [-1, -1], [1, 1], [-1, 1], [1, -1]];

  static modalGenerate(IslandsProvider islandsProvider, BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => buildAlertDialog(context, islandsProvider),
    );
  }

  static buildAlertDialog(BuildContext context, IslandsProvider islandsProvider) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: AlertDialog(
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(32.0))),
        title: SizedBox(
          width: MediaQuery.of(context).size.width * 10,
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  IconButton(
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      icon: const Icon(Icons.close, color: Colors.black),
                      onPressed: () => Navigator.of(context).pop(),
                      iconSize: 25.0)
                ],
              ),
              const Text(
                "Ingresa los valores",
                style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.brown,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Column(
                  children: [
                    TextField(
                      showCursor: true,
                      style: const TextStyle(
                        fontSize: 14.0,
                        color: Colors.black54,
                      ),
                      keyboardType: TextInputType.number,
                      decoration: decoration('Ancho'),
                      cursorColor: Colors.grey.shade500,
                      controller: islandsProvider.widthController,
                      onEditingComplete: () => FocusScope.of(context).unfocus(),
                    ),
                    const SizedBox(height: 20.0),
                    TextField(
                      showCursor: true,
                      style: const TextStyle(
                        fontSize: 14.0,
                        color: Colors.black54,
                      ),
                      keyboardType: TextInputType.number,
                      decoration: decoration('Alto'),
                      cursorColor: Colors.grey.shade500,
                      controller: islandsProvider.heightController,
                      onEditingComplete: () => FocusScope.of(context).unfocus(),
                    ),
                  ],
                )
              ),
              const SizedBox(height: 15.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.black,
                  shape: const StadiumBorder()
                ),
                onPressed: () => _validateInputs(islandsProvider, context),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: const Text("Generar",
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.white,
                      fontWeight: FontWeight.normal
                    ),
                    textAlign: TextAlign.center
                  )
                )
              ),
            ],
          ),
        ),
      ),
    );
  }

  static _validateInputs(IslandsProvider islandsProvider, BuildContext context) {

    bool regexHeight  = !RegExp(r"^[0-9]+$").hasMatch(islandsProvider.heightController.text);
    bool widthHeight  = !RegExp(r"^[0-9]+$").hasMatch(islandsProvider.widthController.text);

    late bool minHeight;
    late bool minWidth;

    try {

      minHeight   = int.parse(islandsProvider.heightController.text) > 0;
      minWidth    = int.parse(islandsProvider.widthController.text) > 0;

    } catch (e) {

      minHeight   = false;
      minWidth    = false;

    }

    if(islandsProvider.heightController.text.isEmpty || islandsProvider.widthController.text.isEmpty) {
      showError("Debes ingresar los valores", islandsProvider, context);
    } else if( regexHeight || widthHeight ) {
      showError("Debes ingresar valores válidos", islandsProvider, context);
    } else if(!minHeight || !minWidth) {
      showError("Debes ingresar valores mayores a 0", islandsProvider, context);
    } else  {
      List<int> interior = [];
      List<List<int>> callback = [];
      int max = 2;

      for(int i = 0; i < int.parse(islandsProvider.heightController.text); i++) {
        for(int j = 0; j < int.parse(islandsProvider.widthController.text); j++) {
          interior.add(Random().nextInt(max));
        }
        callback.add([...interior]);

        interior.clear();
      }

      Navigator.of(context).pop();

      islandsProvider.heightController.text = '';
      islandsProvider.widthController.text = '';

      islandsProvider.grid = callback;

      generateMatrix(islandsProvider);
    }
  }

  static bool check(int x, int y, int n, int m) {
    return (((x >= 0) && (y >= 0)) && (x < n)) && (y < m);
  }

  static void difference(List<List<int>> grid, List<List<bool>> visited, int x, int y, int n, int m) {
    if (((!check(x, y, n, m)) || (grid[x][y] == 0)) || (visited[x][y] == true)) {
        return;
    }
    visited[x][y] = true;

    /// i < 8, para las 8 validaciones si en diagonales suma tambien
    for (int i = 0; i < 4; i++) {
        int x1 = (x + directions[i][0]);
        int y1 = (y + directions[i][1]);
        difference(grid, visited, x1, y1, n, m);
    }
  }

  static int numIslands(IslandsProvider islandsProvider) {

    int ans = 0;
    int n = islandsProvider.grid.length;
    int m = islandsProvider.grid[0].length;
    List<List<bool>> visited = _getVisited(islandsProvider.grid);
    for (int i = 0; i < n; i++) {
      for (int j = 0; j < m; j++) {
        if ((visited[i][j] == false) && (islandsProvider.grid[i][j] == 1)) {
          ans++;
          difference(islandsProvider.grid, visited, i, j, n, m);
        }
      }
    }
    return ans;
  } 

  static List<List<bool>> _getVisited(List<List<int>> grid) {
    List<List<bool>> callback = [];

    List<bool> interior = [];

    int n = grid.length;
    int m = grid[0].length;

    for(int i = 0; i < n; i++) {
      for(int j = 0; j < m; j++) {
        interior.add(grid[i][j] == 0 ? true : false);
      }

      callback.add([...interior]);

      interior.clear();
    }

    return callback;
  }

  static void generateMatrix(IslandsProvider islandsProvider) {

    islandsProvider.counterIslands = numIslands(islandsProvider);
    islandsProvider.isGenerated = true;

  }

  static decoration(String hintText) {
    return InputDecoration(
      hintText: hintText,
      border: OutlineInputBorder(
        borderRadius:BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.grey.shade600),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius:BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.green.shade600),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius:BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.grey.shade600),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius:BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.grey.shade600),
      ),
      fillColor: Colors.grey.shade50,
      filled: true,
      isDense: true,
      contentPadding: const EdgeInsets.all(15), // Added this
    );
  }
  
  static void showError(String message, IslandsProvider islandsProvider, BuildContext context) {
    final snackBar = SnackBar(
      content: Text(message, style: const TextStyle(fontSize: 16.0)),
    );

    Navigator.of(context).pop();

    islandsProvider.heightController.text = '';
    islandsProvider.widthController.text = '';

    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  static void showMessage(String message, BuildContext context) {
    final snackBar = SnackBar(
      content: Text(message, style: const TextStyle(fontSize: 16.0)),
    );

    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}