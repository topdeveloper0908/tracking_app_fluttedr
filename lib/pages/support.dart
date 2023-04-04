// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

// ignore: use_key_in_widget_constructors
class SupportPage extends StatelessWidget {
  bool status = false;
  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        return Scaffold(
            appBar: AppBar(
              backgroundColor: const Color(0xFF2FB1A8),
              title: const Text('Support'),
            ),
            body: Container(
              width: double.infinity,
              height: double.infinity,
              margin: const EdgeInsets.only(top: 20),
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
              child: Column(
                children: [
                  const Text(
                    'Send a request to our technical support and get a response by email',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, color: Colors.black87),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const TextField(
                    keyboardType: TextInputType.multiline,
                    maxLines: 5,
                    cursorColor: Color(0xFF2FB1A8),
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 1, color: Colors.grey)),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 1, color: Color(0xFF2FB1A8))),
                      errorBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 1, color: Colors.redAccent)),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  MaterialButton(
                      // minWidth: MediaQuery.of(context).size.width,
                      color: const Color(0xFF2FB1A8),
                      onPressed: () {},
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: status
                          ? const SizedBox(
                              height: 25,
                              width: 25,
                              // ignore: unnecessary_const
                              child: const CircularProgressIndicator(
                                  backgroundColor: Colors.grey,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white),
                                  strokeWidth: 3))
                          : const SizedBox(
                              child: Text(
                                'Send',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.normal),
                              ),
                            ))
                ],
              ),
            ));
      },
    );
  }
}
