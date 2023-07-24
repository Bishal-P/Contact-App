// ignore_for_file: non_constant_identifier_names

import 'package:call_log/call_log.dart';
import 'package:contactapp2/CallLogHistory.dart';
import 'package:contactapp2/providers/contactprovider.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:swipeable_tile/swipeable_tile.dart';

class CallLogs extends StatefulWidget {
  const CallLogs({super.key});

  @override
  State<CallLogs> createState() => _CallLogsState();
}

class _CallLogsState extends State<CallLogs> {
  TextEditingController searchController2 = TextEditingController();
  List<CallLogEntry> listOfLogs = [];
  List<CallLogEntry> tempLogs = [];
  bool isLoading = false;
  DateTime todayDate1 = DateTime.now();
  DateTime yesterday1 = DateTime.now().subtract(const Duration(days: 1));
  String todayDate = "";
  String yesterday = "";
  String previousDate = "";
  late ContactProvider tempProvider;
  @override
  void initState() {
    // getCallLogs1();
    todayDate = DateFormat('yMd').format(todayDate1);
    yesterday = DateFormat('yMd').format(yesterday1);
    tempProvider = Provider.of<ContactProvider>(context, listen: false);

    // print("The yesterday date is $yesterday");
    super.initState();
  }

  // getCallLogs1() async {
  //   entries = await CallLog.get();
  //   for (CallLogEntry entry in entries) {
  //     listOfLogs.add(entry);
  //     tempLogs.add(entry);
  //   }
  //   isLoading = false;
  //
  // }

  Future<void> CallLogsRefresh() async {
    List<CallLogEntry> temp = [];
    Iterable<CallLogEntry> entries = await CallLog.get();
    for (CallLogEntry entry in entries) {
      temp.add(entry);
    }
    tempProvider.setCallLogEntries(temp);
  }

