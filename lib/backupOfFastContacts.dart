// // import 'package:contacts_service/contacts_service.dart';
// import 'package:fast_contacts/fast_contacts.dart';
// import 'package:flutter/material.dart';
// import 'package:permission_handler/permission_handler.dart';

// void main() {
//   runApp(MaterialApp(
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
//   // List<Contact> contacts = [];
//   bool isLoading = true;
//   @override
//   void initState() {
//     checkContactsPermission();
//     super.initState();
//   }

//   checkContactsPermission() async {
//     if (await Permission.contacts.isGranted) {
//     } else {
//       Permission.contacts.request();
//     }
//   }

//   fetchContacts() async {
//     // print("The contact list is :$contacts");
//     // print("THe length is : ${contacts.length}");
//     isLoading = false;
//     // setState(() {});
//     return await FastContacts.getAllContacts();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Contacts"),
//       ),
//       body: FutureBuilder(
//         future: fetchContacts(),
//         builder: (context, AsyncSnapshot snapshot) {
//           if (snapshot.data == null) {
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           }
//           return ListView.builder(
//               itemCount: snapshot.data.length,
//               itemBuilder: (context, index) {
//                 var phone = "";
//                 Contact contact1 = snapshot.data[index];
//                 List<Phone> ph = contact1.phones;
//                 if (ph.isEmpty) {
//                   // print("The list is empty ");
//                   phone = "No Number";
//                 } else {
//                   phone = contact1.phones[0].number;
//                 }
//                 return ListTile(
//                   leading: CircleAvatar(
//                     child: Text(contact1.displayName[0].toString()),
//                   ),
//                   title: Text(contact1.displayName),
//                   subtitle: Text(phone),
//                 );
//               });
//         },
//       ),
//     );
//   }
// }
