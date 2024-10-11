import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:confetti/confetti.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:kodago/helper/font_family.dart';
import 'package:kodago/helper/screen_size.dart';
import 'package:kodago/helper/view_network_image.dart';
import 'package:kodago/model/story_model.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:story_view/controller/story_controller.dart';
import 'package:story_view/story_view.dart';
import 'package:video_player/video_player.dart';

class StoryScreen extends StatefulWidget {
  final List<dynamic> list;

  const StoryScreen(this.list, {super.key});

  @override
  _StoryScreenState createState() => _StoryScreenState();
}

class _StoryScreenState extends State<StoryScreen>
    with SingleTickerProviderStateMixin {
  late PageController _pageController;
  late AnimationController _animController;
  VideoPlayerController? _videoController;
  int _currentIndex = 0;
  final controller = StoryController();
  late ConfettiController animation;
  double progress = 0;

  // Track if the PDF was downloaded here.
  bool didDownloadPDF = false;

  // Show the progress status to the user.
  String progressString = 'File has not been downloaded yet.';

  @override
  void initState() {
    super.initState();
    animation = ConfettiController(duration: const Duration(seconds: 1));
    _pageController = PageController();
    checkVideo();
    _animController = AnimationController(vsync: this);
    final Story firstStory = widget.list.first;
    _loadStory(story: firstStory, animateToPage: false);

    _animController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animController.stop();
        _animController.reset();
        setState(() {
          if (_currentIndex + 1 < widget.list.length) {
            _currentIndex += 1;
            _loadStory(story: widget.list[_currentIndex]);
          } else {
            _currentIndex = 0;
            _loadStory(story: widget.list[_currentIndex]);
            Navigator.pop(context);
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _animController.dispose();
   _videoController!=null?  _videoController!.dispose():null;
    super.dispose();
  }

  checkVideo() async {
    for (int i = 0; i < widget.list.length; i++) {
      final Story story = widget.list[i];
      if (story.fieldType == 'video') {
        _videoController =
            VideoPlayerController.network(story.video![0].mainUrl)
              ..initialize().then((_) {
                // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
                setState(() {});
                _videoController!.play();
              });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final Story story = widget.list[_currentIndex];
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light
        //color set to transperent or set your own color
        ));
    return WillPopScope(
      onWillPop: () async {
        _videoController!.pause();
        return true;
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: const Color(0xFF606060),
        body: GestureDetector(
          onTapDown: (details) => _onTapDown(details, story),
          child: Stack(
            children: <Widget>[
              PageView.builder(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: widget.list.length,
                onPageChanged: (val) {
                  print(val);
                  final Story story = widget.list[val];
                  if (story.fieldType == 'video') {
                    _videoController =
                        VideoPlayerController.network(story.video![0].mainUrl)
                          ..initialize().then((_) {
                            // Enure the first frame is shown after the video is initialized, even before the play button has been pressed.
                            setState(() {});
                            _videoController!.play();
                          });
                  } else {
                    _videoController!.pause();
                  }
                },
                itemBuilder: (context, i) {
                  final Story story = widget.list[i];
                  return Stack(
                    children: [
                      Positioned(
                        top: 40.0,
                        left: 10.0,
                        right: 10.0,
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: widget.list
                                  .asMap()
                                  .map((i, e) {
                                    return MapEntry(
                                      i,
                                      AnimatedBar(
                                        animController: _animController,
                                        position: i,
                                        currentIndex: _currentIndex,
                                      ),
                                    );
                                  })
                                  .values
                                  .toList(),
                            ),
                            Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 1.5,
                                  vertical: 15.0,
                                ),
                                child: userData(
                                    story.imageLink.toString(),
                                    story.name.toString(),
                                    story.dateText.toString())),
                          ],
                        ),
                      ),
                      Container(
                          child: story.fieldType == 'image'
                              ? Center(
                                  child: CachedNetworkImage(
                                  imageUrl: story.image![0].mainUrl.toString(),
                                  fit: BoxFit.fitHeight,
                                ))
                              : story.fieldType == 'signature'
                                  ? Center(
                                      child: CachedNetworkImage(
                                      imageUrl: story.signature.toString(),
                                      width: MediaQuery.of(context).size.width -
                                          50,
                                    ))
                                  : story.fieldType == 'document'
                                      ? Center(
                                          child: CachedNetworkImage(
                                          imageUrl: story.document![0].thumbUrl
                                              .toString(),
                                          fit: BoxFit.fitHeight,
                                          width: 200,
                                          height: 200,
                                        ))
                                      : story.fieldType == 'video'
                                          ? Center(
                                              child: _videoController!
                                                      .value.isInitialized
                                                  ? Container(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 0),
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height -
                                                              200,
                                                      width: double.infinity,
                                                      child: AspectRatio(
                                                        aspectRatio:
                                                            _videoController!
                                                                .value
                                                                .aspectRatio,
                                                        child: VideoPlayer(
                                                            _videoController!),
                                                      ),
                                                    )
                                                  : Container(),
                                            )
                                          : story.fieldType == 'text'
                                              ? textTypeUi("", story.fieldName,
                                                  story.text)
                              : story.fieldType == 'userlist'
                              ? textTypeUi("", story.fieldName,
                              story.text)
                                              : story.fieldType == 'date'
                                                  ? textTypeUi(
                                                      "",
                                                      story.fieldName,
                                                      story.text)
                                                  : story.fieldType ==
                                                          'dropdown'
                                                      ? textTypeUi(
                                                          story.fieldType,
                                                          story.fieldName,
                                                          story.text)
                                                      : story.fieldType ==
                                                              'DFOFR'
                                                          ? textTypeUi(
                                                              story.fieldType,
                                                              story.fieldName,
                                                              story.text)
                                                          : const SizedBox()),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 6, right: 6, bottom: 8),
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                    behavior: HitTestBehavior.opaque,
                                    onTap: () {
                                      _videoController!.pause();
                                      // Get.toNamed(
                                      //   AppRoutes.groupDetails,
                                      //   arguments: story.groupId,
                                      // )?.then((value) {
                                      //   _videoController!.play();
                                      // });
                                    },
                                    child: SizedBox(
                                      height: 25,
                                      child: Text(story.groupName,
                                          style:const  TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontFamily: FontFamily.interMedium,
                                          )),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 3,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      _videoController!.pause();
                                      // Get.toNamed(AppRoutes.fileRacksDetails,
                                      //     arguments: [
                                      //       story.name,
                                      //       story.groupId,
                                      //       story.sheetId,
                                      //       "",
                                      //     ])?.then((value) {
                                      //   _videoController!.play();
                                      // });
                                    },
                                    child: Text(story.sheetName,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontFamily: FontFamily.interRegular,
                                        )),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              story.fieldType == 'document'
                                  ? Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 10, top: 10),
                                          child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              child: InkWell(
                                                onTap: () {
                                                  _videoController!.pause();
                                                  // Get.toNamed(
                                                  //     AppRoutes
                                                  //         .fileRacksDetails,
                                                  //     arguments: [
                                                  //       story.name,
                                                  //       story.groupId,
                                                  //       story.sheetId,
                                                  //       story.sheetDataId,
                                                  //     ])?.then((value) {
                                                  //   _videoController!.play();
                                                  // });
                                                },
                                                child: const SizedBox(
                                                  height: 30,
                                                  width: 30,
                                                  child: Icon(
                                                    Icons.info,
                                                    size: 30,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              )),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 10, top: 10),
                                          child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              child: InkWell(
                                                onTap: () async {
                                                  String dir =
                                                      (await getApplicationDocumentsDirectory())
                                                          .path;
                                                  download(
                                                      Dio(),
                                                      //  model.filesData[index].mainUrl,
                                                      story.document![0].mainUrl
                                                          .toString(),
                                                      Platform.isAndroid
                                                          ? '/storage/emulated/0/Download/${story.document![0].fileName}'
                                                          : dir +
                                                              story.document![0]
                                                                  .fileName
                                                                  .toString());
                                                },
                                                child: const SizedBox(
                                                  height: 30,
                                                  width: 30,
                                                  child: Icon(
                                                    Icons
                                                        .arrow_circle_down_sharp,
                                                    size: 30,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              )),
                                        )
                                      ],
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.only(
                                          right: 10, top: 10),
                                      child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          child: InkWell(
                                            onTap: () {
                                              _videoController!.pause();
                                              // Get.toNamed(
                                              //     AppRoutes.fileRacksDetails,
                                              //     arguments: [
                                              //       story.name,
                                              //       story.groupId,
                                              //       story.sheetId,
                                              //       story.sheetDataId,
                                              //     ])?.then((value) {
                                              //   _videoController!.play();
                                              // });
                                            },
                                            child: const SizedBox(
                                              height: 30,
                                              width: 30,
                                              child: Icon(
                                                Icons.info,
                                                size: 30,
                                                color: Colors.white,
                                              ),
                                            ),
                                          )),
                                    ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onTapDown(TapDownDetails details, Story story) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double dx = details.globalPosition.dx;
    if (dx < screenWidth / 3) {
      setState(() {
        if (_currentIndex - 1 >= 0) {
          _currentIndex -= 1;
          _loadStory(story: widget.list[_currentIndex]);
        }
      });
    } else if (dx > 2 * screenWidth / 3) {
      setState(() {
        if (_currentIndex + 1 < widget.list.length) {
          _currentIndex += 1;
          _loadStory(story: widget.list[_currentIndex]);
        } else {
          // Out of bounds - loop story
          // You can also Navigator.of(context).pop() here
          _currentIndex = 0;
          _loadStory(story: widget.list[_currentIndex]);
        }
      });
    }
    if (story.fieldType == 'video') {
      if (_videoController!.value.isPlaying) {
        _videoController!.pause();
        _animController.stop();
      } else {
        _videoController!.play();
        _animController.forward();
      }
    }
  }

  void _loadStory({required Story story, bool animateToPage = true}) {
    _animController.stop();
    _animController.reset();
    switch (story.fieldType) {
      case 'image':
        _animController.duration = const Duration(seconds: 5);
        _animController.forward();
        break;
      case 'text':
        _animController.duration = const Duration(seconds: 5);
        _animController.forward();
        break;
      case 'signature':
        _animController.duration = const Duration(seconds: 5);
        _animController.forward();
        break;
      case 'document':
        _animController.duration = const Duration(seconds: 5);
        _animController.forward();
        break;
      case 'date':
        _animController.duration = const Duration(seconds: 5);
        _animController.forward();
        break;
      case 'DFOFR':
        _animController.duration = const Duration(seconds: 5);
        _animController.forward();
        break;
      case 'dropdown':
        _animController.duration = const Duration(seconds: 5);
        _animController.forward();
        break;
      case 'userlist':
        _animController.duration = const Duration(seconds: 5);
        _animController.forward();
        break;
      case 'video':
        _videoController = null;
        _videoController?.dispose();
        _videoController =
            VideoPlayerController.network(story.video![0].mainUrl)
              ..initialize().then((_) {
                setState(() {});
                if (_videoController!.value.isInitialized) {
                  _animController.duration = _videoController!.value.duration;
                  _videoController!.play();
                  _animController.forward();
                }
              });
        break;
    }
    if (animateToPage) {
      _pageController.animateToPage(
        _currentIndex,
        duration: const Duration(milliseconds: 1),
        curve: Curves.easeInOut,
      );
    }

    /* if (story.fieldType == 'image' ||
        story.fieldType == 'signature' ||
        story.fieldType == 'document' ||
        story.fieldType == 'date' ||
        story.fieldType == 'DFOFR' ||
        story.fieldType == 'dropdown'||story.fieldType == 'video') {
      _animController.duration = const Duration(seconds: 5);
      _animController.forward();
    }
    if (animateToPage) {
      _pageController.animateToPage(
        _currentIndex,
        duration: const Duration(milliseconds: 1),
        curve: Curves.easeInOut,
      );
    }*/
  }

  Widget userData(String image, String name, String date) {
    return Row(
      children: [
        ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: ViewNetworkImage(img: image, height: 40.0, width: 40.0)),
        ScreenSize.width(10),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontFamily: FontFamily.interRegular,
                  )),
              Text(date,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontFamily: FontFamily.interRegular,
                  )),
            ],
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(width: 2.0, color: Colors.white),
              borderRadius: const BorderRadius.all(Radius.circular(
                      100.0) //                 <--- border radius here
                  ),
            ),
            child: Container(
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: const Icon(
                    Icons.close,
                    color: Colors.white,
                  )),
            ),
          ),
        ),
      ],
    );
  }

  Widget textTypeUi(
    String fieldType,
    String fieldName,
    String text,
  ) {
    return Stack(
      children: [
        Positioned(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Column(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(5),
                            topRight: Radius.circular(5)),
                        color: Color(0xFF0296f8),
                      ),
                      width: MediaQuery.of(context).size.width / 1.8,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 15),
                      child: Text(
                        fieldName,
                        textAlign: TextAlign.center,
                        maxLines: 10,
                        // Truncate the text with an ellipsis
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            fontFamily: FontFamily.interRegular,
                            color: Colors.white),
                      ),
                    ),
                    fieldType == "DFOFR"
                        ? Container(
                            width: MediaQuery.of(context).size.width / 1.8,
                            decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(5),
                                    bottomRight: Radius.circular(5)),
                                color: Colors.white),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 0, vertical: 20),
                            child: Center(
                                child: Html(
                              style: {
                                'html': Style(
                                    textAlign: TextAlign.center, maxLines: 10),
                              },
                              data: text.toString(),
                            )),
                          )
                        : Container(
                            width: MediaQuery.of(context).size.width / 1.8,
                            decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(5),
                                    bottomRight: Radius.circular(5)),
                                color: Colors.white),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 0, vertical: 20),
                            child: Text(
                              text,
                              maxLines: 10, textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              // Truncate the text with an ellipsis
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: FontFamily.interRegular,
                                  color: Colors.black),
                            ),
                          )
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Future download(Dio dio, String url, String savePath) async {
    await Permission.manageExternalStorage.request();
    try {
      // successSnackBar('downloading please wait', Get.context!, 20);
      final response = await dio.get(
        url,
        onReceiveProgress: updateProgress,
        options: Options(
            responseType: ResponseType.bytes,
            followRedirects: false,
            validateStatus: (status) {
              return status! < 500;
            }),
      );
      var file = File(savePath).openSync(mode: FileMode.write);
      file.writeFromSync(response.data);
      // openfile(url: file.path, filename: 'filename');
      OpenFile.open(file.path);
      await file.close();
    } catch (e) {
      print(e);
    }
  }

  void updateProgress(done, total) {
    progress = done / total;
    if (progress >= 1) {
      progressString = '✅ File has finished downloading. Try opening the file.';
      // successSnackBar(progressString, Get.context!, 20);
      didDownloadPDF = true;
    } else {
      progressString =
          'Download progress: ${(progress * 100).toStringAsFixed(0)}% done.';
    }
    print(progressString);
  }
}

class AnimatedBar extends StatelessWidget {
  final AnimationController animController;
  final int position;
  final int currentIndex;

  const AnimatedBar({
    Key? key,
    required this.animController,
    required this.position,
    required this.currentIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 1.5),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Stack(
              children: <Widget>[
                _buildContainer(
                  double.infinity,
                  position < currentIndex
                      ? Colors.white
                      : Colors.white.withOpacity(0.5),
                ),
                position == currentIndex
                    ? AnimatedBuilder(
                        animation: animController,
                        builder: (context, child) {
                          return _buildContainer(
                            constraints.maxWidth * animController.value,
                            Colors.white,
                          );
                        },
                      )
                    : const SizedBox.shrink(),
              ],
            );
          },
        ),
      ),
    );
  }

  Container _buildContainer(double width, Color color) {
    return Container(
      height: 2.5,
      width: width,
      decoration: BoxDecoration(
        color: color,
        border: Border.all(
          color: Colors.black26,
          width: 0.8,
        ),
        borderRadius: BorderRadius.circular(3.0),
      ),
    );
  }
}
