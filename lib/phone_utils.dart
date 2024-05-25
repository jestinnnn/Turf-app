import 'package:url_launcher/url_launcher.dart';

Future<void> launchPhoneApp(String phoneNumber) async {
  String uri = 'tel:$phoneNumber';
  if (await canLaunchUrl(Uri.parse(uri))) {
    await launchUrl(Uri.parse(uri));
  } else {
    throw 'Could not launch $phoneNumber';
  }
}
