import 'package:flutter/material.dart';
import 'package:sale_management/screens/category/category_success_screen.dart';
import 'package:sale_management/screens/constants.dart';
import 'package:sale_management/screens/size_config.dart';
import 'package:sale_management/screens/widgets/custom_suffix_icon/custom_suffix_icon.dart';
import 'package:sale_management/share/helper/keyboard.dart';
import 'package:sale_management/share/model/key/category_key.dart';


class AddNewCategoryForm extends StatefulWidget {
  @override
  _AddNewCategoryFormState createState() => _AddNewCategoryFormState();
}

class _AddNewCategoryFormState extends State<AddNewCategoryForm> {

  final _formKey = GlobalKey<FormState>();
  String email;
  String password;
  bool remember = false;
  Size size;
  var isClickSave = false;

  var nameController = new TextEditingController();
  var remarkController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Form(
        key: _formKey,
      child: Column(
          children: <Widget>[
            _body(),
            GestureDetector(
              onTap: () {
                KeyboardUtil.hideKeyboard(context);
                save();
              },
              child: Container(
                height: 45,
                width: MediaQuery.of(context).size.width,
                color: Colors.redAccent,
                child: Center(child: Text('Save', style: TextStyle(fontWeight: FontWeight.w700, color: Colors.white, fontFamily: 'roboto', fontSize: 18))),
              ),
            )
          ]
      ),
    );
  }

  Widget _body() {
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
                    Text("Register Category", style: headingStyle),
                    Text(
                      "Complete your details",
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              SizedBox(height: SizeConfig.screenHeight * 0.04),
              _buildNameField(),
              SizedBox(height: SizeConfig.screenHeight * 0.02),
              _buildRemarkField(),
            ],
          ),
        ),
      ),
    );
  }

  TextFormField _buildNameField() {
    return TextFormField(
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      controller: nameController,
      onChanged: (value) => checkFormValid(),
      validator: (value) {
        if (value.isEmpty) {
          return "Invalid name.";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Name",
        hintText: "Enter category name",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSufFixIcon( svgPaddingLeft: 15,svgIcon: "assets/icons/help_outline_black_24dp.svg"),
      ),
    );
  }

  TextFormField _buildRemarkField() {
    return TextFormField(
      keyboardType: TextInputType.text,
      controller: remarkController,
      decoration: InputDecoration(
        labelText: "Remark",
        hintText: "Enter remark",
       floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSufFixIcon( svgPaddingLeft: 15,svgIcon: "assets/icons/border_color_black_24dp.svg"),
      ),
    );
  }

  void save() {
    this.isClickSave = true;
    if( _formKey.currentState.validate()) {
      print('validate');
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CategorySuccessScreen(
          isAddScreen: true,
          vData: {
            CategoryKey.name: nameController.text,
            CategoryKey.remark: remarkController.text
          },
        )),
      );
    }
  }

  void checkFormValid() {
    if(isClickSave) {
      _formKey.currentState.validate();
    }
  }
}
