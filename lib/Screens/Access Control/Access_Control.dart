import 'package:doorstep_guard/Screens/navigator/bottom_nav_bar.dart';
import 'package:doorstep_guard/components/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
import '../../constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AccessControl extends StatefulWidget {
  @override
  _AccessControlState createState() => _AccessControlState();
}

class _AccessControlState extends State<AccessControl> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _guestName = TextEditingController();
  final TextEditingController _guestCnic = TextEditingController();
  final TextEditingController _guestPhoneNo = TextEditingController();

  String _qrCodeResult="" ;
  bool _uidExist=null;
  bool isUserDataNull=false;
  String _name , _phoneNo , _cnic , _address;

  final controller = PageController(
    initialPage: 0,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40.0),
        child: AppBar(
          centerTitle: true,
          backgroundColor: kPrimaryColor,
        ),
      ),

      body:  Form(
        key: _formKey,

        child:  PageView
        // PERSONAL DETAILS AND ADDRESS DETAILS
          (
            controller: controller,
            children:
            [
              // scan screen
              SingleChildScrollView(
                child: Container(
                  alignment: Alignment.topCenter,
                  color: Colors.white,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 25,
                      ),
                      Text(
                        'Access Control',
                        style: TextStyle(
                          fontFamily: 'Montserrat Medium',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Image.asset(
                        'assets/images/accessControl.png',
                        width: 200,
                      ),
                      SizedBox(
                        height: 5,
                      ),

                      SizedBox(
                        height : 20 ,
                      ),



                      RoundedButton(
                          text: "Scan",
                          press:  () async {
                            String codeSanner = await BarcodeScanner
                                .scan(); //barcode scanner
                            setState(() {
                              _qrCodeResult = codeSanner;
                            });
                            idExist(_qrCodeResult);
                          }
                      ),

                      SizedBox(
                        height : 10 ,
                      ),

                      // First check if the user exist or not then do as the condition full fills
                      Container(
                        height: 250,
                        width: 300,
                        decoration: BoxDecoration(
                          border: Border.all(color: kPrimaryColor,width: 2),
                          borderRadius: BorderRadius.circular(20),
                          //color: Colors.grey.shade200,
                        ),
                        child: _uidExist == true ?
                        isUserDataNull == true ?
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Divider(
                              color: kPrimaryColor,
                              thickness: 4,
                              indent: 30,
                              endIndent: 30,
                              height: 30,
                            ),

                            Text ("Incomplete Account",style: TextStyle(
                              color: kPrimaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 28,
                            ), ),

                            Divider(
                              color: kPrimaryColor,
                              thickness: 4,
                              indent: 30,
                              endIndent: 30,
                              height: 30,
                            ),
                            Text ("Incomplete Account Can't Give Access",style: TextStyle(
                              color: kPrimaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ), ),


                          ],
                        ) :
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height:35,
                            ),
                            Divider(
                              color: kPrimaryColor,
                              thickness: 4,
                              indent: 30,
                              endIndent: 30,
                              height: 30,
                            ),

                            Text ("Access Granted",style: TextStyle(
                              color: kPrimaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 33,
                            ), ),
                            Divider(
                              color: kPrimaryColor,
                              thickness: 4,
                              indent: 30,
                              endIndent: 30,
                              height: 30,
                            ),
                            SizedBox(
                              height:35,
                            ),

                            GestureDetector(
                              onTap: (){
                                controller.animateTo(
                                    MediaQuery.of(context).size.width,
                                    duration: new Duration(milliseconds: 600),
                                    curve: Curves.easeIn);
                              },
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 60,
                                  ),
                                  Text("FIll Guest Form ",style: TextStyle(
                                    color: kPrimaryColor,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Icon(Icons.arrow_forward_sharp,color: kPrimaryColor,size: 30,)
                                ],
                              ),
                            )

                          ],
                        ) :
                        _uidExist == false ?
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Divider(
                              color: kPrimaryColor,
                              thickness: 4,
                              indent: 30,
                              endIndent: 30,
                              height: 30,
                            ),

                            Text ("No Access",style: TextStyle(
                              color: kPrimaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 35,
                            ), ),
                            Divider(
                              color: kPrimaryColor,
                              thickness: 4,
                              indent: 30,
                              endIndent: 30,
                              height: 30,
                            ),

                          ],
                        ) :
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Divider(
                              color: kPrimaryColor,
                              thickness: 4,
                              indent: 30,
                              endIndent: 30,
                              height: 30,
                            ),

                            Text ("Scan QR",style: TextStyle(
                              color: kPrimaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 35,
                            ), ),
                            Divider(
                              color: kPrimaryColor,
                              thickness: 4,
                              indent: 30,
                              endIndent: 30,
                              height: 30,
                            ),

                          ],
                        ),
                      ),


                    ],
                  ),
                ),
              ),

              //guest Form
              SingleChildScrollView(
                child: Container(
                   child: Padding(
                     padding: const EdgeInsets.all(2.0),
                     child: Column(
                       children: [

                         SizedBox(
                           height: 20,
                         ),

                         Text("Guest From",style: TextStyle(
                           fontWeight: FontWeight.bold,
                           color: Colors.black54,
                           fontSize: 24,
                         ),),

                         Divider(
                           indent: 100,
                           endIndent: 100,
                           color: Colors.black54,
                           height: 2,
                           thickness: 2,
                         ),
                         SizedBox(
                           height: 2,
                         ),
                         Divider(
                           indent: 100,
                           endIndent: 100,
                           color: Colors.black54,
                           height: 2,
                           thickness: 2,
                         ),

                         SizedBox(
                           height: 20,
                         ),

                         // resident detail
                         Container(
                           height: 320,
                           width: 300,
                           decoration: BoxDecoration(
                             border: Border.all(color: kPrimaryColor,width: 2),
                             borderRadius: BorderRadius.circular(20),
                             //color: Colors.grey.shade200,
                           ),
                           child: Column(
                              children: [
                                Divider(
                                  color: kPrimaryColor,
                                  thickness: 3,
                                  indent: 30,
                                  endIndent: 30,
                                  height: 30,
                                ),

                                Text ("Resident Detail",style: TextStyle(
                                  color: kPrimaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                ), ),

                                Divider(
                                  color: kPrimaryColor,
                                  thickness: 3,
                                  indent: 30,
                                  endIndent: 30,
                                  height: 30,
                                ),

                                SizedBox(
                                  height: 15,
                                ),

                                //name
                                Row(

                                  children: [
                                    SizedBox(
                                      width: 30,
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text("Name : ${_name}",style: TextStyle(
                                        fontSize: 18,
                                      ),),
                                    ),
                                  ],
                                ),

                                Divider(
                                  color: kPrimaryColor,
                                  thickness: 1,
                                  indent: 30,
                                  endIndent: 30,
                                  height: 20,
                                ),

                                // cnic
                                Row(

                                  children: [
                                    SizedBox(
                                      width: 30,
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text("Cnic : ${_cnic}",style: TextStyle(
                                        fontSize: 18,
                                      ),),
                                    ),
                                  ],
                                ),

                                Divider(
                                  color: kPrimaryColor,
                                  thickness: 1,
                                  indent: 30,
                                  endIndent: 30,
                                  height: 20,
                                ),

                                // phone no
                                Row(

                                  children: [
                                    SizedBox(
                                      width: 30,
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text("Phone No : ${_phoneNo}",style: TextStyle(
                                        fontSize: 18,
                                      ),),
                                    ),
                                  ],
                                ),

                                Divider(
                                  color: kPrimaryColor,
                                  thickness: 1,
                                  indent: 30,
                                  endIndent: 30,
                                  height: 20,
                                ),

                                Row(

                                  children: [
                                    SizedBox(
                                      width: 30,
                                    ),

                                    Expanded(child:  Text("Address : ${_address}",style: TextStyle(
                                      fontSize: 18,
                                    ),),)

                                  ],
                                ),

                                Divider(
                                  color: kPrimaryColor,
                                  thickness: 1,
                                  indent: 30,
                                  endIndent: 30,
                                  height: 20,
                                ),

                              ],
                            ),
                         ),


                         SizedBox(
                           height: 20,
                         ),

                         Text(" Fill Guest Form ",style: TextStyle(
                           fontSize: 20,
                           fontWeight: FontWeight.bold,
                           color: Colors.black54,
                         ),),
                         
                         SizedBox(
                           height: 10,
                         ),

                         // Guest Detail Form Field
                         Container(
                           height: 300,
                           width: 300,
                           decoration: BoxDecoration(
                             border: Border.all(color: kPrimaryColor,width: 2),
                             borderRadius: BorderRadius.circular(20),
                             //color: Colors.grey.shade200,
                           ),
                           child: Column(
                             children: [
                               Divider(
                                 color: kPrimaryColor,
                                 thickness: 3,
                                 indent: 30,
                                 endIndent: 30,
                                 height: 30,
                               ),

                               Text ("Guest Detail",style: TextStyle(
                                 color: kPrimaryColor,
                                 fontWeight: FontWeight.bold,
                                 fontSize: 22,
                               ), ),

                               Divider(
                                 color: kPrimaryColor,
                                 thickness: 3,
                                 indent: 30,
                                 endIndent: 30,
                                 height: 30,
                               ),

                               SizedBox(
                                 height: 15,
                               ),

                               //name
                               Container(
                                 child: Row(

                                   children: [
                                    SizedBox(
                                      width: 30,
                                    ),
                                     Expanded(
                                       flex: 3,
                                       child: Text("Name : ",style: TextStyle(
                                         fontSize: 18,
                                       ),),
                                     ),



                                     Expanded(
                                       flex: 7,
                                       child: TextFormField(
                                         controller: _guestName,
                                         validator: (value) {
                                           if (value.isEmpty) {
                                             return 'Field is Empty';
                                           }
                                           return null;
                                         },
                                         style: TextStyle(
                                           color: Colors.black45,
                                           fontSize: 18,
                                           fontFamily: "Montserrat Regular",
                                           fontWeight: FontWeight.bold,
                                         ),
                                         cursorColor: Colors.black54,
                                         decoration: InputDecoration (
                                           //hintText: "Enter Description",
                                           border: InputBorder.none,
                                           focusedBorder: InputBorder.none,
                                           enabledBorder: InputBorder.none,
                                           errorBorder: InputBorder.none,
                                           disabledBorder: InputBorder.none,
                                         ),
                                       ),
                                     )
                                   ],
                                 ),
                               ),

                               Divider(
                                 color: kPrimaryColor,
                                 thickness: 1,
                                 indent: 30,
                                 endIndent: 30,
                                 height: 0,
                               ),

                               SizedBox(
                                 height: 10,
                               ),

                               //cnic
                               Container(
                                 child: Row(

                                   children: [
                                     SizedBox(
                                       width: 30,
                                     ),
                                     Expanded(
                                       flex: 3,
                                       child: Text("Cnic : ",style: TextStyle(
                                         fontSize: 18,
                                       ),),
                                     ),



                                     Expanded(
                                       flex: 7,
                                       child: TextFormField(
                                         controller: _guestCnic,
                                         validator: (value) {
                                           if (value.isEmpty) {
                                             return 'Field is Empty';
                                           }
                                           return null;
                                         },
                                         style: TextStyle(
                                           color: Colors.black45,
                                           fontSize: 18,
                                           fontFamily: "Montserrat Regular",
                                           fontWeight: FontWeight.bold,
                                         ),
                                         cursorColor: Colors.black54,
                                         decoration: InputDecoration (
                                           //hintText: "Enter Description",
                                           border: InputBorder.none,
                                           focusedBorder: InputBorder.none,
                                           enabledBorder: InputBorder.none,
                                           errorBorder: InputBorder.none,
                                           disabledBorder: InputBorder.none,
                                         ),
                                       ),
                                     )
                                   ],
                                 ),
                               ),

                               Divider(
                                 color: kPrimaryColor,
                                 thickness: 1,
                                 indent: 30,
                                 endIndent: 30,
                                 height: 0,
                               ),

                               SizedBox(
                                 height: 10,
                               ),

                               //phone No
                               Container(
                                 child: Row(

                                   children: [
                                     SizedBox(
                                       width: 30,
                                     ),
                                     Expanded(
                                       flex: 3,
                                       child: Text("Phone : ",style: TextStyle(
                                         fontSize: 18,
                                       ),),
                                     ),

                                     Expanded(
                                       flex: 7,
                                       child: TextFormField(
                                         controller: _guestPhoneNo,
                                         validator: (value) {
                                           if (value.isEmpty) {
                                             return 'Field is Empty';
                                           }
                                           return null;
                                         },
                                         style: TextStyle(
                                           color: Colors.black45,
                                           fontSize: 18,
                                           fontFamily: "Montserrat Regular",
                                           fontWeight: FontWeight.bold,
                                         ),
                                         cursorColor: Colors.black54,
                                         decoration: InputDecoration (
                                           //hintText: "Enter Description",
                                           border: InputBorder.none,
                                           focusedBorder: InputBorder.none,
                                           enabledBorder: InputBorder.none,
                                           errorBorder: InputBorder.none,
                                           disabledBorder: InputBorder.none,
                                         ),
                                       ),
                                     )
                                   ],
                                 ),
                               ),

                               Divider(
                                 color: kPrimaryColor,
                                 thickness: 1,
                                 indent: 30,
                                 endIndent: 30,
                                 height: 0,
                               ),

                               SizedBox(
                                 height: 10,
                               ),



                             ],
                           ),
                         ),

                         SizedBox(
                           height: 20,
                         ),

                         RoundedButton(
                             text: "Submit",
                             press:  () async {
                               if (_formKey.currentState.validate()) {
                                 guestForm(_guestName.text, _guestCnic.text, _guestCnic.text);
                               }
                             }
                         ),

                       ],
                     ),
                   )

                ),
              ),

            ],
            physics: NeverScrollableScrollPhysics()
        ),

      ),

    );
  }

