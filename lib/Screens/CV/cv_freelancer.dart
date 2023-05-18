// import 'dart:io';
// import 'dart:typed_data';

// import 'package:flutter/material.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:file_picker/file_picker.dart';

// class UploadCvPage extends StatefulWidget {
//   const UploadCvPage({Key? key}) : super(key: key);

//   @override
//   _UploadCvPageState createState() => _UploadCvPageState();
// }

// class _UploadCvPageState extends State<UploadCvPage> {
//   int index = 6;
//   File? _selectedFile;
//   bool _isUploading = false;
//   String? _uploadUrl;
//   late Uint8List? filebytes;
//   String filename = '';
//   late FilePickerResult result;

//   Future<void> _selectFile() async {
//     FilePickerResult? result = await FilePicker.platform.pickFiles(
//       type: FileType.custom,
//       allowedExtensions: ['pdf', 'doc', 'docx'],
//     );
//     // print(result);
//     if (result != null) {
//       Uint8List? fileBytes = result.files.first.bytes;
//       String fileName = result.files.first.name;
//       setState(() {
//         filename = fileName;
//         filebytes = fileBytes;
//       });
//     }
//   }

//   Future<void> _uploadFile() async {
//     await FirebaseStorage.instance.ref('uploads/$filename').putData(filebytes!);
//     debugPrint("Sucessfully Done");
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(
//         content: Text('CV succesfully uploaded.'),
//       ),
//     );

//     Navigator.pop(context);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // bottomNavigationBar: BottomNavigatorforApp(indexNum: 2),
//       appBar: AppBar(
//         title: const Text('Upload CV'),
//       ),
//       body: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             colors: [Color(0xFF6600FF), Color(0xFF8C309C)],
//             begin: Alignment.centerLeft,
//             end: Alignment.centerRight,
//           ),
//         ),
//         child: Center(
//           child: Card(
//             margin: const EdgeInsets.all(16.0),
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   const Icon(Icons.attach_file, size: 32.0),
//                   const SizedBox(height: 16.0),
//                   const Text(
//                     'Upload your CV',
//                     style: TextStyle(fontSize: 24.0),
//                   ),
//                   const SizedBox(height: 16.0),
//                   ElevatedButton(
//                     onPressed: _selectFile,
//                     child: const Text('seleect file'),
//                   ),
//                   filename == '' ? SizedBox() : Text(filename),
//                   ElevatedButton(
//                     onPressed: _uploadFile,
//                     child: const Text('uplaod file'),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';

class UploadCvPage extends StatefulWidget {
  const UploadCvPage({Key? key}) : super(key: key);

  @override
  _UploadCvPageState createState() => _UploadCvPageState();
}

class _UploadCvPageState extends State<UploadCvPage> {
  int index = 6;
  File? _selectedFile;
  bool _isUploading = false;
  String? _uploadUrl;
  late Uint8List? filebytes;
  String filename = '';
  late FilePickerResult result;

  Future<void> _selectFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx'],
    );
    // print(result);
    if (result != null) {
      Uint8List? fileBytes = result.files.first.bytes;
      String fileName = result.files.first.name;
      setState(() {
        filename = fileName;
        filebytes = fileBytes;
      });
    }
  }

  Future<void> _uploadFile() async {
    await FirebaseStorage.instance.ref('uploads/$filename').putData(filebytes!);
    debugPrint("Successfully Done");
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('CV successfully uploaded.'),
      ),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload CV'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF6600FF), Color(0xFF8C309C)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: Center(
          child: Card(
            margin: const EdgeInsets.all(16.0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 16.0),
                  const Text(
                    'Upload your CV',
                    style: TextStyle(fontSize: 24.0),
                  ),
                  const SizedBox(height: 16.0),
                  OutlinedButton(
                    onPressed: _selectFile,
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Colors.black),
                      backgroundColor: Colors.transparent,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(
                          Icons.attach_file,
                          size: 20.0,
                          color: Colors.grey,
                        ),
                        SizedBox(width: 8.0),
                        Text(
                          'Select File',
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  filename == '' ? SizedBox() : Text(filename),
                  ElevatedButton(
                    onPressed: _uploadFile,
                    style: ElevatedButton.styleFrom(
                      primary: Colors.cyan,
                      elevation: 15,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 14),
                      child: Text(
                        'Upload File',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
