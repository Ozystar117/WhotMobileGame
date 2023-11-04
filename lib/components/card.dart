 import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/extensions.dart';
import 'package:whot_game/cardInfo.dart';
import 'package:whot_game/decks/game_deck.dart';
import 'package:whot_game/decks/market_deck.dart';
import 'package:whot_game/game.dart';

import '../decks/deck.dart';

class Card extends PositionComponent with DragCallbacks{
  Card({required this.cardInfo}): super(size: WhotGame.cardSize);

  Deck? deck;

  late final cardRRect = getRRect();
  late final RRect frontBorderRRect = cardRRect.deflate(10);
  late final RRect backBorderRRect = cardRRect.deflate(50);

  bool isFaceUp = true;

  static final Paint frontBackgroundPaint = Paint()
    ..color = const Color(0xfff5f5f5);

  static final Paint backBackgroundPaint = Paint()
    ..color = const Color(0xff432D57);

  static final Paint borderPaint = Paint()
    ..color = const Color(0xffFFE6CC)
    ..style = PaintingStyle.stroke
    ..strokeWidth = 20;






  final CardInfo cardInfo;


  RRect getRRect(){
    return RRect.fromRectAndRadius(
      size.toRect(),
      const Radius.circular(WhotGame.cardRadius)
    );
  }

  void flip(){
    isFaceUp = !isFaceUp;
  }

  @override
  void render(Canvas canvas) {
    if(isFaceUp){
      canvas.drawRRect(cardRRect, frontBackgroundPaint);
      canvas.drawRRect(frontBorderRRect, borderPaint); // border
      cardInfo.render(canvas, size, isFaceUp);
    }else{
      canvas.drawRRect(cardRRect, backBackgroundPaint);
      canvas.drawRRect(frontBorderRRect, borderPaint); // border
      cardInfo.render(canvas, size, isFaceUp);
    }
  }

  @override
  String toString() {
    return "${cardInfo.shape} - ${cardInfo.number}";
  }

  @override
  void onDragStart(DragStartEvent event) {
    if(deck is GameDeck) return;
    super.onDragStart(event); // set isDragged to true
    priority = 100;
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    if(!isDragged) return;

    final cameraZoom = findGame()!.children
        .whereType<CameraComponent>()
        .where((camera) => camera != findGame()!.camera) // not default camera
        .first.viewfinder.zoom;

    position += event.delta / cameraZoom;
  }

  @override
  void onDragEnd(DragEndEvent event) {
    if(!isDragged) return;
    super.onDragEnd(event);

    final decksAtDropPoint = parent!
        .componentsAtPoint(position + size/2)
        .whereType<Deck>()
        .toList();

    if(decksAtDropPoint.isNotEmpty && decksAtDropPoint.first.runtimeType != deck!.runtimeType) {
      deck!.sendCard(this, decksAtDropPoint.first);
    }else{
      deck!.returnCardToPosition(this);
    }
  }
}