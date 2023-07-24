// ignore_for_file: prefer_interpolation_to_compose_strings, must_be_immutable


import 'package:call_log/call_log.dart';
import 'package:contactapp2/dialogBox.dart';
import 'package:contactapp2/dummyPages.dart';
import 'package:contactapp2/providers/contactprovider.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CallLogHistory extends StatefulWidget {
  CallLogHistory(this.caller, {super.key});
  String caller;
  // String callerName;

  @override
  State<CallLogHistory> createState() => _CallLogHistoryState();
}

class _CallLogHistoryState extends State<CallLogHistory> {
  Iterable<CallLogEntry> entries = [];
  bool isLoading = true;
  List<CallLogEntry> listOfLogs = [];
  DateTime todayDate1 = DateTime.now();
  DateTime yesterday1 = DateTime.now().subtract(const Duration(days: 1));
  String todayDate = "";
  String yesterday = "";
  String previousDate = "";
  @override
  void initState() {
    getLogs();
    todayDate = DateFormat('yMd').format(todayDate1);
    yesterday = DateFormat('yMd').format(yesterday1);
    super.initState();
  }

  getLogs() async {
    entries = await CallLog.query(
      number: widget.caller,
    );
    for (CallLogEntry entry in entries) {
      listOfLogs.add(entry);
      print(entry.name);
    }
    print("The length of entries is : ${listOfLogs.length}");
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Consumer<ContactProvider>(builder: (context, valueChanger, child) {
            print("The valuechanger in call log history is working");
            return Container(
              decoration: BoxDecoration(
                  color: const Color(0xff7FFFD4),
                  borderRadius: BorderRadius.circular(20)),
              // height: 100,

              child: Padding(
                padding:
                    const EdgeInsets.only(top: 15.0, left: 0.0, bottom: 15.0),
                child: ListTile(
                  // tileColor: const Color.fromARGB(79, 127, 255, 212),
                  // iconColor: const Color(0xff7FFFD4),
                  textColor: const Color.fromARGB(255, 0, 0, 0),
                  // collapsedBackgroundColor: const Color.fromARGB(82, 127, 255, 212),
                  title: Row(
                    children: [
                      SizedBox(
                        // color: Colors.green,
                        width: 180,
                        child: Text(
                          valueChanger.contactList2[widget.caller] != null
                              ? valueChanger.contactList2[widget.caller]
                                  .toString()
                              : widget.caller.toString(),
                          overflow: TextOverflow.ellipsis,
                          textScaleFactor: 1.4,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      IconButton(
                          onPressed: () async {
                            if (valueChanger.contactList2[widget.caller] !=
                                null) {
                              try {
                                List<Contact> contact =
                                    await ContactsService.getContacts(
                                        query: valueChanger
                                            .contactList2[widget.caller]);
                                print("The contact to edit is :$contact");
                                await ContactsService.openExistingContact(
                                    contact[0]);
                              } on FormOperationException {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => const Page4()));
                              } on FlutterError {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => const Page4()));
                                //
                              } on Exception {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => const Page4()));
                              }
                            } else {
                              showDialog(
                                  context: context,
                                  builder: (context) =>
                                      CreateContactDialogBox(widget.caller));
                            }
                          },
                          icon: valueChanger.contactList2[widget.caller] != null
                              ? const Icon(
                                  Icons.edit,
                                  color: Colors.black,
                                  size: 30,
                                )
                              : const Icon(
                                  Icons.contact_page,
                                  color: Colors.black,
                                  size: 30,
                                ))
                    ],
                  ),
                  trailing: IconButton(
                      onPressed: () async {
                        await FlutterPhoneDirectCaller.callNumber(
                            widget.caller);
                      },
                      icon: const Icon(
                        Icons.call,
                        size: 35,
                        color: Colors.black,
                      )),
                  subtitle: Row(
                    children: [
                      SizedBox(
                        // color: Colors.red,
                        width: 170,
                        child: Text(
                          widget.caller,
                          style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 17,
                              overflow: TextOverflow.ellipsis),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: InkWell(
                          onTap: () async {
                            await Clipboard.setData(
                                ClipboardData(text: widget.caller));
                          },
                          child: const Icon(
                            Icons.copy,
                            color: Colors.black,
                          ),
                        ),
                      )
                    ],
                  ),
                  leading: (valueChanger.contactList[
                                                      valueChanger.contactList2[widget.caller]] !=
                                                  null &&
                                              valueChanger
                                                      .contactList[
                                                          valueChanger.contactList2[widget.caller]]
                                                      .avatar
                                                      .length >
                                                  0)
                                          ? CircleAvatar(
                                              backgroundImage: MemoryImage(
                                                  valueChanger
                                                      .contactList[
                                                          valueChanger.contactList2[widget.caller]]
                                                      .avatar),
                                              radius: 30,
                                            )
                                          :valueChanger.contactList2[widget.caller]!=null? CircleAvatar(
                                              radius: 30,
                                              child: Text(
                                                valueChanger.contactList2[widget.caller][0],
                                                textScaleFactor: 1.4,
                                              ),
                                            ):const CircleAvatar(
                                              radius: 30,
                                              child: Text(
                                                "#",
                                                textScaleFactor: 1.4,
                                              ),
                                            ),
                ),
              ),
            );
          }),
          !isLoading
              ? Expanded(
                  child: ListView.builder(
                      itemCount: listOfLogs.length,
                      itemBuilder: (context, index) {
                        CallLogEntry currentLog1 = listOfLogs[index];
                        CallType incoming = CallType.incoming;
                        CallType outgoing = CallType.outgoing;
                        CallType missed = CallType.missed;
                        CallType rejected = CallType.rejected;
                        String callingType = "";

                        DateTime currentDate1 =
                            DateTime.fromMillisecondsSinceEpoch(
                                currentLog1.timestamp!);
                        String currentDate =
                            DateFormat('yMd').format(currentDate1);

                        if (currentLog1.callType == incoming) {
                          callingType = "Incoming";
                        } else if (currentLog1.callType == outgoing) {
                          callingType = "Outgoing";
                        } else if (currentLog1.callType == missed) {
                          callingType = "Missed";
                        } else if (currentLog1.callType == rejected) {
                          callingType = "Rejected";
                        }

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
                                            "Yesterday",
                                            textScaleFactor: 1.3,
                                          )
                                        : Text(
                                            DateFormat.yMMMMd('en_US')
                                                .format(currentDate1),
                                            textScaleFactor: 1.3,
                                          ),
                              ),
                              CallLogsExtend1(
                                  currentLog1, callingType, currentDate1)
                            ],
                          );
                        }

                        if (listOfLogs.length > 1 && index != 0) {
                          CallLogEntry previousLog = listOfLogs[index - 1];

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
                                  padding: const EdgeInsets.only(top: 15),
                                  height: 50,
                                  child: const Text(
                                    "Yesterday",
                                    textScaleFactor: 1.3,
                                  ),
                                ),
                                CallLogsExtend1(
                                    currentLog1, callingType, currentDate1)
                              ],
                            );
                          }
                          if (previousDate == currentDate) {
                            return CallLogsExtend1(
                                currentLog1, callingType, currentDate1);
                          }
                          if (currentDate != previousDate) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  padding: const EdgeInsets.only(top: 15),
                                  height: 50,
                                  child: Text(
                                    DateFormat.yMMMMd('en_US')
                                        .format(currentDate1),
                                    textScaleFactor: 1.3,
                                  ),
                                ),
                                CallLogsExtend1(
                                    currentLog1, callingType, currentDate1)
                              ],
                            );
                          }
                        } else {
                          return const SizedBox(
                            height: 0,
                          );
                        }
                        return null;
                      }))
              : const Center(
                  child: CircularProgressIndicator(),
                ),
        ],
      )),
    );
  }
}

