import 'package:flutter/material.dart';
import 'combination.dart';

class User {
  String id;
  String nickname;
  String imageUrl;
  String description;
  List<Combination> combinations;

  User(this.id, this.nickname, this.imageUrl, this.description, this.combinations);
}