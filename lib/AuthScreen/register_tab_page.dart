import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shivom_creation/SplashScreen/splashscreen.dart';
import 'package:shivom_creation/global/global.dart';
import 'package:shivom_creation/widgets/custom_text_field.dart';
import 'package:firebase_storage/firebase_storage.dart' as fStorage;
import 'package:shivom_creation/widgets/loading_dialog.dart';

class RegisterTabPage extends StatefulWidget {

  @override
  State<RegisterTabPage> createState() => _RegisterTabPageState();
}

class _RegisterTabPageState extends State<RegisterTabPage> {

  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  TextEditingController confirmPasswordTextEditingController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String downloadUrlImage = "";

  XFile? imgXFile;
  final ImagePicker imagePicker = ImagePicker();

  getImageFromGallery() async
  {
    imgXFile = await imagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      imgXFile;
    });
  }

  formValidation() async
  {
    if(imgXFile == null)
    {
      Fluttertoast.showToast(msg: "Please select an image.");
    }
    else //image is already selected
      {
        //password is equal to confirm password
        if(passwordTextEditingController.text == confirmPasswordTextEditingController.text)
        {
          //check email, pass, confirm password & name text fields
          if(nameTextEditingController.text.isNotEmpty
              && emailTextEditingController.text.isNotEmpty
              && passwordTextEditingController.text.isNotEmpty
              && confirmPasswordTextEditingController.text.isNotEmpty)
            {
              showDialog(
                  context: context,
                  builder: (c)
                  {
                    return LoadingDialogWidget(
                      message: "Registering your account",
                    );
                  }
              );
              //upload image to storage
              String fileName = DateTime.now().millisecondsSinceEpoch.toString();
              fStorage.Reference storageRef = fStorage.FirebaseStorage.instance.ref().child("UsersImages").child(fileName);
              fStorage.UploadTask uploadImageTask = storageRef.putFile(File(imgXFile!.path));
              fStorage.TaskSnapshot taskSnapshot = await uploadImageTask.whenComplete(() {});
              taskSnapshot.ref.getDownloadURL().then((urlImage)
              {
                downloadUrlImage = urlImage;
              });
              //Save the user info to firestore database
              saveInformationToDatabase();
            }
            else
            {
              Navigator.pop(context);
              Fluttertoast.showToast(msg: "Please complete the form. Do not leave any text field empty.");
            }
        }
        else //password is NOT equal to confirm password
        {
          Fluttertoast.showToast(msg: "Password and Confirm Password do not.");
        }
      }
  }

  saveInformationToDatabase() async
  {
    //authenticate the user first
    User? currentUser;
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailTextEditingController.text.trim(),
        password: passwordTextEditingController.text.trim(),
    ).then((auth)
    {
     currentUser = auth.user;
    }).catchError((errorMessage)
    {
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Error Occurred: \n $errorMessage");
    });

    if(currentUser != null)
    {
      //save info to database and save locally
      saveInfoToFirestoreAndLocally(currentUser!);
    }
  }

  saveInfoToFirestoreAndLocally(User currentUser) async
  {
    //to firestore
    FirebaseFirestore.instance.collection("users")
    .doc(currentUser.uid)
    .set(
      {
        "uid": currentUser.uid,
        "email": currentUser.email,
        "name": nameTextEditingController.text.trim(),
        "photoUrl": downloadUrlImage,
        "status": "approved",
        "userCart": ["initialValue"],
      }
    );

    //save locally
    sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences!.setString("uid", currentUser.uid);
    await sharedPreferences!.setString("email", currentUser.email!);
    await sharedPreferences!.setString("name", nameTextEditingController.text.trim());
    await sharedPreferences!.setString("photoUrl", downloadUrlImage);
    await sharedPreferences!.setStringList("userCart", ["initialValue"]);

    Navigator.push(context, MaterialPageRoute(builder: (c)=> splashscreen()));
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: [

            const SizedBox(height: 14,),

            //get-capture image
            GestureDetector(
              onTap: ()
              {
                getImageFromGallery();
              },
              child: CircleAvatar(
                radius: MediaQuery.of(context).size.width*0.20,
                backgroundColor: Colors.white,
                backgroundImage: imgXFile == null ? null : FileImage(File(imgXFile!.path)),

                child: imgXFile == null
                  ? Icon(
                  Icons.add_photo_alternate,
                  color: Colors.grey,
                  size: MediaQuery.of(context).size.width*0.20,
                ) : null,
              ),
            ),

            const SizedBox(height: 12,),

            //input form field
            Form(
              key: formKey,
              child: Column(
                children: [
                  CustomTextField(
                    textEditingController: nameTextEditingController,
                    iconData: Icons.person,
                    hintText: "Name",
                    isObsecre: false,
                    enabled: true,
                  ),

                  //email
                  CustomTextField(
                    textEditingController: emailTextEditingController,
                    iconData: Icons.email,
                    hintText: "Email",
                    isObsecre: false,
                    enabled: true,
                  ),

                  //Password
                  CustomTextField(
                    textEditingController: passwordTextEditingController,
                    iconData: Icons.lock,
                    hintText: "Password",
                    isObsecre: true,
                    enabled: true,
                  ),

                  //Confirm Pass
                  CustomTextField(
                    textEditingController: confirmPasswordTextEditingController,
                    iconData: Icons.lock,
                    hintText: "Confirm Password",
                    isObsecre: true,
                    enabled: true,
                  ),

                  const SizedBox(height: 20,),
                ],
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.amberAccent,
                padding: EdgeInsets.symmetric(horizontal: 50,vertical: 12),
              ),
                onPressed: ()
                {
                  formValidation();
                },
                child: Text(
                  "Sign Up",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
            ),
            const SizedBox(height: 20,),
          ],
        ),
      ),
    );
  }
}