Widget CallLogsExtend1(currentLog, callingType, currentDate1) {
  formattedTime2(int time) // --> time in form of seconds
  {
    var hour = (time / 3600).floor();
    String h = "";
    var minute = ((time / 3600 - hour) * 60).floor();
    String m = "";
    var second = ((((time / 3600 - hour) * 60) - minute) * 60).floor();
    String s = "";

    if (hour.toInt() == 0) {
      h = "";
    } else {
      hour = hour.toInt();
      h = hour.toString();
      h = h + "h";
    }

    if (minute.toInt() == 0) {
      m = "";
    } else {
      minute = minute.toInt();
      m = minute.toString();
      m = m + "m";
    }
    if (second.toInt() == 0) {
      second = 0;
      s = "0s";
    } else {
      second = second.toInt();
      s = second.toString();
      s = s + "s";
    }
    String time1 = h + " " + m + " " + s;

    // final String setTime = [
    //   if (hour > 0) hour.toString().padLeft(2, "0"),
    //   minute.toString().padLeft(2, "0"),
    //   second.toString().padLeft(2, '0'),
    // ].join(':');
    return time1;
  }

  return ListTile(
    tileColor: const Color.fromARGB(79, 127, 255, 212),
    // iconColor: const Color(0xff7FFFD4),
    textColor: Colors.white,
    // collapsedBackgroundColor: const Color.fromARGB(82, 127, 255, 212),
    title: Text(
      callingType,
      overflow: TextOverflow.ellipsis,
      textScaleFactor: 1.2,
    ),
    trailing: currentLog.duration != 0
        ? const Text("")
        : const Icon(
            Icons.cancel,
            color: Colors.blueGrey,
          ),
    subtitle: Padding(
      padding: const EdgeInsets.only(left: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(DateFormat.jm().format(currentDate1)),
          ),
          Text(formattedTime2(currentLog.duration))
        ],
      ),
    ),
    leading: CircleAvatar(
      backgroundColor: Colors.transparent,
      radius: 30,
      child: callingType == "Outgoing"
          ? const Icon(
              Icons.call_made,
              color: Colors.orangeAccent,
              size: 30,
            )
          : callingType == "Incoming"
              ? const Icon(
                  Icons.call_received,
                  color: Colors.green,
                  size: 30,
                )
              : callingType == "Missed"
                  ? const Icon(
                      Icons.call_missed,
                      color: Colors.red,
                      size: 30,
                    )
                  : const Icon(
                      Icons.call_end,
                      color: Colors.yellow,
                      size: 30,
                    ),
    ),
  );
}
