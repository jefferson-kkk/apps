import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(debugShowCheckedModeBanner: false, home: InterruptorApp()),
  );
}

class InterruptorApp extends StatefulWidget {
  const InterruptorApp({super.key});

  @override
  _InterruptorAppState createState() => _InterruptorAppState();
}

class _InterruptorAppState extends State<InterruptorApp> {
  int estadoemocao = 0;

  void altenarhumor() {
    setState(() {
      estadoemocao++;
      if (estadoemocao >= 3) {
        estadoemocao = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: estadoemocao == 0
          ? Colors.white
          : estadoemocao == 1
              ? Colors.green
              : Colors.red,

      appBar: AppBar(
        title: Text(
          'emoção',
          style: TextStyle(
            color: estadoemocao == 0
                ? Colors.black
                : Colors.white,
          ),
        ),
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Icon(
              estadoemocao == 0
                  ? Icons.sentiment_neutral
                  : estadoemocao == 1
                      ? Icons.sentiment_satisfied
                      : Icons.sentiment_very_dissatisfied,
              size: 100,
            ),

            ElevatedButton(
              onPressed: altenarhumor,
              child: Text("Mudar emoção"),
            ),

          ],
        ),
      ),
    );
  }
}