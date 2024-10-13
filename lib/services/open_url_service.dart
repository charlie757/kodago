import 'package:url_launcher/url_launcher.dart';
class OpenUrlService {
  static openUrl(String url)async{
    // const url = url;
    if(await canLaunch(url)){
      await launch(url);
    }else {
      throw 'Could not launch $url';
    }
  }

}