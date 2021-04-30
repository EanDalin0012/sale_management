import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sale_management/screens/constants.dart';
import 'package:sale_management/screens/size_config.dart';
import 'package:sale_management/screens/vendor/widget/edit_vendor_form.dart';
import 'package:sale_management/share/constant/text_style.dart';
import 'package:sale_management/share/helper/keyboard.dart';

class EditVendorScreen extends StatefulWidget {

  final Map vendor;
  EditVendorScreen({this.vendor});

  @override
  _AddMemberScreenState createState() => _AddMemberScreenState();
}

class _AddMemberScreenState extends State<EditVendorScreen> {
  Size size;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purple[900],
          foregroundColor: Colors.purple[900],
          title: Text("Vendor"),
        ),
        body: SafeArea(
          child: Column(
              children: <Widget>[
                _body(),
                Stack(
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        KeyboardUtil.hideKeyboard(context);
                      },
                      child: Container(
                        width: size.width,
                        height: 45,
                        color: Colors.red,
                        // margin: EdgeInsets.only(
                        //   left: 5,
                        //   right: 5
                        // ),
                        child: Center(child: Text('Update', style: TextStyle(fontWeight: FontWeight.w700, color: Colors.white, fontFamily: fontFamilyDefault, fontSize: 18))),
                      ),
                    ),
                  ],
                )
              ]
          ),
        )
    );
  }

  Expanded _body() {
    return Expanded(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SingleChildScrollView(
              physics: ClampingScrollPhysics(),
              child: Column(
                  children: <Widget>[
                    Center(
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: SizeConfig.screenHeight * 0.04), // 4%
                          Text("Update Vendor", style: headingStyle),
                          Text(
                            "Complete your details",
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: SizeConfig.screenHeight * 0.02),
                    EditVendorForm(vendor: widget.vendor),
                  ])
          ),
        )
    );
  }
}