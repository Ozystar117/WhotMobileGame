import 'package:flame/components.dart';
import 'package:whot_game/decks/player_deck.dart';

import '../components/card.dart';
import '../game.dart';

class AIDeck extends PlayerDeck{
  @override
  int get turn => 2;

  // @override
  // Vector2 get fanOffset => Vector2(WhotGame.cardWidth * 0.01, 0);

  /*
    * Accept the card and flip it
    * super.acceptCard() flips the card to display the front
      however, by flipping it here again, the back of the card will be rendered
  */
  // @override
  // void acceptCard(Card card) {
  //   super.acceptCard(card);
  //   card.flip();
  // }

}