import 'package:flutter/foundation.dart';
import 'package:cart_app/model/catalog.dart';

class ShoppingCart extends ChangeNotifier {
  late Catalog _catalog;
  final List<int> _itemIds = [];

  Catalog get catalog => _catalog;

  set catalog(Catalog _catalog) {
    this._catalog = _catalog;
    notifyListeners();
  }

  List<Item> get items => _itemIds.map((id) => _catalog.getById(id)).toList();

  int get totalPrice =>
      items.fold(0, (total, current) => total + current.price);

  void add(Item item) {
    _itemIds.add(item.id);
    notifyListeners();
  }

  void remove(Item item) {
    _itemIds.remove(item.id);
    notifyListeners();
  }
}
