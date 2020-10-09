import 'package:flutter/material.dart';
import 'package:messenger/helpers/show_alert.dart';
import 'package:messenger/services/auth_service.dart';
import 'package:messenger/widgets/custom_input.dart';
import 'package:messenger/widgets/custom_labels.dart';
import 'package:messenger/widgets/custom_raised_buttom.dart';
import 'package:messenger/widgets/logo.dart';
import 'package:provider/provider.dart';

class InvitationPage extends StatelessWidget {
  const InvitationPage({Key key}) : super(key: key);

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
                  mainText: 'You have an account', 
                  buttonText: 'Sign in',
                  to: 'signin'
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
  final codeCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final authService = Provider.of<AuthService>( context );

    return Container(
      margin: EdgeInsets.only(top: 40),
      padding: EdgeInsets.symmetric( horizontal: 30 ),
       child: Column(
         children: <Widget>[
           CustomInput(
             icon: Icons.verified_user_rounded,
             placeholder: 'Invitation code',
             textController: codeCtrl,
           ),           
           CustomRaisedButtom(
             textButtom: 'Join us now!',
             color: Colors.blue,
             onPressed: authService.signing ? null : () async {

               FocusScope.of( context ).unfocus();
               final validate = await authService.validate(codeCtrl.text.trim().toUpperCase());

               if( validate['ok'] ){
                 // navegar a otra pagina enviando el uid de la invitacion
                Navigator.pushReplacementNamed(context, 'signup', arguments: { "invitation":  validate['invitation'] });
               }else{
                 // Mostrar alerta con el error del backend
                showAlert(context, 'Invitation error', validate['errors']);
               }

             },
          )
         ]
       ),
    );
  }
}
