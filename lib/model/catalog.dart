import 'package:flutter/material.dart';

class Catalog {
  List<String> items = [
    'Breakfast 1',
    'Breakfast 2',
    'Breakfast 3',
    'Breakfast 4',
    'Breakfast 5',
    'Breakfast 6',
    'Breakfast 7',
    'Breakfast 8',
    'Breakfast 9',
    'Breakfast 10',
  ];

  Item getById(int id) => Item(id, items[id % items.length]);

  Item getByPosition(int position) {
    return getById(position);
  }
}

class Item {
  int id;
  String name;
  Color color;
  int price = 22;

  Item(this.id, this.name)
      : color = Colors.primaries[id % Colors.primaries.length];

  @override
  int get hashCode => id;

  @override
  bool operator ==(Object other) => other is Item && other.id == id;
}
