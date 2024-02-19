// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gsheets/gsheets.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_flutter/qr_flutter.dart';

const _credintial = r'''
{
  "type": "service_account",
  "project_id": "qr-ieee-nu",
  "private_key_id": "4a69737a7c73214634a350cacaf7baecff709113",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQDGBA+VWtWdysW6\ngQNb2DUZ52VFCwZUhMH2fKd4EdcGbjJqqMzawloxRLCx88IeCQepQgwl7rNjf+Gv\nM/RhfEOtvOtdgY3NUM9k+jFDp10aEYmef4VebuhnBbhWgcxfgmJd64/TK1Tit2k0\nz/0Av3fOec/oIy7f/QM1Gs2C9D2MPmTp3sHUr0t2AeZHh7ULDdDd9xP/zg4znSgy\nU9b/qTdisZxs9J33n7m3WUuaMAm3lnoyl6D/EDrtWlExOpvR+jpZxHDaoOywP8nc\nWwPWkIjxs2Zg6XvfW2HQdwHWnpRhrhVjQXtQNWnQSnBc5Xxo9kOsu3h0wKNUwn5k\n4D+ZPSCJAgMBAAECggEAGIFfJlYn8o+qGbMmpcKji7GhzEIZhfMqB+WUWh0nFbIk\nhiOeuoHr5IYCMfufLdVjP9SfKUCZrbohRWvyFfBpdcJYBGnokRyrle0KlLtNH9FE\nzTst16p1E27XScllb/p0Tvg8g98scaROHk2RG3sWihR0IN/dyLWIpJVNEqRES6sj\nRUuHQEcEIPvETAIUTSz/DWWq0o1XFZH+EiA0IOajnrqigCMPBpZZX04NbagdQ7uC\nmUJKEIR1wgpuLEe1N7Bs6IUfPg9cb085V5Y174TOfPQMyod3VFir8qjjF3dtneCz\nYB96yQ9/vUjMCr06GYMBWLm9wlHMVSHVqN7q2cMQIwKBgQDt2k3PKyViC7WuN+xn\nZS1Kbj5YRYd6sgQQSBnuFuy06vAk81G4ZnWTxVLdOLL7Xsk5P8FmFBhy8nJWwXN/\nC9kq1PFTn3DkFLYzKFaPluvfeSymQM7YMgx5IN7BBM5MdC0vDZpimYj7h6udknEI\nJcNWb45fxS7Td5jyMhYDsqnZ/wKBgQDVH6uSGSgM7L1FwEY+iVl8r74HdWXaEghW\nG62prt7+H79IErxZFjYAdVFrgHunZ9lhLsfLkOo7RIX3GZiSQivWLzzkiVY99g7c\n7F+QHMXqGxBoxPyEFlpvsMiZ8foJnFenQmtFE1YoJ77NoQTFGzAvY87ImyFMFhk4\nR2olZ9k1dwKBgCU6sEcnB7jrAEr+seAVNBucWeHTMDuCNaSexIBB0lcXFvORqk7k\nqq6wiiHaSBmUYoa1df4WUyVa0Y7GxN8z6ZAMuKFQKYlpvIMRY0siYlUeUGDNcBLi\n8pTbEkLAD9JjtNbSmEGqqohEWhZV359Y2dRjrbNL1+J9q9DtCgkWJAPdAoGAQ5KO\nCH13aFmrTTFAVFWiDNl/y8eaKoErKXoPHsy2ISaZtFVUaH6VUqHf1dDf490WXCzD\n5jQlP/Ni8kyoRj86vOcvTFqLAIxCfCNpzTyCN86q7jz+vzaDKASKJd1F5MQwOnTh\no/4UhBjN806JP6F2LqBbkNk2vnQHPQPPkNqTUNMCgYAEB2b5ktYj4POJpGoGyJDW\nC5DGNfKcMsDSpmSzIUigZozec8G0F1NU3N/roVY3sIU0/agPHFnSo6eZQ+E1hu5E\nXTzpg37U0OhfMsxQs/5vVqEkJDsxOiduqtEASyZ8LzGDJYbvy6xhAqb+UcEQUFTP\n28XFFYIJ2h+xyG38RzOnFA==\n-----END PRIVATE KEY-----\n",
  "client_email": "qrieeenu@qr-ieee-nu.iam.gserviceaccount.com",
  "client_id": "103690943257437868734",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/qrieeenu%40qr-ieee-nu.iam.gserviceaccount.com",
  "universe_domain": "googleapis.com"
}

''';
const _spreadsheetId = '1uIEs-b24DH4h9PuMQXHLIw1IDsoUn0bknU666l0o6WQ';
// const _spreadsheetId = '1VFxbsBh2QIX6GudNI7tVpRs0VRv_8gpU2xFIQIv7SUw';

