
import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:whot_game/decks/deck.dart';

import '../components/card.dart';
import '../game.dart';

class GameDeck extends Deck{

  @override
  Vector2 get fanOffset => Vector2(WhotGame.cardWidth * 0.02, 0);

  @override
  bool acceptCard(Card card) {
    super.acceptCard(card);
    FlameAudio.play('button.mp3');
    return true;
    // FlameAudio.play('flipcard.mp3');
  }
}