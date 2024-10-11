import 'package:flutter/material.dart';
import 'package:kodago/config/app_routes.dart';
import 'package:kodago/helper/app_color.dart';
import 'package:kodago/helper/app_images.dart';
import 'package:kodago/helper/custom_text.dart';
import 'package:kodago/helper/font_family.dart';
import 'package:kodago/helper/screen_size.dart';
import 'package:kodago/helper/view_network_image.dart';
import 'package:kodago/model/feeds_model.dart';
import 'package:kodago/presentation/dashboard/home/view_post_screen.dart';
import 'package:kodago/services/provider/home/home_provider.dart';
import 'package:kodago/widget/comment_bottomsheet.dart';
import 'package:kodago/widget/view_video.dart';
import 'package:video_player/video_player.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class HomePostsWidget extends StatefulWidget {
  int index;
  int currentIndex;
  FeedsModel? feedsModel;
  HomePostsWidget({
    required this.index,
    this.currentIndex = 0,
    this.feedsModel,
  });

  @override
  State<HomePostsWidget> createState() => _HomePostsWidgetState();
}

class _HomePostsWidgetState extends State<HomePostsWidget> {
  ValueNotifier<bool> isSound = ValueNotifier(false);
  // Use ValueNotifier for sound control
  late VideoPlayerController controller;

