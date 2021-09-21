import 'package:trending_on_github/constants/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class NetworkHelper {
  static Future launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      String msg = Strings.couldNotLaunch + url;
      throw msg;
    }
  }
}
