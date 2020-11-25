import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:you_tube_api/models/channel_info.dart';
import 'package:you_tube_api/models/videos_list.dart';
import 'package:you_tube_api/utils/constant.dart';

class Services {
  static const CHANNEL_ID = 'UC_x5XG1OV2P6uZZ5FSM9Ttw';
  static const baseUrl = 'www.googleapis.com';
  static Future<ChannelInfo> getChannelInfo() async {
    Map<String, String> parameters = {
      'part': 'snippet,contentDetails,statistics',
      'id': CHANNEL_ID,
      'key': Constant.API_KEY
    };
    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: 'application/json'
    };

    Uri uri = Uri.https(baseUrl, 'youtube/v3/channels', parameters);
    Response response = await http.get(uri, headers: header);
    ChannelInfo channelInfo = channelInfoFromJson(response.body);
    return channelInfo;
  }

  static Future<VideosList> getVideosList(
      {String playlistId, String pageToken}) async {
    Map<String, String> parameters = {
      'part': 'snippet',
      'playlistId': playlistId,
      'maxResults': '8',
      'pageToken': pageToken,
      'key': Constant.API_KEY
    };

    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: 'application/json'
    };

    Uri uri = Uri.https(baseUrl, 'youtube/v3/playlistItems', parameters);
    Response response = await http.get(uri, headers: header);
    //print(response.body);
    VideosList videosList = videosListFromJson(response.body);
    return videosList;
  }
}

/*curl \
  'https://youtube.googleapis.com/youtube/v3/channels?part=snippet%2CcontentDetails%2Cstatistics&id=UC_x5XG1OV2P6uZZ5FSM9Ttw&access_token=AIzaSyA840lVuzb6PG5MrkvrXnTlX_9C8ZVWlTY&key=[YOUR_API_KEY]' \
  --header 'Authorization: Bearer [YOUR_ACCESS_TOKEN]' \
  --header 'Accept: application/json' \
  --compressed


  curl \
  'https://youtube.googleapis.com/youtube/v3/playlistItems?part=snippet&playlistId=UU_x5XG1OV2P6uZZ5FSM9Ttw&access_token=AIzaSyA840lVuzb6PG5MrkvrXnTlX_9C8ZVWlTY&key=[YOUR_API_KEY]' \
  --header 'Authorization: Bearer [YOUR_ACCESS_TOKEN]' \
  --header 'Accept: application/json' \
  --compressed

*/
