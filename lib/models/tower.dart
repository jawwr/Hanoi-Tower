import 'package:flutter/material.dart';

class Tower extends StatelessWidget {
  const Tower({Key? key, required this.id}) : super(key: key);

  final int id;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 40,
          height: size.height - 200,
          decoration: const BoxDecoration(
              color: Colors.brown,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                topLeft: Radius.circular(20),
              )),
        ),
        Container(
          height: 20,
          decoration: const BoxDecoration(
              color: Colors.brown,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5),
                topRight: Radius.circular(5),
              )),
        ),
      ],
    );
  }
}