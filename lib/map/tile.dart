import 'dart:ui';

import 'package:bonfire/util/objects/sprite_object.dart';
import 'package:flame/position.dart';
import 'package:flame/sprite.dart';
import 'package:flame/text_config.dart';
import 'package:flutter/material.dart';

class Tile extends SpriteObject {
  final bool collision;
  final double size;
  TextConfig _textConfig;
  Position _positionText;
  Paint _paintText = Paint()
    ..color = Colors.lightBlueAccent.withOpacity(0.5)
    ..style = PaintingStyle.stroke
    ..strokeWidth = 1;

  Tile(String spritePath, Position initPosition,
      {this.collision = false, this.size = 32}) {
    position = positionInWorld = Rect.fromLTWH(
      (initPosition.x * size) - (initPosition.x % 2 == 0 ? 0.5 : 0),
      (initPosition.y * size) - (initPosition.y % 2 == 0 ? 0.5 : 0),
      size + (initPosition.x % 2 == 0 ? 1 : 0),
      size + (initPosition.y % 2 == 0 ? 1 : 0),
    );
    if (spritePath.isNotEmpty) sprite = Sprite(spritePath);

    _textConfig = TextConfig(
      fontSize: size / 3.5,
      color: Colors.lightBlueAccent.withOpacity(0.4),
    );
    _positionText = Position(initPosition.x, initPosition.y);
  }

  Tile.fromSprite(Sprite sprite, Position initPosition,
      {this.collision = false, this.size = 32}) {
    this.sprite = sprite;
    position = positionInWorld = Rect.fromLTWH(
      (initPosition.x * size) - (initPosition.x % 2 == 0 ? 0.5 : 0),
      (initPosition.y * size) - (initPosition.y % 2 == 0 ? 0.5 : 0),
      size + (initPosition.x % 2 == 0 ? 1 : 0),
      size + (initPosition.y % 2 == 0 ? 1 : 0),
    );

    _textConfig = TextConfig(
      fontSize: size / 3.5,
      color: Colors.lightBlueAccent.withOpacity(0.4),
    );
    _positionText = Position(initPosition.x, initPosition.y);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    if (gameRef != null && gameRef.constructionMode) _drawGrid(canvas);
  }

  void _drawGrid(Canvas canvas) {
    canvas.drawRect(
      position,
      _paintText,
    );
    _textConfig.render(
      canvas,
      '${_positionText.x.toInt()}:${_positionText.y.toInt()}',
      Position(position.left + 2, position.top + 2),
    );
  }
}
