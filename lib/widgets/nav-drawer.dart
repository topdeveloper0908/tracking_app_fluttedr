import 'package:flutter/material.dart';

class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 300,
        child: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              const DrawerHeader(
                decoration: BoxDecoration(
                    color: Colors.green,
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
                childrenPadding:
                    const EdgeInsets.only(left: 15), //children padding
                children: [
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
                          color: Colors.blue, // set the color of the icon
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
                      trailing: const IconTheme(
                        data: IconThemeData(
                          color: Colors.green, // set the color of the icon
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
                      trailing: const IconTheme(
                        data: IconThemeData(
                          color: Colors.green, // set the color of the icon
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
                      trailing: const IconTheme(
                        data: IconThemeData(
                          color: Colors.green, // set the color of the icon
                          size: 16.0, // set the size of the icon
                        ),
                        child: Icon(Icons
                            .circle), // replace "Icons.star" with your desired icon
                      ),
                      onTap: () {},
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  )
                ],
              ),
              ListTile(
                leading: const Icon(Icons.add),
                title: const Text('Add asset'),
                onTap: () => {},
              ),
              ListTile(
                leading: const Icon(Icons.account_box_outlined),
                title: const Text('Account'),
                onTap: () => {Navigator.of(context).pop()},
              ),
              ListTile(
                leading: const Icon(Icons.settings),
                title: const Text('Settings'),
                onTap: () => {Navigator.of(context).pop()},
              ),
              ListTile(
                leading: const Icon(Icons.help_center_outlined),
                title: const Text('Support'),
                onTap: () => {Navigator.of(context).pop()},
              ),
              ListTile(
                leading: const Icon(Icons.exit_to_app),
                title: const Text('Sign Out'),
                onTap: () => {Navigator.of(context).pop()},
              ),
            ],
          ),
        ));
  }
}
