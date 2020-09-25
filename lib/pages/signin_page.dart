import 'package:flutter/material.dart';
import 'package:messenger/widgets/custom_input.dart';
import 'package:messenger/widgets/custom_labels.dart';
import 'package:messenger/widgets/custom_raised_buttom.dart';
import 'package:messenger/widgets/logo.dart';

class SigninPage extends StatelessWidget {
  const SigninPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF2F2F2),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Logo(),
                _Form(),
                CustomLabels(
                  mainText: 'You have an invitation', 
                  buttonText: 'Create account',
                  to: 'signup'
                ),
                Text('Terms and conditions of use', style: TextStyle( fontWeight: FontWeight.w200 ))
              ],
            ),
          ),
        ),
      )
    );
  }
}



class _Form extends StatefulWidget {

  @override
  __FormState createState() => __FormState();
}

class __FormState extends State<_Form> {
  final emailCtrl = TextEditingController();
  final passCtrl  = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 40),
      padding: EdgeInsets.symmetric( horizontal: 30 ),
       child: Column(
         children: <Widget>[
           CustomInput(
             icon: Icons.mail_outline,
             placeholder: 'Email',
             keyboardType: TextInputType.emailAddress,
             textController: emailCtrl,
           ),
           CustomInput(
             icon: Icons.lock_outline,
             placeholder: 'Password',
             textController: passCtrl,
             isPassword: true,
           ),           
           CustomRaisedButtom(
             textButtom: 'Join us now!',
             color: Colors.blue,
             onPressed: (){
               print( emailCtrl.text );
               print( passCtrl.text );
             },
          )
         ]
       ),
    );
  }
}
