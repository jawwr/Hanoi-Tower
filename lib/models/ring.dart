import 'package:flutter/material.dart';

class Ring extends StatefulWidget {
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
  State<Ring> createState() => _RingState();
}

class _RingState extends State<Ring> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget._width,
      height: widget._height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(widget._height / 5),
          topRight: Radius.circular(widget._height / 5),
        ),
        color: widget._color,
      ),
      child: Center(
        child: Text(
          '${widget.id}',
          style: TextStyle(color: Colors.white, fontSize: widget._height / 2),
        ),
      ),
    );
  }
}
