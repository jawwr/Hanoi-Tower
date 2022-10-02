import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hanoi/models/tower.dart';
import 'package:hanoi/stack.dart';

import 'ring.dart';


class HanoiTower extends StatefulWidget {
  MyStack<Ring> rings;
  final int id;

  HanoiTower({Key? key, required this.rings, required this.id})
      : super(key: key);

  @override
  State<HanoiTower> createState() => _HanoiTowerState();
}

class _HanoiTowerState extends State<HanoiTower> {
  late List<Ring> rings;
  late final int id;

  @override
  void initState() {
    super.initState();
    rings = widget.rings.elements;
    id = widget.id;
    Timer.periodic(const Duration(milliseconds: 50), (timer) {//таймер на каждой башне чтобы чекать изменения и сразу отображать (без этого обновление башен происходит с дикой задержкой)
      setState(() {
        rings = widget.rings.elements;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: 400,
      height: size.height - 100,
      child: Stack(
        children: [
          Tower(id: id),
          Container(
            margin: const EdgeInsets.only(bottom: 20),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: rings,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
