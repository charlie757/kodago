import 'package:flutter/material.dart';
import 'package:kodago/helper/app_color.dart';
import 'package:kodago/helper/app_images.dart';
import 'package:kodago/helper/custom_text.dart';
import 'package:kodago/helper/font_family.dart';
import 'package:kodago/helper/screen_size.dart';
import 'package:kodago/helper/view_network_image.dart';
import 'package:kodago/model/feeds_model.dart';
import 'package:kodago/services/provider/home/home_provider.dart';
import 'package:kodago/uitls/my_sperator.dart';
import 'package:kodago/widget/comment_bottomsheet.dart';
import 'package:video_player/video_player.dart';
import '../../../uitls/mixins.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class ViewPostScreen extends StatefulWidget {
  int currentIndex;
  FeedsModel? feedsModel;
  ViewPostScreen({required this.feedsModel, required this.currentIndex});

  @override
  State<ViewPostScreen> createState() => _ViewPostScreenState();
}

class _ViewPostScreenState extends State<ViewPostScreen>
    with MediaQueryScaleFactor {
  late VideoPlayerController controller;

  @override
  void dispose() {
    // controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var model = widget.feedsModel!.data!.feeds![widget.currentIndex];
    // if (model.fieldType == 'video') {
    //   controller =
    //       VideoPlayerController.networkUrl(Uri.parse(model.video![0].mainURL))
    //         ..initialize().then((_) {
    //           // controller.setVolume(0);
    //           controller.pause();
    //         });
    // } else {}
    return MediaQuery(
      data: mediaQuery,
      child: Scaffold(
          appBar: appBar(),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Container(
              padding: const EdgeInsets.only(top: 15),
              decoration: BoxDecoration(
                  color: AppColor.whiteColor,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                        offset: const Offset(0, -1),
                        color: AppColor.blackColor.withOpacity(.1),
                        blurRadius: 1)
                  ]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  userInfoHeaderWidget(),
                  ScreenSize.height(10),
                  model.fieldType == 'image'
                      ? Padding(
                          padding: const EdgeInsets.only(left: 18, right: 18),
                          child: ViewNetworkImage(
                            img: model.image[0]['thumbURL'],
                            height: 200.0,
                            width: double.infinity,
                          ))
                      : Container(),
                  ScreenSize.height(18),
                  userInfoWidget('Group Name', model.groupName ?? ''),
                  model.fieldType.toString().toLowerCase() != 'image' &&
                          model.fieldType.toString().toLowerCase() != 'video' &&
                          model.fieldType.toString().toLowerCase() != 'document'
                      ? userInfoWidget(model.fieldName, model.text ?? "")
                      : Container(),
                  model.fieldType.toString().toLowerCase() == 'document'
                      ? documentWidget()
                      : Container(),
                  model.fieldType == 'image' ? imagesWidget() : Container(),
                  ScreenSize.height(28),
                  GestureDetector(
                    onTap: () {
                    Provider.of<HomeProvider>(context,listen: false).viewSheetFeedDataApiFunction(groupId: model.groupId, sheetId: model.sheetId, sheetDataId: model.sheetDataId);
                      commentBottomSheet();
                    },
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                          color: const Color(0xffF0F5F9),
                          borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20)),
                          boxShadow: [
                            BoxShadow(
                                offset: const Offset(0, 10),
                                blurRadius: 35,
                                spreadRadius: -10,
                                color: AppColor.blackColor.withOpacity(.2))
                          ]),
                      padding: const EdgeInsets.only(left: 19),
                      alignment: Alignment.center,
                      child: Row(
                        children: [
                          Image.asset(
                            AppImages.comment1Icon,
                            height: 18,
                            width: 18,
                          ),
                          ScreenSize.width(6),
                          customText(
                            title: '10 comments',
                            fontSize: 11,
                            fontWeight: FontWeight.w400,
                            fontFamily: FontFamily.interMedium,
                            color: AppColor.blackColor,
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }

  userInfoHeaderWidget() {
    var model = widget.feedsModel!.data!.feeds![widget.currentIndex];

    return Padding(
      padding: const EdgeInsets.only(left: 18, right: 18),
      child: Row(
        children: [
          ClipOval(
              child: ViewNetworkImage(
            img: model.imageLink,
            height: 42.0,
            width: 42.0,
          )),
          ScreenSize.width(10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              customText(
                title: model.name ?? '',
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColor.blackColor,
                fontFamily: FontFamily.interBold,
              ),
              ScreenSize.height(2),
              customText(
                title: model.dateText != null
                    ? model.dateText.toString().replaceAll('Added on ', '')
                    : '',
                fontSize: 11,
                fontWeight: FontWeight.w400,
                color: AppColor.grey7DColor,
                fontFamily: FontFamily.interMedium,
              ),
            ],
          ),
        ],
      ),
    );
  }

  imagesWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ScreenSize.height(13),
        // const Padding(
        //   padding: EdgeInsets.symmetric(horizontal: 18),
        //   child: MySeparator(
        //     color: Color(0xffC0D0D9),
        //   ),
        // ),
        ScreenSize.height(13),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: customText(
            title: 'Images',
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: AppColor.grey6AColor,
            fontFamily: FontFamily.interMedium,
          ),
        ),
        ScreenSize.height(9),
        Container(
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: ListView.separated(
                separatorBuilder: (context, sp) {
                  return ScreenSize.width(15);
                },
                shrinkWrap: true,
                itemCount: widget
                    .feedsModel!.data!.feeds![widget.currentIndex].image.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return ViewNetworkImage(
                    img: widget.feedsModel!.data!.feeds![widget.currentIndex]
                        .image[index]['thumbURL'],
                    height: 50.0,
                    width: 50.0,
                  );
                })),
      ],
    );
  }

  documentWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: customText(
            title: 'Document',
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: AppColor.grey6AColor,
            fontFamily: FontFamily.interMedium,
          ),
        ),
        ScreenSize.height(5),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Row(
            children: [
              documentContainer(AppImages.pdfIcon),
              ScreenSize.width(8),
              documentContainer(AppImages.msWordIcon),
              ScreenSize.width(8),
              documentContainer(AppImages.excelIcon),
            ],
          ),
        ),
      ],
    );
  }

  documentContainer(String img) {
    return Container(
      height: 34,
      width: 34,
      transformAlignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: const Color(0xffC3CDD8))),
      alignment: Alignment.center,
      child: Image.asset(
        img,
        height: 18,
        width: 18,
      ),
    );
  }

  userInfoWidget(String title, String des) {
    return Padding(
      padding: const EdgeInsets.only(left: 18, right: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          customText(
            title: title,
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: AppColor.grey6AColor,
            fontFamily: FontFamily.interMedium,
          ),
          ScreenSize.height(7),
          customText(
            title: des,
            fontSize: 13,
            fontWeight: FontWeight.w400,
            color: AppColor.blackColor,
            fontFamily: FontFamily.interMedium,
          ),
          ScreenSize.height(14),
          const MySeparator(
            color: Color(0xffC0D0D9),
          ),
          ScreenSize.height(13),
        ],
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              alignment: Alignment.center,
              child: Image.asset(
                AppImages.arrowForeWordIcon,
                height: 20,
                width: 20,
              ),
            ),
          ),
          ScreenSize.width(10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              customText(
                title: widget.feedsModel != null &&
                        widget.feedsModel!.data != null &&
                        widget.feedsModel!.data!.feeds != null
                    ? widget.feedsModel!.data!.feeds![widget.currentIndex]
                            .sheetName ??
                        ""
                    : "",
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColor.blackColor,
                fontFamily: FontFamily.interSemiBold,
              ),
              ScreenSize.height(4),
              customText(
                title: 'File Rack Name',
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: AppColor.appColor,
                fontFamily: FontFamily.interMedium,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
