// import 'dart:io';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:facultyreservation/login_page/login_page.dart';
// import 'package:image_picker/image_picker.dart';

// class ProfileScreen extends StatefulWidget {
//   final ScrollController controller;

//   ProfileScreen({required this.controller});

//   @override
//   _ProfileScreenState createState() => _ProfileScreenState();
// }

// class _ProfileScreenState extends State<ProfileScreen> {
//   final ImagePicker _picker = ImagePicker();
//   XFile? _imageFile;

//   bool showPasswordUI = false;

//   TextEditingController emailController = TextEditingController();
//   TextEditingController newPasswordController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Profile',
//           style: TextStyle(color: Colors.white),
//         ),
//         backgroundColor: const Color(0xFF003580),
//         iconTheme: const IconThemeData(color: Colors.white),
//       ),
//       body: SingleChildScrollView(
//         child: Container(
//           width: MediaQuery.of(context).size.width,
//           child: Column(
//             children: <Widget>[
//               FutureBuilder<User?>(
//                 future: FirebaseAuth.instance.authStateChanges().first,
//                 builder: (context, AsyncSnapshot<User?> snapshot) {
//                   if (snapshot.connectionState == ConnectionState.done) {
//                     return snapshot.data != null
//                         ? displayUserInformation(context, snapshot.data!)
//                         : Text("User not found");
//                   } else {
//                     return CircularProgressIndicator();
//                   }
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget imageProfile() {
//     return Center(
//       child: Stack(
//         children: <Widget>[
//           Padding(
//             padding: const EdgeInsets.all(30.0),
//             child: CircleAvatar(
//               radius: 50.0,
//               backgroundImage: _imageFile == null
//                   ? AssetImage('assets/image_2.jpg')
//                   : FileImage(File(_imageFile!.path)) as ImageProvider<Object>?,
//             ),
//           ),
//           Positioned(
//             bottom: 40.0,
//             left: 90.0,
//             child: Builder(
//               builder: (BuildContext context) {
//                 return InkWell(
//                   onTap: () {
//                     showBottomSheet(
//                       context: context,
//                       builder: (builder) => bottomSheet(context),
//                     );
//                   },
//                   child: Icon(
//                     Icons.camera_alt,
//                     color: Colors.teal,
//                     size: 25.0,
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget bottomSheet(BuildContext context) {
//     return Container(
//       height: 100.0,
//       width: MediaQuery.of(context).size.width,
//       margin: EdgeInsets.symmetric(
//         horizontal: 20.0,
//         vertical: 20.0,
//       ),
//       child: Column(
//         children: <Widget>[
//           Text("Choose Profile Photo", style: TextStyle(fontSize: 20.0)),
//           SizedBox(
//             height: 20.0,
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               FloatingActionButton.extended(
//                 icon: Icon(Icons.camera),
//                 onPressed: () {
//                   takePhoto(ImageSource.camera);
//                 },
//                 label: Text("Camera"),
//               ),
//               SizedBox(width: 20.0),
//               FloatingActionButton.extended(
//                 icon: Icon(Icons.image),
//                 onPressed: () {
//                   takePhoto(ImageSource.gallery);
//                 },
//                 label: Text("Gallery"),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   void takePhoto(ImageSource source) async {
//     final pickedFile = await _picker.pickImage(source: source);
//     if (pickedFile != null) {
//       setState(() {
//         _imageFile = pickedFile;
//       });
//     }
//   }

//   Widget displayUserInformation(BuildContext context, User user) {
//     TextEditingController emailController =
//         TextEditingController(text: user.email ?? 'Anonymous');

//     return Center(
//       child: Column(
//         children: <Widget>[
//           imageProfile(),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: TextFormField(
//               controller: emailController,
//               decoration: InputDecoration(
//                 labelText: 'Email',
//                 border: OutlineInputBorder(),
//                 filled: true,
//                 fillColor: Colors.grey[200],
//               ),
//               readOnly: true,
//             ),
//           ),
//           if (showPasswordUI)
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Column(
//                 children: [
//                   TextFormField(
//                     obscureText: true,
//                     controller: newPasswordController,
//                     decoration: InputDecoration(
//                       labelText: 'New Password',
//                       border: OutlineInputBorder(),
//                       filled: true,
//                       fillColor: Colors.grey[200],
//                     ),
//                   ),
//                   SizedBox(height: 16),
//                   ElevatedButton(
//                     onPressed: () async {
//                       try {
//                         String newPassword = newPasswordController.text;
//                         await FirebaseAuth.instance
//                             .currentUser?.updatePassword(newPassword);

//                         setState(() {
//                           showPasswordUI = false;
//                           newPasswordController.clear();
//                         });
//                       } catch (e) {
//                         print("Error updating password: $e");
//                       }
//                     },
//                     child: Text('Save Password'),
//                   ),
//                 ],
//               ),
//             ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: TextButton(
//               onPressed: () {
//                 setState(() {
//                   showPasswordUI = !showPasswordUI;
//                 });
//               },
//               child: Text(
//                 showPasswordUI ? 'Cancel' : 'Change Password',
//                 style: TextStyle(
//                   color: Colors.blue,
//                   decoration: showPasswordUI
//                       ? TextDecoration.underline
//                       : TextDecoration.none,
//                 ),
//               ),
//             ),
//           ),
//           showSignOut(context, user.isAnonymous),
//         ],
//       ),
//     );
//   }

//   Widget showSignOut(BuildContext context, bool isAnonymous) {
//     if (isAnonymous == true) {
//       return ElevatedButton(
//         style: ElevatedButton.styleFrom(
//           backgroundColor: Colors.red,
//         ),
//         child: Text(
//           "Sign In To Save Your Data",
//           style: TextStyle(color: Colors.white),
//         ),
//         onPressed: () {
//           Navigator.of(context).pushNamed('/convertUser');
//         },
//       );
//     } else {
//       return ElevatedButton(
//         style: ElevatedButton.styleFrom(
//           backgroundColor: Colors.blue,
//         ),
//         child: Text(
//           "Sign Out",
//           style: TextStyle(color: Colors.white),
//         ),
//         onPressed: () async {
//           try {
//             User? currentUser = FirebaseAuth.instance.currentUser;
//             await currentUser?.delete();
//             await FirebaseAuth.instance.signOut();
//             Navigator.pushReplacement(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => LoginPage(controller: PageController()),
//               ),
//             );
//           } catch (e) {
//             print(e);
//           }
//         },
//       );
//     }
//   }
// }

import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  final ScrollController controller;

  ProfileScreen({required this.controller});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ImagePicker _picker = ImagePicker();
  XFile? _imageFile;

  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF003580),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: <Widget>[
              FutureBuilder<User?>(
                future: FirebaseAuth.instance.authStateChanges().first,
                builder: (context, AsyncSnapshot<User?> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return snapshot.data != null
                        ? displayUserInformation(context, snapshot.data!)
                        : Text("User not found");
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget displayUserInformation(BuildContext context, User user) {
    TextEditingController emailController =
        TextEditingController(text: user.email ?? 'Anonymous');

    return Center(
      child: Column(
        children: <Widget>[
          imageProfile(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(
                  color: Color(0xFF003580), // Set the border color here
                ),
                color: Colors.blue[50], // Set the background color here
              ),
              child: TextFormField(
                controller: emailController,
                style: TextStyle(fontSize: 16.0, color: Colors.black),
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(color: Color(0xFF003580)), // Set the label color here
                  border: InputBorder.none,
                ),
                readOnly: true,
              ),
            ),
          ),
          showSignOut(context, user.isAnonymous),
        ],
      ),
    );
  }

  Widget imageProfile() {
    return Center(
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: CircleAvatar(
              radius: 80.0,
              backgroundImage: _imageFile == null
                  ? AssetImage('assets/vector-1.jpg')
                  : FileImage(File(_imageFile!.path)) as ImageProvider<Object>?,
            ),
          ),
          Positioned(
            bottom: 40.0,
            left: 130.0,
            child: Builder(
              builder: (BuildContext context) {
                return InkWell(
                  onTap: () {
                    showBottomSheet(
                      context: context,
                      builder: (builder) => bottomSheet(context),
                    );
                  },
                  child: Icon(
                    Icons.camera_alt,
                    color: Color(0xFF003580),
                    size: 40.0,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget bottomSheet(BuildContext context) {
    return Container(
      height: 200.0,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 20.0,
      ),
      child: Column(
        children: <Widget>[
          Text("Choose Profile Photo", style: TextStyle(fontSize: 20.0)),
          SizedBox(
            height: 20.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FloatingActionButton.extended(
                icon: Icon(Icons.camera_alt, color: Color(0xFF003580)), // Set the icon color here
                onPressed: () {
                  takePhoto(ImageSource.camera);
                },
                label: Text("Camera"),
              ),
              SizedBox(width: 20.0),
              FloatingActionButton.extended(
                icon: Icon(Icons.image, color: Color(0xFF003580)), // Set the icon color here
                onPressed: () {
                  takePhoto(ImageSource.gallery);
                },
                label: Text("Gallery"),
              ),
            ],
          ),
        ],
      ),
    );
  }


  void takePhoto(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _imageFile = pickedFile;
      });
    }
  }

  Widget showSignOut(BuildContext context, bool isAnonymous) {
    if (isAnonymous == true) {
      return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
        ),
        child: Text(
          "Sign In To Save Your Data",
          style: TextStyle(color: Colors.white),
        ),
        onPressed: () {
          Navigator.of(context).pushNamed('/convertUser');
        },
      );
    } else {
      return SizedBox.shrink(); // This will create an empty space and won't render anything
    }
  }
}
