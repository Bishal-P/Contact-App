import 'package:flutter/material.dart';

// class Page1 extends StatelessWidget {
//   const Page1({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//           // color: Colors.amberAccent,
//           ),
//     );
//   }
// }

class Page2 extends StatelessWidget {
  const Page2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          // color: Color.fromARGB(255, 64, 255, 210),
          ),
    );
  }
}

class Page3 extends StatelessWidget {
  const Page3({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          "Coming soon.....",
          textScaleFactor: 1.4,
        ),
      ),
    );
  }
}

class Page4 extends StatefulWidget {
  const Page4({super.key});

  @override
  State<Page4> createState() => _Page4State();
}

class _Page4State extends State<Page4> {
  @override
  void initState() {
    Navigator.pop(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          // color: Color.fromARGB(255, 255, 64, 99),
          ),
    );
  }
}
