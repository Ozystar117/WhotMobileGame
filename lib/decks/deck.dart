import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/cupertino.dart';
import 'package:whot_game/decks/game_deck.dart';
import 'package:whot_game/game.dart';

import '../components/card.dart';

abstract class Deck extends PositionComponent{

  List<Card> cards = [];
  bool isActive = false;
  bool useEffect = true;

  late final borderPaint = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 10
    ..color = const Color(0x50ffffff);

  final activeBorderPaint = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 10
    ..color = const Color(0xffd5e8d4);

  static final Paint backBackgroundPaint = Paint()
    ..color = const Color(0x10ffffff);

  final Vector2 fanOffset = Vector2(WhotGame.cardWidth * 0.25, 0);

  RRect getDeckRRect(){
    return RRect.fromRectAndRadius(
      size.toRect(),
      const Radius.circular(WhotGame.cardRadius),
    );
  }

  /*
   * Add a card to the list of cards in the deck and align the position of the
     added card with the deck
   */
  bool acceptCard(Card card){
    positionCard(card);

    cards.add(card);
    card.deck = this;
    if(!card.isFaceUp) card.flip();
    card.priority = cards.length-1;

    // positionAllCards();

    return true;
  }

  /// Send a card to a new deck
  /// If the card is NOT sent successfully, return it to its position
  void sendCard(Card card, Deck newDeck){
    if(newDeck.acceptCard(card)){
      cards.remove(card);

      positionAllCards(); // adjust the position of the remaining cards

    }else{
      returnCardToPosition(card);
    }

  }

  /// Return a dragged card to its previous position in the UI
  void returnCardToPosition(Card card){
    final index = cards.indexOf(card);
    card.position =
    index == 0 ? position : cards[index - 1].position + fanOffset;
    card.priority = index;
  }

  void renderCards(Canvas canvas){
    for(Card card in cards){
      card.render(canvas);
    }
  }

  List<Card> removeAllCards(){
    final temp = cards.toList();
    cards.clear();
    return temp;
  }

  void positionCard(Card card){
    // card.add(MoveEffect.to(position, EffectController(duration: 0.5)));
    if (cards.isEmpty) {
      if(useEffect) {
        card.add(MoveEffect.to(position, EffectController(duration: 0.5)));
      }else {
        card.position = position;
      }
    } else {
      if(useEffect) {
        card.add(MoveToEffect(
            cards.last.position + fanOffset, EffectController(duration: WhotGame.cardSpeedMilliseconds / 1000)));
      }else {
        card.position = cards.last.position + fanOffset;
      }
    }
  }

  void positionAllCards(){
    for(int i = 0; i < cards.length; i++){
      returnCardToPosition(cards.elementAt(i));
    }
  }

  @override
  void render(Canvas canvas) {
    if(!isActive) {
      canvas.drawRRect(getDeckRRect(), borderPaint); // default border
    } else {
      canvas.drawRRect(getDeckRRect(), activeBorderPaint); // active border
    }

    canvas.drawRRect(getDeckRRect(), backBackgroundPaint); // background
  }


}