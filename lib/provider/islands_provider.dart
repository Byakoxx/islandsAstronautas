import 'package:flutter/material.dart';

class IslandsProvider extends ChangeNotifier {

  List<List<int>> _grid = [];
  Map<int, List<int>> primerGrid = {};
  
  TextEditingController widthController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  int _counterIslands = 0, _navigatorIndex = 0;
  bool _isGenerated = false;
  String _query = 'Astronautas';


  set isGenerated(bool isGenerated)  {
    _isGenerated = isGenerated;
    notifyListeners();
  }

  bool get isGenerated => _isGenerated;

  set query(String query)  {
    _query = query;
    notifyListeners();
  }

  String get query => _query;

  set counterIslands(int counterIslands)  {
    _counterIslands = counterIslands;
    notifyListeners();
  }

  int get counterIslands => _counterIslands;

  set navigatorIndex(int navigatorIndex)  {
    _navigatorIndex = navigatorIndex;
    notifyListeners();
  }

  int get navigatorIndex => _navigatorIndex;


  set grid(List<List<int>> grid)  {
    _grid = grid;
    primerGrid = grid.asMap();
    notifyListeners();
  }

  List<List<int>> get grid => _grid;

}