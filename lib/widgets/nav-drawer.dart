import 'package:flutter/material.dart';

import 'package:tracking/config/styles.dart';
import 'package:tracking/pages/single-assest.dart';
import 'package:tracking/pages/account.dart';
import 'package:tracking/pages/support.dart';
import 'package:tracking/pages/settings.dart';

// ignore: use_key_in_widget_constructors
class NavDrawer extends StatelessWidget {
  AppConfig config = AppConfig();
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 250,
        child: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                    color: config.primary,
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage('assets/images/earth.jpeg'))),
                child: Text(
                  'Side menu',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
              ExpansionTile(
                title: const Text(
                  "Main Group (16)",
                ), //add icon
                iconColor: config.primary,
                textColor: config.primary,
                childrenPadding:
                    const EdgeInsets.only(left: 15), //children padding
                children: [
                  Container(
                    height: 40, // set the desired height here
                    child: ListTile(
                      title: const SizedBox(
                        child: Text(
                          'CLIO 01089-105-90 3904-3856-89 AAAAAAAAAA',
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      trailing: const IconTheme(
                        data: IconThemeData(
                          color: Colors.blue, // set the color of the icon
                          size: 16.0, // set the size of the icon
                        ),
                        child: Icon(Icons
                            .circle), // replace "Icons.star" with your desired icon
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SingleAssest()));
                      },
                    ),
                  ),
                  Container(
                    height: 40, // set the desired height here
                    child: ListTile(
                      title: const SizedBox(
                        width: 100.0,
                        child: Text(
                          'CLIO 01089-105-90 3904-3856-89 AAAAAAAAAA',
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      trailing: const IconTheme(
                        data: IconThemeData(
                          color: Colors.red, // set the color of the icon
                          size: 16.0, // set the size of the icon
                        ),
                        child: Icon(Icons
                            .circle), // replace "Icons.star" with your desired icon
                      ),
                      onTap: () {},
                    ),
                  ),
                  Container(
                    height: 40, // set the desired height here
                    child: ListTile(
                      title: const SizedBox(
                        width: 100.0,
                        child: Text(
                          'CLIO 01089-105-90 3904-3856-89 AAAAAAAAAA',
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      trailing: IconTheme(
                        data: IconThemeData(
                          color: config.primary, // set the color of the icon
                          size: 16.0, // set the size of the icon
                        ),
                        child: Icon(Icons
                            .circle), // replace "Icons.star" with your desired icon
                      ),
                      onTap: () {},
                    ),
                  ),
                  Container(
                    height: 40, // set the desired height here
                    child: ListTile(
                      title: const SizedBox(
                        width: 100.0,
                        child: Text(
                          'CLIO 01089-105-90 3904-3856-89 AAAAAAAAAA',
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      trailing: IconTheme(
                        data: IconThemeData(
                          color: config.primary, // set the color of the icon
                          size: 16.0, // set the size of the icon
                        ),
                        child: Icon(Icons
                            .circle), // replace "Icons.star" with your desired icon
                      ),
                      onTap: () {},
                    ),
                  ),
                  Container(
                    height: 40, // set the desired height here
                    child: ListTile(
                      title: const SizedBox(
                        width: 100.0,
                        child: Text(
                          'CLIO 01089-105-90 3904-3856-89 AAAAAAAAAA',
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      trailing: IconTheme(
                        data: IconThemeData(
                          color: config.primary, // set the color of the icon
                          size: 16.0, // set the size of the icon
                        ),
                        child: Icon(Icons
                            .circle), // replace "Icons.star" with your desired icon
                      ),
                      onTap: () {},
                    ),
                  ),
                  config.v_gap_md
                ],
              ),
              ListTile(
                leading: const Icon(Icons.add),
                minLeadingWidth: 5,
                title: const Text('Add asset'),
                onTap: () => {},
              ),
              ListTile(
                leading: const Icon(Icons.account_box_outlined),
                title: const Text('Account'),
                minLeadingWidth: 5,
                onTap: () => {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AccountPage()))
                },
              ),
              ListTile(
                leading: const Icon(Icons.settings),
                minLeadingWidth: 5,
                title: const Text('Settings'),
                onTap: () => {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SettingPage()))
                },
              ),
              ListTile(
                leading: const Icon(Icons.help_center_outlined),
                minLeadingWidth: 5,
                title: const Text('Support'),
                onTap: () => {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SupportPage()))
                },
              ),
              ListTile(
                leading: const Icon(Icons.exit_to_app),
                minLeadingWidth: 5,
                title: const Text('Sign Out'),
                onTap: () => {Navigator.of(context).pop()},
              ),
            ],
          ),
        ));
  }
}
