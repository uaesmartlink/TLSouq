import 'dart:io';
import 'package:TLSouq/src/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SinglePdfSelector extends StatefulWidget {
  final String label;
  final AuthController authController;
  final int type;

  const SinglePdfSelector(
      {super.key, required this.label, required this.authController, required this.type});

  @override
  _SinglePdfSelectorState createState() => _SinglePdfSelectorState();
}

class _SinglePdfSelectorState extends State<SinglePdfSelector> {
  late File _pdf;
  String pathFile = "";

  Future<void> _pickPdf() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result != null) {
      setState(() {
        pathFile = result.paths.first!;
        _pdf = File(result.paths.first!);
        if (widget.type == 0)
          widget.authController.licenseFile = _pdf;
        else
          widget.authController.vatFile = _pdf;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        right: 15,
        left: 15,
        bottom: 10,
        top: 5,
      ),
      height: 50,
      child: TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.only(left: 18),
          primary: Colors.grey[500],
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
          backgroundColor: Colors.white,
        ),
        onPressed: () async {
          _pickPdf();
        },
        child: Row(
          children: [
            Container(
              child: Icon(
                color: Colors.grey[500],
                Icons.upload,
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(
                  left: 12,
                ),
                child: Text(
                  pathFile == '' ? widget.label : 'Added successfully',
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                right: 17,
              ),
              child: Icon(
                color: Colors.grey[700],
                Icons.upload,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<File> getFile() async {
    return _pdf;
  }
}
