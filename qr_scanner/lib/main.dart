// ignore_for_file: prefer_const_constructors

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:qr_scanner/Pages/QrScanner.dart';
import 'package:qr_scanner/firebase_options.dart';

Future<void> main() async {
// final gsheets = Gsheets(_credintial);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner : false,
      title: 'QR Code generator',
      home: QrScanner(),
    );
  }
}



// Timer? timer;
// bool refreshingData = false;

// class QrScanner extends StatefulWidget {
//   const QrScanner({Key? key}) : super(key: key);

//   @override
//   State<QrScanner> createState() => _QrScannerState();
// }

// class _QrScannerState extends State<QrScanner> {
//   late QRViewController controller;
//   final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

//   String scannedData = '';
//   int scannedDataCount = 0;
//   Color containerColor = Colors.white; // Initialize to white color
//   bool processingScan = false; // Flag to indicate if a scan is being processed
//   bool refreshingData = false; // Flag to indicate if data refresh is in progress

//   @override
//   void initState() {
//     super.initState();
//     _requestPermission();

//     // Start a timer to refresh data every 60 seconds
//     Timer.periodic(Duration(seconds: 60), (timer) {
//       if (!processingScan && !refreshingData) {
//         refreshingData = true;
//         ReadData();
//       }
//     });
//   }

//   @override
//   void dispose() {
//     super.dispose();
//   }

//   void _onQRViewCreated(QRViewController controller) {
//     this.controller = controller;
//     controller.scannedDataStream.listen((scanData) {
//       if (!processingScan && !refreshingData) {
//         setState(() {
//           final qrData = scanData.code!;
//           print('Scanned data: $qrData');
//           if (qrData != scannedData) {
//             _handleScannedData(qrData);
//           }
//         });
//       }
//     });
//   }

//   void _handleScannedData(String qrData) async {
//     setState(() {
//       processingScan = true; // Set flag to indicate processing of scan
//     });

//     if (qrData.isNotEmpty && qrData != scannedData) {
//       final docRef =
//           FirebaseFirestore.instance.collection('IEEEdata').doc(qrData);

//       FirebaseFirestore.instance.runTransaction((transaction) async {
//         final docSnapshot = await transaction.get(docRef);

//         if (docSnapshot.exists) {
//           final currentCount = docSnapshot.data()?['count'] ?? 0;
//           final newCount = currentCount + 1;

//           transaction.update(docRef, {'count': newCount});

//           setState(() {
//             scannedDataCount = newCount;
//             scannedData = qrData;
//             containerColor = _getColorForCount(newCount); // Update color
//           });

//           print('Count incremented for QR data: $qrData');
//         } else {
//           print('Document does not exist for QR data: $qrData');
//         }
//       }).catchError((error) {
//         print("Failed to increment count: $error");
//       });

//       // Wait for a short duration before allowing another scan
//       await Future.delayed(Duration(seconds: 1));

//       // Reset flag after processing the scan
//       setState(() {
//         processingScan = false;
//       });
//     }
//   }

// Widget build(BuildContext context) {
//   return Scaffold(
//     appBar: AppBar(
//       backgroundColor: Colors.grey,
//       title: Center(
//         child: Padding(
//           padding: const EdgeInsets.only(top: 30.0), // Add padding below the text
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(
//                 "IEEE NU",
//                 style: GoogleFonts.libreBaskerville(
//                   textStyle: const TextStyle(
//                     fontSize: 32.0,
//                     color: Color(0xFF001B94),
//                     fontWeight: FontWeight.bold
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     ),
//     backgroundColor: Colors.grey,
//     body: Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         Center(
//           child: SizedBox(
//             width: 350,
//             height: 350,
//             child: QRView(
//               key: qrKey,
//               onQRViewCreated: _onQRViewCreated,
//             ),
//           ),
//         ),
//         const SizedBox(height: 40.0),
//         Container(
//           width: 300,
//           padding: const EdgeInsets.all(20),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(10),
//             color: containerColor, // Use the containerColor variable here
//           ),
//           child: Text(
//             scannedData.isEmpty ? 'Scanning...' : scannedData,
//             style: TextStyle(
//               fontSize: 20,
//               color: Colors.black,
//             ),
//             textAlign: TextAlign.center,
//           ),
//         ),
//         const SizedBox(height: 10),

