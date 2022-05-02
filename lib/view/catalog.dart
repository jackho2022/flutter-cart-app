import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cart_app/model/catalog.dart';
import '../model/cart.dart';

class CatalogPage extends StatelessWidget {
  const CatalogPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title:
                Text('Catalog', style: Theme.of(context).textTheme.headline1),
            floating: true,
            actions: [
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.pushNamed(context, '/cart');
                },
              ),
            ],
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 12)),
          SliverList(
            delegate:
                SliverChildBuilderDelegate((context, index) => ItemList(index)),
          ),
        ],
      ),
    );
  }
}

class ItemList extends StatelessWidget {
  final int index;
  const ItemList(this.index, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var item = context.select<Catalog, Item>(
      (catalog) => catalog.getById(index),
    );
    var textTheme = Theme.of(context).textTheme.headline6;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: LimitedBox(
        maxHeight: 48,
        child: Row(
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Container(
                color: item.color,
              ),
            ),
            const SizedBox(width: 24),
            Expanded(
              child: Text(item.name, style: textTheme),
            ),
            const SizedBox(width: 24),
            AddButton(item: item),
          ],
        ),
      ),
    );
  }
}

class AddButton extends StatelessWidget {
  final Item item;
  const AddButton({required this.item, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isInCart = context.select<ShoppingCart, bool>(
      (cart) => cart.items.contains(item),
    );

    return TextButton(
        onPressed: isInCart
            ? null
            : () {
                var cart = context.read<ShoppingCart>();
                cart.add(item);
              },
        child: isInCart
            ? const Icon(Icons.check, semanticLabel: 'Added')
            : const Text('Add'),
        style: ButtonStyle(
          overlayColor: MaterialStateProperty.resolveWith<Color?>((states) {
            if (states.contains(MaterialState.pressed)) {
              return Theme.of(context).primaryColor;
            }
            return null; // Defer to the widget's default.
          }),
        ));
  }
}
