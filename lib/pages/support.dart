// ignore_for_file: must_be_immutable
import 'package:toast/toast.dart';
import 'package:flutter/material.dart';

import 'package:tracking/services/auth-provider.dart';

class SupportPage extends StatefulWidget {
  const SupportPage({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _SupportPageState createState() => _SupportPageState();
}

// ignore: use_key_in_widget_constructors
class _SupportPageState extends State<SupportPage> {
  bool status = false;
  TextEditingController textCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF2FB1A8),
          title: const Text('Support'),
        ),
        body: SingleChildScrollView(
            child: Container(
          width: double.infinity,
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
              TextFormField(
                controller: textCtrl,
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
                  onPressed: () {
                    sendSupport();
                  },
                  padding: EdgeInsets.symmetric(vertical: 15),
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
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
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
        )));
  }

  void sendSupport() async {
    setState(() {
      status = true;
    });
    if (textCtrl.text.length > 0) {
      setState(() {});
    } else {
      setState(() {
        status = false;
      });
      AuthenticateProviderPage.of(context, listen: false)
          .notifyToastDanger(message: "Error, text is required!");
    }
  }
}
