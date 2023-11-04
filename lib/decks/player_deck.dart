
import 'dart:ui';

import 'package:whot_game/cardInfo.dart';
import 'package:whot_game/components/card.dart';
import 'package:whot_game/decks/deck.dart';
import 'package:whot_game/decks/game_deck.dart';
import 'package:whot_game/decks/market_deck.dart';
import 'package:whot_game/gameplay_manager.dart';

class PlayerDeck extends Deck{

  late int turn = 1;


  @override
  void sendCard(Card card, Deck newDeck) {
    // prevent the player deck from sending cards to the market deck
    if(newDeck is MarketDeck || GameplayManager.turn != turn){
      returnCardToPosition(card);
      return;
    }else if(newDeck is GameDeck){

      if(newDeck.cards.isEmpty){
        returnCardToPosition(card);
        return;
      }

      Card topCard = newDeck.cards.last;

      if(topCard.cardInfo.number == card.cardInfo.number
          || topCard.cardInfo.shape == card.cardInfo.shape){
        super.sendCard(card, newDeck);

        GameplayManager.updateTurn();
        return;
      }

    }

    returnCardToPosition(card);
  }

  @override
  bool acceptCard(Card card) {
    if(GameplayManager.turn != turn) return false;
    GameplayManager.updateTurn();
    return super.acceptCard(card);
  }

  @override
  void render(Canvas canvas) {
    if(GameplayManager.turn == turn){
      isActive = true;
    }else{
      isActive = false;
    }
    super.render(canvas);
  }
}