import 'package:canting_app/data/api/api_services.dart';
import 'package:canting_app/pages/detail_page.dart';
import 'package:canting_app/pages/login_page.dart';
import 'package:canting_app/pages/main_page.dart';
import 'package:canting_app/pages/splash_page.dart';
import 'package:canting_app/provider/index_nav_provider.dart';
import 'package:canting_app/provider/login_tab_provider.dart';
import 'package:canting_app/provider/restaurant_add_preview_provider.dart';
import 'package:canting_app/provider/restaurant_detail_provider.dart';
import 'package:canting_app/provider/restaurant_list_provider.dart';
import 'package:canting_app/provider/restaurant_search_provider.dart';
import 'package:canting_app/provider/simple_property_provider.dart';
import 'package:canting_app/provider/theme_mode_provider.dart';
import 'package:canting_app/routes/navigation_route.dart';
import 'package:canting_app/style/theme/canting_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final themeProvider = ThemeModeProvider();
  await themeProvider.initTheme();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeModeProvider>.value(value: themeProvider),
        Provider(create: (context) => ApiServices()),
        ChangeNotifierProvider(create: (context) => IndexNavProvider()),
        ChangeNotifierProvider(create: (context) => LoginTabProvider()),
        ChangeNotifierProvider(
          create: (context) =>
              RestaurantListProvider(context.read<ApiServices>()),
        ),
        ChangeNotifierProvider(
          create: (context) =>
              RestaurantDetailProvider(context.read<ApiServices>()),
        ),
        ChangeNotifierProvider(
          create: (context) =>
              RestaurantAddPreviewProvider(context.read<ApiServices>()),
        ),
        ChangeNotifierProvider(
          create: (context) =>
              RestaurantSearchProvider(context.read<ApiServices>()),
        ),
        ChangeNotifierProvider(create: (context) => SimplePropertyProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Canting App",
      debugShowCheckedModeBanner: false,
      theme: CantingTheme.lightTheme,
      darkTheme: CantingTheme.darkTheme,
      themeMode: context.watch<ThemeModeProvider>().themeMode,
      // themeMode: ThemeMode.dark,
      initialRoute: NavigationRoute.splashRoute.name,
      routes: {
        NavigationRoute.splashRoute.name: (context) => const SplashPage(),
        NavigationRoute.loginRoute.name: (context) => const LoginPage(),
        NavigationRoute.mainRoute.name: (context) => const MainPage(),
        NavigationRoute.detailRoute.name: (context) => DetailPage(
          restaurantId: ModalRoute.of(context)?.settings.arguments as String,
        ),
      },
    );
  }
}
