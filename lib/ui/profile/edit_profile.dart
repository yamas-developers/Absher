import 'dart:developer';
import 'dart:io';

import 'package:absher/helpers/constants.dart';
import 'package:absher/ui/common_widgets/misc_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/src/provider.dart';

import 'package:intl/intl.dart';
import 'package:image_cropper/image_cropper.dart';

import '../../api/mj_api_service.dart';
import '../../api/mj_apis.dart';
import '../../config/mj_config.dart';
import '../../helpers/public_methods.dart';
import '../../models/user.dart';
import '../../providers/user/user_provider.dart';
import '../common_widgets/rounded_text_field.dart';

class EditProfile extends StatefulWidget {
  // static const String routeName = "/profile_edit";

  const EditProfile({Key? key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  DateTime selectedDate = DateTime.now();
  MjApiService apiService = MjApiService();

  TextEditingController firstNameCtrl = TextEditingController();
  TextEditingController lastNameCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController phoneCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();
  TextEditingController confirmPasswordCtrl = TextEditingController();

  bool isLoading = false;
  bool shouldSubmit = true;

  String firstNameErrorText = '';
  String lastNameErrorText = '';
  String emailErrorText = '';
  String phoneErrorText = '';
  String passwordErrorText = '';
  String confirmPasswordErrorText = '';

  // String phonePrefixText = "+1";
  String completePhoneNumber = "";
  String? profilePic;

  // File? imageFile;
  _getFromGallery() async {
    try {
      PickedFile? pickedFile = await ImagePicker().getImage(
        source: ImageSource.gallery,
      );

      // File file = File("");
      if (pickedFile != null) {
        CroppedFile? croppedFile = await ImageCropper().cropImage(
            sourcePath: pickedFile.path,
            aspectRatioPresets: [
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio3x2,
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.ratio4x3,
              CropAspectRatioPreset.ratio16x9
            ],
          uiSettings: [
            AndroidUiSettings(
                toolbarTitle: 'Cropper',
                toolbarColor: mainColor,
                toolbarWidgetColor: Colors.white,
                initAspectRatio: CropAspectRatioPreset.ratio4x3,
                lockAspectRatio: false),
            IOSUiSettings(
              title: 'Cropper',
            ),
            WebUiSettings(
              context: context,
            ),
          ],
        );
        if (croppedFile != null) {
          setState(() {
            profileImage = File(croppedFile.path);
          });
          // uploadImage(File(croppedFile.path));

        }
      }
    } catch (e) {
      print(e);
    }
  }

  File? profileImage;

  uploadImage(File pickedFile) async {
    // showProgressDialog(context, "Uploading");
    // var response = await apiService.postMultiPartRequest(
    //     MJ_Apis.upload_image + "/user", {"image": File(pickedFile.path)});
    // hideProgressDialog(context);
    // String url = '';
    // if (response != null) {
    //   url = response['url'];
    // } else {
    //   return;
    // }
    // if (url.isEmpty) {
    //   showToast("image uploading failed");
    //   return;
    // }
    if (profilePic != null) {
      // deleteImage(profilePic);
    }
    // setState(() {
      // profilePic = url;
      // User usr = await getuser();
      // setState(() {
      //   user = usr;
      // });
      // imageFile = null;
    // });
    // if (user != null) {
    //   user.profileImage = url;
    // }
    // saveImage(profilePic);
    // await setUser(user);
  }
  ////////////////////////////////////////////////////////////
  saveImage(String image) async {
    dynamic paylaod = {
      "profile_image": image,
    };
    print(paylaod);
    // showProgressDialog(context, MJConfig.please_wait);
    // dynamic response = await apiService.simplePostRequest(
    //     MJ_Apis.update_user + "/" + user.id!, paylaod);
    // // hideProgressDialog(context);
    // print('responseImp: ${response}');
    // // print(response['user_name'].toString());
    // if (response != null) {
    //   print('response status: ' + response['status'].toString());
    //   showToast(response['message']);
    //   // print('status: ${response['status']}');
    //   if (response['status'] == 1) {
    //     var token = this.user.token;
    //     User user = User.fromJson(response['response']['user']);
    //     user.token = token;
    //     setUser(user);
    //     context.read<MyProfileProvider>().setMyProfile(user);
    //   }
    }


submit() async {
  setState(() {
    completePhoneNumber = /*phonePrefixText + */ phoneCtrl.text;
    firstNameErrorText = '';
    emailErrorText = '';
    lastNameErrorText = '';
    phoneErrorText = '';
    passwordErrorText = '';
    confirmPasswordErrorText = '';
  });

  shouldSubmit = true;

  print('phoneNumber: ${completePhoneNumber}');

  if (!RegExp(r"^[A-Za-z' ]{3,}$").hasMatch(firstNameCtrl.text)) {
    if (firstNameCtrl.text.isEmpty) {
      setState(() {
        firstNameErrorText = 'Please enter first name';
      });
    } else {
      setState(() {
        firstNameErrorText = 'First name is not valid';
      });
    }
    shouldSubmit = false;
  }
  if (!RegExp(r"^[A-Za-z' ]{3,}$").hasMatch(lastNameCtrl.text)) {
    if (lastNameCtrl.text.isEmpty) {
      setState(() {
        lastNameErrorText = 'Please enter last name';
      });
    } else {
      setState(() {
        lastNameErrorText = 'Last name is not valid';
      });
    }
    shouldSubmit = false;
  }

  if (!(RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(emailCtrl.text))) {
    if (emailCtrl.text.isEmpty) {
      emailErrorText = 'Please enter email';
    } else {
      setState(() {
        emailErrorText = 'Email is not valid';
      });
    }

    shouldSubmit = false;
  }
  // if (!RegExp(r'((\+[0-9]{1,3}))[ -]?3([0-9]{2})[ -]?[0-9]{4}[ -]?[0-9]{3}$')
  if (!RegExp(r'^[+0-9]{10,13}$').hasMatch(phoneCtrl.text)) {
    if (phoneCtrl.text.isEmpty) {
      setState(() {
        phoneErrorText = 'Please enter phone';
      });
    } else {
      setState(() {
        phoneErrorText = 'Please enter valid phone';
      });
    }
    shouldSubmit = false;
  }

  // if (passwordCtrl.text.isEmpty) {
  //   setState(() {
  //     passwordErrorText = 'Password can not be empty';
  //   });
  //   shouldSubmit = false;
  // }
  // if (passwordCtrl.text.isNotEmpty) {
  //   if (passwordCtrl.text.length < 8) {
  //     passwordErrorText = 'Password:';
  //     setState(() {
  //       passwordErrorText += '\n - Must be at least 8 characters long';
  //     });
  //     shouldSubmit = false;
  //   }
  //   if (RegExp(r"[ ]+").hasMatch(passwordCtrl.text)) {
  //     passwordErrorText == '' ? 'Password:' : '';
  //     setState(() {
  //       passwordErrorText += '\n - Must not contain white spaces';
  //     });
  //     shouldSubmit = false;
  //   }
  //   if (!(RegExp(r"[a-zA-Z]+[A-Za-z]+").hasMatch(passwordCtrl.text))) {
  //     passwordErrorText == '' ? 'Password:' : '';
  //     setState(() {
  //       passwordErrorText +=
  //       '\n - Must contain upper and lower case characters';
  //     });
  //     shouldSubmit = false;
  //   }
  //   if (!(RegExp(r"[.!#$%&'*@+-/=?^_`{|}~]+").hasMatch(passwordCtrl.text))) {
  //     passwordErrorText == '' ? 'Password:' : '';
  //     print('in symbol if');
  //     setState(() {
  //       passwordErrorText += '\n - Must contain at least one special symbol';
  //     });
  //     shouldSubmit = false;
  //   }
  // }
  // if (confirmPasswordCtrl.text.isEmpty) {
  //   setState(() {
  //     confirmPasswordErrorText = 'Please confirm your password';
  //   });
  //   shouldSubmit = false;
  // }
  // if (passwordCtrl.text != confirmPasswordCtrl.text) {
  //   setState(() {
  //     confirmPasswordErrorText = 'Password doesn\'t match';
  //   });
  //   shouldSubmit = false;
  // }

  if (shouldSubmit) {
    MjApiService apiService = MjApiService();
    dynamic payload = {
      "f_name": firstNameCtrl.text,
      "l_name": lastNameCtrl.text,
      "email": emailCtrl.text,
      "phone": completePhoneNumber,
      // "password": passwordCtrl.text,
      // "current_password": confirmPasswordCtrl.text,
    };
    Map<String, File> files = {};
    if(profileImage!=null)
    files = {
      "image": profileImage!,

    };
    try {
      // await setSession(null); //////temporary
      showProgressDialog(context, MJConfig.please_wait, isDismissable: false);
      dynamic response =
      await apiService.postMultiPartRequest(MJ_Apis.update_profile, files, data: payload, );
      if (response != null) {
        showToast(response['message']);
        UserProvider userProvider = context.read<UserProvider>();
        userProvider.setUser(response["response"]["data"]);
        // await userProvider.fetchUser();
        hideProgressDialog(context);
        Navigator.pop(context);
        // if (userProvider.isLogin)
        //   // Navigator.pushNamedAndRemoveUntil(
        //   //     context, home_screen, (val) => false);
        // else {
        //   // Navigator.pushReplacementNamed(context, login_screen);
        // }
      } else {
        hideProgressDialog(context);
        // showToast("Unable to fetch server response, please try later");
      }
    } catch (e) {
      hideProgressDialog(context);
      log("error in signup screen: ${e}");
    } finally {}
  }
}

  save() async {
    dynamic paylaod = {
      /*"firstname": firstNameCtrl.text,
      "lastname": lastNameCtrl.text,
      "username": userNameCtrl.text,
      "phone_number": phoneNumberCtrl.text,
      "age": dateOfBirthCtrl.text,
      "address": addressCtrl.text,
      "email": user.email!,
      "profile_image": profilePic,*/
    };
    print(paylaod);
    /*showProgressDialog(context, MJConfig.please_wait);
    dynamic response = await apiService.simplePostRequest(
        MJ_Apis.update_user + "/" + user.id!, paylaod);
    hideProgressDialog(context);
    print('responseImp: ${response}');
    // print(response['user_name'].toString());
    if (response != null) {
      print('response status: ' + response['status'].toString());
      showToast(response['message']);
      // print('status: ${response['status']}');
      if (response['status'] == 1) {
        var token = this.user.token;
        User user = User.fromJson(response['response']['user']);
        user.token = token;
        setUser(user);
        context.read<MyProfileProvider>().setMyProfile(user);
        Navigator.of(context).pop();
      } else {}
    }*/
  }

  User? user;

  // @override
  // void initState() {
  //   super.initState();
  // }

  @override
  void didChangeDependencies() {
    getuser();
  }

  getuser() async {
    setState(() {
    user = Provider.of<UserProvider>(context, listen: false).currentUser;
    });

    if (user != null) {
      firstNameCtrl.text = user?.fName ?? '';
      lastNameCtrl.text = user?.lName ?? '';
      phoneCtrl.text = user?.phone??"";
      emailCtrl.text = user?.email??'';
      // userNameCtrl.text = user.username ?? '';
      // dateOfBirthCtrl.text = dateOfBirthCtrl.text;
      // addressCtrl.text = user.address ?? '';
      // passwordCtrl.text = user!.password ?? '';
      setState(() {
        profilePic = user?.image;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(243, 243, 243, 1),
      appBar: AppBar(
        // backgroundColor: Theme,
        // leading: getDefaultAppBackButton(color: Colors.white),
        elevation: 0,
        toolbarHeight: 50,
        title: Text('${user?.fName} ${user?.lName}'),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                      onTap: () {
                        _getFromGallery();
                      },
                      child: Container(
                        decoration: BoxDecoration(border: Border.all(color: mainColor.withOpacity(0.3)),borderRadius: BorderRadius.circular(100),),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: profileImage==null
                              ?
                          // FileImage()
                          ImageWithPlaceholder(
                            width: 120,
                            height: 120,
                            image: profilePic,
                            prefix: MJ_Apis.profileImgPath,
                            fit: BoxFit.cover,
                          )
                              : ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Container(
                                  color: Colors.black12,
                                  child: Image.file(
                                    profileImage!,
                                    // color: Colors.grey,
                                    width: 120,
                                    height: 120,
                                    fit: BoxFit.fitHeight,
                                  ))
                          ),
                        ),
                      )),
                ],
              ),
              SizedBox(height: 16,),
              Text(
                "Edit profile",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                child: Column(
                  children: [
                    RoundedTextField(
                      label: getString("auth__first_name"),
                      icon: Icons.person,
                      controller: firstNameCtrl,
                      errorText: firstNameErrorText,
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    RoundedTextField(
                      label: getString("auth__last_name"),
                      icon: Icons.person,
                      controller: lastNameCtrl,
                      errorText: lastNameErrorText,
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    RoundedTextField(
                      label: getString("auth__email_address"),
                      icon: Icons.alternate_email,
                      controller: emailCtrl,
                      errorText: emailErrorText,
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    RoundedTextField(
                      label: getString("auth__phone"),
                      icon: Icons.phone,
                      controller: phoneCtrl,
                      errorText: phoneErrorText,
                    ),

                  ],
                ),
              ),
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
                child: SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: MaterialButton(
                      color: mainColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      onPressed: () {
                        submit();
                      },
                      child: Text(
                        "Save",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w500),
                      ),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
