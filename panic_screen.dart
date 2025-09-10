import 'package:flutter/material.dart';

class PanicScreen extends StatelessWidget {
  const PanicScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Simple dummy screen that looks like a harmless calculator
    return Scaffold(
      appBar: AppBar(title: Text('Calculator')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('0', style: TextStyle(fontSize: 48)),
            SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: List.generate(12, (index) {
                return ElevatedButton(onPressed: () {}, child: Text('${index+1}'));
              }),
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Return'),
            )
          ],
        ),
      ),
    );
  }
}
