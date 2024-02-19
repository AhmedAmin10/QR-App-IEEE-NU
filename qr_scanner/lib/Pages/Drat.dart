// class QrScanner extends StatefulWidget {
//   const QrScanner({Key? key}) : super(key: key);

//   @override
//   State<QrScanner> createState() => _QrScannerState();
// }

// class _QrScannerState extends State<QrScanner> {
//   late QRViewController controller;
//   final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

//   String scannedData = '';

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('IEEE Code Scanner')),
//       backgroundColor: Colors.grey,
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Center(
//             child: SizedBox(
//               width: 350,
//               height: 350,
//               child: QRView(
//                 key: qrKey,
//                 onQRViewCreated: _onQRViewCreated,
//               ),
//             ),
//           ),
//           SizedBox(height: 40.0),
//           Container(
//             width: 300,
//             padding: EdgeInsets.all(20),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(10),
//             ),
//             child: Text(
//               scannedData,
//               style: TextStyle(fontSize: 20),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   void _onQRViewCreated(QRViewController controller) {
//     this.controller = controller;
//     controller.scannedDataStream.listen((scanData) {
//       setState(() {
//         scannedData = scanData.code!;
//       });
//     });
//   }

//   @override
//   void dispose() {
//     controller.dispose();
//     super.dispose();
//   }
// }

// void ReadData() async {
//   try {
//     // Initialize Firestore
//     FirebaseFirestore firestore = FirebaseFirestore.instance;

//     // Fetch data from Google Sheets
//     final gsheets = GSheets(_credintial);
//     final ss = await gsheets.spreadsheet(_spreadsheetId);
//     final sheet = ss.worksheetByTitle('teest');
//     final rows = await sheet?.values.map.allRows();

//     if (rows != null) {
//       // Store data in Firestore
//       for (var row in rows) {
//         try {
//           await firestore.collection('QrData').add(row);
//           print('Data stored successfully in Firestore');
//         } catch (e) {
//           print('Error storing data in Firestore: $e');
//         }
//       }
//     } else {
//       print('No data fetched from Google Sheets.');
//     }
//   } catch (e) {
//     print('Error fetching data from Google Sheets: $e');
//   }
// }

// // import 'package:flutter/material.dart';
// // import 'package:qr_code_scanner/qr_code_scanner.dart';
// // import 'package:cloud_firestore/cloud_firestore.dart';

// // class QrScanner extends StatefulWidget {
// //   const QrScanner({Key? key}) : super(key: key);

// //   @override
// //   State<QrScanner> createState() => _QrScannerState();
// // }

// // class _QrScannerState extends State<QrScanner> {
// //   late QRViewController controller;
// //   final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

// //   String scannedData = '';
// //   int scanCount = 0;

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(title: Text('IEEE Code Scanner')),
// //       backgroundColor: Colors.grey,
// //       body: Column(
// //         mainAxisAlignment: MainAxisAlignment.center,
// //         crossAxisAlignment: CrossAxisAlignment.center,
// //         children: [
// //           Center(
// //             child: SizedBox(
// //               width: 350,
// //               height: 350,
// //               child: QRView(
// //                 key: qrKey,
// //                 onQRViewCreated: _onQRViewCreated,
// //               ),
// //             ),
// //           ),
// //           SizedBox(height: 40.0),
// //           Container(
// //             width: 300,
// //             padding: EdgeInsets.all(20),
// //             decoration: BoxDecoration(
// //               color: scanCount > 2 ? Colors.red : Colors.green,
// //               borderRadius: BorderRadius.circular(10),
// //             ),
// //             child: Text(
// //               scanCount > 2 ? 'Access Denied' : 'Access Granted',
// //               style: TextStyle(fontSize: 20, color: Colors.white),
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   void _onQRViewCreated(QRViewController controller) {
// //     this.controller = controller;
// //     controller.scannedDataStream.listen((scanData) {
// //       setState(() {
// //         scannedData = scanData.code!;
// //         _updateScanCount(scannedData);
// //       });
// //     });
// //   }

// //   void _updateScanCount(String qrData) {
// //     // Fetch the scanned data from Firestore and increment the scan count
// //     FirebaseFirestore.instance.collection('scans').doc(qrData).get().then((doc) {
// //       if (doc.exists) {
// //         int currentCount = doc.data()!['count'];
// //         setState(() {
// //           scanCount = currentCount + 1;
// //         });
// //         FirebaseFirestore.instance.collection('scans').doc(qrData).update({'count': scanCount});
// //       } else {
// //         // If the document doesn't exist, create it with count 1
// //         setState(() {
// //           scanCount = 1;
// //         });
// //         FirebaseFirestore.instance.collection('scans').doc(qrData).set({'count': 1});
// //       }
// //     });
// //   }

// //   @override
// //   void dispose() {
// //     controller.dispose();
// //     super.dispose();
// //   }
// // }
