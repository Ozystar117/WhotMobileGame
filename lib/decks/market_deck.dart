
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:whot_game/decks/deck.dart';
import 'package:whot_game/decks/game_deck.dart';
import 'package:whot_game/decks/player_deck.dart';
import 'package:whot_game/utility.dart';

import '../components/card.dart';

class MarketDeck extends Deck with TapCallbacks{

  /// Ensure that the cards in the market are not fanned out
  @override
  Vector2 get fanOffset => Vector2(0, 0);

  @override
  bool acceptCard(Card card) {

    super.acceptCard(card);

    if(card.isFaceUp) card.flip();
    cards.shuffle();
    for(var card in cards){
      card.priority = cards.indexOf(card);
    }

    return true;

  }

  @override
  void sendCard(Card card, Deck newDeck) {
    if (newDeck is GameDeck && newDeck.cards.isNotEmpty) {
      returnCardToPosition(card);
      return;
    }
    super.sendCard(card, newDeck);
  }

  /// If the market deck is empty,
  /// transfer the cards from the game deck
  /// (except the top card) to the market deck
  @override
  void onTapUp(TapUpEvent event) {
    if(cards.isEmpty){
      final gameDeck = parent!.firstChild<GameDeck>();
      final removedCards = gameDeck!.removeAllCards();
      Card topCard = removedCards.last;
      for (var card in removedCards.reversed) {
        gameDeck.sendCard(card, this);
      }
      sendCard(topCard, gameDeck); // send back the card at the top of the game deck
    }

  }

}