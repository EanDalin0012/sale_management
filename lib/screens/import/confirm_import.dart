import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sale_management/screens/constants.dart';
import 'package:sale_management/screens/size_config.dart';
import 'package:sale_management/screens/widgets/custom_suffix_icon/custom_suffix_icon.dart';
import 'package:sale_management/share/constant/text_style.dart';
import 'package:sale_management/share/model/key/m_key.dart';
import 'package:sale_management/share/utils/number_format.dart';

class ConfirmSale extends StatefulWidget {
  final List<dynamic> vData;
  ConfirmSale({
    @required this.vData
  });
  @override
  _SaleAddConfirmState createState() => _SaleAddConfirmState();
}

class _SaleAddConfirmState extends State<ConfirmSale> {
  var colorValue = Colors.deepPurple;
  Size size;
  var styleInput = TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.w500, fontFamily: fontFamilyDefault);
  var remarkValueController = new TextEditingController();
  var nameValueController = new TextEditingController();
  var i = 0;
  double pay = 0.0;
  double vPay = 0.0;
  Map vCustomer;
  String email;

  @override
  void initState() {
    super.initState();
    vPayFunction();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    this.i = 0;
    return Scaffold(
        appBar: _buildAppBar(),
        body: Container(
          height: size.height,
          child: Column(
            children: <Widget>[
              Center(
                child: Column(
                  children: <Widget>[
                    SizedBox(height: SizeConfig.screenHeight * 0.04), // 4%
                    Text("Import Items", style: headingStyle),
                    Text(
                      "Complete your details. \n Please check your items ready then click confirm.",
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
                child: Column(
                    children: <Widget>[
                      SizedBox(height: SizeConfig.screenHeight * 0.04),
                      _buildRemarkField(),
                      SizedBox(height: SizeConfig.screenHeight * 0.02),
                    ]
                ),
              ),
              Divider(
                color: Colors.purple[900].withOpacity(0.5),
              ),
              _body(),
              _buildConfirmButton ()
            ],
          ),
        )
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text('Conform', style: TextStyle(fontFamily: fontFamilyDefault, fontWeight: FontWeight.w700)),
      leading: InkWell(
        onTap: () {
          Navigator.pop(context, widget.vData);
        },
        child: Icon(
            Icons.arrow_back
        ),
      ),
      backgroundColor: Colors.purple[900],
    );
  }

  Widget _buildConfirmButton () {
    setState(() {
      pay = vPay;
    });
    return Stack(
      children: <Widget>[
        InkWell(
          onTap: () {

          },
          child: Container(
            width: size.width,
            height: 45,
            color: Colors.red,
            child: Center(child: Text('Confirm', style: TextStyle(fontWeight: FontWeight.w700, color: Colors.white, fontFamily: 'roboto', fontSize: 18))),
          ),
        ),
      ],
    );
  }

  Widget _container() {
    return  Container(
      color: Color(0xFF939BA9).withOpacity(0.5),
      height: 40,
      padding: EdgeInsets.only(
          left: 10,
          top: 10,
          right: 20,
          bottom: 10
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
              'Sale Conform',
              style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500, fontFamily: fontFamilyDefault)
          ),
          Text(FormatNumber.usdFormat2Digit(pay.toString()) + ' USD', style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w700, fontFamily: fontFamilyDefault),)
        ],
      ),
    );
  }

  Widget buildListView() {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          color: Colors.white,
        ),
        child: Column(

        )
    );
  }

  Widget _buildDataTable() {
    return DataTable(
        columns: <DataColumn>[
          DataColumn(
            label: Text('No'),
          ),
          DataColumn(
            label: Text('Product'),
          ),
          DataColumn(
            label: Text('Package'),
          ),
          DataColumn(
            label: Text('Quantity'),
          ),
          DataColumn(
            label: Text('Total'),
          ),
          DataColumn(
            label: Text('Action'),
          ),
        ],
        rows: widget.vData.map((e) {
          i += 1;
          return DataRow(
              cells: <DataCell>[
                DataCell(Text(i.toString())),
                DataCell(
                    Row(
                        children: <Widget>[
                          _buildLeading(e[SaleAddItemKey.productUrl].toString()),
                          SizedBox(width: 10),
                          Text(e[SaleAddItemKey.productName].toString())
                        ]
                    )
                ),
                DataCell(Text(e[SaleAddItemKey.packageProductName].toString())),
                DataCell(Text(e[SaleAddItemKey.quantity].toString())),
                DataCell(Text(e[SaleAddItemKey.total].toString() + ' \$')),
                DataCell(_buildRemoveButton(e))
              ]
          );
        }).toList()
    );
  }

  Widget _buildLeading(String url) {
    return Container(
      width: 35,
      height: 35,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(60)),
        border: Border.all(color: Colors.grey, width: 2),
      ),
      child: CircleAvatar(
        radius: 30.0,
        backgroundImage:NetworkImage(url),
        backgroundColor: Colors.transparent,
      ),
    );
  }

  Widget _buildRemoveButton(Map<dynamic, dynamic> item) {
    return  Container(
      height: 35,
      width: 120,
      child: RaisedButton.icon(
          color: Colors.red,
          elevation: 4.0,
          onPressed: () {
            setState(() {
              widget.vData.remove(item);
              pay = pay - double.parse(item[SaleAddItemKey.total]);
              print('${item[SaleAddItemKey.total]}');
            });
          },
          icon: FaIcon(FontAwesomeIcons.minusCircle,size: 20 , color: Colors.white,),
          label: Text('Remove',style: TextStyle(fontFamily: fontFamilyDefault, fontWeight: FontWeight.w700, fontSize: 15, color: Colors.white))
      ),
    );
  }

  Expanded _body() {
    return Expanded(
        child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Column(
                        children: <Widget>[
                          _buildDataTable(),
                        ],
                      ),
                    ),
                  ),
                ])
        )
    );
  }

  TextFormField _buildCustomerField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => email = newValue,
      onChanged: (value) {
        // if (value.isNotEmpty) {
        //   removeError(error: kEmailNullError);
        // } else if (emailValidatorRegExp.hasMatch(value)) {
        //   removeError(error: kInvalidEmailError);
        // }
        // return null;
      },
      validator: (value) {
        // if (value.isEmpty) {
        //   addError(error: kEmailNullError);
        //   return "";
        // } else if (!emailValidatorRegExp.hasMatch(value)) {
        //   addError(error: kInvalidEmailError);
        //   return "";
        // }
        // return null;
      },
      decoration: InputDecoration(
        labelText: "Member",
        hintText: "Select member",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSufFixIcon( svgPaddingLeft: 15,svgIcon: "assets/icons/expand_more_black_24dp.svg"),
      ),
    );
  }

  TextFormField _buildRemarkField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => email = newValue,
      onChanged: (value) {
        // if (value.isNotEmpty) {
        //   removeError(error: kEmailNullError);
        // } else if (emailValidatorRegExp.hasMatch(value)) {
        //   removeError(error: kInvalidEmailError);
        // }
        // return null;
      },
      validator: (value) {
        // if (value.isEmpty) {
        // }
        // return null;
      },
      decoration: InputDecoration(
        labelText: "Remark",
        hintText: "Enter remark",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSufFixIcon( svgPaddingLeft: 15,svgIcon: "assets/icons/border_color_black_24dp.svg"),
      ),
    );
  }

  Widget _buildChip({String label, Color color}) {
    return Chip(
      labelPadding: EdgeInsets.all(2.0),
      avatar: CircleAvatar(
        // backgroundColor: Colors.white70,
        child: CustomSufFixIcon(svgIcon: "assets/icons/help_outline_black_24dp.svg"),
      ),
      label: Text(
        label,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      backgroundColor: color,
      elevation: 6.0,
      shadowColor: Colors.grey[60],
      padding: EdgeInsets.all(8.0),
    );
  }


  vPayFunction() {
    widget.vData.map((e)
    {
      double d = double.parse(e[SaleAddItemKey.total]);
      vPay += d;
    }).toList();
    setState(() {
      pay = vPay;
    });
  }

}