  @override
  void dispose() {
    // controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var model = widget.feedsModel!.data!.feeds![widget.index];
    // if (model.fieldType == 'video') {
    //   controller =
    //       VideoPlayerController.networkUrl(Uri.parse(model.video![0].mainURL))
    //         ..initialize().then((_) {
    //           // controller.setVolume(0);
    //           controller.pause();
    //         });
    // } else {}
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        userInfoHeaderWidget(),
        ScreenSize.height(10),
        model.fieldType == 'image'
            ? ViewNetworkImage(
                img: model.image[0]['thumbURL'],
                width: double.infinity,
              )
            : model.fieldType == ''
                ? Stack(
                    children: [
                      GestureDetector(
                        onTap: () {
                          AppRoutes.pushCupertinoNavigation(
                              ViewVideo(videoUrl: model.video![0].mainURL));
                        },
                        child: AspectRatio(
                          aspectRatio: controller.value.aspectRatio,
                          child: VideoPlayer(controller),
                        ),
                      ),
                      // GestureDetector(
                      //   onTap: () {
                      //     controller.play();
                      //   },
                      //   child: Align(
                      //       alignment: Alignment.bottomCenter,
                      //       child: Container(
                      //           height: 40,
                      //           width: 40,
                      //           decoration: BoxDecoration(
                      //               shape: BoxShape.circle,
                      //               color: AppColor.blackColor.withOpacity(.3)),
                      //           child: const Icon(
                      //             Icons.play_arrow,
                      //             color: AppColor.whiteColor,
                      //           ))),
                      // )
                      // Positioned(
                      //   right: 0 + 15,
                      //   bottom: 0 + 15,
                      //   child: GestureDetector(
                      //     onTap: () {
                      //       if (isSound.value == true) {
                      //         isSound.value = false;
                      //         controller.setVolume(0);
                      //       } else {
                      //         isSound.value = true;
                      //         controller.setVolume(10);
                      //       }
                      //     },
                      //     child: Container(
                      //       height: 25,
                      //       width: 25,
                      //       decoration: BoxDecoration(
                      //           shape: BoxShape.circle,
                      //           color: AppColor.blackColor.withOpacity(.3)),
                      //       alignment: Alignment.center,
                      //       child: Icon(
                      //         isSound.value
                      //             ? Icons.volume_up_rounded
                      //             : Icons.volume_off,
                      //         color: AppColor.whiteColor,
                      //         size: 15,
                      //       ),
                      //     ),
                      //   ),
                      // )
                    ],
                  )
                : Container(
                    height: 400,
                    width: double.infinity,
                    color: AppColor.storyGradientColor1,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 10),
                    child: customText(
                      title: model.text ?? '',
                      fontSize: 18,
                      color: AppColor.whiteColor,
                      fontWeight: FontWeight.w500,
                      fontFamily: FontFamily.interMedium,
                      textAlign: TextAlign.center,
                    ),
                  ),
        ScreenSize.height(12),
        likeCommentSeeMoreWidget(),
        ScreenSize.height(16),
        currentLikeAndCountWidget(),
        ScreenSize.height(5),
        commentWidget()
      ],
    );
  }

  userInfoHeaderWidget() {
    var model = widget.feedsModel!.data!.feeds![widget.index];
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 25),
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
          const Spacer(),
          Image.asset(
            AppImages.moreHorizontalIcon,
            width: 14,
            height: 5,
          )
        ],
      ),
    );
  }

  likeCommentSeeMoreWidget() {
    var model = widget.feedsModel!.data!.feeds![widget.index];
    return Consumer<HomeProvider>(
      builder: (context,myProvider,child) {
        return Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Row(
            children: [
              Image.asset(
                AppImages.thumb1Icon,
                height: 16,
                width: 18,
              ),
              ScreenSize.width(13),
              GestureDetector(
                onTap: () {
                  myProvider.clearController();
                  myProvider.commentApiFunction(groupId: model.groupId, sheetId: model.sheetId, sheetDataId: model.sheetDataId);
                  commentBottomSheet(groupId: model.groupId,sheetDataId: model.sheetDataId,sheetId: model.sheetId).then((val){
                     myProvider.clearPages();
                        myProvider.feedsApiFunction();
                  });
                },
                child: Image.asset(
                  AppImages.commentIcon,
                  height: 16,
                  width: 15,
                ),
              ),
              ScreenSize.width(13),
              Image.asset(
                AppImages.shareIcon,
                height: 16,
                width: 18,
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  AppRoutes.pushCupertinoNavigation(ViewPostScreen(
                    currentIndex: widget.index,
                    feedsModel: widget.feedsModel,
                  ));
                },
                child: customText(
                  title: 'Show more',
                  color: AppColor.darkAppColor,
                  fontFamily: FontFamily.interMedium,
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                ),
              )
            ],
          ),
        );
      }
    );
  }

  currentLikeAndCountWidget() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            'assets/dummay/profile.png',
            height: 17,
            width: 17,
          ),
          ScreenSize.width(6.5),
          const Expanded(
            child: Text.rich(TextSpan(
                text: 'Liked by ',
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: AppColor.blackColor,
                    fontFamily: FontFamily.interRegular),
                children: [
                  TextSpan(
                      text: 'caring_love ',
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: AppColor.blackColor,
                          fontFamily: FontFamily.interSemiBold),
                      children: [
                        TextSpan(
                            text: 'and ',
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                                color: AppColor.blackColor,
                                fontFamily: FontFamily.interRegular),
                            children: [
                              TextSpan(
                                  text: '44,686 others',
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                      color: AppColor.blackColor,
                                      fontFamily: FontFamily.interSemiBold))
                            ])
                      ])
                ])),
          )
        ],
      ),
    );
  }

  commentWidget() {
    var model = widget.feedsModel!.data!.feeds![widget.index];
    return Consumer<HomeProvider>(
      builder: (context,myProvider,child) {
        return Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text.rich(TextSpan(
                  text: 'joshua_l  ',
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: AppColor.blackColor,
                      fontFamily: FontFamily.interBold),
                  children: [
                    TextSpan(
                        text:
                            'The game in Japan was amazing and I want to share some photos',
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: AppColor.blackColor,
                            fontFamily: FontFamily.interMedium))
                  ])),
              ScreenSize.height(5),
              InkWell(
                onTap: (){
                  myProvider.clearController();
                  myProvider.commentApiFunction(groupId: model.groupId, sheetId: model.sheetId, sheetDataId: model.sheetDataId);
                  commentBottomSheet(groupId: model.groupId,sheetDataId: model.sheetDataId,sheetId: model.sheetId).then((val){
                    myProvider.clearPages();
                    myProvider.feedsApiFunction();
                  });
                  
                },
                child: SizedBox(
                  height: 20,
                  width: double.infinity,
                  child: customText(
                    title: 'View all ${model.commentCount??"0"} comments',
                    fontSize: 13,
                    color: const Color(0xff706F6F),
                    fontWeight: FontWeight.w400,
                    fontFamily: FontFamily.interMedium,
                  ),
                ),
              )
            ],
          ),
        );
      }
    );
  }
}
