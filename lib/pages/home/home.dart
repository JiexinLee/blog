import 'package:flutter/material.dart';

import 'package:flutter_abnhelper/constants/colors.dart';
import 'package:flutter_abnhelper/constants/url.dart';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;
import 'package:flutter_abnhelper/widgets/card.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with AutomaticKeepAliveClientMixin {
  /// by inheritage this mixin, app will be able to keep data, will not
  /// refresh data itself.

  List<String> titleList = [];
  List<String> imageUrls = [];
  List<String> linksList = [];
  bool isLoading = true;

  /// by inheritage this mixin, have to override this
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    getResourceFromWeb();
  }

  /// fetch data from internet
  Future getResourceFromWeb() async {
    final url = Uri.parse(URL.scrapingLink);
    final response = await http.get(url);
    dom.Document html = dom.Document.html(response.body);

    /// get titles to list
    final titles = html
        .querySelectorAll('h2.post-card-title > a')
        .map((element) => element.innerHtml.trim())
        .toList();

    /// get image urls to list
    final images = html
        .querySelectorAll('a.post-card-image-link > img')
        .map((e) => e.attributes['src']!)
        .toList();

    /// get link for blogs
    final links = html
        .querySelectorAll('h2.post-card-title > a')
        .map((e) => e.attributes['href']!)
        .toList();

    setState(() {
      titleList = titles;
      imageUrls = images;
      linksList = links;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              centerTitle: true,
              title: const Text(
                "LEE'S SCRAPING BLOGS",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 21,
                    fontWeight: FontWeight.bold),
              ),
              expandedHeight: 150,
              flexibleSpace: FlexibleSpaceBar(
                background: Image.asset(
                  "assets/images/home_cover.png",
                  fit: BoxFit.cover,
                ),
              ),
              backgroundColor: AppColor.mainThemeColor,
              floating: true,
              snap: true,
              pinned: true,
            ),
          ];
        },
        body: isLoading
            ? const Center(
                child: SizedBox(
                    width: 100,
                    height: 100,
                    child: CircularProgressIndicator(
                      color: Colors.indigo,
                    )),
              )
            : Container(
                margin: const EdgeInsets.only(top: 5),
                child: ListView.separated(
                  itemCount: titleList.length,
                  itemBuilder: (context, index) =>
                      card(index, context, titleList, imageUrls, linksList),
                  separatorBuilder: (BuildContext context, int index) =>
                      const SizedBox(
                    height: 20,
                  ),
                ),
              ),
      ),
    );
  }
}
