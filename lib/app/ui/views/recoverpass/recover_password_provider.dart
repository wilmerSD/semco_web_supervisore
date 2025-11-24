import 'package:app_tasking/app/ui/views/login/login_view.dart';
import 'package:app_tasking/app/ui/views/recoverpass/widgets/recover_pass_code.dart';
import 'package:app_tasking/app/ui/views/recoverpass/widgets/recover_pass_reset.dart';
import 'package:flutter/material.dart';

class RecoverPasswordProvider with  ChangeNotifier {
  bool isVisibleIcon = false;
  bool isLoading = false;
  bool isVisible = false;

  TextEditingController ctrlPasswordText = TextEditingController();
  TextEditingController textCtrlCodeVerification = TextEditingController();
  TextEditingController textCtrlEmail = TextEditingController();
  TextEditingController textCtrlUser = TextEditingController();
  TextEditingController textCtrlPasswordToConfirm = TextEditingController();

  Future validateCode(BuildContext context) async{
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const RecoverPassReset()));
  }

  Future validateEmail(BuildContext context) async{
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const RecoverPassCode()));
  }
  Future validatePass(BuildContext context) async{
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginView()));
  }



}
