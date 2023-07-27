import 'package:flutter/material.dart';

class Counter extends StatefulWidget {
  final int count;

  const Counter({super.key, this.count = 0});

  @override
  State<Counter> createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  late int _count;

  void _increment(int value) {
    setState(() {
      if (_count + value < 0) return;

      _count += value;
    });
  }

  @override
  void initState() {
    super.initState();
    _count = widget.count;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Opacity(
          opacity: _count > 0 ? 1 : 0,
          child: TextButton(
            onPressed: () => _increment(-1),
            child: const Text('-', style: TextStyle(fontSize: 24)),
          ),
        ),
        Text('$_count', style: const TextStyle(fontSize: 24)),
        TextButton(
          onPressed: () => _increment(1),
          child: const Text('+', style: TextStyle(fontSize: 24)),
        ),
      ]
    );
  }
}
