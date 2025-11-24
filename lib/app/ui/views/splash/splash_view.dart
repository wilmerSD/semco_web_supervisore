import 'package:animate_do/animate_do.dart';
import 'package:app_tasking/app/ui/views/splash/splash_provider.dart';
import 'package:app_tasking/core/routes/app_routes_name.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SplashProvider(),
      child: Builder(builder: (context) {
        Future.delayed(const Duration(seconds: 1), () {
          context.go(AppRoutesName.LOGIN);
        });
        return Scaffold(
          body: ZoomIn(
            duration: const Duration(milliseconds: 800),
            child: Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                image: AssetImage("assets/Fondo.png"),
                fit: BoxFit.fill,
              )),
              child: Center(
                child: ZoomIn(
                  child: /* Text(nameSystem, style:  AppTextStyle(context)
                    .bold32(color: AppColors.secondaryConst),), */
                  Container(
                    width: 350,
                    height: 250,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                            'assets/supervisore.png'), // Reemplaza con tu imagen
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                  ), 
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
