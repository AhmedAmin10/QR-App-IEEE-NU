const functions = require('firebase-functions');
const { GoogleSpreadsheet } = require('google-spreadsheet');

const _spreadsheetId = '1AwO3S4dVLZqbmE-nrDshsLOWY41M_s7CjyEgvXWYt1o';
const _credintial = require({
    "type": "service_account",
    "project_id": "qr-ieee-nu",
    "private_key_id": "e6a5a272026ee3e7a5fe666d64d6f913e898ce52",
    "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDNtVVEZKzPyjCo\nZMymzLkwzxrMe8Hzxc7QsC5ViJhbkeSl2KY+UrDCenOxpCYgEI7PjiNgPa2o4Atx\nKBPJN0m9mNyzxXn3dgmph75oozVTncov6FBXHh2tIxFExepB2fiigXFSIW9fDr5k\nj7VV1P31MrtNWSdT01en5Q935EIsBdzOrvR71FqWYMcTWDiZD/rU9YisByGyi2NR\nHlrNFUPxxLVckWxgGtkT3c7/HYjhQT/JQCWjbV+FxmeF3jJkOC3UJv9B7LFRDcCm\nB6s8bvWtBO9SzsN12HsAgbWhCSdqAS5FTyDGf4whvzuShTWKfakcZMwL/wlwZFQc\n0EkZiqEBAgMBAAECggEAG8bkHCeiBC7vshVmYxGa4iHdIwaFEpc/zYM0xnz64caK\nAvEFxb2hu6kQTUj2kvbZaeJuGXVKqVaThPSd81pBXVYyWx4L0aQBOwCm7/c14LQa\nVKzAiHr7E+F71/cHolu+DKeA90+ne8UAZZDYMh5gKodurkufGV0c5YFzPMO4QbxM\nmr+P8bKqKPIM8SP/PItUrag+kbRnJlVe0NsgXknPXnvFlgOWBBjFm/Gqwl4k5r1G\n0e9iUkilfYZA2qJaJGgokvkZGtMy0IAEbF8KuK4cx6qQvE+Flyb4k8au/cxk+CEi\n28hY8gCrFNCWngCMnsq5M1+4frl/MpjZ4rgYldMfPwKBgQD+7753vejXWE37hfui\nBFqtDa0Ywzx9mAcChXWNl1A4EFkbNGtVo6zYyE8aXThbCa6fbJhQdHHRse1dGHD1\nTVKOjNEB0pT0ceU+iFIp+ri5eYEXiG5GYWo0wK/3VKyfea8t5AgyZU81PHwxthzo\nHq7LFDH482WyXs+xYQgQvXxq6wKBgQDOkQQ5pl6JBmFs2alaSxk3IMZIXbDxSqcs\npVwxekQ5gZsoeanXZHrLwVwIMMKHn8Pf+72Byw0XTcXogyy8OKlzvOjXeAqVD49Z\nphPWSOBbEvJDwQ35Stt8dB0qdhf6WVsDUYx0Fw6bU19CiwrGKFK44qqeuSLd8ZH1\n15jbHKOQwwKBgQCbell+K6sykl9U87yobeFjQ0D7Ji7hJfO4fO5ZgRviZU4CwnBn\nlV/YAioEGTBCjWAbSJ6ICsxTqCDsMvjJEfQ0jfr2EpjXkBLQlVEO2yMHsuuhD4q5\nj7W3IIDw5Yo15H+LDFRXb+PjwtS3eKqegf/2SIXFn6O5Kgue0V+a3gVgKwKBgHIh\nacY4h+8JmXa85HdBGxN8hlGhgowvBSMD0mZ7+YoUdBfu8MpTeA1wLltQJYst2Nm+\ni7xU5kzD6d9H6sWsQOPzsmqqpp4pVLjhrAAvj9aCJ10MI55jn9WpihvV1/W4vTKe\nMg5KVwW3EOEBVdiamuoQQtkjzYH3YQAGOSyHLFBlAoGBALim7J9EiQ4E+2o+Cvds\nVHb7x64K6oFuQAFFViFfjHr94izVilbSURZs8wMYKNdeKYdRX0QfHJv93Ql23PbP\nR4GnX33qMzeeGefTi7fw2h4norVSfTA4V2adZhd4c9gXUkSXM98zy8Tg7l3pcE+9\n9V6F35qySxNW4BlaqjnDlB9N\n-----END PRIVATE KEY-----\n",
    "client_email": "qrieeenu@qr-ieee-nu.iam.gserviceaccount.com",
    "client_id": "103690943257437868734",
    "auth_uri": "https://accounts.google.com/o/oauth2/auth",
    "token_uri": "https://oauth2.googleapis.com/token",
    "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
    "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/qrieeenu%40qr-ieee-nu.iam.gserviceaccount.com",
    "universe_domain": "googleapis.com"
  });

exports.updateGoogleSheet = functions.firestore
  .document('IEEEdata/{email}')
  .onUpdate(async (change, context) => {
    const newCount = change.after.data().count;
    const email = context.params.email;

    try {
      const gsheets = new GoogleSpreadsheet(_spreadsheetId);
      await gsheets.useServiceAccountAuth(_credintial);
      await gsheets.loadInfo(); // Load the document info

      const sheet = gsheets.sheetsByIndex[0]; // Assuming the sheet is at index 0
      const rows = await sheet.getRows(); // Get all rows

      // Find the row corresponding to the email
      const row = rows.find(row => row.Email === email);
      if (row) {
        // Update the count in the sheet
        row.Attendence = newCount;
        await row.save();
        console.log(`Count updated in Google Sheet for Email: ${email}`);
      } else {
        console.log(`Email not found in Google Sheet: ${email}`);
      }
    } catch (error) {
      console.error('Error updating Google Sheet:', error);
    }
  });
