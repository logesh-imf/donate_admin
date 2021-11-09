import 'package:flutter/material.dart';
import 'package:donate_admin/design.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:donate_admin/pages/allusers.dart';
import 'package:donate_admin/pages/donations.dart';
import 'package:donate_admin/pages/requests.dart';
import 'package:provider/provider.dart';
import 'package:donate_admin/firebase/users.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int activePage = 0;
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AllUsersFirebase>(
            create: (context) => AllUsersFirebase())
      ],
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Design.backgroundColor,
          leading: const Image(
            image: AssetImage('images/donate_logo.png'),
          ),
          title: const Text('Donate Now Admin console'),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.logout))
          ],
        ),
        body: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 250,
              color: Colors.grey[350],
              child: Column(
                children: [
                  Container(
                    height: 40,
                    color: (activePage == 0) ? Colors.white : Colors.grey[350],
                    child: Row(
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          color: (activePage == 0)
                              ? Design.backgroundColor
                              : Colors.grey[400],
                          child: Icon(Icons.supervised_user_circle_sharp,
                              color: (activePage == 0)
                                  ? Colors.white
                                  : Colors.black),
                        ),
                        const SizedBox(width: 10),
                        TextButton(
                            onPressed: () {
                              setState(() {
                                activePage = 0;
                              });
                            },
                            child: Container(
                              child: Text(
                                'All Users',
                                style: TextStyle(
                                    color: (activePage == 0)
                                        ? Design.backgroundColor
                                        : Colors.black),
                              ),
                            ))
                      ],
                    ),
                  ),
                  Container(
                    height: 40,
                    color: (activePage == 1) ? Colors.white : Colors.grey[350],
                    child: Row(
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          color: (activePage == 1)
                              ? Design.backgroundColor
                              : Colors.grey[400],
                          child: Icon(Icons.volunteer_activism,
                              color: (activePage == 1)
                                  ? Colors.white
                                  : Colors.black),
                        ),
                        const SizedBox(width: 10),
                        TextButton(
                            onPressed: () {
                              setState(() {
                                activePage = 1;
                              });
                            },
                            child: Container(
                              child: Text(
                                'Donations',
                                style: TextStyle(
                                    color: (activePage == 1)
                                        ? Design.backgroundColor
                                        : Colors.black),
                              ),
                            ))
                      ],
                    ),
                  ),
                  Container(
                    height: 40,
                    color: (activePage == 2) ? Colors.white : Colors.grey[350],
                    child: Row(
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          color: (activePage == 2)
                              ? Design.backgroundColor
                              : Colors.grey[400],
                          child: Center(
                              child: FaIcon(FontAwesomeIcons.handsHelping,
                                  color: (activePage == 2)
                                      ? Colors.white
                                      : Colors.black)),
                        ),
                        const SizedBox(width: 10),
                        TextButton(
                            onPressed: () {
                              setState(() {
                                activePage = 2;
                              });
                            },
                            child: Container(
                              child: Text(
                                'Requests',
                                style: TextStyle(
                                    color: (activePage == 2)
                                        ? Design.backgroundColor
                                        : Colors.black),
                              ),
                            ))
                      ],
                    ),
                  ),
                ],
              ),
            ),
            (activePage == 0)
                ? AllUsers()
                : (activePage == 1)
                    ? Donations()
                    : Requests()
          ],
        ),
      ),
    );
  }
}