  @override
  Widget build(BuildContext context) {
    // print("The call logs are $entries");

    // print("THe log is :${listOfLogs.length}");

    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: Column(children: [
              Container(
                decoration: BoxDecoration(
                    color: const Color(0xff7FFFD4),
                    borderRadius: BorderRadius.circular(20)),
                // height: 100,

                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    children: [
                      Expanded(child: Consumer<ContactProvider>(
                          builder: (context, valueChanger2, child) {
                        return TextField(
                          autofocus: false,
                          controller: searchController2,
                          onChanged: (value) {
                            valueChanger2.setSearchLogEntries(value);
                            // listOfLogs = [];
                            // searchFun() {
                            //   if (value.isNotEmpty) {
                            //     for (int i = 0; i < tempLogs.length; i++) {
                            //       if (tempLogs[i].name != null) {
                            //         var upcase1 = tempLogs[i]
                            //             .name!
                            //             .toString()
                            //             .toUpperCase();
                            //         var num = tempLogs[i].number!.toUpperCase();
                            //         var upcase2 = value.toUpperCase();
                            //         if (upcase1.contains(upcase2) ||
                            //             num.contains(value)) {
                            //           listOfLogs.add(tempLogs[i]);
                            //         }
                            //       }
                            //     }
                            //   } else {
                            //     listOfLogs = tempLogs;
                            //   }
                            // }

                            // searchFun();

                            //
                          },
                          decoration: InputDecoration(
                            suffixIcon: searchController2.text.isEmpty
                                ? const SizedBox(
                                    width: 0,
                                    height: 0,
                                  )
                                : InkWell(
                                    child: const Icon(
                                      Icons.clear,
                                      color: Colors.white,
                                    ),
                                    onTap: () {
                                      valueChanger2.setSearchLogEntries("");
                                      searchController2.clear();
                                      // setState(() {
                                      //   listOfLogs = tempLogs;
                                      // });
                                    },
                                  ),

                            filled: true,
                            fillColor: const Color.fromARGB(255, 36, 35, 35),
                            hintText: 'Search for name or number',
                            contentPadding: const EdgeInsets.all(15),
                            // contentPadding: const EdgeInsets.only(
                            //     left: 14.0, bottom: 8.0, top: 8.0),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Colors.transparent),
                              borderRadius: BorderRadius.circular(25.7),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Colors.transparent),
                              borderRadius: BorderRadius.circular(25.7),
                            ),
                          ),
                        );
                      })),
                      InkWell(
                        child: Container(
                          margin: const EdgeInsets.only(left: 10),
                          width: 45,
                          height: 45,
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(50)),
                          child: const Icon(Icons.add),
                        ),
                        onTap: () async {
                          try {
                            await ContactsService.openContactForm();
                          } on FormOperationException catch (e) {
                            switch (e.errorCode) {
                              case FormOperationErrorCode
                                    .FORM_OPERATION_CANCELED:
                              case FormOperationErrorCode
                                    .FORM_COULD_NOT_BE_OPEN:
                              case FormOperationErrorCode
                                    .FORM_OPERATION_UNKNOWN_ERROR:
                              default:
                                print(e.errorCode);
                            }
                          }
                        },
                      )
                    ],
                  ),
                ),
              ),
              !isLoading
                  ? Consumer<ContactProvider>(builder: (context, value, child) {
                      print("The list is loading");
                      listOfLogs = value.temLogEntries;
                      return Expanded(
                        child: RefreshIndicator(
                          onRefresh: CallLogsRefresh,
                          child: ListView.builder(
                              itemCount: listOfLogs.length,
                              itemBuilder: (context, index) {
                                CallLogEntry currentLog = listOfLogs[index];
                                CallType incoming = CallType.incoming;
                                CallType outgoing = CallType.outgoing;
                                CallType missed = CallType.missed;
                                CallType rejected = CallType.rejected;
                                String callingType = "";
                                DateTime currentDate1 =
                                    DateTime.fromMillisecondsSinceEpoch(
                                        currentLog.timestamp!);
                                String currentDate =
                                    DateFormat('yMd').format(currentDate1);

                                // print("Current duration is:${currentLog.duration}");
                                if (currentLog.callType == incoming) {
                                  callingType = "incoming";
                                } else if (currentLog.callType == outgoing) {
                                  callingType = "outgoing";
                                } else if (currentLog.callType == missed) {
                                  callingType = "missed";
                                } else if (currentLog.callType == rejected) {
                                  callingType = "rejected";
                                }

                                // if (currentDate != previousDate) {
                                //   previousDate = currentDate;
                                //   return Column(
                                //     // crossAxisAlignment: CrossAxisAlignment.start,

                                //     children: [
                                //       Container(
                                //         padding: const EdgeInsets.only(top: 15),
                                //         height: 50,
                                //         child: currentDate == todayDate
                                //             ? const Text(
                                //                 "Today",
                                //                 textScaleFactor: 1.3,
                                //               )
                                //             : currentDate == yesterday
                                //                 ? const Text(
                                //                     "Yesterday",
                                //                     textScaleFactor: 1.3,
                                //                   )
                                // : Text(
                                //     DateFormat.yMMMMd('en_US')
                                //         .format(currentDate1),
                                //     textScaleFactor: 1.3,
                                //   ),
                                //       ),
                                //       CallLogsExtend(context,
                                //           currentLog, callingType, currentDate1)
                                //     ],
                                //   );
                                // }
                                // if (currentDate == previousDate) {
                                //   return CallLogsExtend(context,
                                //       currentLog, callingType, currentDate1);
                                // }

                                // if (index == 0 &&
                                //     DateFormat('yMd').format(
                                //             DateTime.fromMillisecondsSinceEpoch(
                                //                 currentLog.timestamp!)) ==
                                //         todayDate) {
                                // return Column(
                                //   // crossAxisAlignment: CrossAxisAlignment.start,

                                //   children: [
                                // Container(
                                //   padding: const EdgeInsets.only(top: 15),
                                //   height: 50,
                                //   child: const Text(
                                //     "Today",
                                //     textScaleFactor: 1.3,
                                //   ),
                                // ),
                                // CallLogsExtend(context,
                                //     currentLog, callingType, currentDate1)
                                //   ],
                                // );
                                // }

                                if (index == 0) {
                                  return Column(
                                    // crossAxisAlignment: CrossAxisAlignment.start,

                                    children: [
                                      Container(
                                        padding: const EdgeInsets.only(top: 15),
                                        height: 50,
                                        child: currentDate == todayDate
                                            ? const Text(
                                                "Today",
                                                textScaleFactor: 1.3,
                                              )
                                            : currentDate == yesterday
                                                ? const Text(
                                                    "yesterday",
                                                    textScaleFactor: 1.3,
                                                  )
                                                : Text(
                                                    DateFormat.yMMMMd('en_US')
                                                        .format(currentDate1),
                                                    textScaleFactor: 1.3,
                                                  ),
                                      ),
                                      CallLogsExtend(context, currentLog,
                                          callingType, currentDate1, value)
                                    ],
                                  );
                                }

                                if (listOfLogs.length > 1 && index != 0) {
                                  CallLogEntry previousLog =
                                      listOfLogs[index - 1];

                                  DateTime previousDate1 =
                                      DateTime.fromMillisecondsSinceEpoch(
                                          previousLog.timestamp!);
                                  String previousDate =
                                      DateFormat('yMd').format(previousDate1);
                                  if (currentDate == yesterday &&
                                      previousDate != currentDate) {
                                    return Column(
                                      // crossAxisAlignment: CrossAxisAlignment.start,

                                      children: [
                                        Container(
                                          padding:
                                              const EdgeInsets.only(top: 15),
                                          height: 50,
                                          child: const Text(
                                            "Yesterday",
                                            textScaleFactor: 1.3,
                                          ),
                                        ),
                                        CallLogsExtend(context, currentLog,
                                            callingType, currentDate1, value)
                                      ],
                                    );
                                  }
                                  if (previousDate == currentDate) {
                                    return CallLogsExtend(context, currentLog,
                                        callingType, currentDate1, value);
                                  }
                                  if (currentDate != previousDate) {
                                    return Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          padding:
                                              const EdgeInsets.only(top: 15),
                                          height: 50,
                                          child: Text(
                                            DateFormat.yMMMMd('en_US')
                                                .format(currentDate1),
                                            textScaleFactor: 1.3,
                                          ),
                                        ),
                                        CallLogsExtend(context, currentLog,
                                            callingType, currentDate1, value)
                                      ],
                                    );
                                  }
                                } else {
                                  return const SizedBox(
                                    height: 0,
                                  );
                                }
                                return null;
                                // return;
                              }),
                        ),
                      );
                    })
                  : const Center(
                      child: CircularProgressIndicator(),
                    ),
            ])));
  }
}

