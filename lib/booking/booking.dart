import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:random_string/random_string.dart';
import '../services/database.dart';

class booking extends StatefulWidget {
  const booking({super.key});
  @override
  State<booking> createState() => _bookingState();
}

class _bookingState extends State<booking> {
  TextEditingController fulnamecontroller= new TextEditingController();
  TextEditingController hallcontroller= new TextEditingController();
  TextEditingController datecontroller= new TextEditingController();
  TextEditingController timecontroller= new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
       appBar: AppBar(
      title: const Text(
          'Reserve Lecture Halls',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF003580),
        iconTheme: const IconThemeData(color: Colors.white),
    ),
      body: Container(
        margin: EdgeInsets.only(left:20.0,top:10.0,right: 20.0),
        child: SingleChildScrollView(
          child: Column        
            (crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              SizedBox(height: 30.0,), 
              Text( "Lecturer Name",
              style:TextStyle(color:Colors.black,fontSize: 20.0,fontWeight: FontWeight.bold),),              
              Container( 
                padding: EdgeInsets.only(left: 10.0),
                decoration:BoxDecoration(border:Border.all(),borderRadius:BorderRadius.circular( 10) ),
                child:TextField(
                  controller:fulnamecontroller,
                  decoration: InputDecoration(border: InputBorder.none),
                ),
              ),   
              SizedBox(height: 20.0,),            
              Text( "Lecture Hall",
              style:TextStyle(color:Colors.black,fontSize: 20.0,fontWeight: FontWeight.bold),), 
              Container( 
                padding: EdgeInsets.only(left: 10.0),
                decoration:BoxDecoration(border:Border.all(),borderRadius:BorderRadius.circular( 10) ),
                child:TextField(
                  controller:hallcontroller,
                  decoration: InputDecoration(border: InputBorder.none),
                ),
              ),         
              SizedBox(height: 20.0,), 
              Text( "Lecture Date",
              style:TextStyle(color:Colors.black,fontSize: 20.0,fontWeight: FontWeight.bold),), 
              Container( 
                padding: EdgeInsets.only(left: 8.0),
                decoration:BoxDecoration(border:Border.all(),borderRadius:BorderRadius.circular( 10) ),
                child:TextField(
                  controller:datecontroller,
                  decoration: InputDecoration(border: InputBorder.none),
                ),
              ),            
              SizedBox(height: 20.0,),  
              Text( "Lecture Time",
              style:TextStyle(color:Colors.black,fontSize: 20.0,fontWeight: FontWeight.bold),), 
              Container( 
                padding: EdgeInsets.only(left: 10.0),
                decoration:BoxDecoration(border:Border.all(),borderRadius:BorderRadius.circular( 10) ),
                child:TextField(
                  controller:timecontroller,
                  decoration: InputDecoration(border: InputBorder.none),
                ),
              ),       
              SizedBox(height: 30.0,),   
                Center(
                  child: ElevatedButton(onPressed:() async{
                      String Id=randomAlphaNumeric(10);
                      Map<String,dynamic>bookinhInfoMap={
                        "Full Name":fulnamecontroller.text,
                        "Hall":hallcontroller.text,
                        "Date":datecontroller.text,
                        "Id":Id,
                        "Time":timecontroller.text,
                      };          
                      await DatbaseMethods().addBookingDeatails(bookinhInfoMap, Id).then((value) =>
                        Fluttertoast.showToast(
                          msg: "Lecture Hall has been reserved successfully",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0,
                        )
                      );
                      Navigator.pop(context);

                  },
                  child:Text(
                    "Add Reservation",style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                  ),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: const Color(0xFFfeba02),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: BorderSide(color: Colors.black),
                    ),          
                  ),
                  ),
              ),
            ],                 
          ),
        )
      ),
    );
  }
}
