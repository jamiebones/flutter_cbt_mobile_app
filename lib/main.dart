import 'package:cbt_app/redux/store.dart';
import 'package:cbt_app/ui/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

void main() async {
  Redux.init();
  runApp(StoreProvider<AppState>(
      store: Redux.store, child: MaterialApp(home: Home())));
}
