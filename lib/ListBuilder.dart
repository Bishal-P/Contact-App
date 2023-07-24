import 'package:flutter/material.dart';

import 'package:contacts_service/contacts_service.dart';

Widget ListBuilder(Contact name1,phone,displayname) {
  Contact contac = name1;
  return ListTile(
    leading: (contac.avatar != null && contac.avatar!.isNotEmpty)
        ? CircleAvatar(backgroundImage: MemoryImage(contac.avatar!))
        : CircleAvatar(
            child: Text(contac.initials()),
          ),
    title: Text(contac.displayName.toString()),
    subtitle: Text(phone),
  );
}
