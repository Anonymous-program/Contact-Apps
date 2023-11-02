import 'package:contact_app/db/sqlite_helper.dart';
import 'package:contact_app/models/contact_model.dart';
import 'package:flutter/material.dart';

class ContactDetailsPage extends StatefulWidget {
  static const String routeName = '/details';
  const ContactDetailsPage({super.key});

  @override
  State<ContactDetailsPage> createState() => _ContactDetailsPageState();
}

class _ContactDetailsPageState extends State<ContactDetailsPage> {
  int? id;
  bool _isLoading = true;
  late ContactModel _contactModel;

  @override
  void didChangeDependencies() {
    id = ModalRoute.of(context)!.settings.arguments as int;
    SqliteHelper.getContactById(id!).then((contact) {
      _contactModel = contact;
      setState(() {
        _isLoading = false;
      });
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
      ),
      body: Center(
        child: _isLoading
            ? const CircularProgressIndicator()
            : Column(
                children: [
                  Card(
                    elevation: 5,
                    child: ListTile(
                      title: Text(_contactModel.name),
                      subtitle: Text(_contactModel.designation),
                    ),
                  ),
                  Card(
                    elevation: 5,
                    child: ListTile(
                        title: Text(_contactModel.mobile),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                                onPressed: () {}, icon: const Icon(Icons.sms)),
                            IconButton(
                                onPressed: () {}, icon: const Icon(Icons.call)),
                          ],
                        )),
                  ),
                  Card(
                    elevation: 5,
                    child: ListTile(
                      title: Text(_contactModel.email),
                      trailing: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.email),
                      ),
                    ),
                  ),
                  Card(
                    elevation: 5,
                    child: ListTile(
                      title: Text(_contactModel.address),
                      trailing: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.my_location),
                      ),
                    ),
                  ),
                  Card(
                    elevation: 5,
                    child: ListTile(
                      title: Text(_contactModel.website),
                      trailing: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.web),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
