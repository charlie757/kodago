import 'package:flutter/material.dart';
import 'package:kodago/helper/app_color.dart';
import 'package:kodago/helper/app_images.dart';
import 'package:kodago/helper/custom_text.dart';
import 'package:kodago/helper/font_family.dart';
import 'package:kodago/helper/screen_size.dart';
import 'package:kodago/services/provider/home/home_provider.dart';
import 'package:story_view/story_view.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class ViewStoryScreen extends StatefulWidget {
 final int index;
   ViewStoryScreen({
    this.index=-1
  });

  @override
  State<ViewStoryScreen> createState() => _ViewStoryScreenState();
}

class _ViewStoryScreenState extends State<ViewStoryScreen> with SingleTickerProviderStateMixin {
final controller = StoryController();
  PageController pageController = PageController();
  VideoPlayerController? videoController;
List<StoryItem> storyItems = [];
  @override
  void initState() {
  callInitFunction();
    super.initState();
  }

  callInitFunction(){
     final provider = Provider.of<HomeProvider>(context,listen: false);
    var model = provider.feedsModel!.data!.story!;
    for(int i=0;i<model[widget.index].stories!.length;i++){
      if(model[widget.index].stories![i].fieldType=='video'){
storyItems.add(StoryItem.pageVideo(model[widget.index].stories![i].video![0].mainURL, controller: controller));
      }
      else if(model[widget.index].stories![i].fieldType=='image'){
        storyItems.add(StoryItem.pageImage(url: model[widget.index].stories![i].image![0]['thumbURL'], controller: controller));
      }
      storyItems.add(StoryItem.text(title: model[0].stories![i].text.toString(), backgroundColor: AppColor.storyGradientColor1),);
    }
  }


  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HomeProvider>(context);
    var model = provider.feedsModel!.data!.story!;
    // print(widget.index);
    // print("fgbfg..${model[widget.index].name}");
    return Scaffold(
         body: PageView.builder(
        controller: pageController, // Pass the pageController here
        itemCount: model.length,
        itemBuilder: (context, index) {
          // final transform = calculatePageTransform(index, currentPageValue);
          return AnimatedBuilder(
            animation: pageController,
            builder: (context,child) {
              return StoryView(
                storyItems: storyItems,
                controller: controller,
                onStoryShow: (storyItem, index) {
                  print("Story shown at index: $index");
                },
                repeat: false, // Should the stories be slid forever
                onComplete: () {
                  // Automatically move to the next page when the story is complete
                  if (index < model.length - 1) {
                        storyItems = [
                         StoryItem.text(title: model[index].storyName, backgroundColor: Colors.red),
                    StoryItem.text(title:  model[index].storyName, backgroundColor: Colors.blue),
                     ];
                    pageController.animateToPage(
                      index + 1,
                      duration: const Duration(milliseconds: 100),
                      curve: Curves.easeIn,
                    );
                  } else {
                    // Optionally handle case when there are no more pages
                    // Navigator.pop(context); // Close the screen if it’s the last page
                  }
                },
                onVerticalSwipeComplete: (direction) {
                  if (direction == Direction.down) {
                    Navigator.pop(context);
                  }
                },
                // Preferably for inline story view
              );
            }
          );
        },
      ),
   
      // body: SafeArea(
      //   child: Column(
      //     children: [
      //       Expanded(
      //           child: Stack(
      //         children: [
      //           Image.asset(
      //             'assets/dummay/story.png',
      //             width: double.infinity,
      //             fit: BoxFit.cover,
      //           ),
      //           Padding(
      //             padding: const EdgeInsets.only(top: 5),
      //             child: LinearProgressIndicator(
      //               value: .4,
      //               minHeight: 2,
      //               color: AppColor.whiteColor,
      //               backgroundColor: const Color(0xffE2E2E2).withOpacity(.7),
      //             ),
      //           ),
      //           visitRecodWidget()
      //         ],
      //       )),
      //       Container(
      //         // height: 100,
      //         padding: const EdgeInsets.only(
      //           top: 8,left: 10,right: 10,bottom: 25
      //         ),
      //         color: AppColor.blackColor,
      //         child: Row(
      //           children: [
      //             Expanded(child: commentTextField()),
      //             ScreenSize.width(16),
      //             Image.asset(
      //               AppImages.thumb1Icon,
      //               height: 16,
      //               width: 18,
      //               color: AppColor.whiteColor,
      //             ),
      //             ScreenSize.width(16),
      //             Image.asset(
      //               AppImages.shareIcon,
      //               height: 16,
      //               width: 18,
      //               color: AppColor.whiteColor,
      //             ),
      //           ],
      //         ),
      //       )
      //     ],
      //   ),
      // ),
   
    );
  }

  commentTextField() {
    return SizedBox(
      height: 40,
      child: TextFormField(
        style:const TextStyle(
          color: AppColor.whiteColor
        ),
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
            // isDense: true,
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppColor.whiteColor.withOpacity(.7),
                ),
                borderRadius: BorderRadius.circular(50)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppColor.whiteColor.withOpacity(.7),
                ),
                borderRadius: BorderRadius.circular(50)),
            hintText: 'Type a message',
            hintStyle: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: AppColor.whiteColor.withOpacity(.7),
                fontFamily: FontFamily.interRegular)),
      ),
    );
  }

  visitRecodWidget() {
    return Align(
      alignment: Alignment.topRight,
      child: Padding(
        padding: const EdgeInsets.only(top: 35, right: 10),
        child: Container(
          height: 37,
          width: 115,
          decoration: BoxDecoration(
              color: AppColor.whiteColor,
              borderRadius: BorderRadius.circular(30)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                AppImages.visitRecordIcon,
                height: 15,
                width: 15,
              ),
              ScreenSize.width(7),
              customText(
                title: 'Visit record',
                color: const Color(0xff6A88A4),
                fontWeight: FontWeight.w500,
                fontSize: 12,
                fontFamily: FontFamily.interMedium,
              )
            ],
          ),
        ),
      ),
    );
  }
}
