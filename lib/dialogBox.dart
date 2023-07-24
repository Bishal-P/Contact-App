// import 'package:contacts_service/contacts_service.dart';
// ignore_for_file: must_be_immutable

import 'package:contactapp2/providers/contactprovider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:provider/provider.dart';
import 'package:contacts_service/contacts_service.dart' as cs;

class CreateContactDialogBox extends StatefulWidget {
  CreateContactDialogBox(this.value, {super.key});
  String value;

  @override
  State<CreateContactDialogBox> createState() => _CreateContactDialogBoxState();
}

class _CreateContactDialogBoxState extends State<CreateContactDialogBox> {
  TextEditingController contactNumberController = TextEditingController();
  TextEditingController contactNameController = TextEditingController();
  @override
  void initState() {
    contactNumberController.text = widget.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // contactNameController.text = "Helo";
    // String val = widget.value;

    return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          height: 300,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: const Color.fromARGB(255, 52, 95, 104),
          ),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 25),
                child: Text(
                  "Create new contact",
                  textScaleFactor: 1.4,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Name",
                    // labelText: "Name",
                    floatingLabelAlignment: FloatingLabelAlignment.start,
                    // labelStyle: TextStyle(fontSize: 20, color: Colors.white),
                    contentPadding: const EdgeInsets.all(15),
                    prefixIcon: const Icon(Icons.verified_user),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(25.7),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(25.7),
                    ),
                  ),
                  controller: contactNameController,
                  // initialValue: widget.value,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Phone Number",
                    // labelText: "Name",
                    floatingLabelAlignment: FloatingLabelAlignment.start,
                    // labelStyle: TextStyle(fontSize: 20, color: Colors.white),
                    contentPadding: const EdgeInsets.all(15),
                    prefixIcon: const Icon(Icons.verified_user),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(25.7),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(25.7),
                    ),
                  ),
                  controller: contactNumberController,
                  // initialValue: widget.value,
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Consumer<ContactProvider>(
                      builder: (context, valueChanger, child) {
                    return Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text("Cancel")),
                          Padding(
                            padding: const EdgeInsets.only(right: 25, left: 30),
                            child: TextButton(
                                onPressed: () async {
                                  final newContact = Contact();
                                  newContact.name.first =
                                      contactNameController.text;
                                  newContact.phones = [
                                    Phone(contactNumberController.text)
                                  ];
                                  FlutterContacts.insertContact(newContact);
                                  cs.Contact newContact1 = cs.Contact();

                                  newContact1.displayName =
                                      contactNameController.text;

                                  cs.Item phone = cs.Item(
                                      label: "Mobile",
                                      value: contactNumberController.text);
                                  newContact1.phones = [phone];

                                  valueChanger.setAzContactList(
                                      contactNameController.text,
                                      contactNumberController.text,
                                      newContact1);
                                  // newContact.displayName = contactNameController.text;
                                  // newContact.phones = [
                                  //   Item(
                                  //       label: "mobile",
                                  //       value: contactNumberController.text)
                                  // ];
                                  // ContactsService.addContact(newContact);
                                  // print(
                                  //     "The new contact is : ${newContact.phones![0].value} and ${newContact.displayName}");

                                  Navigator.pop(context);
                                },
                                child: const Text("Create")),
                          )
                        ]);
                  }))
            ],
          ),
        )
        // title: const Text("Add to Contacts"),
        // content: Column(
        //   children: [
        //     TextField(
        //       controller: contactNameController,
        //     )
        //   ],
        // ),
        // content: TextField(),
        // actions: [
        // TextButton(
        //     onPressed: () {
        //       Navigator.pop(context);
        //     },
        //     child: const Text("Cancel")),
        // TextButton(
        //     onPressed: () {
        //       Navigator.pop(context);
        //     },
        //     child: const Text("Create"))
        // ],
        );
  }
}