//checks if user exists or not and set state if it exist
Future idExist(String qrCode)async
{
  final snapShot = await FirebaseFirestore.instance.collection('User Details').doc(qrCode).get();
  if(snapShot == null || !snapShot.exists)
    {
      setState(() {
        _uidExist = false;
      });
    }
   else
  {
    setState(() {
      _uidExist = true;
    });

    FirebaseFirestore.instance.collection('User Details').doc(_qrCodeResult).get().then((value) {
      Map map=value.data();
      var data=map["Email "];
      if(data==""){
       setState(() {
         isUserDataNull = true;
       });
      }
      else{
       setState(() {
         isUserDataNull = false;
         _name = map['Full Name '];
         _phoneNo = map['Phone '];
         _cnic = map['Cnic '];
         _address = "House # ${map['House No ']} , Street # ${map['Street No ']}, Phase # ${map['Phase ']}";
         print("name ${_name} ");

       });
      }
    });

  }
}//id exist function

  Future <void> guestForm(String name , String cnic , String phone  )async {

    final CollectionReference incident =  FirebaseFirestore.instance.collection('Guest Access');

    final ProgressDialog pr = ProgressDialog(context);
    pr.style(
      message: 'Please Wait...',
      progressWidget: CircularProgressIndicator(
        valueColor: new AlwaysStoppedAnimation<Color>(Color(0xFF172953)),
      ),
      progress: 0,
      maxProgress: 100,
    );
    pr.show();

    try{
      await incident.doc().set({
        "guest name" : name,
        "guest cnic" : cnic,
        "guest phone" : phone,
        "Time" : DateTime.now().toString(),

      }).whenComplete(() => {
        pr.hide(),
        Navigator.pushReplacement(context, MaterialPageRoute(builder : (context)=> BottomBar()),),
      });
    }
    catch (e)
    {
      print(e);
    }

  }


}//final
