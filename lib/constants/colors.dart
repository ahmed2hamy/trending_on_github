part of 'constants.dart';

const Color kPrimaryColor = Color(0xffFD8469);

final MaterialColor kPrimarySwatch =
    MaterialColor(kPrimaryColor.hashCode, _primaryColorMap);

Map<int, Color> _primaryColorMap = {
  50: const Color.fromRGBO(253, 132, 105, .1),
  100: const Color.fromRGBO(253, 132, 105, .2),
  200: const Color.fromRGBO(253, 132, 105, .3),
  300: const Color.fromRGBO(253, 132, 105, .4),
  400: const Color.fromRGBO(253, 132, 105, .5),
  500: const Color.fromRGBO(253, 132, 105, .6),
  600: const Color.fromRGBO(253, 132, 105, .7),
  700: const Color.fromRGBO(253, 132, 105, .8),
  800: const Color.fromRGBO(253, 132, 105, .9),
  900: const Color.fromRGBO(253, 132, 105, 1),
};
