import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:link_text/link_text.dart';

import 'package:http/http.dart' as http;

dynamic _lastIndex = false;

// Create a variable
var _controller = ScrollController();

class PostList extends StatefulWidget {
  @override
  _PostListState createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  dynamic data = false;
  bool noMore = false;
  bool isLoading = false;

  void loadServer() async {
    setState(() {
      isLoading = true;
    });
    String url = 'http://android.sitetastingmyanmar.com/techbank.php?index=' +
        _lastIndex.toString();
    try {
      var response = await http.post(url).timeout(
            // When TimeOut, Call it Again
            Duration(seconds: 60),
          );

      // If response is NULL, do nothing
      if (response == null) return;

      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);

        try {
          setState(() {
            isLoading = false;
            if (responseData.length == 0 || responseData == '') noMore = true;
            if (data == false) {
              data = responseData;
            } else {
              data.addAll(responseData);
            }
          });

          _lastIndex = data.last['id'];
        } catch (e) {
          // Do Nothing
        }
      } else {
        print("FAILED");
      }
    } on SocketException {}
  }

  @override
  void initState() {
    _lastIndex = false;
    data = false;
    noMore = false;
    isLoading = false;

// Setup the listener.
    _controller.addListener(() {
      if (_controller.position.atEdge) {
        if (_controller.position.pixels == 0) {
          // You're at the top.
        } else {
          // You're at the bottom.
          loadServer();
        }
      }
    });

    loadServer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                Image.asset('icon.jpg', width: 32),
                SizedBox(width: 10),
                Text("Tech Bank"),
              ],
            ),
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return SimpleDialog(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            "Copyright © Spiceworks Myanmar 2020.",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 18, color: Colors.blue),
                          ),
                        )
                      ],
                    );
                  },
                );
              },
              child: Icon(Icons.info, size: 28, color: Colors.white),
            )
          ],
        ),
      ),
      body: data == false
          ? Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text("Loading Data . . ."),
                ],
              ),
            )
          : RefreshIndicator(
              onRefresh: () async {
                data = false;
                loadServer();
              },
              child: SingleChildScrollView(
                controller: _controller,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 5,
                    horizontal: 3,
                  ),
                  margin: const EdgeInsets.only(bottom: 10),
                  child: Column(
                    children: <Widget>[
                      for (var i = 0; i < data.length; i++)
                        PostItem(
                          data: data[i]['data'],
                        ),
                      if (noMore == false)
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                width: 18,
                                height: 18,
                                child: CircularProgressIndicator(
                                  strokeWidth: 1,
                                ),
                              ),
                            ],
                          ),
                        )
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}

