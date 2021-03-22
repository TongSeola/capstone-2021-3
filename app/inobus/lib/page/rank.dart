import 'package:flutter/material.dart';
import '../api/json.dart';

class RankPage extends StatefulWidget {
  RankPage();
  @override
  _RankPage createState() => _RankPage();
}

class _RankPage extends State<RankPage> {
  List<String> rankList;
  List<RankText> rankText = [];

  void getOrganizationRank() async {
    var requestOrganizationList = await requestOrganization();
    setState(() {
      rankList = requestOrganizationList;
    });
  }

  List getRankText(mediaQuery) {
    setState(() {
      for (var j = 3; j < rankList.length; j++) {
        rankText.add(RankText(
            bottomHeight: mediaQuery.size.height * 0.05,
            rankeText: "${j + 1}등 : ${rankList[j]}"));
      }
    });
    return rankText;
  }

  @override
  void initState() {
    super.initState();
    getOrganizationRank();
  }

  @override
  Widget build(BuildContext context) {
    // 반응형으로 만들기 위한 변수
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
        body: rankList != null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                        top: mediaQuery.size.width * 0.1,
                        bottom: mediaQuery.size.width * 0.1,
                      ),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            RankIcon(
                                rankColor: Colors.grey,
                                rankSize: mediaQuery.size.width * 0.2,
                                rankText: rankList[1]),
                            RankIcon(
                                rankColor: Colors.yellow,
                                rankSize: mediaQuery.size.width * 0.25,
                                rankText: rankList[0]),
                            RankIcon(
                                rankColor: Colors.brown,
                                rankSize: mediaQuery.size.width * 0.15,
                                rankText: rankList[2]),
                          ]),
                    ),
                    Expanded(
                        //스크롤 가능하게
                        child: ListView(
                      padding: EdgeInsets.only(
                        left: mediaQuery.size.width * 0.1,
                      ),
                      children: getRankText(mediaQuery),
                    ))
                  ])
            : Text("Loading"));
  }
}

// 아이콘으로 등수 표현
class RankIcon extends StatelessWidget {
  final double rankSize;
  final String rankText;
  final Color rankColor;

  RankIcon({Key key, this.rankSize, this.rankText, this.rankColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(rankText),
        Icon(
          Icons.emoji_events,
          color: rankColor,
          size: rankSize,
        ),
        if (rankColor == Colors.yellow)
          Text("1등")
        else if (rankColor == Colors.grey)
          Text("2등")
        else if (rankColor == Colors.brown)
          Text("3등")
      ],
    );
  }
}

// 텍스트로 등수 표현
class RankText extends StatelessWidget {
  final double bottomHeight;
  final String rankeText;

  RankText({Key key, this.bottomHeight, this.rankeText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: bottomHeight),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [Text(rankeText)]),
    );
  }
}
