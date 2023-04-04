import 'package:flutter/material.dart';
import 'package:tracking/services/auth-provider.dart';

// ignore: use_key_in_widget_constructors
class AccountPage extends StatelessWidget {
  @override
  // ignore: must_call_super
  void initState() {}
  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        return Scaffold(
            appBar: AppBar(
              backgroundColor: const Color(0xFF2FB1A8),
              title: const Text('Account'),
            ),
            body: Container(
              width: double.infinity,
              height: double.infinity,
              margin: EdgeInsets.only(top: 20),
              padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
              decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(width: 1, color: Colors.grey),
                      bottom: BorderSide(width: 1, color: Colors.grey))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'OPGA BATNA',
                    style: TextStyle(fontSize: 24),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 120,
                            child: const Text(
                              'Account: ',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          const Text(
                            '71',
                            style: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Container(
                            width: 120,
                            child: const Text(
                              'Email: ',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Expanded(
                              child: const Text(
                            'topdeveloper0908@gmail.com',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.w500,
                                fontSize: 16),
                          ))
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Container(
                            width: 120,
                            child: const Text(
                              'Balance: ',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          const Text(
                            '691200,00 DZD',
                            style: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Container(
                            width: 120,
                            child: const Text(
                              'Bonus: ',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          const Text(
                            '0,00DZD',
                            style: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          )
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ));
      },
    );
  }
}
