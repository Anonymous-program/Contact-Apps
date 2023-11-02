import 'package:contact_app/db/sqlite_helper.dart';
import 'package:contact_app/models/contact_model.dart';
import 'package:contact_app/pages/scan_page.dart';
import 'package:flutter/material.dart';
import '../custom_widget/coonract_row_item.dart';
import 'new_contact_page.dart';

class ContactListPage extends StatefulWidget {
  static const String routeName = '/';
  const ContactListPage({super.key});

  @override
  State<ContactListPage> createState() => _ContactListPageState();
}

class _ContactListPageState extends State<ContactListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: const Text(
          'Contact List',
          style: TextStyle(
            color: Colors.white,
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
      body: FutureBuilder<List<ContactModel>>(
          future: SqliteHelper.getAllContacts(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final contactList = snapshot.data!;
              return ListView.builder(
                itemCount: contactList.length,
                itemBuilder: (context, index) {
                  final contact = contactList[index];
                  return ContactRowItem(contact);
                },
              );
            }
            if (snapshot.hasError) {
              return const Center(
                child: Text('failed to load data'),
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.pushNamed(context, ScanPage.routeName);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
