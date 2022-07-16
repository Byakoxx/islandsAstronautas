import 'package:Islands/helpers/helpers.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter_plus/webview_flutter_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

import '../utils/colors.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  bool isLoading=true;
  final _key = UniqueKey();
  String urlRaw = Uri.encodeFull('https://time.is/es/calendar');
  String message = 'Te comparto el calendario por si olvidates en qué día estamos 🙈🙈🙈:\n\n';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightGrayColor,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade600,
        centerTitle: true,
        title:
          const Text(
            "Calendario",
            style: TextStyle(
              color: whiteColor
            ),
          ),
        actions: <Widget>[
          PopupMenuButton(
            icon: const Icon(Icons.more_vert, color: whiteColor, size: 30.0,),
            onSelected: choiceAction,
            itemBuilder: (BuildContext context) {
            return Constants.choices.map((String choice) {
              return PopupMenuItem<String>(
                value: choice,
                child: Row(
                  children: <Widget>[
                    IconButton(
                        icon: Icon(
                          _iconList(choice),
                          color: Colors.grey.shade600,
                          size: 20.0
                        ),
                        onPressed: () {},
                        iconSize: 30,
                      ),
                    const SizedBox(width: 5.0),
                    Text(
                      choice,
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontFamily: 'TypoGrotesk'
                      )
                    ),
                  ],
                ),
              );
            }).toList();
          },),
        ],

      ),
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            WebViewPlus(
              key: _key,
              initialUrl: urlRaw,
              javascriptMode: JavascriptMode.unrestricted,
              onPageFinished: (finish) {
                setState(() {
                  isLoading = false;
                });
              },
            ),
            isLoading ? Center(
              child: SizedBox(
                width: 100.0,
                height: 100.0,
                child: CircularProgressIndicator(
                  color: Colors.grey.shade400,
                  strokeWidth: 4.0,
                ),
              ),
            ) : Stack(),
          ],
        ),
      ),
    );
  }
  
  IconData? _iconList(String choice) {
    if(choice == 'Abrir en navegador') {
      return Icons.web;
    } else {
      return Icons.share;
    }
  }

  void choiceAction(String choice) async {
    if (choice == Constants.FirstItem) {
      _launchWhatsApp();
    }
  }
  
  _launchWhatsApp() async {
    final link = WhatsAppUnilink(
      phoneNumber: "https://api.whatsapp.com/send?",
      text: "$message $urlRaw",
    );
      await launch(link.toString());
  }
}

class Constants {
  static const String FirstItem = 'Compartir en WhatsApp';

  static const List<String> choices = <String>[
    FirstItem,
  ];
}