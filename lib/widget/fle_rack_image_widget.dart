
  import 'package:flutter/material.dart';
import 'package:kodago/config/app_routes.dart';
import 'package:kodago/helper/app_color.dart';
import 'package:kodago/helper/custom_text.dart';
import 'package:kodago/helper/font_family.dart';
import 'package:kodago/helper/screen_size.dart';
import 'package:kodago/helper/view_network_image.dart';
import 'package:kodago/model/file_rack/file_rack_details_model.dart';
import 'package:kodago/services/open_url_service.dart';
import 'package:kodago/services/provider/file_rack/file_rack_details_provider.dart';
import 'package:kodago/uitls/my_sperator.dart';
import 'package:kodago/widget/view_image.dart';
import 'package:kodago/widget/view_video.dart';

fileRackImagesWidget(int index, FileRackDetailsModel  model,{bool isFileRack=false}) {
    var fileModel =model.data!.sheetData!.dbdata![0].data![index];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:  EdgeInsets.symmetric(horizontal:isFileRack?11: 18),
          child: customText(
            title: fileModel.fieldName,
            fontSize: 12.5,
            fontWeight: FontWeight.w400,
            color:isFileRack?AppColor.blackColor: AppColor.grey6AColor,
            fontFamily:isFileRack?FontFamily.interRegular: FontFamily.interMedium,
          ),
        ),
        ScreenSize.height(9),
        fileModel.fieldName.toString().toLowerCase() == 'signature'
            ? ViewNetworkImage(
                img: fileModel.fullURL,
                // height: 150.0,
                // width: 150.0,
              )
            :fileModel.filesData!.isEmpty?
             Padding(
               padding: const EdgeInsets.symmetric(horizontal: 18),
               child: customText(
                           title:  '---' ,
                           fontSize: 13,
                           fontWeight: FontWeight.w400,
                           color: AppColor.blackColor,
                           fontFamily: FontFamily.interMedium,
                         ),
             ):
             SizedBox(
                height: 50,
                child: ListView.separated(
                    separatorBuilder: (context, sp) {
                      return ScreenSize.width(15);
                    },
                    shrinkWrap: true,
                    padding:  EdgeInsets.symmetric(horizontal:isFileRack?11: 18),
                    itemCount: fileModel.filesData!.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, si) {
                      return GestureDetector(
                        onTap: (){
                          fileModel.fieldType.toString().toLowerCase()=='video'?
                          AppRoutes.pushCupertinoNavigation(ViewVideo(videoUrl: fileModel.filesData![si].mainUrl)):
                          fileModel.fieldType.toString().toLowerCase()=='image'?
                          AppRoutes.pushCupertinoNavigation(ViewImagesScreen(
                            imgCount: si,imgList: fileModel.filesData!,
                          )):
                          fileModel.fieldType.toString().toLowerCase()=='document'?
                          OpenUrlService.openUrl(fileModel.filesData![si].mainUrl):
                          null;
                        },
                        child: ViewNetworkImage(
                          img: fileModel.filesData![si].imageUrl,
                          height: 50.0,
                          width: 50.0,
                        ),
                      );
                    })),
                    isFileRack?Container():
           const Padding(
          padding: EdgeInsets.only(left: 18,right: 18,top: 14),
          child:  MySeparator(
            color: Color(0xffC0D0D9),
          ),
        ),
        ScreenSize.height(isFileRack?0:13),
      ],
    );
  }
