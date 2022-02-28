import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:appolo_car/Utils.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String dropdownMakeValue = 'Make';
  List<String> spinnerMakeItems = ['Make', 'Audi', 'BMW', 'Acura'];

  String dropdownModelValue = 'Model';
  List<String> spinnerModelItems = ['Model', 'Honda', 'Suzuki', 'Vgnor'];

  String dropdownYearValue = '2022';
  List<String> spinnerYearItems = [];

  String dropdownTransmissionValue = 'Transmission';
  List<String> spinnerTransmissionItems = [
    'Transmission',
    'automatic',
    'standard',
  ];

  String dropdownDriverTypeValue = 'Driver Type';
  List<String> spinnerDriverTypeItems = ['Driver Type', '4wd', '2wd', 'awd'];

  String dropdownDoorTypeValue = 'Door Type';
  List<String> spinnerDoorTypeItems = [
    'Door Type',
    '2 door',
    '3 door',
    '4 door'
  ];

  List<String> imageList = [];

  final ImagePicker _picker = ImagePicker();

  static const double editTextFieldTopMargin = 20;
  static const double textSize = 14;

  @override
  void initState() {
    super.initState();
    for (int i = 2022; i >= 1990; i--) {
      spinnerYearItems.add(i.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(
          top: 20,
        ),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 5),
              child: Row(
                children: [
                  const Image(
                    image: AssetImage('assets/images/logo.png'),
                    width: 220,
                  ),
                  Expanded(child: Container()),
                  Container(
                    color: Colors.transparent,
                    child: Container(
                        margin: const EdgeInsets.only(right: 15),
                        padding: const EdgeInsets.only(
                            left: 17, right: 17, top: 6, bottom: 6),
                        decoration: const BoxDecoration(
                            color: Color(0xFFEAD00B),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                        child: const Center(
                          child: Text(
                            "About us",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        )),
                  ),
                ],
              ),
            ),
            const Image(image: AssetImage('assets/images/banner.png')),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding: const EdgeInsets.only(left: 25, right: 25),
                child: const Text(
                  "Please fill the following information",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(top: 10, left: 25, right: 25),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () async {
                          if (imageList.length == 5) {
                            Utils.showMessage(
                                context, 'You can\'t add more then 5 image');
                            return;
                          }
                          final XFile? image = await _picker.pickImage(
                              source: ImageSource.gallery);
                          if (image != null) {
                            setState(() {
                              imageList.add(image.path);
                            });
                          }
                        },
                        child: Container(
                          margin: const EdgeInsets.only(
                              top: editTextFieldTopMargin),
                          child: Row(
                            children: const [
                              Icon(
                                Icons.add,
                                color: Color(0xBAEAD00B),
                                size: 24.0,
                              ),
                              Text('Add Image')
                            ],
                          ),
                        ),
                      ),
                      Visibility(
                        visible: imageList.isNotEmpty,
                        child: GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 5,
                            crossAxisSpacing: 5.0,
                            mainAxisSpacing: 5.0,
                          ),
                          itemCount: imageList.length,
                          itemBuilder: (context, index) {
                            return Image.file(
                              File(imageList[index]),
                              width: 100,
                              height: 100,
                            );
                          },
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 20),
                        width: double.infinity,
                        height: 40,
                        padding: const EdgeInsets.only(
                          left: 15,
                          right: 10,
                        ),
                        decoration: const BoxDecoration(
                            color: Color(0xBAEAD00B),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                        child: DropdownButton<String>(
                          isExpanded: true,
                          value: dropdownMakeValue,
                          icon: const Icon(
                            Icons.arrow_drop_down,
                            color: Colors.black,
                          ),
                          iconSize: 30,
                          elevation: 16,
                          style: const TextStyle(
                              color: Colors.black, fontSize: textSize),
                          underline: Container(
                            height: 0,
                            color: Colors.transparent,
                          ),
                          onChanged: (data) {
                            setState(() {
                              dropdownMakeValue = data!;
                            });
                          },
                          items: spinnerMakeItems
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                      Container(
                        margin:
                            const EdgeInsets.only(top: editTextFieldTopMargin),
                        width: double.infinity,
                        height: 40,
                        padding: const EdgeInsets.only(
                            left: 15, right: 10, bottom: 3),
                        decoration: const BoxDecoration(
                            color: Color(0xBAEAD00B),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                        child: const TextField(
                          style: TextStyle(
                              fontSize: textSize, color: Colors.black),
                          decoration: InputDecoration(
                            hintText: 'Model',
                            hintStyle: TextStyle(color: Colors.black),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      Container(
                        margin:
                            const EdgeInsets.only(top: editTextFieldTopMargin),
                        width: double.infinity,
                        height: 40,
                        padding: const EdgeInsets.only(
                            left: 15, right: 10, bottom: 3),
                        decoration: const BoxDecoration(
                            color: Color(0xBAEAD00B),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                        child: const TextField(
                          style: TextStyle(
                              fontSize: textSize, color: Colors.black),
                          decoration: InputDecoration(
                            hintText: 'Trim',
                            hintStyle: TextStyle(color: Colors.black),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      Container(
                        margin:
                            const EdgeInsets.only(top: editTextFieldTopMargin),
                        width: double.infinity,
                        height: 40,
                        padding: const EdgeInsets.only(
                          left: 15,
                          right: 10,
                        ),
                        decoration: const BoxDecoration(
                            color: Color(0xBAEAD00B),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                        child: DropdownButton<String>(
                          isExpanded: true,
                          value: dropdownYearValue,
                          icon: const Icon(
                            Icons.arrow_drop_down,
                            color: Colors.black,
                          ),
                          iconSize: 30,
                          elevation: 16,
                          style: const TextStyle(
                              color: Colors.black, fontSize: textSize),
                          underline: Container(
                            height: 0,
                            color: Colors.transparent,
                          ),
                          onChanged: (data) {
                            setState(() {
                              dropdownYearValue = data!;
                            });
                          },
                          items: spinnerYearItems
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                      Container(
                        margin:
                            const EdgeInsets.only(top: editTextFieldTopMargin),
                        width: double.infinity,
                        height: 40,
                        padding: const EdgeInsets.only(
                            left: 15, right: 10, bottom: 3),
                        decoration: const BoxDecoration(
                            color: Color(0xBAEAD00B),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                        child: const TextField(
                          style: TextStyle(
                              fontSize: textSize, color: Colors.black),
                          decoration: InputDecoration(
                            hintText: 'VIN#',
                            hintStyle: TextStyle(color: Colors.black),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      Container(
                        margin:
                            const EdgeInsets.only(top: editTextFieldTopMargin),
                        width: double.infinity,
                        height: 40,
                        padding: const EdgeInsets.only(
                          left: 15,
                          right: 10,
                        ),
                        decoration: const BoxDecoration(
                            color: Color(0xBAEAD00B),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                        child: DropdownButton<String>(
                          isExpanded: true,
                          value: dropdownTransmissionValue,
                          icon: const Icon(
                            Icons.arrow_drop_down,
                            color: Colors.black,
                          ),
                          iconSize: 30,
                          elevation: 16,
                          style: const TextStyle(
                              color: Colors.black, fontSize: textSize),
                          underline: Container(
                            height: 0,
                            color: Colors.transparent,
                          ),
                          onChanged: (data) {
                            setState(() {
                              dropdownTransmissionValue = data!;
                            });
                          },
                          items: spinnerTransmissionItems
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                      Container(
                        margin:
                            const EdgeInsets.only(top: editTextFieldTopMargin),
                        width: double.infinity,
                        height: 40,
                        padding: const EdgeInsets.only(
                          left: 15,
                          right: 10,
                        ),
                        decoration: const BoxDecoration(
                            color: Color(0xBAEAD00B),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                        child: DropdownButton<String>(
                          isExpanded: true,
                          value: dropdownDriverTypeValue,
                          icon: const Icon(
                            Icons.arrow_drop_down,
                            color: Colors.black,
                          ),
                          iconSize: 30,
                          elevation: 16,
                          style: const TextStyle(
                              color: Colors.black, fontSize: textSize),
                          underline: Container(
                            height: 0,
                            color: Colors.transparent,
                          ),
                          onChanged: (data) {
                            setState(() {
                              dropdownDriverTypeValue = data!;
                            });
                          },
                          items: spinnerDriverTypeItems
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                      Container(
                        margin:
                            const EdgeInsets.only(top: editTextFieldTopMargin),
                        width: double.infinity,
                        height: 40,
                        padding: const EdgeInsets.only(
                            left: 15, right: 10, bottom: 3),
                        decoration: const BoxDecoration(
                            color: Color(0xBAEAD00B),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                        child: const TextField(
                          style: TextStyle(
                              fontSize: textSize, color: Colors.black),
                          decoration: InputDecoration(
                            hintText: 'KMS',
                            hintStyle: TextStyle(color: Colors.black),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      Container(
                        margin:
                            const EdgeInsets.only(top: editTextFieldTopMargin),
                        width: double.infinity,
                        height: 40,
                        padding: const EdgeInsets.only(
                            left: 15, right: 10, bottom: 3),
                        decoration: const BoxDecoration(
                            color: Color(0xBAEAD00B),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                        child: const TextField(
                          style: TextStyle(
                              fontSize: textSize, color: Colors.black),
                          decoration: InputDecoration(
                            hintText: 'Fuel Type',
                            hintStyle: TextStyle(color: Colors.black),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 20),
                        width: double.infinity,
                        height: 40,
                        padding: const EdgeInsets.only(
                          left: 15,
                          right: 10,
                        ),
                        decoration: const BoxDecoration(
                            color: Color(0xBAEAD00B),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                        child: DropdownButton<String>(
                          isExpanded: true,
                          value: dropdownDoorTypeValue,
                          icon: const Icon(
                            Icons.arrow_drop_down,
                            color: Colors.black,
                          ),
                          iconSize: 30,
                          elevation: 16,
                          style: const TextStyle(
                              color: Colors.black, fontSize: textSize),
                          underline: Container(
                            height: 0,
                            color: Colors.transparent,
                          ),
                          onChanged: (data) {
                            setState(() {
                              dropdownDoorTypeValue = data!;
                            });
                          },
                          items: spinnerDoorTypeItems
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 40),
                      ),
                      Container(
                        color: Colors.transparent,
                        child: GestureDetector(
                          onTap: () async {
                            // topcarsellerinfo@gmail.com
                            // TopCarSellerInfo2022
                            String username = 'topcarsellerinfo@gmail.com';
                            String password = 'TopCarSellerInfo2022';

                            final smtpServer = gmail(username, password);
                            // Use the SmtpServer class to configure an SMTP server:
                            // final smtpServer1 = SmtpServer('smtp.domain.com');

                            // See the named arguments of SmtpServer for further configuration
                            // options.

                            // Create our message.
                            final message = Message()
                              ..from = Address(username, 'Sohaib Raza')
                              ..recipients.add('msohaibraza1@gmail.com')
                              // ..ccRecipients.addAll(['destCc1@example.com', 'destCc2@example.com'])
                              // ..bccRecipients.add(Address('bccAddress@example.com'))
                              ..subject =
                                  'Test Dart Mailer library :: 😀 :: ${DateTime.now()}'
                              ..text =
                                  'This is the plain text.\nThis is line 2 of the text part.'
                              ..html =
                                  "<h1>Test</h1>\n<p>Hey! Here's some HTML content</p>";

                            try {
                              final sendReport =
                                  await send(message, smtpServer);
                              print('Message sent: ' + sendReport.toString());
                            } on MailerException catch (e) {
                              print('Message not sent.' + e.toString());
                              for (var p in e.problems) {
                                print('Problem: ${p.code}: ${p.msg}');
                              }
                            }
                          },
                          child: Container(
                              padding:
                                  const EdgeInsets.only(top: 10, bottom: 10),
                              decoration: const BoxDecoration(
                                  color: Color(0xFFEAD00B),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0))),
                              child: const Center(
                                child: Text(
                                  "Submit",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 17),
                                ),
                              )),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 20),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
