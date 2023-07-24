import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

class DialerPage extends StatefulWidget {
  const DialerPage({super.key});

  @override
  State<DialerPage> createState() => _DialerPageState();
}

class _DialerPageState extends State<DialerPage> {
  TextEditingController _numberController = TextEditingController();
  var number = "";
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          Expanded(
              flex: 4,
              child: Container(
                color: const Color.fromARGB(255, 29, 29, 29),
              )),
          Expanded(
              flex: 7,
              child: Container(
                decoration: const BoxDecoration(
                  color: Color.fromARGB(130, 0, 0, 0),
                  // borderRadius: BorderRadius.only(
                  //     topLeft: Radius.circular(40),
                  //     topRight: Radius.circular(40))
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                              flex: 9,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: TextField(
                                  style: TextStyle(fontSize: 30),
                                  controller: _numberController,
                                  showCursor: true,
                                  mouseCursor: MouseCursor.uncontrolled,
                                  readOnly: true,
                                ),
                              )),
                          Expanded(
                              flex: 1,
                              child: InkWell(
                                onLongPress: () {
                                  number = "";
                                  _numberController.text = number;
                                  _numberController.selection =
                                      TextSelection.fromPosition(TextPosition(
                                          offset:
                                              _numberController.text.length));
                                  setState(() {});
                                },
                                child: IconButton(
                                    onPressed: () {
                                      if (number.isNotEmpty) {
                                        number = number.substring(
                                            0, number.length - 1);
                                      }
                                      _numberController.text = number;
                                      _numberController.selection =
                                          TextSelection.fromPosition(
                                              TextPosition(
                                                  offset: _numberController
                                                      .text.length));
                                      setState(() {});
                                    },
                                    icon: const Icon(Icons.backspace_outlined)),
                              ))
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () {
                            number += "1";
                            _numberController.text = number;
                            _numberController.selection =
                                TextSelection.fromPosition(TextPosition(
                                    offset: _numberController.text.length));
                            setState(() {});
                          },
                          child: Container(
                            width: 90,
                            height: 55,
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 53, 52, 52),
                                borderRadius: BorderRadius.circular(20)),
                            child: const Center(
                                child: Text(
                              "1",
                              textScaleFactor: 2,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            number += "2";
                            _numberController.text = number;
                            _numberController.selection =
                                TextSelection.fromPosition(TextPosition(
                                    offset: _numberController.text.length));
                            setState(() {});
                          },
                          child: Container(
                            width: 90,
                            height: 55,
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 53, 52, 52),
                                borderRadius: BorderRadius.circular(20)),
                            child: const Center(
                                child: Text(
                              "2",
                              textScaleFactor: 2,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            number += "3";
                            _numberController.text = number;
                            _numberController.selection =
                                TextSelection.fromPosition(TextPosition(
                                    offset: _numberController.text.length));
                            setState(() {});
                          },
                          child: Container(
                            width: 90,
                            height: 55,
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 53, 52, 52),
                                borderRadius: BorderRadius.circular(20)),
                            child: const Center(
                                child: Text(
                              "3",
                              textScaleFactor: 2,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )),
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () {
                            number += "4";

                            _numberController.text = number;
                            _numberController.selection =
                                TextSelection.fromPosition(TextPosition(
                                    offset: _numberController.text.length));
                            setState(() {});
                          },
                          child: Container(
                            width: 90,
                            height: 55,
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 53, 52, 52),
                                borderRadius: BorderRadius.circular(20)),
                            child: const Center(
                                child: Text(
                              "4",
                              textScaleFactor: 2,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            number += "5";
                            _numberController.text = number;
                            _numberController.selection =
                                TextSelection.fromPosition(TextPosition(
                                    offset: _numberController.text.length));
                            setState(() {});
                          },
                          child: Container(
                            width: 90,
                            height: 55,
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 53, 52, 52),
                                borderRadius: BorderRadius.circular(20)),
                            child: const Center(
                                child: Text(
                              "5",
                              textScaleFactor: 2,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            number += "6";
                            _numberController.text = number;
                            _numberController.selection =
                                TextSelection.fromPosition(TextPosition(
                                    offset: _numberController.text.length));
                            setState(() {});
                          },
                          child: Container(
                            width: 90,
                            height: 55,
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 53, 52, 52),
                                borderRadius: BorderRadius.circular(20)),
                            child: const Center(
                                child: Text(
                              "6",
                              textScaleFactor: 2,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )),
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () {
                            number += "7";
                            _numberController.text = number;
                            _numberController.selection =
                                TextSelection.fromPosition(TextPosition(
                                    offset: _numberController.text.length));
                            setState(() {});
                          },
                          child: Container(
                            width: 90,
                            height: 55,
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 53, 52, 52),
                                borderRadius: BorderRadius.circular(20)),
                            child: const Center(
                                child: Text(
                              "7",
                              textScaleFactor: 2,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            number += "8";
                            _numberController.text = number;
                            _numberController.selection =
                                TextSelection.fromPosition(TextPosition(
                                    offset: _numberController.text.length));
                            setState(() {});
                          },
                          child: Container(
                            width: 90,
                            height: 55,
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 53, 52, 52),
                                borderRadius: BorderRadius.circular(20)),
                            child: const Center(
                                child: Text(
                              "8",
                              textScaleFactor: 2,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            number += "9";
                            _numberController.text = number;
                            _numberController.selection =
                                TextSelection.fromPosition(TextPosition(
                                    offset: _numberController.text.length));
                            setState(() {});
                          },
                          child: Container(
                            width: 90,
                            height: 55,
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 53, 52, 52),
                                borderRadius: BorderRadius.circular(20)),
                            child: const Center(
                                child: Text(
                              "9",
                              textScaleFactor: 2,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )),
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () {
                            number += "*";
                            _numberController.text = number;
                            _numberController.selection =
                                TextSelection.fromPosition(TextPosition(
                                    offset: _numberController.text.length));
                            setState(() {});
                          },
                          child: Container(
                            width: 90,
                            height: 55,
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 53, 52, 52),
                                borderRadius: BorderRadius.circular(20)),
                            child: const Center(
                                child: Text(
                              "*",
                              textScaleFactor: 2,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            number += "0";
                            _numberController.text = number;
                            _numberController.selection =
                                TextSelection.fromPosition(TextPosition(
                                    offset: _numberController.text.length));
                            setState(() {});
                          },
                          onLongPress: () {
                            number += "+";
                            _numberController.text = number;
                            _numberController.selection =
                                TextSelection.fromPosition(TextPosition(
                                    offset: _numberController.text.length));
                            setState(() {});
                          },
                          child: Container(
                            width: 90,
                            height: 55,
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 53, 52, 52),
                                borderRadius: BorderRadius.circular(20)),
                            child: const Center(
                                child: Text(
                              "+ 0",
                              textScaleFactor: 2,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            number += "#";
                            _numberController.text = number;
                            _numberController.selection =
                                TextSelection.fromPosition(TextPosition(
                                    offset: _numberController.text.length));
                            setState(() {});
                          },
                          child: Container(
                            width: 90,
                            height: 55,
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 53, 52, 52),
                                borderRadius: BorderRadius.circular(20)),
                            child: const Center(
                                child: Text(
                              "#",
                              textScaleFactor: 2,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )),
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Container(
                            width: 110,
                            height: 70,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40),
                                color: const Color(0xff7FFFD4)),
                            child: IconButton(
                                onPressed: () {
                                  if (_numberController.text != "" ||
                                      _numberController.text != " " ||
                                      _numberController.text.isNotEmpty) {
                                    FlutterPhoneDirectCaller.callNumber(
                                        _numberController.text);
                                  }
                                  // var phoneNumber = _numberController.text;
                                },
                                icon: const Icon(
                                  Icons.call,
                                  size: 50,
                                )),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ))
        ],
      ),
    ));
  }
}
