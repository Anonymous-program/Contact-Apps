import 'package:contact_app/pages/contact_details_page.dart';
import 'package:contact_app/pages/new_contact_page.dart';
import 'package:contact_app/pages/scan_page.dart';
import 'package:flutter/material.dart';
import 'pages/contact_list_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: ContactListPage.routeName,
      routes: {
        ContactListPage.routeName: (page) => const ContactListPage(),
        NewContactPage.routeName: (page) => const NewContactPage(),
        ContactDetailsPage.routeName: (page) => const ContactDetailsPage(),
        ScanPage.routeName: (page) => const ScanPage(),
      },
    );
  }
}
