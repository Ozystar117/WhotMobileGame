
import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/services.dart';
import 'package:whot_game/cardInfo.dart';
import 'package:whot_game/components/background.dart';
import 'package:whot_game/components/card.dart';
import 'package:whot_game/decks/ai_deck.dart';
import 'package:whot_game/decks/game_deck.dart';
import 'package:whot_game/decks/market_deck.dart';
import 'package:whot_game/decks/player_deck.dart';
import 'package:whot_game/gameplay_manager.dart';
import 'package:whot_game/utility.dart';

import 'decks/deck.dart';

class WhotGame extends FlameGame{
  double gameWidth = 0;
  double gameHeight = 0;
  static const double cardWidth = 1100;
  static const double cardHeight = 1400;
  static const double cardRadius = 100;
  static const double margin = 200;

  static final Vector2 cardSize = Vector2(cardWidth, cardHeight);
  late final Vector2 gameSize;

  late final GameplayManager gameplayManager;

  

  @override
  Future<void> onLoad() async{
    await Flame.device.setLandscapeLeftOnly();

    await Future.delayed(const Duration(seconds: 1)); // wait for 1s for the flamegame.size to be updated

    // see notes.txt for resizing on ipad

    gameWidth = size.x * 10;
    gameHeight = size.y * 10;
    gameSize = Vector2(gameWidth, gameHeight);


    // print(gameSize);
    await Flame.images.load('card-sprites3.png');
    await FlameAudio.audioCache.loadAll(['flipcard.mp3', 'button.mp3']);

    BackGround backGround = BackGround()
      ..y = (margin/2)
      ..size = gameSize;
    Deck marketDeck = MarketDeck()
      ..size = cardSize
      ..x = margin
      ..y = margin;
    Deck gameDeck = GameDeck()
      ..size = Vector2(cardWidth * 3, cardHeight)
      ..x = gameWidth-((cardSize.x * 6) + margin)
      ..y = margin;
    Deck aiDeck = AIDeck()
      ..size = cardSize
      ..x = (gameDeck.x + gameDeck.width) + (cardSize.x + (margin/2))
      ..y = margin;
    PlayerDeck playerDeck = PlayerDeck()
      ..size = Vector2(gameWidth-(margin*2), cardHeight)
      ..x = margin
      ..y = gameHeight - (cardHeight + margin);

    // List<Card> gameCards = Utility.getAllCards();

    final world = World()
      ..add(backGround);
      // ..add(gameDeck)
      // ..add(marketDeck)
      // ..add(playerDeck)
      // ..add(aiDeck)
      // ..addAll(gameCards);
    add(world);

    final camera = CameraComponent(world: world)
      ..viewport.size = Vector2(gameWidth, gameHeight)
    // ..viewfinder.visibleGameSize = Vector2(gameWidth*1.1, gameHeight*1.1) // zoom out
    // ..viewfinder.visibleGameSize = Vector2(gameWidth/1.1, gameHeight/1.1) // zoom in
      ..viewfinder.visibleGameSize = Vector2(gameWidth, gameHeight) // normal zoom
      ..viewfinder.position = Vector2(gameWidth/2, 0)
      ..viewfinder.anchor = Anchor.topCenter;
    add(camera);

    // gameCards.forEach(marketDeck.acceptCard);
    gameplayManager = GameplayManager(world: world, gameDeck: gameDeck, marketDeck: marketDeck, aiDeck: aiDeck, playerDeck: playerDeck);
    gameplayManager.begin();
  }

  static Sprite whotSprite(double x, double y, double width, double height) {
    return Sprite(
      Flame.images.fromCache('card-sprites3.png'),
      srcPosition: Vector2(x, y),
      srcSize: Vector2(width, height),
    );
  }

  // static void playAudio(String audioFile){
  //
  // }
}