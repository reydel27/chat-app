import 'package:flutter/material.dart';
import 'package:messenger/helpers/show_alert.dart';
import 'package:messenger/widgets/custom_input.dart';
import 'package:messenger/widgets/custom_labels.dart';
import 'package:messenger/widgets/custom_raised_buttom.dart';
import 'package:messenger/widgets/logo.dart';

import 'package:messenger/services/auth_service.dart';
import 'package:provider/provider.dart';


class SignupPage extends StatelessWidget {
  const SignupPage({Key key}) : super(key: key);


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
                  mainText: 'You have an account?', 
                  buttonText: 'Sign in',
                  to: 'signin'
                ),
                Text('Terms and conditions of use', style: TextStyle( fontWeight: FontWeight.w200 ))
              ],
            )
          ),
        )
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
  final passCtrl = TextEditingController();
  final usernameCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>( context );
    final Map arguments = ModalRoute.of(context).settings.arguments as Map;  
    
    return Container(
      margin: EdgeInsets.only(top: 40),
      padding: EdgeInsets.symmetric( horizontal: 30 ),
       child: Column(
         children: <Widget>[
           CustomInput(
             icon: Icons.security_rounded,
             placeholder: 'Username', 
             textController: usernameCtrl
          ),           
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
             onPressed: authService.signing ? null : () async {

               FocusScope.of( context ).unfocus();
               final signup = await authService.signup(usernameCtrl.text.trim(), emailCtrl.text.trim(), passCtrl.text.trim(), arguments['invitation']);

               if( signup ){
                 // conectar con socket server

                 // navegar a otra pagina
                Navigator.pushReplacementNamed(context, 'users');
               }else{
                 // Mostrar alerta
                  showAlert(context, 'Authentication error', 'Sign in credentials fails');
               }
             },
          )
         ]
       ),
    );
  }
}