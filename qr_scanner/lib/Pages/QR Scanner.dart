// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRCodeScanner extends StatefulWidget {
  const QRCodeScanner({super.key});

  @override
  State<StatefulWidget> createState() => _QRCodeScannerState();
}


class _QRCodeScannerState extends State<QRCodeScanner> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  String scannedData = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Code Scanner'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: QRView(
              key: qrKey,
              onQRViewCreated: (controller) {
                setState(() {
                  this.controller = controller;
                });
                controller.scannedDataStream.listen((scanData) {
                  setState(() {
                    scannedData = scanData.code!;
                  });
                });
              },
              overlay: QrScannerOverlayShape(
                borderRadius: 16,
                borderColor: Colors.white,
                borderLength: 30,
                borderWidth: 10,
                cutOutSize: 300,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.all(20),
              color: const Color.fromARGB(255, 20, 20, 20),
              child: Text(
                'Scanned Data: $scannedData',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
