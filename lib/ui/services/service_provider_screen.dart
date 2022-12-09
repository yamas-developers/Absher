import 'package:absher/helpers/public_methods.dart';
import 'package:flutter/material.dart';

import '../../helpers/constants.dart';

class ServiceProviderScreen extends StatefulWidget {
  const ServiceProviderScreen({Key? key}) : super(key: key);

  @override
  State<ServiceProviderScreen> createState() => _ServiceProviderScreenState();
}

class _ServiceProviderScreenState extends State<ServiceProviderScreen> {
  String image = "assets/images/placeholder_image.png";
  String service = "Other Service";
  @override
  void didChangeDependencies() {
    if(ModalRoute.of(context)!.settings.arguments == null) return;
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    if(args!=null){
      image = args["image"];
      service = args["service"];
      print("arguments: ${image}, ${service}");
    }
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: mainColor,
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 6,
            ),
            Container(
              padding: EdgeInsets.fromLTRB(6, 10, 18, 0),
              child: Flex(
                direction: Axis.horizontal,
                children: [
                  Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: (){
                            Navigator.pop(context);
                          },
                          child: Image.asset(
                            "assets/icons/back_arrow_icon.png",
                            width: 22,
                            height: 22,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 8,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                            child: Text(
                              "Service Provider",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: mainColor,
                                  fontWeight: FontWeight.w500),
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Hero(
                tag: ValueKey("${service}"),
                child: Image.asset("${image}", height: 200,fit: BoxFit.fill,width: getWidth(context),)),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Text("${service}", style: TextStyle(
                color: mainColor,
                fontSize: 20,
                fontWeight: FontWeight.w500
              ),),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 18, vertical: 18),
              margin: EdgeInsets.symmetric(horizontal: 18),

              decoration: BoxDecoration(
                color:mainColorLightest,
                borderRadius: BorderRadius.circular(15)
              ),
              child: Row(
                children: [
                  Image.asset("assets/icons/contact_person_icon.png", height: 42,),
                  SizedBox(width: 20,),
                  Expanded(
                    child: Text("Order Service",

                      style: TextStyle(
                      color: mainColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 16
                    ),),
                  ),
                  Image.asset("assets/icons/whatsapp_icon.png", height: 42,)
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Description", style: TextStyle(
                    color: mainColor,
                    fontSize: 16
                  ),),
                  SizedBox(
                    height: 10,
                  ),
                  Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do "
                      "eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad "
                      "minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip "
                      "ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate "
                      "velit esse cillum dolore eu fugiat nulla pariatur. "
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed "
                      "do eiusmod tempor incididunt ut labore et dolore magna aliqua. "
                      "Ut enim ad minim veniam, quis nostrud exerc", style: TextStyle(
                    color: Colors.black
                  ),),
                ],
              ),
            ),
            SizedBox(
              height: 35,
            ),
          ],
        ),
      ),
    );
  }
}
