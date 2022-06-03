import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Test Url_Launcher',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Test Url_Launcher'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            OutlinedButton(
              onPressed: () => openWhatsapp(),
              child: const Text('Abrir whatsapp'),
            ),
          ],
        ),
      ),
    );
  }

  Future openWhatsapp() async {
    String mensagem = 'Teste mensagem';
    String phoneNumber = '47999187998';
    bool isIos = false;

    String _textMessage = Uri.encodeFull(mensagem);

    //encoda # e % para mensagem do whatsapp
    _textMessage = _textMessage.replaceAll("#", "%23");
    _textMessage = _textMessage.replaceAll("?", "%3F");

    if (isIos) {
      var whatsappUrlIos = "https://wa.me/55$phoneNumber?text=$_textMessage";

      if (await canLaunch(whatsappUrlIos)) {
        await launch(whatsappUrlIos, forceSafariVC: false);
      } else {
        print(
            "Não foi possível realizar o envio da mensagem pois não localizamos o aplicativo Whatsapp instalado em seu dispositivo.");
      }
    } else {
      var whatsappUrlAndroid =
          "whatsapp://send?phone=55" + phoneNumber + "&text=$_textMessage";

      if (await canLaunch(whatsappUrlAndroid)) {
        await launch(whatsappUrlAndroid);
      } else {
        print(
            "Não foi possível realizar o envio da mensagem pois não localizamos o aplicativo Whatsapp instalado em seu dispositivo.");
      }
    }
  }
}
