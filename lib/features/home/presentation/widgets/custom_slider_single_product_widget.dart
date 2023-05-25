
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecomerce/core/utils/app_colors.dart';
import 'package:flutter/material.dart';


class CustomSliderSingleProductWidget extends StatefulWidget {
  const CustomSliderSingleProductWidget(
      {Key? key,
      this.isDark = false,
      this.maxHeight = 170,
      required this.maxWidth,
      required this.fit,
      required this.image,
      required this.sliderHeight})
      : super(key: key);
  final List image;
  final double sliderHeight;
  final BoxFit fit;
  final double maxWidth;
  final double maxHeight;
  final bool isDark;

  @override
  State<CustomSliderSingleProductWidget> createState() =>
      _CustomSliderSingleProductWidget();
}

class _CustomSliderSingleProductWidget
    extends State<CustomSliderSingleProductWidget> {
  final CarouselController _controller = CarouselController();
  int currentIndex = 0;

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.lotionColor,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          CarouselSlider(
              options: CarouselOptions(
                  height: widget.sliderHeight,
                  viewportFraction: 1.0,
                  enableInfiniteScroll: true,
                  autoPlay: true,
                  aspectRatio: 2.0,
                  enlargeCenterPage: true,
                  autoPlayInterval: const Duration(seconds: 5),
                  autoPlayAnimationDuration: const Duration(milliseconds: 1500),
                  autoPlayCurve: Curves.easeIn,
                  onPageChanged: (index, reason) {
                    setState(() {
                      currentIndex = index;

                      _inductorWidget(context, currentIndex);
                      // SingleProductScreen();
                    });
                  }),
              items: widget.image.map((e) {
                // setState(() {
                //   currentIndex = widget.image.indexOf(e);
                // });

                return InkWell(
                  child: Container(
                    width: widget.maxWidth,
                    height: widget.maxHeight,
                    child: CachedNetworkImage(
                      filterQuality: FilterQuality.high,
                      fit: widget.fit,
                      imageUrl: e,
                     
                    ),
                  ),
              
                  onTap: () {
                    // setState(() {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => HeroScreen(
                      //               imageName: e,
                      //               images: widget.image,
                      //               currentIndex: currentIndex,
                      //             )));
                    // });
                  },
                );
              }).toList()),
          Positioned(
              // bottom: 10.0,

              child: _inductorWidget(context, currentIndex))
        ],
      ),
    );
  }

  _inductorWidget(context, int currentIndex) {
    return Container(
      child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(widget.image.length, (index) {
            return Container(
              width: 8.0,
              height: 8.0,
              margin:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: (widget.isDark == true ? Colors.white : Colors.black)
                      .withOpacity(currentIndex == index ? 0.9 : 0.4)),
            );
          })),
    );
  }
}
