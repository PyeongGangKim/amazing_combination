import 'package:flutter/material.dart';
import 'Menu.dart';
import 'Combination.dart';

class Brand {
  String name;
  List<Menu> menuList;
  List<Combination> combinations;
  String imageUrl;
  List<String> tags;
  Brand({
    this.name,
    this.menuList,
    this.combinations,
    this.imageUrl,
    this.tags,
  });
}