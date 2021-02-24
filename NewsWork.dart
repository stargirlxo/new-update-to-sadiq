import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:testty/retriveinfo.dart';
import 'NewsReading.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(NewsWork());
}

class NewsWork extends StatefulWidget {
  @override
  _NewsWorkState createState() => _NewsWorkState();
}

class _NewsWorkState extends State<NewsWork> {
  DatabaseReference DB = FirebaseDatabase.instance.reference();

  List<myInfo> allData = [];

  final List<String> imgList = [];

  void GetNews() {
    FirebaseDatabase database;
    database = FirebaseDatabase.instance;
    database.goOnline();
    database.setPersistenceEnabled(true);
    database.setPersistenceCacheSizeBytes(10000000);
    DB.child('news').once().then((DataSnapshot snap) {
      var keys = snap.value.keys;
      var data = snap.value;
      allData.clear();
      for (var key in keys) {
        setState(() {
          //print("this key ${data[key]['contant']}");
          myInfo d = new myInfo(data[key]['contant'], data[key]['date'],
              data[key]['ImageUrl'], data[key]['title']);
          allData.add(d);
          //print("igjregjhrkgjkr ${d}");
        });
      }
    });
  }

  var difference;

  void orderAdsByDate(allData) {
    var temp;

    for (int i = 0; i < allData.length - 1; i++) {
      for (int j = i + 1; j < allData.length; j++) {
        difference = allData[i].date.compareTo(allData[j].date);

        if (difference == -1) {
          temp = allData[i];
          allData[i] = allData[j];
          allData[j] = temp;
        }
      }
    }

    print('rrrr${allData}');
  }

