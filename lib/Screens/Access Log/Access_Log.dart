import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import '../../constants.dart';

class AccessLog extends StatefulWidget {
  @override
  _AccessLogState createState() => _AccessLogState();
}

class _AccessLogState extends State<AccessLog> {
  final f = new DateFormat('dd-MM-yyyy hh:mm a');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40.0),
        child: AppBar(
          backgroundColor:  Color(0xFF172953),
        ),
      ),
      body: new Container(
        alignment: Alignment.topCenter,
        color: Colors.white,
        child: new Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Text(
              'Access Log',
              style: TextStyle(
                fontFamily: 'Montserrat Medium',
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Image.asset(
              'assets/images/accessLogMain.png',
              width: 200,
            ),
            SizedBox(
              height: 25,
            ),
            Expanded(
                child:FutureBuilder<QuerySnapshot>(
                    future: FirebaseFirestore.instance.collection('Guest Access').get(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final List<DocumentSnapshot> documents = snapshot.data.docs;
                        if(snapshot.data!=null){
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child:ListView(
                                children: documents.map((doc) => Card(
                                  child:Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.white,
                                      border: Border.all(color: Color(0xFF172953)),
                                    ),

                                    child:  Container(
                                      height: 300,
                                      width: 250,
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
                                          Row(

                                            children: [
                                              SizedBox(
                                                width: 30,
                                              ),
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text("Name : ${doc['guest name']}",style: TextStyle(
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
                                                child: Text("Cnic : ${doc['guest cnic']}",style: TextStyle(
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
                                                child: Text("Phone : ${doc['guest phone']}",style: TextStyle(
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
                                              Expanded(
                                               child: Text("DateTime : ${f.format(DateTime.parse(doc['Time'])).toString()}",style: TextStyle(
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

                                        ],
                                      ),
                                    ),
                                  ),)).toList()) ,
                          );
                        }
                        else {
                          return Text('no data');
                        }
                      }
                      else if (snapshot.hasError) {
                        return Text(snapshot.error.toString());
                      }
                      else{
                        return Center(child:  CircularProgressIndicator(
                          valueColor: new AlwaysStoppedAnimation<Color>(Color(0xFF172953)),
                        ),);
                      }
                    })
            )
          ],
        ),
      ),
    );
  }
}
