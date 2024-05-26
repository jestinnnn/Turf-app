import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QR extends StatefulWidget {
  final String id;
  final String qrnumber;
 QR({super.key, required this.id, required this.qrnumber});

  @override
  State<QR> createState() => _QRState();
}

class _QRState extends State<QR> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Qr View"),
      ),
      body: Center(
        child: Container(
            color: Color.fromARGB(255, 182, 220, 255),
            height: 350,
            width: 350,
            child: qrview(widget.qrnumber)),
      ),
    );
  }

  qrview(String a) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: QrImageView(
        data: a,
        version: QrVersions.auto,
        size: 100,
        gapless: false,
        embeddedImageStyle: QrEmbeddedImageStyle(
          size: Size(60, 256),
        ),
      ),
    );
  }
}
