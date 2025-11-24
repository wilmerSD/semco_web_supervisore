import 'package:app_tasking/app/ui/views/recoverpass/recover_password_provider.dart';
import 'package:app_tasking/app/ui/views/recoverpass/widgets/recover_pass_email.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecoverPasswordView extends StatelessWidget {
  const RecoverPasswordView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final recoverpassProvider = Provider.of<RecoverPasswordProvider>(context);
    return RecoverPasswordEmail();
  }
}
