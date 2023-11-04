
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:whot_game/game.dart';

class BackGround extends PositionComponent{
  static final Paint backBackgroundPaint = Paint()
    ..color = const Color(0x50ffffff);

  RRect getRRect(){
    return RRect.fromRectAndRadius(
        Vector2(size.x, size.y).toRect(),
        const Radius.circular(100)
    );
  }

  @override
  void render(Canvas canvas) {
    canvas.drawRRect(getRRect(), backBackgroundPaint);
  }
}