  @override
  void initState() {
    GetNews();

    // imgList.add(allData[0].ImageUrl);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("this is data ${allData.length}");
    orderAdsByDate(allData);

    if (allData.length != 0 && allData.length != null) {
      if (allData[0].ImageUrl == '') {
        imgList.add(
            ',,,${allData[0].title},,,${allData[0].contant},,,${allData[0].date}');
      } else {
        imgList.add(
            '${allData[0].ImageUrl},,,${allData[0].title},,,${allData[0].contant},,,${allData[0].date}');
      }

      if (allData[1].ImageUrl == '') {
        imgList.add(
            ',,,${allData[1].title},,,${allData[1].contant},,,${allData[1].date}');
      } else {
        imgList.add(
            '${allData[1].ImageUrl},,,${allData[1].title},,,${allData[1].contant},,,${allData[1].date}');
      }

      if (allData[2].ImageUrl == '') {
        imgList.add(
            ',,,${allData[2].title},,,${allData[2].contant},,,${allData[2].date}');
      } else {
        imgList.add(
            '${allData[2].ImageUrl},,,${allData[2].title},,,${allData[2].contant},,,${allData[2].date}');
      }

      if (allData[3].ImageUrl == '') {
        imgList.add(
            ',,,${allData[3].title},,,${allData[3].contant},,,${allData[3].date}');
      } else {
        imgList.add(
            '${allData[3].ImageUrl},,,${allData[3].title},,,${allData[3].contant},,,${allData[3].date}');
      }

      if (allData[4].ImageUrl == '') {
        imgList.add(
            ',,,${allData[4].title},,,${allData[4].contant},,,${allData[4].date}');
      } else {
        imgList.add(
            '${allData[4].ImageUrl},,,${allData[4].title},,,${allData[4].contant},,,${allData[4].date}');
      }
    }

    // print('ffff${imgList[1].split(',,,')[3]}');

    List<Widget> imageSliders = imgList
        .map((item) => GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  new MaterialPageRoute(
                    builder: (context) => NewsReading(
                        NewsContent: item.split(',,,')[2],
                        NewsTitle: item.split(',,,')[1],
                        date: item.split(',,,')[3],
                        ImageUrl: item.split(',,,')[0]),
                  ),
                );
              },
              child: Container(
                child: Container(
                  margin: EdgeInsets.all(0.0),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(4, 0, 4, 0),
                    child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(50.0)),
                        child: Stack(
                          children: <Widget>[
                            item.split(',,,')[0] == ''
                                ? Container(
                                    decoration: new BoxDecoration(
                                      color: Colors.transparent,
                                      image: new DecorationImage(
                                          fit: BoxFit.cover,
                                          colorFilter: new ColorFilter.mode(
                                              Colors.black.withOpacity(0.2),
                                              BlendMode.colorBurn),
                                          image: AssetImage(
                                              'assets/images/DefaultAd.png')),
                                    ),
                                  )
                                : Image.network(item.split(',,,')[0],
                                    fit: BoxFit.cover, width: 1000.0),
                            Positioned(
                              bottom: 0.0,
                              left: 0.0,
                              right: 0.0,
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.black45,
                                      Colors.black12,
                                    ],
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                  ),
                                ),
                                padding: EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 20.0),
                                child: Text(
                                  item.split(',,,')[1] ?? '',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.tajawal(
                                    color: Colors.black,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )),
                  ),
                ),
              ),
            ))
        .toList();

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        builder: (BuildContext context, Widget child) {
          return new Directionality(
            textDirection: TextDirection.rtl,
            child: new Builder(
              builder: (BuildContext context) {
                return new MediaQuery(
                  data: MediaQuery.of(context).copyWith(
                    textScaleFactor: 1.0,
                  ),
                  child: child,
                );
              },
            ),
          );
        },
        home: allData.length == 0
            ? Center(
                child: new CircularProgressIndicator(),
              )
            : Scaffold(
                backgroundColor: const Color.fromRGBO(255, 254, 244, 1.0),
                appBar: AppBar(
                  // backgroundColor: Colors.grey,
                  backgroundColor: const Color.fromRGBO(128, 0, 0, 1.0),
                  title: Text(
                    'اخبار التعليم المستمر',
                    style: GoogleFonts.tajawal(
                      fontSize: 16.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                body: Container(
                  color: const Color.fromRGBO(255, 254, 244, 1.0),
                  child: ListView(
                    children: <Widget>[
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: Text(
                              'احدث الاخبار :',
                              textAlign: TextAlign.right,
                              style: GoogleFonts.tajawal(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0),
                            ),
                          ),
                        ],
                      ),
                      Divider(
                        height: 20.0,
                        thickness: 2.0,
                        color: Colors.red,
                      ),
                      imgList.length == 0 ||
                              imgList.length == null ||
                              allData.length == 0 ||
                              allData.length == null
                          ? Center(
                              child: new CircularProgressIndicator(),
                            )
                          : Container(
                              height: MediaQuery.of(context).size.height * 0.3,
                              child: Container(
                                child: Column(
                                  children: <Widget>[
                                    CarouselSlider(
                                      options: CarouselOptions(
                                        autoPlay: true,
                                        aspectRatio: 2.0,
                                        enlargeCenterPage: true,
                                        scrollDirection: Axis.vertical,
                                      ),
                                      items: imageSliders,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                      // SizedBox(
                      //   height: 9.0,
                      // ),
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Text(
                              'كافة الاخبار :',
                              textAlign: TextAlign.right,
                              style: GoogleFonts.tajawal(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0),
                            ),
                          ),
                        ],
                      ),
                      Divider(
                        height: 5.0,
                        thickness: 2.0,
                        color: Colors.red,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      new Container(
                        color: const Color.fromRGBO(255, 254, 244, 1.0),
                        height: MediaQuery.of(context).size.height * 0.48,
                        width: MediaQuery.of(context).size.width,
                        child: allData.length == 0 || allData.length == null
                            ? new Center(
                                child: new CircularProgressIndicator(),
                              )
                            : new ListView.builder(
                                itemCount: allData.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return SingleAdDesignVertical(
                                      allData[index].title,
                                      allData[index].date,
                                      allData[index].ImageUrl,
                                      allData[index].contant);
                                },
                              ),
                      ),
                    ],
                  ),
                ),
              ));
  }

  Widget SingleAdDesignVertical(
      String title, String date, String imgURL, String content) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            new MaterialPageRoute(
              builder: (context) => NewsReading(
                  NewsContent: content,
                  NewsTitle: title,
                  date: date,
                  ImageUrl: imgURL),
            ));
      },
      child: new Card(
        color: const Color.fromRGBO(255, 254, 244, 1.0),
        child: new Container(
          height: 120.0,
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.only(bottom: 5.0, right: 8.0, left: 8.0),
                child: Container(
                  height: 120.0,
                  width: 120.0,
                  decoration: new BoxDecoration(
                    color: Colors.transparent,
                    shape: BoxShape.circle,
                    image: new DecorationImage(
                        fit: BoxFit.cover,
                        colorFilter: new ColorFilter.mode(
                            Colors.blueGrey, BlendMode.colorBurn),
                        image: AssetImage('assets/images/this.png')),
                  ),
                  child: Container(
                    height: 130.0,
                    width: 150.0,
                    decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(imgURL),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Align(
                            alignment: AlignmentDirectional.topStart,
                            child: new Text(
                              title ?? '',
                              overflow: TextOverflow.ellipsis,
                              textDirection: TextDirection.rtl,
                              maxLines: 3,
                              style: GoogleFonts.tajawal(
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 20.0),
                            ),
                          ),
                        ),

                      Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: new Text(
                            date ?? '',
                            textDirection: TextDirection.rtl,
                            style: GoogleFonts.tajawal(
                                color: Colors.grey,
                                fontWeight: FontWeight.normal,
                                fontSize: 16.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  height: 200.0,
                  width: 50.0,
                  child: Icon(
                    Icons.chevron_right,
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
