import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:recipebook/confiig/loading.dart';
import 'package:recipebook/confiig/size.dart';
import 'package:recipebook/confiig/theme.dart';
import 'package:recipebook/routes.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:sizer/sizer.dart';

Future<void> main() async {
  await LoadingConfig().set();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      child: Sizer(builder: (context, orientation, deviceType) {
        SizeConfig().set(context);
        return MaterialApp.router(
          title: 'RecipeBook',
          debugShowCheckedModeBanner: false,
          theme: theme(context),
          builder: EasyLoading.init(builder: (context, child) {
            SizeConfig().set(context);
            return ResponsiveWrapper.builder(
              ClampingScrollWrapper.builder(context, child!),
              maxWidth: MediaQuery.of(context).size.width,
              minWidth: 1000,
              defaultScale: true,
              breakpoints: [
                const ResponsiveBreakpoint.resize(600, name: MOBILE),
                const ResponsiveBreakpoint.autoScale(1000, name: TABLET),
                const ResponsiveBreakpoint.resize(1200, name: DESKTOP),
                const ResponsiveBreakpoint.autoScale(2460, name: "4K"),
              ],
              background: Container(
                color: const Color(
                  0xFFF5F5F5,
                ),
              ),
            );
          }),
          routerConfig: router,
        );
      }),
    );
  }
}
