import 'package:flutter/material.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  bool _revealMessage = false;
  double _containerWidth = 100;
  Color _shoppingBagColor = Colors.blue;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _revealMessage = !_revealMessage;
            _containerWidth = 200;
          });
        },
        child: AnimatedContainer(
            duration: const Duration(seconds: 1),
            padding: const EdgeInsets.all(10),
            width: _containerWidth,
            decoration: BoxDecoration(
                color: _shoppingBagColor,
                borderRadius: BorderRadius.circular(10)),
            child: !_revealMessage
                ? const Icon(
                    Icons.shopping_bag,
                    color: Colors.white,
                  )
                : const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.check),
                      Text("Added to cart"),
                    ],
                  )),
      ),
    );

    // } else {
    //   return Center(
    //       child: GestureDetector(
    //     onTap: () {
    //       setState(() {
    //         _revealMessage = !_revealMessage;
    //       });
    //     },
    //     child: AnimatedContainer(
    //         width: _containerWidth,
    //         duration: const Duration(
    //           milliseconds: 500,
    //         ),
    //         padding: const EdgeInsets.all(10),
    //         decoration: BoxDecoration(
    //             color: Colors.green, borderRadius: BorderRadius.circular(20)),
    //         child: const Row(
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           children: [
    //             Icon(Icons.check),
    //             Text("Added to cart"),
    //           ],
    //         )),
    //   ));
    // }
  }
}
