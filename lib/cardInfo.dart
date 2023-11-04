
import 'dart:ui';

import 'package:flame/components.dart';

import 'components/card.dart';
import 'game.dart';

class CardInfo{
  final int number;
  final String shape;
  late final Sprite shapeSprite;
  late final Sprite whotSprite;

  late final List<Sprite> numberSprites;

  CardInfo({required this.number, required this.shape}){
    shapeSprite = getShapeSprite();
    numberSprites = getNumberSprite();
    whotSprite = getWhotSprite();
  }

  getWhotSprite(){
    return WhotGame.whotSprite(6, 319, 191, 55);
  }

  getShapeSprite(){
    switch(shape.toLowerCase().trim()){
      case "square":
        return WhotGame.whotSprite(0, 0, 81, 80);
      case "circle":
        return WhotGame.whotSprite(120, 0, 81, 80);
      case "triangle":
        return WhotGame.whotSprite(240, 0, 81, 80);
      case "star":
        return WhotGame.whotSprite(360, 0, 81, 81);
      case "cross":
        return WhotGame.whotSprite(480, 0, 81, 80);
    }
    return WhotGame.whotSprite(0, 0, 81, 81);
  }

  getNumberSprite(){
    switch(number){
      case 1:
        return [WhotGame.whotSprite(26, 131, 25, 52)];
      case 2:
        return [WhotGame.whotSprite(142, 131, 35, 52)];
      case 3:
        return [WhotGame.whotSprite(252, 132, 34, 52)];
      case 4:
        return [WhotGame.whotSprite(378, 131, 41, 52)];
      case 5:
        return [WhotGame.whotSprite(531, 131, 37, 54)];
      case 7:
        return [WhotGame.whotSprite(19, 222, 41, 53)];
      case 8:
        return [WhotGame.whotSprite(141, 222, 36, 52)];
      case 10:
        return [WhotGame.whotSprite(26, 131, 25, 52), WhotGame.whotSprite(270, 221, 40, 53)];
      case 11:
        return [WhotGame.whotSprite(26, 131, 25, 52), WhotGame.whotSprite(26, 131, 25, 52)];
      case 12:
        return [WhotGame.whotSprite(26, 131, 25, 52), WhotGame.whotSprite(142, 131, 35, 52)];
      case 13:
        return [WhotGame.whotSprite(26, 131, 25, 52), WhotGame.whotSprite(252, 132, 34, 52)];
      case 14:
        return [WhotGame.whotSprite(26, 131, 25, 52), WhotGame.whotSprite(378, 131, 41, 52),];


    }
    return WhotGame.whotSprite(0, 0, 81, 81);
  }



  void drawSprite(Canvas canvas, Sprite sprite, double relativeX, double relativeY, Vector2 size, {double scale = 1}){
    sprite.render(
      canvas,
      position: Vector2(relativeX * size.x, relativeY * size.y),
      anchor: Anchor.center,
      size: sprite.srcSize.scaled(scale),
    );
  }

  void render(Canvas canvas, Vector2 size, bool isFaceUp){
    if(isFaceUp){
      drawSprite(canvas, shapeSprite, 0.5, 0.5, size, scale: 7); // large shape
      drawSprite(canvas, shapeSprite, 0.15, 0.2, size, scale: 2); // small shape at top-left
      drawSprite(canvas, shapeSprite, 0.9, 0.8, size, scale: 2); // small shape at bottom-right
      for (int i = 0; i < numberSprites.length; i++) {
        drawSprite(canvas, numberSprites.elementAt(i), 0.1 + (i * 0.06), 0.1, size, scale: 2); // small number(s) at top-left
      }
      for (int i = 0; i < numberSprites.length; i++) {
        drawSprite(canvas, numberSprites.elementAt(i), 0.85 + (i * 0.06), 0.9, size, scale: 2); // small number(s) at bottom-right
      }
    }else{
      drawSprite(canvas, whotSprite, 0.5, 0.5, size, scale: 3);
    }
  }

}