Timer? timer;
bool refreshingData = false;

class QrScanner extends StatefulWidget {
  const QrScanner({Key? key}) : super(key: key);

  @override
  State<QrScanner> createState() => _QrScannerState();
}

class _QrScannerState extends State<QrScanner> {
  late QRViewController controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  String scannedData = '';
  int scannedDataCount = 0;
  Color containerColor = Colors.white; // Initialize to white color
  bool processingScan = false; // Flag to indicate if a scan is being processed
  bool refreshingData = false; // Flag to indicate if data refresh is in progress

  @override
  void initState() {
    super.initState();
    _requestPermission();

    // Start a timer to refresh data every 60 seconds
    Timer.periodic(Duration(minutes: 60), (timer) {
      if (!processingScan && !refreshingData) {
        refreshingData = true;
        ReadData();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      if (!processingScan && !refreshingData) {
        setState(() {
          final qrData = scanData.code!;
          print('Scanned data: $qrData');
          if (qrData != scannedData) {
            _handleScannedData(qrData);
          }
        });
      }
    });
  }


Future<void> updateTotalCount(int totalScanned) async {
  final docRef = FirebaseFirestore.instance.collection('TotalCount').doc('total');
  
  await docRef.set({'total': totalScanned});
  
  print('Total count updated in TotalCount collection: $totalScanned');
}



void _handleScannedData(String qrData) async {
  setState(() {
    processingScan = true; // Set flag to indicate processing of scan
  });

  if (qrData.isNotEmpty && qrData != scannedData) {
    final docRef =
        FirebaseFirestore.instance.collection('IEEEdata').doc(qrData);

    FirebaseFirestore.instance.runTransaction((transaction) async {
      final docSnapshot = await transaction.get(docRef);

      if (docSnapshot.exists) {
        final currentCount = docSnapshot.data()?['count'] ?? 0;
        final newCount = currentCount + 1;

        transaction.update(docRef, {'count': newCount});

        setState(() {
          scannedDataCount = newCount;
          scannedData = qrData;
          containerColor = _getColorForCount(newCount); // Update color
        });

        print('Count incremented for QR data: $qrData');

        // Fetch the total count of scanned QR codes from Firebase
        final querySnapshot = await FirebaseFirestore.instance
            .collection('IEEEdata')
            .where('count', isGreaterThan: 0)
            .get();

        final totalScanned = querySnapshot.docs.length;
        print('Total scanned QR codes: $totalScanned');

        // Update the total count in the TotalCount collection
        await updateTotalCount(totalScanned);
      } else {
        print('Document does not exist for QR data: $qrData');
      }
    }).catchError((error) {
      print("Failed to increment count: $error");
    });

    // Wait for a short duration before allowing another scan
    await Future.delayed(Duration(seconds: 1));

    // Reset flag after processing the scan
    setState(() {
      processingScan = false;
    });
  }
}


Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      backgroundColor: Colors.grey,
      title: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 30.0), // Add padding below the text
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "IEEE NU",
                style: GoogleFonts.libreBaskerville(
                  textStyle: const TextStyle(
                    fontSize: 32.0,
                    color: Color(0xFF001B94),
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
    backgroundColor: Colors.grey,
    body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: SizedBox(
            width: 350,
            height: 350,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
        ),
        const SizedBox(height: 40.0),
        Container(
          width: 300,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: containerColor, // Use the containerColor variable here
          ),
          child: Text(
            scannedData.isEmpty ? 'Scanning...' : scannedData,
            style: TextStyle(
              fontSize: 20,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 10),

        SizedBox(
          width: 250,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),

            child: MaterialButton(
              onPressed: () {
                setState(() {
                  scannedData = '';
                  scannedDataCount = 0;
                  containerColor = Colors.white; // Reset color to white
                });
                controller.resumeCamera(); // Refresh camera
              },
              color: Color(0xFF001B94),
              textColor: Colors.white,
              padding: const EdgeInsets.all(20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                'Reset',
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8), // Add some space before the creator text
        Text(
          'Created by Operations Head Ahmed Amin',
          style: GoogleFonts.libreBaskerville(fontSize: 14,
          color: Color(0xFF001B94),
          fontWeight: FontWeight.bold),
        ),
      ],
    ),
  );
}

