import 'package:flutter/material.dart';
import 'package:sale_management/screens/import/import.dart';
import 'package:sale_management/screens/size_config.dart';
import 'package:sale_management/screens/widgets/default_button/default_button.dart';
import 'package:sale_management/share/constant/text_style.dart';

class ImportSuccessBody extends StatelessWidget {
  final bool isAddScreen;
  final bool isEditScreen;
  final Map vData;
  ImportSuccessBody({Key key,this.isEditScreen, this.isAddScreen, this.vData}): super(key: key);

  final headingStyle = TextStyle(
      fontSize: getProportionateScreenWidth(28),
      fontWeight: FontWeight.bold,
      color: Colors.black,
      height: 1.5,
      fontFamily: fontFamilyDefault
  );

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop:  () async {
        return Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ImportScreen()),
        );
      },
      child: Column(
        children: <Widget>[
          SizedBox(height: SizeConfig.screenHeight * 0.07),
          Center(
            child: Image.asset(
              "assets/icons/success-green-check-mark.png",
              height: SizeConfig.screenHeight * 0.2, //40%
            ),
          ),
          SizedBox(height: SizeConfig.screenHeight * 0.07),
          Center(
            child: Column(
              children: <Widget>[
                SizedBox(height: SizeConfig.screenHeight * 0.04), // 4%
                if (this.isAddScreen == true)
                  Text("Register Import", style: headingStyle),
                if(this.isEditScreen == true)
                  Text("Update Import", style: headingStyle),

                Text("completed",textAlign: TextAlign.center,),
              ],
            ),
          ),
          SizedBox(height: SizeConfig.screenHeight * 0.02),
          Center(
            child: Text(
              "Success",
              style: TextStyle(
                fontSize: getProportionateScreenWidth(30),
                fontWeight: FontWeight.bold,
                color: Colors.green[800],
              ),
            ),
          ),
          Spacer(),
          SizedBox(
            width: SizeConfig.screenWidth * 0.7,
            child: DefaultButton(
              elevation: 3,
              text: "Back",
              color: Colors.green[800],
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ImportScreen()),
                );
              },
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
}
