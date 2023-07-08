import 'package:flutter/material.dart';
import 'package:urbanplantscapes_mobile_app/theme/helper.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../data/images_slider_jason.dart';
import '../data/services_json.dart';
import '../theme/colors.dart';
import '../theme/constraints.dart';
import '../theme/padding.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    Widget getFooter() {
      var size = MediaQuery.of(context).size;
      return Container(
        width: size.width,
        height: 90,
        decoration: BoxDecoration(
            color: textWhite,
            border: Border(
                top: BorderSide(width: 2, color: textBlack.withOpacity(0.06)))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: size.width - 40,
              height: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12), color: primary),
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      book_appointment,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: textWhite),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      );
    }

    return Scaffold(
      appBar: PreferredSize(
        child: getAppBar(),
        preferredSize: Size.fromHeight(200),
      ),
      body: getBody(),
      bottomNavigationBar: getFooter(),
    );
  }
}

Widget getAppBar() {
  return AppBar(
    automaticallyImplyLeading: false,
    backgroundColor: primary,
    flexibleSpace: Stack(
      children: [
        Container(
          //height: 200,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(getImage("home.png")), fit: BoxFit.cover)),
        ),
        Container(
          decoration: BoxDecoration(color: textBlack.withOpacity(0.5)),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Center(
                    child: Padding(
                  padding: EdgeInsets.only(left: 20, right: 20, top: 10),
                  child: Text(
                    welcome_message,
                    style: TextStyle(
                        color: textWhite,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                )),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(width: 2, color: textWhite)),
                  child: const Padding(
                    padding:
                        EdgeInsets.only(left: 12, right: 12, bottom: 8, top: 8),
                    child: Text(
                      header_text,
                      style: TextStyle(
                          fontSize: 16,
                          color: textWhite,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    ),
  );
}

Widget getBody() {
  return Column(
    children: [
      Container(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.only(top: mainPadding, bottom: mainPadding),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(serviceTypes.length, (index) {
                return Container(
                  width: 120,
                  height: 120,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 80.0,
                        height: 80.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: AssetImage(
                                  getImage(serviceTypes[index]['image']))),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        serviceTypes[index]['name'],
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ),
        ),
      ),
      SizedBox(height: 20),
      CarouselSliderExample(),
    ],
  );
}

class CarouselSliderExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(children: [
        CarouselSlider(
          items: List.generate(imagesSlide.length, (index) {
            return Container(
              margin: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                image: DecorationImage(
                  image: AssetImage(getImage(imagesSlide[index]['image'])),
                  fit: BoxFit.cover,
                ),
              ),
            );
          }),
          options: CarouselOptions(
            height: 380.0,
            enlargeCenterPage: true,
            autoPlay: true,
            aspectRatio: 16 / 9,
            autoPlayCurve: Curves.fastOutSlowIn,
            enableInfiniteScroll: true,
            autoPlayAnimationDuration: Duration(milliseconds: 800),
            viewportFraction: 0.8,
          ),
        ),
      ]),
    );
  }
}