Map<String, String> emojis = {
  ':)': 'https://assets.chatwork.com/images/emoticon2x/emo_smile.gif',
  ':(': 'https://assets.chatwork.com/images/emoticon2x/emo_sad.gif',
  ':D': 'https://assets.chatwork.com/images/emoticon2x/emo_more_smile.gif',
  '8-)': 'https://assets.chatwork.com/images/emoticon2x/emo_lucky.gif',
  ':o': 'https://assets.chatwork.com/images/emoticon2x/emo_surprise.gif',
  ';)': 'https://assets.chatwork.com/images/emoticon2x/emo_wink.gif',
  ';(': 'https://assets.chatwork.com/images/emoticon2x/emo_tears.gif',
  '|-)': 'https://assets.chatwork.com/images/emoticon2x/emo_snooze.gif',
  '(sweat)': 'https://assets.chatwork.com/images/emoticon2x/emo_sweat.gif',
  ':|': 'https://assets.chatwork.com/images/emoticon2x/emo_mumu.gif',
  ':*': 'https://assets.chatwork.com/images/emoticon2x/emo_kiss.gif',
  ':p': 'https://assets.chatwork.com/images/emoticon2x/emo_tongueout.gif',
  '(blush)': 'https://assets.chatwork.com/images/emoticon2x/emo_blush.gif',
  ':^)': 'https://assets.chatwork.com/images/emoticon2x/emo_wonder.gif',
  '(inlove)': 'https://assets.chatwork.com/images/emoticon2x/emo_love.gif',
  ']:)': 'https://assets.chatwork.com/images/emoticon2x/emo_grin.gif',
  '(talk)': 'https://assets.chatwork.com/images/emoticon2x/emo_talk.gif',
  '(yawn)': 'https://assets.chatwork.com/images/emoticon2x/emo_yawn.gif',
  '(puke)': 'https://assets.chatwork.com/images/emoticon2x/emo_puke.gif',
  '(emo)': 'https://assets.chatwork.com/images/emoticon2x/emo_ikemen.gif',
  '8-|': 'https://assets.chatwork.com/images/emoticon2x/emo_otaku.gif',
  '(bow)': 'https://assets.chatwork.com/images/emoticon2x/emo_bow.gif',
  '(clap)': 'https://assets.chatwork.com/images/emoticon2x/emo_clap.gif',
  '(whew)': 'https://assets.chatwork.com/images/emoticon2x/emo_whew.gif',
  '(^^;)': 'https://assets.chatwork.com/images/emoticon2x/emo_wry_smile.gif',
  '(shake)': 'https://assets.chatwork.com/images/emoticon2x/emo_shake.gif',
  '(nod)': 'https://assets.chatwork.com/images/emoticon2x/emo_nod.gif',
  ':#)': 'https://assets.chatwork.com/images/emoticon2x/emo_ninmari.gif',
  '(roger)': 'https://assets.chatwork.com/images/emoticon2x/emo_roger.gif',
  '(flex)': 'https://assets.chatwork.com/images/emoticon2x/emo_muscle.gif',
  '(dance)': 'https://assets.chatwork.com/images/emoticon2x/emo_dance.gif',
  '(:/)': 'https://assets.chatwork.com/images/emoticon2x/emo_komanechi.gif',
  '(gogo)': 'https://assets.chatwork.com/images/emoticon2x/emo_gogo.gif',
  '(think)': 'https://assets.chatwork.com/images/emoticon2x/emo_think.gif',
  '(please)': 'https://assets.chatwork.com/images/emoticon2x/emo_please.gif',
  '(F)': 'https://assets.chatwork.com/images/emoticon2x/emo_flower.gif',
  '(h)': 'https://assets.chatwork.com/images/emoticon2x/emo_heart.gif',
  '(*)': 'https://assets.chatwork.com/images/emoticon2x/emo_star.gif',
  '(lightbulb)':
      'https://assets.chatwork.com/images/emoticon2x/emo_lightbulb.gif',
  '(devil)': 'https://assets.chatwork.com/images/emoticon2x/emo_devil.gif',
  '(anger)': 'https://assets.chatwork.com/images/emoticon2x/emo_anger.gif',
  '(quick)': 'https://assets.chatwork.com/images/emoticon2x/emo_quick.gif',
  '(cracker)': 'https://assets.chatwork.com/images/emoticon2x/emo_cracker.gif',
  '(eat)': 'https://assets.chatwork.com/images/emoticon2x/emo_eat.gif',
  '(^)': 'https://assets.chatwork.com/images/emoticon2x/emo_cake.gif',
  '(coffee)': 'https://assets.chatwork.com/images/emoticon2x/emo_coffee.gif',
  '(beer)': 'https://assets.chatwork.com/images/emoticon2x/emo_beer.gif',
  '(handshake)':
      'https://assets.chatwork.com/images/emoticon2x/emo_handshake.gif',
  '(y)': 'https://assets.chatwork.com/images/emoticon2x/emo_yes.gif'
};

Widget transX(BuildContext context, String data) {
  emojis.forEach((k, v) {
    data = data.replaceAll(k, '#%%#emoji:' + v + '#%%#');
  });

  data = data.replaceAll('\n', '#%%#br:#%%#');

  List<String> xData = data.split('#%%#');

  return Wrap(
    children: <Widget>[
      for (var i = 0; i < xData.length; i++)
        if (xData[i].length > 6 && xData[i].substring(0, 6) == 'emoji:')
          Container(
            width: 18,
            height: 18,
            margin: const EdgeInsets.only(left: 2, right: 2),
            child: Image.network(xData[i].substring(6)),
          )
        else if (xData[i].length >= 3 && xData[i].substring(0, 3) == 'br:')
          Container(width: MediaQuery.of(context).size.width)
        else
          LinkText(
            text: xData[i],
            textStyle: TextStyle(fontSize: 16, height: 1.5),
            linkStyle: TextStyle(
                fontSize: 16,
                color: Colors.blue,
                decoration: TextDecoration.underline,
                height: 1.5),
          )
    ],
  );
}

class PostItem extends StatefulWidget {
  final dynamic data;

  PostItem({@required this.data});

  @override
  _PostItemState createState() => _PostItemState();
}

class _PostItemState extends State<PostItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(5),
      ),
      margin: const EdgeInsets.only(top: 8),
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      child: transX(context, widget.data),
    );
  }
}
