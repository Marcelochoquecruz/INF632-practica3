import 'package:get/get.dart';
import '../views/main_view.dart';
import '../views/home_view.dart';
import '../views/palindrome_view.dart';
import '../views/friendly_numbers_view.dart';
import '../views/binary_converter_view.dart';

class AppRoutes {
  static final routes = [
    GetPage(
      name: '/',
      page: () => const MainView(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: '/home',
      page: () => const HomeView(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: '/palindrome',
      page: () => const PalindromeView(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: '/friendly-numbers',
      page: () => const FriendlyNumbersView(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: '/binary-converter',
      page: () => const BinaryConverterView(),
      transition: Transition.cupertino,
    ),
  ];
}
