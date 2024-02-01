import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fulusi/colors/colors.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import '../globalWidgets.dart';
import '../logins/login_screens/register/register.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final TextEditingController _fieldOne = TextEditingController();
final TextEditingController _fieldTwo = TextEditingController();
final TextEditingController _fieldThree = TextEditingController();
final TextEditingController _fieldFour = TextEditingController();

class Referral extends StatefulWidget {

  const Referral({Key? key}) : super(key: key);

  @override
  State<Referral> createState() => _ReferralState();
}

class _ReferralState extends State<Referral> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
        backgroundColor: white,
        body: Padding(
          padding: const EdgeInsets.only(left: 20,right: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Image(
                  width: 400,
                  height: 400,
                  image: Svg('assets/images/account_Info/Code/undraw_referral_re_0aji.svg'),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextWidget('Referral Code',
                  FontWeight.w700,
                  mainBlue,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextWidget('Please provide your referral code to ensure proper credit and benefits.',
                  FontWeight.w400,
                  grey,
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    OtpInput(_fieldOne,1),
                    OtpInput(_fieldTwo,2),
                    OtpInput(_fieldThree,3),
                    OtpInput(_fieldFour,4),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: ElavatedButton('Continue' , white, mainOrange,(){
                    checkReferral('123');
                    Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Verify()),
                  );}),
                ),
              ],
            ),
          ),
        )
    ));
  }
}



class OtpInput extends StatelessWidget {
  int otpNumber;
  final  TextEditingController controller;
  OtpInput(this.controller , this.otpNumber);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width :40,
      child: TextField(
        style: const TextStyle(
            color: black
        ),
        autofocus: false,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        controller: controller,
        maxLength: 1,
        cursorColor: seedBlue,
        decoration:const InputDecoration(
            hintText: 'x',
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))
            ),
            enabledBorder: OutlineInputBorder(
              borderSide:  BorderSide(
                  color: mainOrange, width: 2.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide:  BorderSide(
                  color: grey, width: 2.0),
            ),
            hintStyle: TextStyle(
                color: grey,fontSize: 20)),
        onChanged: (value){
          if(value.length==1){
            FocusScope.of(context).nextFocus();
            if(otpNumber==1){
              checkTextFieldStatus();
            }
          }
        },
        onEditingComplete: (){
        },
      ),
    );
  }
}

bool textFieldStatus =false;
void checkTextFieldStatus()async{
  while(textFieldStatus ==false){
    await Future.delayed(const Duration(seconds:5));
   textFieldStatusComplete();
   if (textFieldStatus){
    String code=textFieldStatusComplete();
     print(code);
     checkReferral(code);
   }

  }

}


String textFieldStatusComplete() {
  bool all = _fieldOne.text.isNotEmpty &&
      _fieldTwo.text.isNotEmpty &&
      _fieldThree.text.isNotEmpty &&
      _fieldFour.text.isNotEmpty;
  String code ='';
  if (all) {
    textFieldStatus = true;
   code = (_fieldOne.text +
        _fieldTwo.text +
        _fieldThree.text +
        _fieldFour.text);
  }
  return code;
}




  checkReferral (String code)async{
  try{
    CollectionReference collection=FirebaseFirestore.instance.collection('referralCode');
    QuerySnapshot snapshot=await collection.where('code', isEqualTo: code).get();
    if (snapshot.docs.isNotEmpty){
      print(code);
    }
   else{
      print ('sucker');
    }
  }
  catch(e){
    print(e);
  }

  }