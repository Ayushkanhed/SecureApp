import 'package:flutter/material.dart';

class PanicScreen extends StatelessWidget {
  const PanicScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          const SizedBox(height: 24),
          const Center(child: Text('Calculator', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))),
          const SizedBox(height: 12),
          Expanded(
            child: GridView.count(
              crossAxisCount: 3,
              padding: const EdgeInsets.all(16),
              children: List.generate(
                  12,
                  (i) => CalculatorTile(
                      label: '${i < 9 ? i + 1 : (i == 9 ? "*" : (i == 10 ? 0 : "#"))}')),
            ),
          ),
        ]),
      ),
    );
  }
}

class CalculatorTile extends StatelessWidget {
  final String label;
  const CalculatorTile({Key? key, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {},
        child: Center(child: Text(label, style: const TextStyle(fontSize: 18))),
      ),
    );
  }
}

