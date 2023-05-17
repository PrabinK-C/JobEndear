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
  late Uint8List fileBytes;
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

      await FirebaseStorage.instance
          .ref('uploads/$fileName')
          .putData(fileBytes!);

      debugPrint("Sucessfully Done");
    }
  }

  Future<void> _uploadFile() async {
    if (_selectedFile == null) {
      return;
    } else {
      setState(() {
        _isUploading = true;
      });

      setState(() {
        _isUploading = false;
        //_uploadUrl = downloadUrl;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // bottomNavigationBar: BottomNavigatorforApp(indexNum: 2),
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
                  const Icon(Icons.attach_file, size: 32.0),
                  const SizedBox(height: 16.0),
                  const Text(
                    'Upload your CV',
                    style: TextStyle(fontSize: 24.0),
                  ),
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: _selectFile,
                    child: const Text('uplaod file'),
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
