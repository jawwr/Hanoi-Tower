import 'package:flutter/material.dart';

class Ring extends StatelessWidget {
  const Ring(
      {Key? key,
      required width,
      required height,
      required this.id,
      required color})
      : _width = width,
        _height = height,
        _color = color,
        super(key: key);
  final double _width;
  final double _height;
  final Color _color;
  final int id;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _width,
      height: _height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(_height / 5),
          topRight: Radius.circular(_height / 5),
        ),
        color: _color,
        // border: Border.all(color: Colors.black),
      ),
      child: Center(
        child: Text(
          '$id',
          style: TextStyle(
            color: Colors.white,
            fontSize: _height / 2
          ),
        ),
      ),
    );
  }
}
