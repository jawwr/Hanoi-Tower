import 'package:flutter/material.dart';

class InputRingCountBar extends StatelessWidget {
  InputRingCountBar(
      {Key? key,
      required this.func,
      required this.isStart,
      required this.restart,
      required String count})
      : _controller = TextEditingController()..text = count,
        super(key: key);
  final void Function(int, double) func;
  final bool isStart;
  final void Function() restart;
  final TextEditingController _controller;
  late final double _height;

  void _start() {
    String input = _controller.text;
    if (_validate(input) == null) {
      int value = int.tryParse(input)!;
      func(value, _height);
    }
  }

  String? _validate(String? input) {
    if (input == null) {
      return "Ничего не введено";
    }
    if (int.tryParse(input) != null) {
      return null;
    }
    return "Not a number";
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    _height = size.height;
    return Container(
      height: 100,
      width: 700,
      child: Center(
        child: Container(
          height: 50,
          child: Stack(
            children: [
              _restartButton(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _inputData(),
                  _startButton(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _inputData() {
    return Flexible(
      child: Container(
        height: 200,
        width: 250,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(50),
            bottomLeft: Radius.circular(50),
          ),
        ),
        child: TextFormField(
          validator: _validate,
          controller: _controller,
          onEditingComplete: _start,
          decoration: InputDecoration(
            errorBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red)),
            border: InputBorder.none,
            hintText: 'Введите количество колец',
            enabled: !isStart,
            contentPadding: const EdgeInsets.symmetric(horizontal: 20),
          ),
        ),
      ),
    );
  }

  Widget _restartButton() {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 200),
      right: isStart ? 120 : 200,
      top: 5,
      child: GestureDetector(
        onTap: restart,
        child: Container(
          margin: const EdgeInsets.only(left: 10),
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            color: Colors.cyan,
            borderRadius: BorderRadius.circular(50),
          ),
          child: const Icon(
            Icons.refresh,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _startButton() {
    return GestureDetector(
      onTap: !isStart ? _start : () {},
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
                color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
