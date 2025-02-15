// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import '../widgets/hearts_animation.dart';

class FloatingHeartsProvider with ChangeNotifier {
  final List<Widget> _hearts = <Widget>[];
  int _key = 0;

  List<Widget> get hearts => _hearts;

  void addHeart() {
    _hearts.addAll([
      HeartAnimation(key: Key((_key + 1).toString())),
      HeartAnimation(key: Key((_key + 2).toString())),
      HeartAnimation(key: Key((_key + 3).toString()))
    ]);
    _key += 3;
    notifyListeners();
  }

  void removeHeart(Key? key) {
    _hearts.clear();
  }
}
