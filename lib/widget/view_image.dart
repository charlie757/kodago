import 'dart:io';
import 'dart:isolate';
import 'dart:ui';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kodago/helper/app_color.dart';
import 'package:kodago/helper/custom_text.dart';
import 'package:kodago/helper/font_family.dart';
import 'package:kodago/helper/view_network_image.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';
// import 'package:pod_player/pod_player.dart';

class ViewImagesScreen extends StatefulWidget {
  final imgCount;
  final imgList;
  ViewImagesScreen({super.key, this.imgCount, this.imgList});

  @override
  State<ViewImagesScreen> createState() => _ViewImagesScreenState();
}

class _ViewImagesScreenState extends State<ViewImagesScreen> {
  int currentCount = 1;
  int downloadImageCount = 1;
  ReceivePort port = ReceivePort();
  String downloadStatus = '';
  String imgUrl = '';
  String? taskId;
  FlickManager? flickManager;

  @override
  void initState() {
    currentCount = widget.imgCount + 1;
    super.initState();
  }

 
  @override
  void dispose() {
    super.dispose();
  }

  bool pagingEnabled = true;
  final TransformationController transformationController =
      TransformationController();
  double get scale => transformationController.value.row0.x;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.blackColor,
      // appBar: customAppBar(),
      body: SafeArea(
          child: PageView.builder(
              clipBehavior: Clip.none,
              physics: pagingEnabled
                  ? const ScrollPhysics()
                  : const NeverScrollableScrollPhysics(),
              controller: PageController(
                  viewportFraction: 1, initialPage: widget.imgCount),
              itemCount: widget.imgList.length,
              onPageChanged: (val) {
                currentCount = val + 1;
                setState(() {});
              },
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 5, right: 5),
                  child: InteractiveViewer(
                          maxScale: 7,
                          transformationController: transformationController,
                          minScale: 1,
                          boundaryMargin: const EdgeInsets.all(5),
                          onInteractionUpdate: (end) {
                            if (scale == 1.0) {
                              pagingEnabled = true;
                            } else {
                              pagingEnabled = false;
                            }
                            setState(() {});
                          },
                          child: ViewNetworkImage(
                              img: widget.imgList[index].mainUrl,
                              height: double.infinity,
                              width: double.infinity),
                        ),
                );
              })),
      // SafeArea(
      //   child: Column(
      //     children: [
      //       Expanded(
      //         child:
      //         // imgUrl.toString().endsWith('mp4')
      //         //     ? PageView.builder(
      //         //         itemCount: widget.imgList.length,
      //         //         clipBehavior: Clip.none,
      //         //         controller: PageController(viewportFraction: 1,initialPage: currentCount),
      //         //         onPageChanged: (val) {
      //         //           print('currentCount..rwee..$val');
      //         //            currentCount = val + 1;

      //         //           imgUrl =
      //         //               "${ApiUrl.imgBaseUrl}${widget.imgList[val].image}";
      //         //           controller = PodPlayerController(
      //         //             podPlayerConfig:
      //         //                 const PodPlayerConfig(autoPlay: true),
      //         //             playVideoFrom: PlayVideoFrom.network(imgUrl),
      //         //           )..initialise();
      //         //           setState(() {
      //         //           });
      //         //         },
      //         //         itemBuilder: (context, index) {
      //         //           return Padding(
      //         //             padding: const EdgeInsets.all(8.0),
      //         //             child: PodVideoPlayer(controller: controller!),
      //         //           );
      //         //         })
      //              PhotoViewGallery.builder(
      //                 enableRotation: false,
      //                 gaplessPlayback: true,
      //                 scrollPhysics: const BouncingScrollPhysics(),
      //                 builder: (BuildContext context, int index) {
      //                   return PhotoViewGalleryPageOptions(
      //                     imageProvider: NetworkImage(widget
      //                             .imgList[index].image
      //                             .toString()
      //                             .endsWith('mp4')
      //                         ? "${ApiUrl.thumbnailUrl}${widget.imgList[index].thumbnails}"
      //                         : "${ApiUrl.imgBaseUrl}${widget.imgList[index].image}",),
      //                     initialScale: PhotoViewComputedScale.contained * 1,
      //                     filterQuality: FilterQuality.high,
      //                     minScale: PhotoViewComputedScale.contained * 1.0,
      //                   );
      //                 },
      //                 itemCount: widget.imgList.length,
      //                 backgroundDecoration: const BoxDecoration(
      //                     // color: Colors
      //                     ),
      //                 customSize: const Size(double.infinity, 400),
      //                 // backgroundDecoration: BoxDecoration(color: AppColor.whiteColor),
      //                 pageController: PageController(
      //                     initialPage: widget.imgCount, viewportFraction: 1),
      //                 onPageChanged: (val) {
      //                   currentCount = val + 1;
      //                   print("currentCount....$currentCount");
      //                   imgUrl =
      //                       "${ApiUrl.imgBaseUrl}${widget.imgList[val].image}";
      //                   // controller = PodPlayerController(
      //                   //   podPlayerConfig:
      //                   //       const PodPlayerConfig(autoPlay: true),
      //                   //   playVideoFrom: PlayVideoFrom.network(imgUrl),
      //                   // )..initialise();
      //                   // imgType = widget.imgList[val].image
      //                   //           .toString()
      //                   //           .endsWith('mp4')?'video':'img';
      //                   setState(() {});
      //                 },
      //               ),
      //       ),
      //     ],
      //   ),
      // ),

      bottomNavigationBar: Container(
        height: 40,
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {},
                child: Icon(
                  Icons.arrow_back_ios,
                  size: 19,
                  color: AppColor.whiteColor,
                )),
            customText(
                title: "${currentCount.toString()} / ${widget.imgList.length}",
                fontSize: 14,
                fontFamily: FontFamily.interRegular,
                color: AppColor.whiteColor,
                fontWeight: FontWeight.w400),
            GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {},
                child: Icon(
                  Icons.arrow_forward_ios,
                  size: 19,
                  color: AppColor.whiteColor,
                )),
          ],
        ),
      ),
    );
  }
}
