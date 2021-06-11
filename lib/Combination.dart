import 'package:amazing_combination/controllers/AuthenticationController.dart';
import 'package:amazing_combination/controllers/UserController.dart';
import 'package:amazing_combination/models/Brand.dart';
import 'package:amazing_combination/widgets/CombinationListBrand.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:amazing_combination/widgets/combinationAdd.dart';

class CombinationPage extends StatelessWidget {
  const CombinationPage({Key key, @required this.brand}) : super(key: key);

  final Brand brand;


  @override
  Widget build(BuildContext context) {
    print('combination page: ' + brand.name);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('조합'),
      ),
      body: Column(
        children: [
          Image.network(
              brand.imageUrl,
            width: MediaQuery.of(context).size.height,
            height: 250,
          ),
          Expanded(
            child: CombinationListBrand(brand),
          )
        ],
      ),
      floatingActionButton: CombinationAdd(brand),

    );
  }
}