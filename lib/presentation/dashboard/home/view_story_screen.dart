import 'package:flutter/material.dart';
import 'package:kodago/helper/app_color.dart';
import 'package:kodago/helper/app_images.dart';
import 'package:kodago/helper/custom_text.dart';
import 'package:kodago/helper/font_family.dart';
import 'package:kodago/helper/screen_size.dart';
import 'package:kodago/helper/view_network_image.dart';
import 'package:kodago/services/provider/home/home_provider.dart';
import 'package:kodago/uitls/extension.dart';
import 'package:kodago/uitls/time_format.dart';
import 'package:story_view/story_view.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
class ViewStoryScreen extends StatefulWidget {
  final int index;
  ViewStoryScreen({this.index = -1});

  @override
  State<ViewStoryScreen> createState() => _ViewStoryScreenState();
}

class _ViewStoryScreenState extends State<ViewStoryScreen>
    with SingleTickerProviderStateMixin {
  final controller = StoryController();
  PageController pageController = PageController();
  VideoPlayerController? videoController;
  List<StoryItem> storyItems = [];
  int currentIndex = 0;
  int currentStoryIndex=0;
  @override
  void initState() {
    pageController = PageController(initialPage: widget.index);
    currentIndex  = widget.index;
    callInitFunction();
    super.initState();
  }

  callInitFunction() {
    final provider = Provider.of<HomeProvider>(context, listen: false);
    var model = provider.feedsModel!.data!.story!;
    storyItems.clear(); // Always clear the stories when initializing
    for (int i = 0; i < model[widget.index].stories!.length; i++) {
      if (model[widget.index].stories![i].fieldType == 'video') {
        storyItems.add(StoryItem.pageVideo(
            model[widget.index].stories![i].video![0].mainURL,
            controller: controller));
      } else if (model[widget.index].stories![i].fieldType == 'image') {
        storyItems.add(StoryItem.pageImage(
            url: model[widget.index].stories![i].image![0]['thumbURL'],
            controller: controller));
      } else {
        storyItems.add(
          StoryItem.text(
              title: model[widget.index].stories![i].text.toString(),
              backgroundColor: AppColor.storyGradientColor1),
        );
      }
    }
  }

  addNextStories(int index) {
    storyItems.clear(); // Clear old stories before adding new ones
    currentIndex = index;
    final provider = Provider.of<HomeProvider>(context, listen: false);
    var model = provider.feedsModel!.data!.story!;
    print("index....$index");
    currentStoryIndex = 0;
    for (int i = 0; i < model[index].stories!.length; i++) {
      if (model[index].stories![i].fieldType == 'video') {
        print("url....${model[index].stories![i].video![0].mainURL}");
        storyItems.add(StoryItem.pageVideo(
            model[index].stories![i].video![0].mainURL,
            controller: controller));
      } else if (model[index].stories![i].fieldType == 'image') {
        storyItems.add(StoryItem.pageImage(
            url: model[index].stories![i].image![0]['thumbURL'],
            controller: controller));
      } else {
        storyItems.add(
          StoryItem.text(
              title: model[index].stories![i].text.toString(),
              backgroundColor: AppColor.storyGradientColor1),
        );
      }
    }
    setState(() {
      
    });
  
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HomeProvider>(context);
    var model = provider.feedsModel!.data!.story!;

    return Scaffold(
      body: PageView.builder(
        controller: pageController,
        itemCount: model.length,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (val) {
        },
        itemBuilder: (context, index) {
          return Column(
            children: [
              Expanded(
                child: AnimatedBuilder(
                  animation: pageController,
                  builder: (context, child) {
                    return Stack(
                      children: [
                        
                        StoryView(
                          storyItems: storyItems,
                          controller: controller,
                          onStoryShow: (storyItem, si) {
                            currentStoryIndex = si;
                            print("Showing story index $si");
                          },
                          repeat: false, // Don't repeat the stories
                          onComplete: () {
                            if(index<model.length-1){
                               pageController.animateToPage(
                                index + 1,
                                duration: const Duration(milliseconds: 200),
                                curve: Curves.easeInOut,
                              );
                              addNextStories(index+1);
                            }
                            else{
                              print('dfbbcvb');
                              Navigator.pop(context);  
                            }
                           },
                          onVerticalSwipeComplete: (direction) {
                            if (direction == Direction.down) {
                              Navigator.pop(context);  // Close the screen on vertical swipe
                            }
                          },
                        ),
                        userDetailsWidget(),
                      ],
                    );
                  },
                ),
              ),
              commentTextField()
            ],
          );
        },
      ),
    );
  }

userDetailsWidget(){
  return Consumer<HomeProvider>(
    builder: (context,myProvider,child) {
        var model = myProvider.feedsModel!.data!.story!;
      return Padding(
        padding: const EdgeInsets.only(top: 70,left: 20,right: 15),
        child: Column(
          children: [
            Row(
              children: [
                ClipOval(
            child: ViewNetworkImage(
              img: model[currentIndex].storyImageLink,
              height: 45.0,width: 45.0,
            ),
            ),
            ScreenSize.width(10),
            customText(title: model[currentIndex].storyName.toString().capitalize(),
            fontSize: 15,fontWeight: FontWeight.w500,
            fontFamily: FontFamily.interMedium,color: AppColor.whiteColor,
            ),
            ScreenSize.width(7),
            Container(height: 6,width: 6,decoration:const BoxDecoration(
              color: AppColor.whiteColor,shape: BoxShape.circle
            ),),
            ScreenSize.width(7),
              customText(title:
              model[currentIndex].stories!.isNotEmpty?
               TimeFormat.storyDate(model[currentIndex].stories![currentStoryIndex].lastUpdate):'',
            fontSize: 14,fontWeight: FontWeight.w500,
            fontFamily: FontFamily.interRegular,color: AppColor.whiteColor,
            ),
              ],
            ),
             Align(
              alignment: Alignment.centerRight,
              child: visitRecodWidget(),
             )
          ],
        ),
      );
    }
  );
}

  commentTextField(){
    return  Container(
              height: 100,
              padding: const EdgeInsets.only(
                top: 8,left: 10,right: 10,bottom: 25
              ),
              color: AppColor.blackColor,
              child: Row(
                children: [
                  Expanded(child: textField()),
                  ScreenSize.width(16),
                  Image.asset(
                    AppImages.thumb1Icon,
                    height: 16,
                    width: 18,
                    color: AppColor.whiteColor,
                  ),
                  ScreenSize.width(16),
                  Image.asset(
                    AppImages.shareIcon,
                    height: 16,
                    width: 18,
                    color: AppColor.whiteColor,
                  ),
                ],
              ),
            );
  }

  visitRecodWidget() {
    return Container(
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
    );
  }

  textField() {
    return SizedBox(
      height: 40,
      child: TextFormField(
        style:const TextStyle(
          color: AppColor.whiteColor
        ),
        onTap: (){
          controller.pause();
        },
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
                onChanged: (val){
                  // controller.pause();
                },
      ),
    );
  }
}
