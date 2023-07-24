// // import 'package:contacts_service/contacts_service.dart';
// import 'package:fast_contacts/fast_contacts.dart';
// import 'package:flutter/material.dart';
// import 'package:permission_handler/permission_handler.dart';

// void main() {
//   runApp(const MaterialApp(
//     debugShowCheckedModeBanner: false,
//     title: "Contacts",
//     home: HomePage(),
//   ));
// }

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   List<Contact> contac = [];
//   bool isLoading = true;
//   final ScrollController _controller = ScrollController();
//   @override
//   void initState() {
//     checkContactsPermission();

//     super.initState();
//   }

//   checkContactsPermission() async {
//     if (await Permission.contacts.isGranted) {
//       fetchContacts();
//     } else {
//       Permission.contacts.request();
//     }
//   }

//   fetchContacts() async {
//     // print("The contact list is :$contacts");
//     // print("THe length is : ${contacts.length}");
//     isLoading = false;
//     // setState(() {});
//     contac = await FastContacts.getAllContacts();

//     print("the list is sorted........");
//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Contacts"),
//       ),
//       body: ListView.builder(
//         controller: _controller,
//         primary: false,
//         physics: const AlwaysScrollableScrollPhysics(),
//         itemCount: contac.length,
//         itemBuilder: (context, index) {
//           contac.sort((a, b) => a.displayName.compareTo(b.displayName));
//           // contac.sort();
//           // // var sorted = contac
//           // //   ..sort(
//           // //       (item1, item2) => item2[displayName][0].compareTo(item1));
//           // print("the sorted list is :$sorted");
//           var phone = "No Number";
//           var name = "No Name";
//           Contact contact1 = contac[index];
//           List<Phone> ph = contact1.phones;
//           if (ph.isNotEmpty) {
//             // print("The list is empty ");
//             phone = contact1.phones[0].number;
//           }
//           if (contact1.displayName.isNotEmpty) {
//             name = contact1.displayName;
//           }
//           return ListTile(
//             leading: CircleAvatar(
//               child: Text(name[0].toUpperCase()),
//             ),
//             title: Text(name),
//             subtitle: Text(phone),
//           );
//         },
//       ),
//     );
//   }
// }
// import 'package:fast_contacts/fast_contacts.dart';

// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables

import 'package:call_log/call_log.dart';
import 'package:contactapp2/CallLogs.dart';
import 'package:contactapp2/MainPage.dart';
import 'package:contactapp2/dialerPage.dart';
// import 'package:contactapp2/dialerPage.dart';
import 'package:contactapp2/dummyPages.dart';
import 'package:contactapp2/providers/contactprovider.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => ContactProvider(),
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      title: "Contacts",
      home: HomePage(0),
    ),
  ));
}

class HomePage extends StatefulWidget {
  HomePage(this.currentIndex, {super.key});

  int currentIndex;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  PageController pgController = PageController();
  List<CallLogEntry> listOfLogs = [];
  late ContactProvider contactprovder;
  bool perm = false;

  @override
  void initState() {
    checkContactsPermission();
    contactprovder = Provider.of<ContactProvider>(context, listen: false);

    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  checkContactsPermission() async {
    Map<Permission, PermissionStatus> statuses = await [
      // Permission.storage,
      Permission.contacts,
      Permission.phone
    ].request();
    print(statuses[Permission.location]);
    if (statuses[Permission.phone] == PermissionStatus.granted) {
      getLogs();
      getList();
    }

    // print(statuses[Permission.contacts]);
    // print(statuses[Permission.phone]);

    // if (await Permission.contacts.status.isDenied) {
    //   Permission.contacts.request();
    //   // fetchContacts();
    // }

    // if (await Permission.phone.status.isDenied) {
    //   Permission.phone.request();
    // }

    // Permission.unknown;
  }

  getLogs() async {
    List<CallLogEntry> temp = [];
    Iterable<CallLogEntry> entries = await CallLog.get();
    for (CallLogEntry entry in entries) {
      temp.add(entry);
    }
    contactprovder.setCallLogEntries(temp);
  }

  getList() async {
    List<Contact> contactInitial = await ContactsService.getContacts();
    for (Contact entry in contactInitial) {
      var name, number;
      try {
        if (entry.displayName == null) {
          name = entry.phones![0];
          number = name;
        } else {
          name = entry.displayName;
        }
      } on TypeError {
        name = "No record";
        number = "00000000000";
      } on RangeError {
        number = "No record";
        name = "No record";
      }
      number =
          entry.phones!.isNotEmpty ? entry.phones![0].value.toString() : "#";

      // contactprovder.setContact(name, entry);
      // contactprovder.setContact2(number, name);
      number = number.replaceAll(" ", "");
      contactprovder.setAzContactList(name, number, entry);
    }
    contactprovder.setIsLoading();
    // List<Contact> johns =
    //     await ContactsService.getContactsForPhone("7318843250");
    // print("The length of searching for contact is :${johns[0].givenName}");
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.paused:
        print("The app is paused");
        break;
      case AppLifecycleState.resumed:
        getLogs();
        print("The app is resumed");
        break;
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.detached:
        break;
    }
  }

  // int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    print("at                mainpage");
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // backgroundColor: Colors.black,
      body: PageView(
        controller: pgController,
        onPageChanged: (value) {
          widget.currentIndex = value;
          setState(() {});
        },
        children: const [CallLogs(), DialerPage(), MainPage(), Page3()],
      ),
      bottomNavigationBar: CurvedNavigationBar(
          // animationCurve: Curves.ease,
          index: widget.currentIndex,
          onTap: (value) {
            pgController.animateToPage(value,
                duration: const Duration(milliseconds: 300),
                curve: Curves.ease);
          },
          height: 60,
          buttonBackgroundColor: const Color(0xff7FFFD4),
          animationDuration: const Duration(milliseconds: 300),
          color: const Color(0xff7FFFD4),
          backgroundColor: const Color.fromARGB(255, 0, 0, 0),
          items: const [
            Icon(
              Icons.home,
              size: 30,
            ),
            Icon(Icons.call_received_outlined, size: 30),
            Icon(Icons.contact_phone_outlined, size: 30),
            Icon(Icons.phone, size: 30),
          ]),
    );
  }
}
