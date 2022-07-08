import 'package:doorstep_guard/Screens/Access%20Control/Access_Control.dart';
import 'package:doorstep_guard/Screens/Access%20Log/Access_Log.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.topCenter,
      child: new Column(
        children: [
          SizedBox(
            height: size.height*0.04,
          ), //15

          Image.asset(
            'assets/images/mainMenu.png',
            width: size.height*0.4,
          ), // 150 , 240

          /*
              1: In each column  rows are added
              2: In each row two expanded Containers are added which divide the rows in two parts
              3: Now each Expanded Container "Stack" widget is used ,
              4: Black bordered Container , an image and text is stacked in each Expanded container.
              5: to Align the Black bordered Container first "Positioned.filled(centerLeft/right)" and then "padding" is used
              * */

          SizedBox(
            height: size.height*0.04,
          ),
          // ROW # 1 ( ACCESS CONTROL & RESERVATIONS )
          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: new GestureDetector(
                  child: new Container(
                    height: size.height*0.4,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.white,
                    child: new Stack(
                      children: [
                        Positioned.fill(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: const EdgeInsets.all(9.0),
                              child: new Container(
                                height: size.height*0.4,
                                width: size.width*0.4,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.shade400,
                                      blurRadius: 13,
                                      offset: Offset(0, 5),
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(9),
                                  color: Colors.white,
                                  border: Border.all(color: Colors.grey),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          right: size.height*-0.06,
                          bottom: size.width*-0.05,
                          child: Image.asset(
                            'assets/images/Scan.png',
                            height: size.height*0.28,
                          ),
                        ),
                        Positioned(
                          top: size.height*0.05,
                          right: size.width*0.08,
                          child: new Text(
                            'Access Control',
                            style: TextStyle(
                              fontFamily: 'Montserrat Medium',
                              fontWeight: FontWeight.w900,
                              fontSize: 17,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  onTap: () => {
                    Navigator.push(context,MaterialPageRoute(builder: (context) => AccessControl(),
                      ),
                    ),
                  },
                ),
              ),
              Expanded(
                child: new GestureDetector(
                  child: new Container(
                    height: size.height*0.4,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.white,
                    child: new Stack(
                      children: [
                        Positioned.fill(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.all(9.0),
                              child: new Container(
                                height: size.height*0.4,
                                width: size.width*0.4,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(9),
                                  color: Colors.white,
                                  border: Border.all(color: Colors.grey),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.shade400,
                                      blurRadius: 13,
                                      offset: Offset(0, 5),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          right: size.height*-0.05,
                          bottom: size.width*-0.05,
                          child: Image.asset(
                            'assets/images/accessLog.png',
                            fit: BoxFit.cover,
                          ),
                          width: size.height*0.42,
                        ),
                        Positioned(
                          top: size.height*0.05,
                          left: size.width*0.12,
                          child: new Text(
                            'Access Logs',
                            style: TextStyle(
                              fontFamily: 'Montserrat Medium',
                              fontWeight: FontWeight.w700,
                              fontSize: 17,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  onTap: () => {
                  Navigator.push(context,MaterialPageRoute(builder: (context) => AccessLog(),),)
                  },
                ),
              ),
            ],
          ),

        ],
      ),
    );
  }
}
