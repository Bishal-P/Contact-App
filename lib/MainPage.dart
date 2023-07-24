// ignore_for_file: non_constant_identifier_names, camel_case_types, file_names

import 'package:azlistview/azlistview.dart';
import 'package:contactapp2/CallLogHistory.dart';
import 'package:contactapp2/providers/contactprovider.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swipeable_tile/swipeable_tile.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  var CurrentIndex = 0;
  // List<Contact> contacts = [];
  List<azList> itemsInAzList = [];
  // List<azList> tempList = [];
  TextEditingController searchController = TextEditingController();
  // late Contact contact1;
  bool isLoading = false;
  // final ScrollController _controller = ScrollController();
  @override
  void initState() {
    // final contactprov = Provider.of<ContactProvider>(context, listen: false);
    // contactprov.getAllContacts(true);
    // print("the value of pro is :${contactprov.contactList2}");

    super.initState();
  }

  // fetchContacts() async {
  //   // contacts = await ContactsService.getContacts(withThumbnails: false);
  //   final contactprov = Provider.of<ContactProvider>(context, listen: false);
  //   // itemsInAzList = contactprov.contactList2
  //   //     .map((item) => azList(
  //   //         title:item[],
  //   //         tag: item.displayName![0].toUpperCase(),
  //   //         number: item.phones!.isNotEmpty
  //   //             ? item.phones![0].value.toString()
  //   //             : "#"))
  //   //     .toList();
  //   contactprov.contactList2.forEach((key, value) =>
  //       itemsInAzList.add(azList(title: value, tag: value[0], number: key)));
  //   print(itemsInAzList);

  //   tempList = itemsInAzList;

  //   // print("The contact list is :$contacts");
  //   // print("THe length is : ${contacts.length}");
  //   isLoading = false;
  //   try {
  //     setState(() {});
  //   } on FlutterError catch (e) {
  //     print("Exception handled :$e");
  //   }
  // }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // searchController.clear();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
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
                        builder: (context, valuechanger, child) {
                      return TextField(
                        autofocus: false,
                        controller: searchController,
                        onChanged: (value) {
                          valuechanger.searchAllContacts(value);
                          // print("THe value is ${value}");
                          // itemsInAzList = [];
                          // searchList() {
                          // for (int i = 0; i < tempList.length; i++) {
                          //   if (tempList[i]
                          //           .title
                          //           .toUpperCase()
                          //           .contains(value.toUpperCase()) ||
                          //       tempList[i].number.contains(value)) {
                          //     itemsInAzList.add(tempList[i]);
                          //   }
                          //   setState(() {});
                          // }
                          // }

                          // if (value.isEmpty) {
                          //   itemsInAzList = tempList;
                          //   setState(() {});
                          // } else {
                          //   searchList();
                          // }

                          // setState(() {});
                        },
                        decoration: InputDecoration(
                          suffixIcon: searchController.text.isEmpty
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
                                    searchController.clear();
                                    valuechanger.searchAllContacts("");
                                    // setState(() {
                                    //   itemsInAzList = tempList;
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
                        child: const Icon(
                          Icons.add,
                          weight: 1000,
                        ),
                      ),
                      onTap: () async {
                        try {
                          await ContactsService.openContactForm();
                        } on FormOperationException catch (e) {
                          switch (e.errorCode) {
                            case FormOperationErrorCode.FORM_OPERATION_CANCELED:
                            case FormOperationErrorCode.FORM_COULD_NOT_BE_OPEN:
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
            Consumer<ContactProvider>(builder: (context, valuechanger, child) {
              // valuechanger.azContactList;
              itemsInAzList = valuechanger.azContactList;
              return Expanded(
                child: !valuechanger.isLoading
                    ? Padding(
                        padding:
                            const EdgeInsets.only(top: 8, left: 8, right: 8),
                        child: AzListView(
                            // itemScrollController: _controller,
                            data: itemsInAzList,
                            // padding: const EdgeInsets.only(left: 50),
                            // controller: _controller,
                            // primary: false,
                            physics: const AlwaysScrollableScrollPhysics(),
                            itemCount: itemsInAzList.length,
                            itemBuilder: (context, index) {
                              itemsInAzList.sort((a, b) => a.title
                                  .toLowerCase()
                                  .compareTo(b.title.toLowerCase()));
                              azList contactIndex = itemsInAzList[index];
                              // var phone = "";
                              // if (contact1.phones!.isEmpty) {
                              //   phone = "No number";
                              // } else {
                              //   phone = contact1.phones![0].value.toString();
                              // }
                              return SwipeableTile(
                                
                                  // resizeDuration: Duration(seconds: 2),
                                  borderRadius: 20,
                                  color: const Color.fromARGB(255, 0, 0, 0),
                                  swipeThreshold: 0.8,
                                  direction: SwipeDirection.startToEnd,
                                  onSwiped: (direction) {
                                    
                                    setState(() {});
                                    // Here call setState to update state
                                  },
                                  backgroundBuilder:
                                      (context, direction, progress) {
                                    if (direction ==
                                        SwipeDirection.endToStart) {
                                      // return your widget
                                    } else if (direction ==
                                            SwipeDirection.startToEnd &&
                                        progress.value > 0.5) {
                                          FlutterPhoneDirectCaller.callNumber(
                                    contactIndex.number);
                                      print(
                                          "Name : ${contactIndex.title} , Number :${contactIndex.number}");

                                      // return your widget
                                    }
                                    return AnimatedBuilder(
                                      animation: progress,
                                      builder: (context, child) {
                                        return AnimatedContainer(
                                          // decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.red])),
                                          duration:
                                              const Duration(milliseconds: 400),
                                          color: progress.value > 0.8
                                              ? const Color(0xFFed7474)
                                              : const Color(0xff40E0D0),
                                        );
                                      },
                                    );
                                  },
                                  key: UniqueKey(),
                                  child: InkWell(
                                      child: Padding(
                                    padding: const EdgeInsets.only(right: 30),
                                    child: ExpansionTile(
                                      iconColor: const Color(0xff7FFFD4),
                                      textColor: const Color(0xff7FFFD4),
                                      collapsedBackgroundColor:
                                          const Color.fromARGB(
                                              82, 127, 255, 212),
                                      title: Text(
                                        contactIndex.title,
                                        overflow: TextOverflow.ellipsis,
                                        textScaleFactor: 1.2,
                                      ),
                                      subtitle: Text(
                                        contactIndex.number,
                                        textScaleFactor: 0.8,
                                      ),
                                      leading: (valuechanger.contactList[
                                                      contactIndex.title] !=
                                                  null &&
                                              valuechanger
                                                      .contactList[
                                                          contactIndex.title]
                                                      .avatar
                                                      .length >
                                                  0)
                                          ? CircleAvatar(
                                              backgroundImage: MemoryImage(
                                                  valuechanger
                                                      .contactList[
                                                          contactIndex.title]
                                                      .avatar),
                                              radius: 30,
                                            )
                                          : CircleAvatar(
                                              radius: 30,
                                              child: Text(
                                                contactIndex.tag,
                                                textScaleFactor: 1.4,
                                              ),
                                            ),
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            IconButton(
                                                onPressed: () async {
                                                  await FlutterPhoneDirectCaller
                                                      .callNumber(
                                                          itemsInAzList[index]
                                                              .number);
                                                },
                                                icon: const Icon(
                                                  Icons.call,
                                                  color: Color(0xff7FFFD4),
                                                  size: 30,
                                                )),
                                            IconButton(
                                                onPressed: () {
                                                  String num =
                                                      itemsInAzList[index]
                                                          .number;
                                                  num = num.replaceAll(" ", "");
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (_) =>
                                                              CallLogHistory(
                                                                  num)));
                                                },
                                                icon: const Icon(
                                                  Icons.history,
                                                  color: Color(0xff7FFFD4),
                                                  size: 30,
                                                )),
                                            IconButton(

                                                //                               onPressed: () async {
                                                // try {
                                                //   var contactName = itemsInAzList[CurrentIndex].title;
                                                //   List<Contact> contactQuery =
                                                //       await ContactsService.getContacts(query: contactName);

                                                //   // await ContactsService.openExistingContact(contactQuery[0]);
                                                //   await ContactsService.openContactForm();

                                                //   print("THe selected name is : $contactName");
                                                // } on FormOperationException {
                                                //   Navigator.push(context, MaterialPageRoute(builder: (_) => Page4()));
                                                //   // print("an error occuered :$e");
                                                // } on TypeError {
                                                //   print("Type error occured");
                                                // }

                                                onPressed: () async {
                                                  try {
                                                    // for (int i = 0;
                                                    //     i < contacts.length;
                                                    //     i++) {
                                                    //   if (contacts[i]
                                                    //           .displayName ==
                                                    //       itemsInAzList[index]
                                                    //           .title) {
                                                    await ContactsService
                                                        .openExistingContact(
                                                            valuechanger
                                                                    .contactList[
                                                                itemsInAzList[
                                                                        index]
                                                                    .title]);
                                                    // print(
                                                    //     "The name of the contact is ${contacts[i].displayName}");
                                                    // }
                                                    // }
                                                  } on FormOperationException catch (e) {
                                                    switch (e.errorCode) {
                                                      case FormOperationErrorCode
                                                            .FORM_OPERATION_CANCELED:
                                                      case FormOperationErrorCode
                                                            .FORM_COULD_NOT_BE_OPEN:
                                                      case FormOperationErrorCode
                                                            .FORM_OPERATION_UNKNOWN_ERROR:
                                                      default:
                                                      // print(e.errorCode);
                                                    }
                                                  }
                                                },
                                                icon: const Icon(
                                                  Icons.edit,
                                                  color: Color(0xff7FFFD4),
                                                  size: 30,
                                                )),
                                            IconButton(
                                                onPressed: () async {
                                                  Contact contactToDelete =
                                                      valuechanger.contactList[
                                                          itemsInAzList[index]
                                                              .title];
                                                  var value = ContactsService
                                                      .deleteContact(
                                                          contactToDelete);

                                                  print(
                                                      "The value of the value is :$value");
                                                  // valuechanger.contactList
                                                  //     .remove(
                                                  //         itemsInAzList[index]
                                                  //             .number);
                                                  // valuechanger.contactList2
                                                  //     .remove(
                                                  //         itemsInAzList[index]
                                                  //             .title);
                                                  valuechanger
                                                      .azContactListDelete(
                                                          itemsInAzList[index]
                                                              .title,
                                                          itemsInAzList[index]
                                                              .number);
                                                  // List<Contact> nameToDelete =
                                                  //     await ContactsService
                                                  //         .getContacts(
                                                  //             query:
                                                  //                 itemsInAzList[
                                                  //                         index]
                                                  //                     .title);
                                                  // var value =
                                                  //     await ContactsService
                                                  //         .deleteContact(
                                                  //             nameToDelete[0]);
                                                  // // print(
                                                  // //     "THe value of var is :${value}");
                                                  // if (value == null) {
                                                  //   Navigator.push(
                                                  //       context,
                                                  //       MaterialPageRoute(
                                                  //           builder: (_) =>
                                                  //               const MainPage()));
                                                  // }
                                                },
                                                icon: const Icon(
                                                  Icons.delete,
                                                  color: Color(0xff7FFFD4),
                                                  size: 30,
                                                ))
                                          ],
                                        )
                                      ],
                                    ),
                                  )
                                      // child: Container(
                                      //   decoration: BoxDecoration(
                                      //       color: const Color.fromARGB(
                                      //           134, 202, 198, 198),
                                      //       borderRadius:
                                      //           BorderRadius.circular(20)),
                                      //   child: Row(
                                      //     children: [
                                      //       Padding(
                                      //         padding: const EdgeInsets.all(5.0),
                                      // child: CircleAvatar(
                                      //   radius: 30,
                                      //   child: Text(contactIndex.tag),
                                      //         ),
                                      //       ),
                                      //       Expanded(
                                      //           child: Column(
                                      //         crossAxisAlignment:
                                      //             CrossAxisAlignment.start,
                                      //         children: [
                                      //           Padding(
                                      //             padding:
                                      //                 const EdgeInsets.all(8.0),
                                      //             child: Text(
                                      // contactIndex.title,
                                      // overflow: TextOverflow.ellipsis,
                                      // textScaleFactor: 1.4,
                                      //             ),
                                      //           ),
                                      //           Padding(
                                      //             padding: const EdgeInsets.only(
                                      //                 left: 8.0),
                                      //             child: Text(
                                      // contactIndex.number,
                                      // textScaleFactor: 0.8,
                                      //             ),
                                      //           )
                                      //         ],
                                      //       ))
                                      //     ],
                                      //   ),
                                      // ),
                                      ) // Here Tile which will be shown at the top
                                  );
                            }),
                      )
                    : const Center(
                        child: CircularProgressIndicator(),
                      ),
              );
            })
          ],
        ),
      ),
    );
  }
}
