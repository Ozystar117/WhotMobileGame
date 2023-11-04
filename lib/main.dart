
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:whot_game/game.dart';

void main(){

  final game = WhotGame();
  runApp(GameWidget(game: game));
}