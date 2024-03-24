import 'package:flutter/material.dart';
import 'dart:io';
//import 'package:shared_preferences/shared_preferences.dart';
//import 'package:image_picker/image_picker.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  File? _image;

  // Future<void> _selectImage(ImageSource source) async {
  //   final pickedFile = await ImagePicker().getImage(source: source);
  //   if (pickedFile != null) {
  //     setState(() {
  //       _image = File(pickedFile.path);
  //     });
  //   }
  // }

  // Future<void> _saveUserData() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   await prefs.setString('name', _name);
  //   if (_image != null) {
  //     final imageBytes = _image?.readAsBytesSync();
  //     await prefs.setInt('image_length', imageBytes!.length);
  //     await prefs.setBytes('image', imageBytes);
  //   } else {
  //     await prefs.remove('image_length');
  //     await prefs.remove('image');
  //   }
  // }

  // Future<void> _loadUserData() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   setState(() {
  //     _name = prefs.getString('name') ?? '';
  //     final imageLength = prefs.getInt('image_length');
  //     if (imageLength != null && imageLength > 0) {
  //       final imageBytes = prefs.getBytes('image');
  //       if (imageBytes != null) {
  //         _image = File.fromRawPath(imageBytes);
  //       }
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: _image == null
                    ? const Text('No image selected.')
                    : Image.file(_image!),
              ),
              ElevatedButton(
                onPressed: () {
                  //_selectImage(ImageSource.gallery);
                },
                child: const Text('Select Image'),
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Name'),
                initialValue: _name,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
                onSaved: (value) {
                  _name = value!;
                },
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState?.save();
                    //_saveUserData();
                    // Navigator.pushReplacement(
                    //   context,
                    //   MaterialPageRoute(builder: (_) => HomeScreen()),
                    // );
                  }
                },
                child: const Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    //_loadUserData();
  }
}

// class HomeScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Home Screen'),
//       ),
//       body: Center(
//         child: Text('Welcome, ${widget.name}!'),
//       ),
//     );
//   }
// }