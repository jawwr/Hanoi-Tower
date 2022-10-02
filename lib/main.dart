import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hanoi/models/constants.dart';
import 'package:hanoi/stack.dart';

import 'models/InputRingCountBar.dart';
import 'models/ring.dart';
import 'models/hanoiTowers.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _hanoi(
      Ring currentCube, HanoiTower start, HanoiTower mid, HanoiTower end) {
    //логика просчета ходов для решения
    if (currentCube.id == 1) {
      // print("${currentCube.id} из ${start.id} в ${end.id}");
      func.add(() => _swap(currentCube.id, start, end));
      return;
    } else {
      _hanoi(_findPrevCube(currentCube), start, end, mid);

      // print("${currentCube.id} из ${start.id} в ${end.id}");
      func.add(() => _swap(currentCube.id, start, end));
      _hanoi(_findPrevCube(currentCube), mid, start, end);
    }
  }

  List<Function> func = [];

  Ring _findPrevCube(Ring current) =>
      _rings.where((ring) => ring.id == current.id - 1).first;

  Ring _findCubeById(int id) => _rings.where((cube) => cube.id == id).first;

  void _swap(int ringId, HanoiTower towerFrom, HanoiTower towerTo) {
    //логика перемещения колец между башнями
    setState(() {
      Ring ring = _findCubeById(ringId);
      towerFrom.rings.pop();
      towerTo.rings.push(ring);
    });
  }

  final List<HanoiTower> _towers = [
    //изначальный список всех башен
    HanoiTower(
      rings: MyStack(),
      id: 1,
    ),
    HanoiTower(
      rings: MyStack(),
      id: 2,
    ),
    HanoiTower(
      rings: MyStack(),
      id: 3,
    ),
  ];
  List<Ring> _rings = [];
  bool _isStart = false;
  int _count = 0;

  void _restart() {
    setState(() {
      _rings = [];
      for (var towers in _towers) {
        towers.rings = MyStack<Ring>.copyOfList(_rings);
      }
      _count = 0;
      func = [];
      _isStart = false;
    });
  }

  void _start(int ringCount, double height) {
    setState(() {
      _count = ringCount;
      _rings = _generateRings(ringCount, height);
      _towers.first.rings = MyStack.copyOfList(_rings);

      Future.delayed(const Duration(seconds: 1), () {
        // var start = DateTime.now();

        _hanoi(_rings.last, _towers.first, _towers[1],
            _towers.last); //Вызов логики просчета решения
        // var stop = DateTime.now();
        // print('start: $start');
        // print('stop: $stop');
        // print('Время выполнения: ${stop.difference(start).inMilliseconds} ms');
      });

      _isStart = true;
    });

    Future.delayed(const Duration(seconds: 1), () async {
      for (int i = 0; i < func.length; i++) {
        await Future.delayed(const Duration(milliseconds: 500), () {
          func[
              i](); //Из-за того, что в флаттере задержка асинхронная приходится записывать в лист функций и вызывать
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
  }

  List<Ring> _generateRings(int count, double height) {
    //генерация колец
    List<Ring> rings = [];
    double width = 350;
    double dif = 300 / (2 * count);
    double ringsHeight = (height - 350) / count;
    for (int i = count; i > 0; i--) {
      rings.insert(
        0,
        Ring(
            width: width,
            height: ringsHeight,
            id: i,
            color: colors[Random().nextInt(colors.length)]),
      );
      width -= dif;
    }
    return rings;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InputRingCountBar(
            func: _start,
            isStart: _isStart,
            restart: _restart,
            count: _count != 0 ? _count.toString() : '',
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: _towers,
          ),
        ],
      ),
    );
  }
}
