import 'package:flutter/material.dart';

import '../models/contact_model.dart';
import '../pages/contact_details_page.dart';

class ContactRowItem extends StatefulWidget {
  final ContactModel contact;
  const ContactRowItem(this.contact, {super.key});

  @override
  State<ContactRowItem> createState() => _ContactRowItemState();
}

class _ContactRowItemState extends State<ContactRowItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: Card(
        color: Colors.grey,
        elevation: 5,
        child: ListTile(
          onTap: () {
            Navigator.pushNamed(context, ContactDetailsPage.routeName,
                arguments: widget.contact.id);
          },
          title: Text(widget.contact.name),
          tileColor: Colors.blue,
          titleTextStyle: const TextStyle(
            color: Colors.white,
          ),
          subtitle: Text(widget.contact.designation),
          subtitleTextStyle: const TextStyle(
            color: Colors.white,
          ),
          trailing: Icon(widget.contact.isFavorite
              ? Icons.favorite
              : Icons.favorite_border),
        ),
      ),
    );
  }
}
