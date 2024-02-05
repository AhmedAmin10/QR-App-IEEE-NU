import 'package:flutter/material.dart';

import 'package:gsheets/gsheets.dart';
import 'package:qr_flutter/qr_flutter.dart';


const _credintial = r'''
{
  "type": "service_account",
  "project_id": "qr-app-ieeenu",
  "private_key_id": "7ec0a6fa391ffef839e3e953d8b1eb26f3679d01",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDzenKuQ9q95a2a\nGTusv4bj+Jtxk73RN6WRfnQwkOz4GTy5IWyrqNvlKMpJzWJHUuxaRY9OCxXQZtvO\n6t6t88zPY36NFTdY/SbzNNZVeqYECqbWbTj+N40e9JSj6h8B2NiKyWXD0nuevkaW\nf0sCSL88dxrsBaevRqJL2s8JtqJYDXvdbbUArJ0eEVom0I49ZmntZAskjD/erR5o\nbMqheuIuAau9wv3ZgzkOhoomMX/K4+3Ya3GhL14c6uJR9C21noUtKoYDRe8j705J\nISkxtxN4NpBScXRGfU6B6jqaWhCuDlvT6f9XQA6blof8rRf3E1dy+Mb7w0oo0Kn9\ngrEsh2J3AgMBAAECggEADXcprYKaL+NqcPnRR5IGG0iODD+AAXii4wOL2H3DZUs8\nBP8Yu/uoQam6Wk+ODmTDJpDvRoEtcSunH2/05cj0fEnD33ibaYQCqfOzoOGaGeIe\n7P/4ZXLcDqi3KcOSeG8uNqrBwo07AgIC9GLQ2qz8SpNJvWDor7Rn2GsfBSoBG35z\nyg1VejLUlr84wuSIxslYPrbYLSZrIdO1P8yM90CMtcwGMp/eKtseflLgn0A0ecA3\nUYJ9jMbRORKt6yjU1CT1GZ+Lmk/MM1qM+46cWDR0YCFLWNLwnLsVxpwHJxGGY/PR\nhkPRcLanqKq1fDGmNGcN/IEQVVcvNVtoQizjCRvtYQKBgQD/+piqa2Xn+XdMPbnD\n0cwefWw+FiESTSAHXJMnbpYCdbeslaXWh+zLROOWEe9nF3y+jg/3JiFRxYkYrbvs\nT8Zg3vem1wq1XP4yX3Hll++ZTO9sstkrxaASpm/x81XQlRic1e/TQUlQtcOycAAe\n40zlIwFvuNH71KVPQQOjSuPSIQKBgQDzf5Z18GctYsUaXmKixiRyEWw+NOfSHsCu\nH9E/w9yl63G6CMje8Sgma2y2jQxmwCNo8brKPSgcYdeZjbTQJMYCAjm0+y+ACzA6\nmBmR30sygi04KyPskNkZ+e7pVG/k4UDK4y8haxoi+4Q2NtCc+LSVurh0uJyU0KW2\np+69yWpRlwKBgDD3xmarfuYegeTS1guQwcR/Z8qEvzTaDit6WSgs7oNv84APbJca\nj4DfH85ghfSpuJJXaNR1teAHss9GxPFS3XdAkA2Zi5HgRTxrp8UtCIfCAPdBS2wl\nNRb8QeP+EceCDiBKiMNX9Od8rgAfjtZZ0ybuSGMP7xOGvUzo+gIt3GEhAoGBAJgf\n7fBg8RT50ApZTWZERCC/odB7XRl4/QfL+P7Nbtx56+M9+cDPCTZ3hsPF+yl2gKjf\n3MLc0mJo/jmAvqYLU2mN2l+nTlXAp7DztYXc6y3zBi1BRoBVPk1sSEad6gokcEZR\nCPDn6LxSRpdYR5zKBIhGz1acv7Z5ZA5pfE41t6ahAoGASO+xHWMHN/ahzDUvRJ/l\nEHY4pyD0tNt2ydyR3nBdJ4nFWXP0/uI+0W6jeDhw5w1tuBvn8pNb/q9ZxSnLBYrc\nh4zLgl2yvqETGRd5YyYV4Mhw/DR96V9SkDMfqzYxozgS4N9mc5EIWogloY1rKWhL\nA8c+yETPk7TcBFMePEy9+V8=\n-----END PRIVATE KEY-----\n",
  "client_email": "qr-app-ieeenu@qr-app-ieeenu.iam.gserviceaccount.com",
  "client_id": "111387072373112804655",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/qr-app-ieeenu%40qr-app-ieeenu.iam.gserviceaccount.com",
  "universe_domain": "googleapis.com"
}

''';

const _spreadsheetId = '1qmbs7c_kehHWUI1RCi_2bu2ffaWqbGxrjvkjtiPoEjg';

class QrGenerator extends StatefulWidget {
  const QrGenerator({super.key});

  @override
  State<QrGenerator> createState() => _QrGeneratorState();
}

class _QrGeneratorState extends State<QrGenerator> {
  // Function to handle the button press
  void _generateQRCode() {
    // Add your QR code generation logic here
    // For example, you can use a QR code package like qr_flutter
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Code Generator'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: ReadData,
          child: Text('Generate QR Code'),
        ),
      ),
    );
  }
}

// void ReadData() async {
//   final CollectionReference contacts =
//       FirebaseFirestore.instance.collection("contacts2");
//   final gsheet = GSheets(_credintial);
//   final ss = await gsheet.spreadsheet(_spreadsheetId);
//   var sheet = ss.worksheetByTitle("Test");
//   int rows = sheet?.rowCount ?? 0;

//   for (var i = 1; i <= rows; i++) {
//     var cellsRow = await sheet?.cells.row(i) ?? [];

//     if (cellsRow.isNotEmpty) {
//       var cellValue = cellsRow.elementAt(1)?.value ?? "No value";
//       print(cellValue);
//     } else {
//       print("Row $i is empty.");
//     }
//   }
// }

void ReadData() async {
  final gsheet = GSheets(_credintial);
  final ss = await gsheet.spreadsheet(_spreadsheetId);
  var sheet = ss.worksheetByTitle("Test");

  // Ensure the sheet is not null
  if (sheet == null) {
    print("Sheet not found");
    return;
  }

  // Get the non-empty rows from the "Name" column
  var nonEmptyRows = await sheet.cells.column(2, fromRow: 2);
  
  for (var i = 0; i < nonEmptyRows.length; i++) {
    var cellValue = nonEmptyRows[i]?.value;
    
    if (cellValue != null && cellValue.isNotEmpty) {
      print("$cellValue");
    }
  }
}