  Color _getColorForCount(int count) {
    if (count >= 0 && count < 2) {
      return Colors.green;
    } else if (count >= 2) {
      return Colors.red;
    } else {
      return Colors.white; // Default color if count is negative
    }
  }

  void _requestPermission() async {
    // Assuming the permission is already granted
    print('Storage permission granted');
    ReadData();
  }

  void ReadData() async {
    try {
      final gsheets = GSheets(_credintial);
      final ss = await gsheets.spreadsheet(_spreadsheetId);
      final sheet = ss.worksheetByTitle('Form Responses 1');
      final rows = await sheet?.values.map.allRows();

      if (rows != null) {
        final firestore = FirebaseFirestore.instance;
        final storage = FirebaseStorage.instance;

        for (var row in rows) {
          if (row.isNotEmpty) {
            String? Email = row['Email']; // Change to 'Email' column

            if (Email != null && Email.isNotEmpty) {
              print('Checking for Email: $Email');

              final qrData =
                  await firestore.collection('IEEEdata').doc(Email).get();

              if (!qrData.exists) {
                final qrImage = QrPainter(
                  data: Email, // Change to 'Email'
                  version: QrVersions.auto,
                  color: Colors.white,
                  gapless: true,
                  errorCorrectionLevel: QrErrorCorrectLevel.L,
                );

                final imageData =
                    await qrImage.toImageData(200, format: ImageByteFormat.png);

                final storageRef = storage
                    .ref()
                    .child('qr_images/$Email.png'); // Change to 'Email'
                await storageRef.putData(imageData!.buffer.asUint8List());

                final String downloadURL = await storageRef.getDownloadURL();

                await firestore.collection('IEEEdata').doc(Email).set({
                  'count': 0,
                  'qr_image_url': downloadURL,
                });

                print('Data stored successfully in Firestore for Email: $Email');
              } else {
                print('QR code already exists for Email: $Email. Skipping.');
              }
            } else {
              print('Email is null or empty');
            }
          }
        }
      } else {
        print('No data fetched from Google Sheets.');
      }

      // Set refreshingData flag to false after completing data refresh
      refreshingData = false;
    } catch (e) {
      print('Error fetching data: $e');
      // Set refreshingData flag to false in case of error
      refreshingData = false;
    }
  }
}

// Define constants
// const _spreadsheetId = '1568lTtKaFh204GVyugvTpVO9ThvBoeaKQvvYuu9rmRo';

// const writeRequestsPerMinute =
//     60; // Write requests per minute per user per project

// // Declare variables
// Timer? timer;
// bool refreshingData = false;
// bool updatingData = false; // Flag to track if data is being updated

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

//   late StreamSubscription<QuerySnapshot> _subscription;

//   @override
//   void initState() {
//     super.initState();
//     _requestPermission();

//     // Start a timer to refresh data every 5 minutes
//     Timer.periodic(Duration(minutes: 5), (timer) {
//       if (!processingScan && !refreshingData) {
//         refreshingData = true;
//         ReadData();
//       }
//     });

//     // Listen for changes to the entire collection in Firestore
//     _subscription = FirebaseFirestore.instance
//         .collection('IEEEdata')
//         .snapshots()
//         .listen((snapshot) {
//       for (var change in snapshot.docChanges) {
//         if (change.type == DocumentChangeType.modified) {
//           final newCount = change.doc.data()?['count'] ?? 0;
//           final email = change.doc.id;
//           setState(() {
//             // Update count and color based on the change
//             if (email == scannedData) {
//               scannedDataCount = newCount;
//               containerColor = _getColorForCount(newCount);
//             }
//           });
//           // Update count in Google Sheet
//           updateCountInGoogleSheet(email, newCount.toString());
//         }
//       }
//     });
//   }

//   @override
//   void dispose() {
//     _subscription.cancel(); // Cancel the subscription when the widget is disposed
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

