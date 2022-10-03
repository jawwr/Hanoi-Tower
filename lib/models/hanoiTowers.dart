import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hanoi/models/tower.dart';
import 'package:hanoi/stack.dart';

import 'ring.dart';

class HanoiTower extends StatefulWidget {
  MyStack<Ring> rings;
  final int id;

  static void start(){
    _HanoiTowerState._isStart  = true;
  }

  static void stop(){
    _HanoiTowerState._isStart = false;
  }

  HanoiTower({Key? key, required this.rings, required this.id})
      : super(key: key);

  @override
  State<HanoiTower> createState() => _HanoiTowerState();
}

class _HanoiTowerState extends State<HanoiTower> {
  late List<Ring> _rings;
  late final int _id;
  static bool _isStart = false;

  @override
  void initState() {
    super.initState();
    _rings = widget.rings.elements;
    _id = widget.id;
    Timer.periodic(
      const Duration(milliseconds: 100),
      (timer) {
        //таймер на каждой башне чтобы чекать изменения и сразу отображать (без этого обновление башен происходит с дикой задержкой)
        setState(() {
          _rings = widget.rings.elements;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width * .28,
      height: size.height - 100,
      child: Stack(
        children: [
          Tower(id: _id),
          AnimatedOpacity(
            opacity: _isStart ? 1 : 0,
            duration: const Duration(milliseconds: 100),
            child: Container(
              margin: EdgeInsets.only(bottom: (size.height * .02)),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: _rings,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
