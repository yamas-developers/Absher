import 'package:absher/helpers/route_constants.dart';
import 'package:pinput/pinput.dart';
import 'package:flutter/material.dart';

import '../../helpers/constants.dart';
import '../../helpers/public_methods.dart';
import '../common_widgets/rounded_center_button.dart';


class OtpVerificationScreen extends StatefulWidget {
  static const String routeName = "/otp_screen";

  const OtpVerificationScreen({Key? key}) : super(key: key);


  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final TextEditingController _pinPutController = TextEditingController();
  // User? user;

  int enteredPin = 0;
  String? _verId;
  int? _resendToken;
  bool initialized = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    var userData = ModalRoute.of(context)!.settings.arguments;
    // user = userData as User;
    // print('userData: ${user!.toJson()}');
    // if(!initialized){
    // sendOtp();
    // initialized = true;
    // }
    super.didChangeDependencies();
  }

  // _verificationCompleted(auth.PhoneAuthCredential credential) {
  //   print('authCredentials in Verification Completed: $credential');
  // }
  //
  // _verificationFailed(auth.FirebaseAuthException e) {
  //   print('exception: $e');
  // }

  _codeSent(String verificationId, int? resendToken) {
    // _verId = verificationId;
    // _resendToken = resendToken;
    //
    // print('verID: $verificationId');
    // print('resendToken: $resendToken');

    // String smsCode = '123456';

    // Create a PhoneAuthCredential with the code
    // auth.PhoneAuthCredential credential = auth.PhoneAuthProvider.credential(
    //     verificationId: verificationId, smsCode: smsCode);
    // print('credentials in codeSent: $credential');

    // Sign the user in (or link) with the credential
  }

  _codeAutoRetrievalTimeout(String verificationId) {
    print('verificationId in timeout: $verificationId');
  }

  sendOtp() async {
    // await auth.FirebaseAuth.instance.verifyPhoneNumber(
    //   phoneNumber: '${user!.phoneNumber}',
    //   // user!.phoneNumber!,
    //   verificationCompleted: _verificationCompleted,
    //   verificationFailed: _verificationFailed,
    //   codeSent: _codeSent,
    //   codeAutoRetrievalTimeout: _codeAutoRetrievalTimeout,
    //   forceResendingToken: _resendToken,
    //   timeout:Duration(seconds: 60),
    // );
  }

  // verifyOtp() async {
  //   print('myTag in verifyOtp');
  //   final auth.PhoneAuthCredential credential =
  //       auth.PhoneAuthProvider.credential(
  //           verificationId: _verId!, smsCode: _pinPutController.text);
  //
  //   try {
  //     showProgressDialog(context, "Verifying One Time Passscode", isDismissable: false);
  //     //show progress dialogue
  //     await auth.FirebaseAuth.instance
  //         .signInWithCredential(credential)
  //         .then((auth.UserCredential verifiedUser) async {
  //       print('myTag in signinwithcredentials');
  //
  //       if (verifiedUser != null) {
  //         MjApiService apiService = MjApiService();
  //
  //
  //         dynamic paylaod = {
  //         "username": user!.username,
  //         "email": user!.email,
  //         "is_phone_verified": "Yes",
  //         };
  //         print('myTag in before calling api, payload: $paylaod');
  //
  //         dynamic response = await apiService.simplePostRequest(MJ_Apis.update_user+"/${user!.id}", paylaod);
  //         print('response in OTP screen: ${response}');
  //         print(response['username'].toString());
  //
  //         hideProgressDialog(context);
  //
  //         if(response != null){
  //           print('response status: ' + response['status'].toString());
  //           showToast(response['message']);
  //           // print('status: ${response['status']}');
  //           if(response['status'] == 1){
  //             User user = User.fromJson(response['response']['user']);
  //             user.token = response['response']['token'];
  //             Navigator.pushNamed(context, LoginScreen.routeName,);
  //           }
  //         }
  //         //go to login screen
  //       }
  //       //dismiss dialogu
  //     });
  //   } on Exception {
  //     //handle exception
  //   }
  // }

  @override
  Widget build(BuildContext context) {

    bool isKeyboardAppeared = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Column(
        // mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: getHeight(context) * 0.05,
                ),
                Image.asset(
                  'assets/images/app_logo.png',
                  width: 110,

                  // height: 140,
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  getString("auth__verify_otp"),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: mediumGreyFontColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 50,
                ),
                buildPinPut(
                  // controller: _pinPutController,
                  // label: 'ENTER OTP',
                  // icon: Icons.verified_outlined,
                ),
                SizedBox(
                  height: 50,
                ),
                RoundedCenterButtton(
                    onPressed: () {
                      Navigator.pushNamed(context, home_screen);

                    },
                    title: getString("auth__sign_up")),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Didn\'t get OTP?',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    TextButton(

                      onPressed: () async {
                        await sendOtp();

                      },
                      child: Text(
                        'Resend',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Theme.of(context).accentColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget buildPinPut() {
    final defaultPinTheme = PinTheme(
      // margin: EdgeInsets.all(5),
      width: 40,
      height: 43,
      textStyle: TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(30, 60, 87, 1),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromRGBO(200, 200, 200, 1)),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        color: Color.fromRGBO(234, 239, 243, 1),
      ),
    );

    return Pinput(
      controller: _pinPutController,
      keyboardType:
          TextInputType.numberWithOptions(signed: false, decimal: false),
      length: 6,
      defaultPinTheme: defaultPinTheme,
      focusedPinTheme: focusedPinTheme,
      submittedPinTheme: submittedPinTheme,
      showCursor: true,
      onCompleted: (pin) {
        print(pin);
      },
    );
  }
}
