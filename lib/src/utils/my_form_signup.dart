import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';

class MyFormWidget extends StatefulWidget {
  @override
  _MyFormWidgetState createState() => _MyFormWidgetState();
}

class _MyFormWidgetState extends State<MyFormWidget> {
  final _formKey = GlobalKey<FormState>();
  late String _firstName, _lastName, _email, _password, _confirmPassword;
  late File _licenseFile, _vatFile;

  Future<void> _getLicenseFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result != null) {
      setState(() {
        _licenseFile = File(result.files.single.path!);
      });
    }
  }

  Future<void> _getVatFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result != null) {
      setState(() {
        _vatFile = File(result.files.single.path!);
      });
    }
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      // Send form data to API
      var url = Uri.parse('https://example.com/register');
      var request = http.MultipartRequest('POST', url);
      request.fields['firstName'] = _firstName;
      request.fields['lastName'] = _lastName;
      request.fields['email'] = _email;
      request.fields['password'] = _password;
      request.fields['confirmPassword'] = _confirmPassword;
      if (_licenseFile != null) {
        request.files.add(
          http.MultipartFile(
            'licenseFile',
            _licenseFile.readAsBytes().asStream(),
            _licenseFile.lengthSync(),
            filename: _licenseFile.path.split('/').last,
          ),
        );
      }
      if (_vatFile != null) {
        request.files.add(
          http.MultipartFile(
            'vatFile',
            _vatFile.readAsBytes().asStream(),
            _vatFile.lengthSync(),
            filename: _vatFile.path.split('/').last,
          ),
        );
      }
      var response = await request.send();
      if (response.statusCode == 200) {
        print('Form submitted successfully');
      } else {
        print('Error submitting form');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(labelText: 'First Name'),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your first name';
              }
              return null;
            },
            onSaved: (value) {
              _firstName = value!;
            },
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Last Name'),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your last name';
              }
              return null;
            },
            onSaved: (value) {
              _lastName = value!;
            },
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Email'),
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your email';
              }
              if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                return 'Please enter a valid email address';
              }
              return null;
            },
            onSaved: (value) {
              _email = value!;
            },
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Password'),
            keyboardType: TextInputType.emailAddress,
            obscureText: true,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter a password';
              }
              return null;
            },
            onSaved: (value) {
              _password = value!;
            },
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Confirm Password'),
            obscureText: true,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please confirm your password';
              }
              if (value != _password) {
                return 'Passwords do not match';
              }
              return null;
            },
            onSaved: (value) {
              _confirmPassword = value!;
            },
          ),
          SizedBox(height: 20),
          ElevatedButton(
            child: Text('Select License PDF'),
            onPressed: _getLicenseFile,
          ),
          SizedBox(height: 10),
          ElevatedButton(
            child: Text('Select VAT PDF'),
            onPressed: _getVatFile,
          ),
          SizedBox(height: 20),
          ElevatedButton(
            child: Text('Submit'),
            onPressed: _submitForm,
          ),
        ],
      ),
    );
  }
}
