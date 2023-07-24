// import 'dart:async';
import 'package:azlistview/azlistview.dart';
import 'package:call_log/call_log.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';

class azList extends ISuspensionBean {
  String title;
  String tag;
  String number;
  azList({required this.title, required this.tag, required this.number});

  @override
  String getSuspensionTag() => tag;
}

class ContactProvider extends ChangeNotifier {
  final Map<String, Contact> _contactList = {};

  get contactList => _contactList;

  void setContact(String key, Contact value) {
    _contactList[key] = value;
    notifyListeners();
  }

  final Map<String, String> _contactList2 = {};

  get contactList2 => _contactList2;

  void setContact2(String key, String value) {
    _contactList2[key] = value;
  }

  void delContact2(String number) {}

  List<azList> _azContactList = [];
  final List<azList> _tempAzContactList = [];

  get azContactList => _azContactList;

  void setAzContactList(String name, String number, Contact contact) {
    azList item =
        azList(title: name, tag: name[0].toUpperCase(), number: number);
    _azContactList.add(item);
    _tempAzContactList.add(item);
    _contactList[name] = contact;
    _contactList2[number] = name;
    notifyListeners();
  }

  void azContactListDelete(String name, String number) {
    azList valuetodelete = azList(title: "", tag: "", number: "");
    for (azList entry in _azContactList) {
      if (entry.title == name) {
        valuetodelete = entry;
        break;
      }
    }
    _azContactList.remove(valuetodelete);
    _tempAzContactList.remove(valuetodelete);
    _contactList2.remove(number);
    _contactList.remove(name);
    print("The valuechanger in call log history is :${_contactList2[number]}");
    notifyListeners();
  }

  void searchAllContacts(String value) {
    _azContactList = [];
    // List<azList> valueFind;
    if (value != "" || value.isEmpty) {
      for (int i = 0; i < _tempAzContactList.length; i++) {
        if (_tempAzContactList[i].number.contains(value) ||
            _tempAzContactList[i]
                .title
                .toLowerCase()
                .contains(value.toLowerCase())) {
          _azContactList.add(_tempAzContactList[i]);
        }
      }
    } else {
      _azContactList = _tempAzContactList;
    }
    notifyListeners();
  }

  List<CallLogEntry> _CallLogEnteries = [];
  List<CallLogEntry> _tempLogEntries = [];

  get callLogEnteries => _CallLogEnteries;
  get temLogEntries => _tempLogEntries;

  void setCallLogEntries(List<CallLogEntry> value) {
    print("The loading is working");
    _CallLogEnteries = [];
    _tempLogEntries = [];
    _CallLogEnteries = value;
    _tempLogEntries = value;
    notifyListeners();
  }

  void setSearchLogEntries(String value) {
    _tempLogEntries = [];
    var value1 = value.toLowerCase();
    if (value1 == "" || value1.isEmpty) {
      _tempLogEntries = _CallLogEnteries;
    } else {
      for (int i = 0; i < _CallLogEnteries.length; i++) {
        if (_CallLogEnteries[i].name!.toLowerCase().contains(value1) ||
            _CallLogEnteries[i].number!.contains(value1)) {
          _tempLogEntries.add(_CallLogEnteries[i]);
        }
      }
    }

    // var value1 = value.toLowerCase();

    //   if (value.replaceAll(" ", "") == "" || value.isEmpty) {
    //     _tempAzContactList = _azContactList;
    //   }
    //   // print("yhe value of the search list is :${value}");

    //   // <CallLogEntry> tempValue;
    //  else{
    //    if (value != "" || value.isNotEmpty) {
    //     for (CallLogEntry entry in _CallLogEnteries) {
    //       if (entry.number!.contains(value) ||
    //           entry.name!.toLowerCase().contains(value)) {
    //         _tempLogEntries.add(entry);
    //       }
    //     }
    //   } else {
    //     _tempLogEntries = _CallLogEnteries;
    //   }
    //  }
    notifyListeners();
  }

  bool _isLoading = true;

  get isLoading => _isLoading;

  void setIsLoading() {
    _isLoading = false;
    notifyListeners();
  }

  // void clearCallLogEntries() {
  //   _CallLogEnteries=[];
  //   notifyListeners();
  // }
}
