import 'package:flutter/material.dart';
import 'package:kodago/helper/app_color.dart';
import 'package:kodago/helper/app_images.dart';
import 'package:kodago/helper/custom_text.dart';
import 'package:kodago/helper/font_family.dart';
import 'package:kodago/helper/screen_size.dart';
import 'package:kodago/helper/view_network_image.dart';
import 'package:kodago/services/provider/common/common_provider.dart';
import 'package:kodago/services/provider/home/home_provider.dart';
import 'package:kodago/services/provider/view_feeds_provider.dart';
import 'package:kodago/uitls/my_sperator.dart';
import 'package:kodago/uitls/time_format.dart';
import 'package:kodago/widget/comment_bottomsheet.dart';
import 'package:kodago/widget/fle_rack_image_widget.dart';
import 'package:video_player/video_player.dart';
import '../../../uitls/mixins.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class ViewFeedsScreen extends StatefulWidget {
  final String groupId;
  final String sheetId;
  final String sheetDataId;
  final String sheetName;
  ViewFeedsScreen(
      {required this.groupId,
      required this.sheetDataId,
      required this.sheetId,
      required this.sheetName});

  @override
  State<ViewFeedsScreen> createState() => _ViewFeedsScreenState();
}

class _ViewFeedsScreenState extends State<ViewFeedsScreen>
    with MediaQueryScaleFactor {
  late VideoPlayerController controller;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((val) {
      callInitFunction();
    });
    super.initState();
  }

  callInitFunction() {
    final provider = Provider.of<ViewFeedsProvider>(context, listen: false);
    provider.viewSheetFeedDataApiFunction(
        groupId: widget.groupId,
        sheetId: widget.sheetId,
        sheetDataId: widget.sheetDataId);
  }

  @override
  void dispose() {
    // controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: mediaQuery,
      child: Scaffold(
          appBar: appBar(),
          body: Consumer<ViewFeedsProvider>(builder: (context, myProvider, child) {
            return SingleChildScrollView(
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
                child: myProvider.fileRackDetailsModel != null &&
                        myProvider.fileRackDetailsModel!.data != null &&
                        myProvider.fileRackDetailsModel!.data!.sheetData !=
                            null &&
                        myProvider.fileRackDetailsModel!.data!.sheetData!
                                .dbdata !=
                            null
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          userInfoHeaderWidget(myProvider),
                          ScreenSize.height(20),
                          ListView.builder(
                              itemCount: myProvider.fileRackDetailsModel!.data!
                                  .sheetData!.dbdata![0].data!.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                var fileModel = myProvider.fileRackDetailsModel!
                                    .data!.sheetData!.dbdata![0].data![index];
                                return fileModel.fieldType
                                                .toString()
                                                .toLowerCase() ==
                                            'image' ||
                                        fileModel.fieldType
                                                .toString()
                                                .toLowerCase() ==
                                            'document' ||
                                        fileModel.fieldType
                                                .toString()
                                                .toLowerCase() ==
                                            'signature' ||
                                        fileModel.fieldType
                                                .toString()
                                                .toLowerCase() ==
                                            'video'
                                    ? fileRackImagesWidget(
                                        index, myProvider.fileRackDetailsModel!)
                                    : fileRackWidget(
                                            title: fileModel.fieldName,
                                            des: fileModel.dValue.toString().isEmpty? 
                                                fileModel.fieldValue:fileModel.dValue.toString(),
                                            isRequired: false);
                              }),
                          ScreenSize.height(28),
                          GestureDetector(
                            onTap: () {
                              final homeProvider = Provider.of<CommonProvider>(
                                  context,
                                  listen: false);
                              homeProvider.clearController();
                              homeProvider.commentApiFunction(
                                  groupId: widget.groupId,
                                  sheetId: widget.sheetId,
                                  sheetDataId: widget.sheetDataId);
                              commentBottomSheet(
                                      groupId: widget.groupId,
                                      sheetId: widget.sheetId,
                                      sheetDataId: widget.sheetDataId)
                                  .then((val) {
                                    print(val);
                                myProvider.viewSheetFeedDataApiFunction(
                                    groupId: widget.groupId,
                                    sheetId: widget.sheetId,
                                    sheetDataId: widget.sheetDataId,isLoader: false);
                              });
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
                                        color:
                                            AppColor.blackColor.withOpacity(.2))
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
                                    title:
                                        '${myProvider.fileRackDetailsModel != null && myProvider.fileRackDetailsModel!.data != null && myProvider.fileRackDetailsModel!.data!.sheetData != null && myProvider.fileRackDetailsModel!.data!.sheetData!.dbdata != null && myProvider.fileRackDetailsModel!.data!.sheetData!.dbdata![0].comments != null ? myProvider.fileRackDetailsModel!.data!.sheetData!.dbdata![0].comments!.total ?? '' : ''} comments',
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
                      )
                    : Container(),
              ),
            );
          })),
    );
  }

  userInfoHeaderWidget(ViewFeedsProvider provider) {
    var feedModel = provider.fileRackDetailsModel!.data!.sheetData!.dbdata![0];
    return Padding(
      padding: const EdgeInsets.only(left: 18, right: 18),
      child: Row(
        children: [
          ClipOval(
              child: ViewNetworkImage(
            img: feedModel.imageLink,
            height: 42.0,
            width: 42.0,
          )),
          ScreenSize.width(10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              customText(
                title: feedModel.username ?? '',
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColor.blackColor,
                fontFamily: FontFamily.interBold,
              ),
              ScreenSize.height(2),
              customText(
                title: feedModel.createdAt != null
                    ? "Added on ${TimeFormat.formatDateWithoutOfT(feedModel.createdAt!)}"
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

  fileRackWidget(
      {required String title, required String des, required isRequired}) {
        print(des);
        if(title.toLowerCase()=='list')
        print(des.toString().unserialize());
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
            title: des.isEmpty ? '---' : 
             des,
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
                title: widget.sheetName,
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

  String extractLatLng(String fieldValue) {
    final latLngPattern =
        RegExp(r'latitude";s:\d+:"([^"]+)";s:9:"longitude";s:\d+:"([^"]+)"');
    final match = latLngPattern.firstMatch(fieldValue);

    if (match != null) {
      final latitude = match.group(1);
      final longitude = match.group(2);
      return 'Lat: $latitude, Lng: $longitude'; // Format the output as desired
    } else {
      return 'Coordinates not found'; // Return a default message if not found
    }
  }
}
extension PHPSerialization on String {
  Map<String, String> unserialize() {
    if (!this.startsWith('a:')) {
      throw FormatException('Invalid PHP serialized string');
    }

    // Remove the outer array indicators
    String cleaned = this.replaceFirst(RegExp(r'a:\d+:\{i:\d+;'), '');
    cleaned = cleaned.replaceFirst(RegExp(r'\}$'), '');

    // Split by ';' to get each key-value pair
    List<String> pairs = cleaned.split(';');

    Map<String, String> dataMap = {};

    // Process each pair
    for (String pair in pairs) {
      if (pair.isNotEmpty) {
        // Split by ':' to get key and value
        List<String> keyValue = pair.split(':');
        if (keyValue.length == 2) {
          String key = keyValue[0].replaceAll(RegExp(r's:\d+:|"'), '').trim();
          String value = keyValue[1].replaceAll(RegExp(r's:\d+:|"'), '').trim();
          dataMap[key] = value;
        }
      }
    }

    return dataMap;
  }
}