Widget CallLogsExtend(context, currentLog, callingType, currentDate1, value) {
  return InkWell(
    onTap: () => Navigator.push(context,
        MaterialPageRoute(builder: (_) => CallLogHistory(currentLog.number))),
    child: SwipeableTile(
        behavior: HitTestBehavior.opaque,
        // resizeDuration: Duration(seconds: 2),
        borderRadius: 20,
        color: const Color.fromARGB(67, 15, 25, 21),
        swipeThreshold: 0.8,
        direction: SwipeDirection.startToEnd,
        onSwiped: (direction) async {
          //
          // Here call setState1 to update state
        },
        backgroundBuilder: (context, direction, progress) {
          // if (direction == SwipeDirection.startToEnd && progress.value < 0.5) {}
          if (direction == SwipeDirection.startToEnd && progress.value > 0.5) {
            FlutterPhoneDirectCaller.callNumber(currentLog.number);
            // print(
            //     "Name : ${contactIndex.title} , Number :${contactIndex.number}");

            // return your widget
          }
          return AnimatedBuilder(
            animation: progress,
            builder: (context, child) {
              return AnimatedContainer(
                // decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.red])),
                duration: const Duration(milliseconds: 400),
                color: progress.value > 0.4
                    ? const Color(0xFFed7474)
                    : const Color(0xff40E0D0),
              );
            },
          );
        },
        key: UniqueKey(),
        child: InkWell(
          child: Padding(
            padding: const EdgeInsets.only(right: 0),
            child: ListTile(
              tileColor: const Color.fromARGB(79, 127, 255, 212),
              // iconColor: const Color(0xff7FFFD4),
              textColor: Colors.white,
              // collapsedBackgroundColor: const Color.fromARGB(82, 127, 255, 212),
              title: Text(
                (currentLog.name != null && currentLog.name != "")
                    ? currentLog.name.toString()
                    : value.contactList2.containsKey(currentLog.number)
                        ? value
                            .contactList2[currentLog.number.replaceAll(" ", "")]
                        : currentLog.number,
                overflow: TextOverflow.ellipsis,
                textScaleFactor: 1.2,
              ),
              trailing: currentLog.duration != 0
                  ? const Text("")
                  : const Icon(
                      Icons.cancel,
                      color: Colors.blueGrey,
                    ),
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Row(
                      children: [
                        callingType == "outgoing"
                            ? const Icon(
                                Icons.call_made,
                                color: Colors.orangeAccent,
                                size: 20,
                              )
                            : callingType == "incoming"
                                ? const Icon(
                                    Icons.call_received,
                                    color: Colors.green,
                                  )
                                : callingType == "missed"
                                    ? const Icon(
                                        Icons.call_missed,
                                        color: Colors.red,
                                      )
                                    : const Icon(
                                        Icons.call_end,
                                        color: Colors.yellow,
                                      ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(callingType),
                        ),
                      ],
                    ),
                  ),
                  Text(DateFormat.jm().format(currentDate1)),
                ],
              ),
              leading: (value.contactList[currentLog.name.toString()] != null &&
                      value.contactList[currentLog.name].avatar.length > 0)
                  ? CircleAvatar(
                      backgroundImage: MemoryImage(
                          value.contactList[currentLog.name].avatar),
                      radius: 30,
                    )
                  : CircleAvatar(
                      radius: 30,
                      child:
                          currentLog.name != null && currentLog.name.length > 0
                              ? Text(
                                  currentLog.name[0],
                                  textScaleFactor: 1.4,
                                )
                              : const Text(
                                  "#",
                                  textScaleFactor: 1.4,
                                ),
                    ),
            ),
          ),
        ) // Here Tile which will be shown at the top
        ),
  );
}
