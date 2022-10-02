import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hanoi/models/constants.dart';

import 'models/cube.dart';
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
      towerFrom.rings.remove(ring);
      towerTo.rings.insert(0, ring);
    });
  }

  final List<HanoiTower> _towers = [
    //изначальный список всех башен
    HanoiTower(
      rings: [],
      id: 1,
    ),
    HanoiTower(
      rings: [],
      id: 2,
    ),
    HanoiTower(
      rings: [],
      id: 3,
    ),
  ];
  List<Ring> _rings = [];
  int _ringsCount = 3;
  bool _isStart = false;

  void _start(int ringCount) {
    setState(() {
      _rings = _generateRings(ringCount, 700);
      _towers.first.rings = List.of(_rings);
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
    double ringsHeight = (height - 300) / count;
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

class InputRingCountBar extends StatelessWidget {
  InputRingCountBar({Key? key, required this.func, required this.isStart})
      : super(key: key);
  final void Function(int) func;
  final bool isStart;
  final TextEditingController controller = TextEditingController();

  void _start() {
    String input = controller.text;
    if(_validate(input) != null) {
      int value = int.tryParse(input)!;
      func(value);
    }
  }

  String? _validate(String? input){
    if(input != null){
      return "Ничего не введено";
    }
    if(int.tryParse(input!) != null){
      return null;
    }
    return "Not a number";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 350,
      // color: Colors.cyan,
      child: Center(
        child: Container(
          height: 50,
          child: Row(
            children: [
              Flexible(
                child: Container(
                  height: 200,
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(50),
                      bottomLeft: Radius.circular(50),
                    ),
                  ),
                  child: TextFormField(
                    validator: _validate,
                    controller: controller,
                    onEditingComplete: _start,
                    decoration: InputDecoration(
                      errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
                      border: InputBorder.none,
                      hintText: 'Введите количество колец',
                      enabled: !isStart,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 20)
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: !isStart ? _start : (){},
                behavior: HitTestBehavior.translucent,
                child: Container(
                  width: 100,
                  height: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.cyan,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(50),
                      bottomRight: Radius.circular(50),
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      'Start',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
