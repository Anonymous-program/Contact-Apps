import 'package:contact_app/db/sqlite_helper.dart';
import 'package:contact_app/models/contact_model.dart';
import 'package:contact_app/utils/helper_function.dart';
import 'package:flutter/material.dart';

import '../utils/constant.dart';

class NewContactPage extends StatefulWidget {
  static const String routeName = '/new_contact';
  const NewContactPage({super.key});
  @override
  State<NewContactPage> createState() => _NewContactPageState();
}

class _NewContactPageState extends State<NewContactPage> {
  @override
  final _nameController = TextEditingController();
  final _companyNameController = TextEditingController();
  final _designationController = TextEditingController();
  final _addressController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _websiteController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void didChangeDependencies() {
    final contact = ModalRoute.of(context)!.settings.arguments as ContactModel;
    super.didChangeDependencies();
    _setPropertiesToTextFields(contact);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _companyNameController.dispose();
    _designationController.dispose();
    _addressController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _websiteController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'New Contact',
          style: TextStyle(),
        ),
        actions: [
          IconButton(onPressed: _contactSave, icon: const Icon(Icons.save)),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              child: TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  labelText: 'Contact Name',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.cyan),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return emptyFieldMsg;
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              child: TextFormField(
                controller: _companyNameController,
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.group_add),
                    labelText: 'Company Name',
                    border: OutlineInputBorder()),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return emptyFieldMsg;
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              child: TextFormField(
                controller: _designationController,
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.description),
                    labelText: 'Designation',
                    border: OutlineInputBorder()),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return emptyFieldMsg;
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              child: TextFormField(
                controller: _addressController,
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.location_on_rounded),
                    labelText: 'Street Address',
                    border: OutlineInputBorder()),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return emptyFieldMsg;
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              child: TextFormField(
                keyboardType: TextInputType.phone,
                controller: _phoneController,
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.phone),
                    labelText: 'Mobile No',
                    border: OutlineInputBorder()),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return emptyFieldMsg;
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: _emailController,
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.email),
                    labelText: 'Email Address',
                    border: OutlineInputBorder()),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return emptyFieldMsg;
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              child: TextFormField(
                controller: _websiteController,
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.web),
                    labelText: 'Website',
                    border: OutlineInputBorder()),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return emptyFieldMsg;
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _contactSave() async {
    if (_formKey.currentState!.validate()) {
      final contact = ContactModel(
        name: _nameController.text,
        companyName: _companyNameController.text,
        designation: _designationController.text,
        address: _addressController.text,
        email: _emailController.text,
        mobile: _phoneController.text,
        website: _websiteController.text,
      );
      final rowId = await SqliteHelper.insertNewContact(contact);
      if (rowId > 0) {
        Navigator.pop(context, true);
      } else {
        showMessage(context, 'Failed to save');
      }
    }
  }

  void _setPropertiesToTextFields(ContactModel contact) {
    if (mounted) {
      setState(() {
        _nameController.text = contact.name;
        _companyNameController.text = contact.companyName;
        _designationController.text = contact.designation;
        _addressController.text = contact.address;
        _phoneController.text = contact.mobile;
        _emailController.text = contact.email;
        _websiteController.text = contact.website;
      });
    }
  }
}
