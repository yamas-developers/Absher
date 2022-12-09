import 'package:absher/helpers/constants.dart';
import 'package:absher/providers/location/location_provider.dart';
import 'package:absher/ui/common_widgets/comon.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../helpers/public_methods.dart';
import '../common_widgets/rounded_center_button.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({Key? key}) : super(key: key);

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<LocationProvider>().getCurrentLocation();
    });
    super.initState();
  }

  bool isInitialScreen = true;

  @override
  void didChangeDependencies() {
    if (ModalRoute.of(context)!.settings.arguments == null) return;
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    if (args != null) {
      isInitialScreen = args["isInitialScreen"];

      print("arguments: ${isInitialScreen}");
    }
    super.didChangeDependencies();
  }

  bool languageContainerExpanded  = false;
  // String selctedLanguage = "Arabic";
  // List languagesList = ["English", "Arabic"];

  @override
  Widget build(BuildContext context) {
    String currentLocale = context.locale.toString();
    Widget column = Column(
      // mainAxisAlignment: MainAxisAlignment.center,
      // crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: getHeight(context)*0.13,),
        Image.asset(
          'assets/images/app_logo.png',
          width: 130,

          // height: 140,
        ),
        SizedBox(height: 35,),
        Text(getString(isInitialScreen? "language__select_language_location" : "language__select_language"),
          textAlign: TextAlign.center,
          style: TextStyle(
              color: mainColor,
              fontSize: 16,
              fontWeight: FontWeight.w600
          ),),
        SizedBox(height: 40,),
        InkWell(
          onTap: (){
            setState(() {
              languageContainerExpanded = !languageContainerExpanded;
            });
          },
          child: AnimatedContainer(
            duration: Duration(milliseconds: 200),
            height: languageContainerExpanded ? 90 : 55,
            width: getWidth(context)-66,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
            decoration: BoxDecoration(
                color: mainColor.withOpacity(languageContainerExpanded? 1:0.9),
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                    colors: [mainColor, mainColorLight.withOpacity(languageContainerExpanded? 1:0.8)]
                    ,begin: Alignment.topCenter,
                    end: Alignment.bottomCenter
                ),
                boxShadow: [
                  BoxShadow(
                      color: darkGreyColor.withOpacity(0.2),
                      offset: Offset(0, 2),
                      blurRadius: 8)
                ]
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 6.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(width: 20,),
                  SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        // SizedBox(height: 10,),
                        ...List.generate(langs.length, (index) => Visibility(
                          visible: currentLocale == langs[index]["locale"] || languageContainerExpanded,
                          child: InkWell(
                            onTap: (){
                              if(!languageContainerExpanded){
                                setState(() {
                                  languageContainerExpanded = !languageContainerExpanded;
                                });
                                return;
                              }
                              setLocale(langs[index]);
                              setState(() {
                                // currentLocale = langs[index]["locale"];
                                languageContainerExpanded = !languageContainerExpanded;
                              });
                            },
                            child: Padding(
                              padding: EdgeInsets.only(bottom: languageContainerExpanded ? 20 : 0.0),
                              child: Text(langs[index]["lang"],
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600
                                ),),
                            ),
                          ),
                        ),),

                      // if(languageContainerExpanded)SizedBox(height: 30,),
                      // Visibility(
                      //   visible: selctedLanguage == "Arabic" || languageContainerExpanded,
                      //   child: InkWell(
                      //     onTap: (){
                      //       if(!languageContainerExpanded){
                      //         setState(() {
                      //           languageContainerExpanded = !languageContainerExpanded;
                      //         });
                      //         return;
                      //       }
                      //       setState(() {
                      //         selctedLanguage = "Arabic";
                      //         languageContainerExpanded = !languageContainerExpanded;
                      //       });
                      //     },
                      //     child: Text("Arabic",
                      //       textAlign: TextAlign.center,
                      //       style: TextStyle(
                      //           color: Colors.white,
                      //           fontSize: 15,
                      //           fontWeight: FontWeight.w600
                      //       ),),
                      //   ),
                      // ),

                    ],),
                  ),

                  // SizedBox(width: 30,),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 0),
                    child: Image.asset("assets/icons/arrow_down.png", height: 20,),
                  ),
                  SizedBox(width: 20,),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 30,),
        if(isInitialScreen)GestureDetector(
          onTap: (){
            modalBottomSheetCity(context);
          },
          child: Container(
            width: getWidth(context)-66,
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 0),
            decoration: BoxDecoration(
                color: mainColor.withOpacity(0.9),
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                    colors: [mainColor, mainColorLight.withOpacity(0.8)]
                    ,begin: Alignment.topCenter,
                    end: Alignment.bottomCenter
                ),
                boxShadow: [
                  BoxShadow(
                      color: darkGreyColor.withOpacity(0.2),
                      offset: Offset(0, 2),
                      blurRadius: 8)
                ]
            ),
            child: Row(
              children: [
                SizedBox(width: 14,),
                Image.asset("assets/icons/pin.png", height: 20,),
                SizedBox(width: 15,),
                Text(getString("language__city"),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w600
                  ),),

              ],
            ),
          ),
        ),
        if(isPortrait(context))Spacer()
        else SizedBox(height: 70,),

        RoundedCenterButtton(onPressed: (){
          if(isInitialScreen)
          Navigator.pushNamed(context, "login_screen");
          else Navigator.pop(context);
        }, title: getString("done")),
        SizedBox(height: getHeight(context)*0.15,)
      ],
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        toolbarHeight: 0,
      ),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Opacity(
              opacity: isPortrait(context) ? 1:0.2 ,
              child: Image.asset(
                'assets/images/language_screen_bg.png',
                // width: 130,
                width: getWidth(context),

                fit: BoxFit.fitWidth,
                // height: 140,
              ),
            ),
          ),
          SizedBox(
            width: getWidth(context),
            child: isPortrait(context) ?column: SingleChildScrollView(
              child: column,
            ) ,
          ),
        ],
      ),
    );
  }
  setLocale(loc) async {
    String currentLocale = context.locale.toString();
    print("MJ: localization: ${currentLocale}");
    if(currentLocale != loc["locale"])
      {

    await context.setLocale(Locale(loc["locale"]));
    showToast(getString('language__current_lang'));
      }
  }

}
