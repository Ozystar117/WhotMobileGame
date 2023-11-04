import 'package:flame/camera.dart';
import 'package:whot_game/decks/ai_deck.dart';
import 'package:whot_game/decks/game_deck.dart';
import 'package:whot_game/decks/market_deck.dart';
import 'package:whot_game/decks/player_deck.dart';
import 'package:whot_game/utility.dart';

import 'components/card.dart';
import 'decks/deck.dart';

class GameplayManager{
  final World world;
  final Deck gameDeck;
  final Deck marketDeck;
  final Deck aiDeck;
  Deck playerDeck;
  final List<Card> gameCards = Utility.getAllCards();

  static int turn = 1;

  GameplayManager({
    required this.world,
    required this.gameDeck,
    required this.marketDeck,
    required this.aiDeck,
    required this.playerDeck,
  });

  void begin(){
    world.add(gameDeck);
    world.add(marketDeck);
    world.add(aiDeck);
    world.add(playerDeck);
    world.addAll(gameCards);

    gameCards.forEach(marketDeck.acceptCard); // populate the market deck
    // playerDeck.turn = 1;
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