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
import 'package:kodago/widget/comment_bottomsheet.dart';
import 'package:video_player/video_player.dart';

// ignore: must_be_immutable
class HomePostsWidget extends StatelessWidget {
  int index;
  FeedsModel? feedsModel;
  HomePostsWidget({required this.index, this.feedsModel});

  late VideoPlayerController controller;
  @override
  Widget build(BuildContext context) {
    var model = feedsModel!.data!.feeds![index];
    if (model.fieldType == 'video') {
      controller =
          VideoPlayerController.networkUrl(Uri.parse(model.video![0].mainURL))
            ..initialize().then((_) {
              controller.play();
              // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
            });
    }
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
            : model.fieldType == 'video'
                ? AspectRatio(
                    aspectRatio: controller.value.aspectRatio,
                    child: VideoPlayer(controller),
                  )
                : Image.asset('assets/dummay/Rectangle.png'),
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
    var model = feedsModel!.data!.feeds![index];
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
              commentBottomSheet();
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
              AppRoutes.pushCupertinoNavigation(const ViewPostScreen());
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
          customText(
            title: 'View all 152 comments',
            fontSize: 13,
            color: const Color(0xff706F6F),
            fontWeight: FontWeight.w400,
            fontFamily: FontFamily.interMedium,
          )
        ],
      ),
    );
  }
}