//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.grey,
//         title: Center(
//           child: Padding(
//             padding:
//                 const EdgeInsets.only(top: 30.0), // Add padding below the text
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   "IEEE NU",
//                   style: GoogleFonts.libreBaskerville(
//                     textStyle: const TextStyle(
//                         fontSize: 32.0,
//                         color: Color(0xFF001B94),
//                         fontWeight: FontWeight.bold),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
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
//           const SizedBox(height: 40.0),
//           Container(
//             width: 300,
//             padding: const EdgeInsets.all(20),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(10),
//               color: containerColor, // Use the containerColor variable here
//             ),
//             child: Text(
//               scannedData.isEmpty ? 'Scanning...' : scannedData,
//               style: TextStyle(
//                 fontSize: 20,
//                 color: Colors.black,
//               ),
//               textAlign: TextAlign.center,
//             ),
//           ),
//           const SizedBox(height: 10),
//           SizedBox(
//             width: 250,
//             child: Container(
//               margin: const EdgeInsets.symmetric(vertical: 10),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: MaterialButton(
//                 onPressed: () {
//                   setState(() {
//                     scannedData = '';
//                     scannedDataCount = 0;
//                     containerColor = Colors.white; // Reset color to white
//                   });
//                   controller.resumeCamera(); // Refresh camera
//                 },
//                 color: Color(0xFF001B94),
//                 textColor: Colors.white,
//                 padding: const EdgeInsets.all(20),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: Text(
//                   'Reset',
//                   style: const TextStyle(fontSize: 16),
//                 ),
//               ),
//             ),
//           ),
//           const SizedBox(height: 8), // Add some space before the creator text
//           Text(
//             'Created by Operations Head Ahmed Amin',
//             style: GoogleFonts.libreBaskerville(
//                 fontSize: 14,
//                 color: Color(0xFF001B94),
//                 fontWeight: FontWeight.bold),
//           ),
//         ],
//       ),
//     );
//   }

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
// }

// final Duration updateInterval = Duration(minutes: 5); // Minimum time between updates (5 minutes)
// DateTime lastUpdate = DateTime.now().subtract(updateInterval); // Initialize last update time

// void updateCountInGoogleSheet(String qrData, String newCount) async {
//   try {
//     if (!updatingData) {
//       updatingData = true;
//       final now = DateTime.now();
//       if (now.difference(lastUpdate) > updateInterval) {
//         final gsheets = GSheets(_credintial);
//         final ss = await gsheets.spreadsheet(_spreadsheetId);
//         final sheet = ss.worksheetByTitle('Form Responses 1');
//         final rows = await sheet?.values.map.allRows();

//         if (rows != null) {
//           final attendanceColumnIndex = rows[0].keys.toList().indexOf('Attendence');
//           if (attendanceColumnIndex != -1) {
//             final updates = <Future<void>>[];
//             for (var row in rows) {
//               if (row['Email'] == qrData) {
//                 updates.add(sheet!.values.insertValue(newCount, column: attendanceColumnIndex + 1, row: rows.indexOf(row) + 2));
//                 print('Count updated in Google Sheet for QR data: $qrData');
//                 lastUpdate = now; // Update last update time
//                 break;
//               }
//             }
//             await Future.wait(updates); // Batch update all changes
//             await Future.delayed(Duration(seconds: 60 ~/ writeRequestsPerMinute)); // Delay to stay within quota limit
//           } else {
//             print('Attendance column not found in Google Sheet.');
//           }
//         } else {
//           print('No data fetched from Google Sheets.');
//         }
//       } else {
//         print('Update skipped due to rate limiting. Wait for the next interval.');
//       }

//       updatingData = false;
//     }
//   } catch (e) {
//     print('Error updating count in Google Sheet: $e');
//     updatingData = false;
//   }
// }




// void ReadData() async {
//   try {
//     if (!refreshingData) {
//       refreshingData = true;
//       final gsheets = GSheets(_credintial);
//       final ss = await gsheets.spreadsheet(_spreadsheetId);
//       final sheet = ss.worksheetByTitle('Form Responses 1');
//       final rows = await sheet?.values.map.allRows();

//       if (rows != null) {
//         final firestore = FirebaseFirestore.instance;
//         final storage = FirebaseStorage.instance;

//         for (var i = 0; i < rows.length; i++) {
//           var row = rows[i];
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
//                     .child('QR_Images/$Email.png'); // Change to 'Email'
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

//               final count = qrData.data()?['count'] ?? 0;
//               final countColumnIndex = rows[0].keys.toList().indexOf('Attendence');
//               if (countColumnIndex != -1) {
//                 await sheet!.values.insertValue(count.toString(), column: countColumnIndex + 1, row: i + 2);
//                 print('Count updated for Email: $Email');
//               } else {
//                 print('Count column not found in the row.');
//               }

//               await Future.delayed(Duration(seconds: 60 ~/ writeRequestsPerMinute)); // Delay to stay within quota limit
//             } else {
//               print('Email is null or empty');
//             }
//           }
//         }
//       } else {
//         print('No data fetched from Google Sheets.');
//       }

//       refreshingData = false;
//     }
//   } catch (e) {
//     print('Error fetching data: $e');
//     refreshingData = false;
//   }
// }
