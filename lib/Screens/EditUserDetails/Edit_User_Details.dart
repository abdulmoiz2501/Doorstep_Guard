import 'package:doorstep_guard/Services/Firestore_PersonalDetails.dart';
import 'package:doorstep_guard/Screens/navigator/bottom_nav_bar.dart';
import 'package:doorstep_guard/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';

class EditUserDetails extends StatefulWidget {
  String emailID,fullName,cnic,phone,phase,street,houseNo,postalCode;

  EditUserDetails(this.emailID,this.fullName,this.cnic,this.phone,this.phase,this.street,this.houseNo,this.postalCode);

  @override
  _EditUserDetailsState createState() => _EditUserDetailsState();
}

class _EditUserDetailsState extends State<EditUserDetails> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final controller = PageController(
    initialPage: 0,
  );

  final TextEditingController _email = TextEditingController();
  final TextEditingController _fullName = TextEditingController();
  final TextEditingController _cnic = TextEditingController();
  final TextEditingController _phoneNo = TextEditingController();
  final TextEditingController _phase = TextEditingController();
  final TextEditingController _street = TextEditingController();
  final TextEditingController _houseNo = TextEditingController();
  final TextEditingController _postalCode = TextEditingController();

  @override
  void initState() {
    super.initState();
    setState(() {
      _email.text=widget.emailID;
      _fullName.text=widget.fullName;
      _cnic.text=widget.cnic;
      _phoneNo.text=widget.phone;
      _phase.text=widget.phase;
      _street.text=widget.street;
      _houseNo.text=widget.houseNo;
      _postalCode.text=widget.postalCode;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40.0),
        child: AppBar(
          backgroundColor: Color(0xFF172953),
        ),
      ),
      body: Form(
        key: _formKey,
        child:  PageView
        // PERSONAL DETAILS AND ADDRESS DETAILS
          (
            controller: controller,
            children:
            [
              // personal details
              SingleChildScrollView(
                child: new Container(
                  alignment: Alignment.topCenter,
                  color: Colors.white,
                  child: new Column(
                    children: [
                      SizedBox(
                        height:size.height*0.025,
                      ),
                      Text(
                        'Personal Details',
                        style: TextStyle(
                          fontFamily: 'Montserrat Medium',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height:size.height*0.015,
                      ),
                      Image.asset(
                        'assets/images/personal_Info.png',
                        width: size.height*0.33,
                      ),
                      SizedBox(
                        height: size.height*0.03,
                      ),

                      /*
                    1: text is wrapped in align
                    2: a sized box is used
                    3: a text field is wrapped in container
                    4: enabled border and focus border is used
                      */

                      // Full Name
                      customTextField("Full Name", _fullName, size ),
                      // CNIC
                      customTextField("Cnic", _cnic, size),
                      // PHONE
                      customTextField("Phone", _phoneNo, size),
                      // EMAIL
                      customTextField("Email", _email, size,readOnly: true),

                      SizedBox(
                        height: size.height*0.01,
                      ),

                      // SUBMIT BUTTON
                      SizedBox(
                        height: size.height*0.08,
                        width: size.width*0.6,
                        child: RaisedButton(
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              controller.animateTo(
                                  MediaQuery.of(context).size.width,
                                  duration: new Duration(milliseconds: 600),
                                  curve: Curves.easeIn);
                            }
                          },
                          color: Color(0xFF172953),
                          child: Text(
                            'Next',
                            style: TextStyle(
                              fontFamily: 'Montserrat Medium',
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                              side: BorderSide(color: Colors.black)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // address details
              SingleChildScrollView(
                child: new Container(
                  alignment: Alignment.topCenter,
                  color: Colors.white,
                  child: new Column(
                    children: [
                      SizedBox(
                        height:size.height*0.025,
                      ),
                      Text(
                        'Address Details',
                        style: TextStyle(
                          fontFamily: 'Montserrat Medium',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height:size.height*0.015,
                      ),
                      Image.asset(
                        'assets/images/address_info.png',
                        width: size.height*0.20,
                      ),
                      SizedBox(
                        height: size.height*0.03,
                      ),

                      /*
                    1: text is wrapped in align
                    2: a sized box is used
                    3: a text field is wrapped in container
                    4: enabled border and focus border is used
                      */

                      // Full Name
                      customTextField("Phase", _phase, size ),
                      // CNIC
                      customTextField("Street", _street, size),
                      // PHONE
                      customTextField("House no", _houseNo, size),
                      // EMAIL
                      customTextField("Postal Code", _postalCode, size,),

                      SizedBox(
                        height: size.height*0.01,
                      ),

                      // Buttons BACK and SUBMIT
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            height: size.height*0.08,
                            width: size.width*0.4,
                            child: RaisedButton(
                              onPressed: () {
                                controller.previousPage(
                                    duration: Duration(milliseconds: 600),
                                    curve: Curves.easeIn);
                              },
                              color: Color(0xFF172953),
                              child: Text(
                                'Back',
                                style: TextStyle(
                                  fontFamily: 'Montserrat Medium',
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                              ),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  side: BorderSide(color: Colors.black)),
                            ),
                          ),
                          SizedBox(
                            height: size.height*0.08,
                            width: size.width*0.4,
                            child: RaisedButton(
                              onPressed: () {
                                if (_formKey.currentState.validate()) {
                                  inputData();
                                 
                                }
                              },
                              color: Color(0xFF172953),
                              child: Text(
                                'Submit',
                                style: TextStyle(
                                  fontFamily: 'Montserrat Medium',
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                              ),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  side: BorderSide(color: Colors.black)),
                              
                             
                            ),
                          ),
                        ],
                      )

                    ],
                  ),
                ),
              ),

            ],
            physics: NeverScrollableScrollPhysics()
        ),

      ),
    );
  }

  Widget customTextField(String title ,var controller , Size size,{bool readOnly = false} )
  {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            '         $title',
            style: TextStyle(
              fontFamily: 'Montserrat Medium',
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: Colors.grey.shade600,
            ),
          ),
        ),
        SizedBox(
          height: size.height*0.005,
        ),
        new Container(
          height: size.height*0.07,
          width: size.width*0.85,
          child: TextFormField(
            readOnly: readOnly,
            validator: (value) {
              if (value.isEmpty) {
                return 'Field is Empty';
              }
              return null;
            },
            controller: controller,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(0),
                borderSide: BorderSide(
                  color: Colors.grey,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(0),
                borderSide: BorderSide(
                  color: kPrimaryColor,
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: size.height*0.02,
        ),
      ],
    );
  }

  final FirebaseAuth auth = FirebaseAuth.instance;

  void inputData() async {

    final ProgressDialog pr = ProgressDialog(context);
    pr.style(
      message: 'Please Wait...',
      progressWidget: CircularProgressIndicator(
        valueColor: new AlwaysStoppedAnimation<Color>(Color(0xFF172953)),
      ),
    );
    pr.show();
    
    // getting current user id
    final User user = auth.currentUser;
    final uid = user.uid;

    // updating data entered by user
    await DataBaseService(uid: user.uid).editProduct(_fullName.text, _cnic.text, _phoneNo.text,
        _email.text, _phase.text , _street.text, _houseNo.text , _postalCode.text).whenComplete(() =>pr.hide());

    if (user != null)
    {
      Navigator.pushReplacement(context, MaterialPageRoute(builder : (context)=> BottomBar(),),);
    }
  }
}
