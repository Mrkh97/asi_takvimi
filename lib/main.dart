import 'package:asi_takvimi/color_schemes.g.dart';
import 'package:asi_takvimi/constants/app_colors.dart';
import 'package:asi_takvimi/views/Hastalar/hastalar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [Locale('tr')],
        locale: const Locale('tr'),
        initialBinding: BindingsBuilder(() {
          // Get.put(AuthController());
          // Get.put(NotficationController());
        }),
        debugShowCheckedModeBanner: false,
        title: 'Aşı Takvimi',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: lightColorScheme,
          appBarTheme: const AppBarTheme(
              backgroundColor: MyAppColors.baseColor,
              titleTextStyle: TextStyle(
                  fontSize: 18,
                  color: MyAppColors.darkBlue,
                  fontWeight: FontWeight.w500)),
        ),
        darkTheme: ThemeData(
          useMaterial3: true,
          colorScheme: darkColorScheme,
        ),
        themeMode: ThemeMode.light,
        initialRoute: '/',
        getPages: [
          GetPage(
            name: '/',
            page: () => Hastalar(),
            transition: Transition.fadeIn,
          ),
        ]);
  }
}
