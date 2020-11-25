import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:you_tube_api/models/channel_info.dart';
import 'package:you_tube_api/models/videos_list.dart';
import 'package:you_tube_api/screen/video_player_screen.dart';
import 'package:you_tube_api/utils/services.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  VideosList _videosList;
  ChannelInfo _channelInfo;
  Item _item;
  bool _loading;
  String _playlistId;
  String _nextPageToken;

  ScrollController _scrollController;

  _getChannelInfo() async {
    var _channelInfo = await Services.getChannelInfo();
    _item = _channelInfo.items[0];
    _playlistId = _item.contentDetails.relatedPlaylists.uploads;
    print('play list id : $_playlistId');
    await _loadVideos();
    setState(() {
      _loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _loading = true;
    });
    _getChannelInfo();
    _nextPageToken = '';
    _scrollController = ScrollController();
    _videosList = VideosList();
    _videosList.videos = List();
  }

  _loadVideos() async {
    VideosList tempVideoList = await Services.getVideosList(
        playlistId: _playlistId, pageToken: _nextPageToken);
    _nextPageToken = tempVideoList.nextPageToken;
    _videosList.videos.addAll(tempVideoList.videos);
    print('videos:${_videosList.videos.length}');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'You Tube Playlist',
        ),

        //backgroundColor: Colors.red,
      ),
      body: Container(
        child: Column(
          children: [
            _buildInfoView(),
            Expanded(
              child: NotificationListener<ScrollEndNotification>(
                onNotification: (ScrollNotification notification) {
                  if (_videosList.videos.length >=
                      int.parse(_item.statistics.videoCount)) {
                    return true;
                  }
                  if (notification.metrics.pixels ==
                      notification.metrics.maxScrollExtent) {
                    _loadVideos();
                  }
                  return true;
                },
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    VideoItem videoitem = _videosList.videos[index];
                    print(
                        "hello ${videoitem.video.thumbnails.thumbnailsDefault.url}");
                    return InkWell(
                      onTap: () async {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => VideoPlayer(
                                      videoItem: videoitem,
                                    )));
                      },
                      child: Container(
                        child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Row(
                            children: [
                              Image.network(videoitem
                                  .video.thumbnails.thumbnailsDefault.url),
                              SizedBox(
                                width: 20,
                              ),
                              Flexible(child: Text(videoitem.video.title)),
                              SizedBox(
                                width: 20,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: _videosList.videos.length,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _buildInfoView() {
    return _loading
        ? CircularProgressIndicator()
        : Container(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Card(
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      CircleAvatar(
                          backgroundImage: CachedNetworkImageProvider(
                              _item.snippet.thumbnails.medium.url)),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: Text(
                          _item.snippet.title,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w400),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          _item.statistics.videoCount,
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
