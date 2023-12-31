
import 'package:flame/camera.dart';
import 'package:whot_game/decks/ai_deck.dart';
import 'package:whot_game/decks/game_deck.dart';
import 'package:whot_game/decks/market_deck.dart';
import 'package:whot_game/decks/player_deck.dart';
import 'package:whot_game/game.dart';
import 'package:whot_game/utility.dart';

import 'components/card.dart';
import 'decks/deck.dart';

class GameplayManager{
  final World world;
  final Deck gameDeck;
  final Deck marketDeck;
  final Deck aiDeck;
  PlayerDeck playerDeck;
  final List<Card> gameCards = Utility.getAllCards();

  static int turn = 1;

  GameplayManager({
    required this.world,
    required this.gameDeck,
    required this.marketDeck,
    required this.aiDeck,
    required this.playerDeck,
  });

  Future<void> begin() async {
    world.add(gameDeck);
    world.add(marketDeck);
    world.add(aiDeck);
    world.add(playerDeck);
    world.addAll(gameCards);

    marketDeck.useEffect = false;

    gameCards.forEach(marketDeck.acceptCard); // populate the market deck

    marketDeck.useEffect = true;

    // share 5 cards each
    for(int i = 0; i < 10; i++){
      if(turn == playerDeck.turn){
        marketDeck.sendCard(marketDeck.cards.last, playerDeck);
      }else{
        marketDeck.sendCard(marketDeck.cards.last, aiDeck);
      }
      await Future.delayed(const Duration(milliseconds: WhotGame.cardSpeedMilliseconds));
    }

    // initial game card
    marketDeck.sendCard(marketDeck.cards.last, gameDeck);
  }

  static void updateTurn(){
    if(turn > 1) {
      turn = 1;
    } else {
      turn++;
    }
    // notify players
  }
}