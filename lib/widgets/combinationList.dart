
import 'package:flutter/material.dart';

class CombinationList extends StatelessWidget {
  const CombinationList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context, int index) => Combination(context, index),
        separatorBuilder: (context, int index) => const Divider(),
        itemCount: 10
    );
  }
}

Widget Combination(BuildContext context, int index) {
  // TODO: Indicate 1st & 2nd most favorite combination
  return ListTile(
    leading: Icon(Icons.fastfood),
    title: Text('combination name $index'),
    subtitle: Text('menu 1 + menu 2'),
    trailing: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Column(
          children: [
            Icon(Icons.favorite, color: Colors.red,),
            Text('11'),
          ],
        ),
        Column(
          children: [
            Icon(Icons.star, color: Colors.yellow),
            Text('22'),
          ],
        )
      ],
    ),
  );
}