//         SizedBox(
//           width: 250,
//           child: Container(
//             margin: const EdgeInsets.symmetric(vertical: 10),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(10),
//             ),

//             child: MaterialButton(
//               onPressed: () {
//                 setState(() {
//                   scannedData = '';
//                   scannedDataCount = 0;
//                   containerColor = Colors.white; // Reset color to white
//                 });
//                 controller.resumeCamera(); // Refresh camera
//               },
//               color: Color(0xFF001B94),
//               textColor: Colors.white,
//               padding: const EdgeInsets.all(20),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: Text(
//                 'Reset',
//                 style: const TextStyle(fontSize: 16),
//               ),
//             ),
//           ),
//         ),
//         const SizedBox(height: 8), // Add some space before the creator text
//         Text(
//           'Created by Operations Head Ahmed Amin',
//           style: GoogleFonts.libreBaskerville(fontSize: 14,
//           color: Color(0xFF001B94),
//           fontWeight: FontWeight.bold),
//         ),
//       ],
//     ),
//   );
// }

//   Color _getColorForCount(int count) {
//     if (count >= 0 && count < 2) {
//       return Colors.green;
//     } else if (count >= 2) {
//       return Colors.red;
//     } else {
//       return Colors.white; // Default color if count is negative
//     }
//   }

//   void _requestPermission() async {
//     // Assuming the permission is already granted
//     print('Storage permission granted');
//     ReadData();
//   }

//   void ReadData() async {
//     try {
//       final gsheets = GSheets(_credintial);
//       final ss = await gsheets.spreadsheet(_spreadsheetId);
//       final sheet = ss.worksheetByTitle('Form Responses 1');
//       final rows = await sheet?.values.map.allRows();

//       if (rows != null) {
//         final firestore = FirebaseFirestore.instance;
//         final storage = FirebaseStorage.instance;

//         for (var row in rows) {
//           if (row.isNotEmpty) {
//             String? Email = row['Email']; // Change to 'Email' column

//             if (Email != null && Email.isNotEmpty) {
//               print('Checking for Email: $Email');

//               final qrData =
//                   await firestore.collection('IEEEdata').doc(Email).get();

//               if (!qrData.exists) {
//                 final qrImage = QrPainter(
//                   data: Email, // Change to 'Email'
//                   version: QrVersions.auto,
//                   color: Colors.white,
//                   gapless: true,
//                   errorCorrectionLevel: QrErrorCorrectLevel.L,
//                 );

//                 final imageData =
//                     await qrImage.toImageData(200, format: ImageByteFormat.png);

//                 final storageRef = storage
//                     .ref()
//                     .child('qr_images/$Email.png'); // Change to 'Email'
//                 await storageRef.putData(imageData!.buffer.asUint8List());

//                 final String downloadURL = await storageRef.getDownloadURL();

//                 await firestore.collection('IEEEdata').doc(Email).set({
//                   'count': 0,
//                   'qr_image_url': downloadURL,
//                 });

//                 print('Data stored successfully in Firestore for Email: $Email');
//               } else {
//                 print('QR code already exists for Email: $Email. Skipping.');
//               }
//             } else {
//               print('Email is null or empty');
//             }
//           }
//         }
//       } else {
//         print('No data fetched from Google Sheets.');
//       }

//       // Set refreshingData flag to false after completing data refresh
//       refreshingData = false;
//     } catch (e) {
//       print('Error fetching data: $e');
//       // Set refreshingData flag to false in case of error
//       refreshingData = false;
//     }
//   }
// }