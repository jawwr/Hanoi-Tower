import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hanoi/models/tower.dart';

import 'ring.dart';

class HanoiTower extends StatefulWidget {
  List<Ring> rings;
  final int id;

  HanoiTower({Key? key, required this.rings, required this.id})
      : super(key: key);

  @override
  State<HanoiTower> createState() => _HanoiTowerState(cubes: rings, id: id);
}

class _HanoiTowerState extends State<HanoiTower> {
  _HanoiTowerState({
    required this.cubes,
    this.id = 1,
  });

  List<Ring> cubes;
  final int id;

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(milliseconds: 50), (timer) {//таймер на каждой башне чтобы чекать изменения и сразу отображать (без этого обновление башен происходит с дикой задержкой)
      setState(() {
        cubes = widget.rings;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      // margin: const EdgeInsets.symmetric(horizontal: 20),
      width: 400,
      height: size.height - 100,
      child: Container(
        // padding: const EdgeInsets.only(top: 30),
        child: Stack(
          children: [
            Tower(id: id),
            Container(
              margin: const EdgeInsets.only(bottom: 20),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: cubes,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
