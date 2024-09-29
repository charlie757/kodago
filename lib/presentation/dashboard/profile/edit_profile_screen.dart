import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kodago/helper/custom_btn.dart';
import 'package:kodago/helper/custom_textfield.dart';
import 'package:kodago/helper/screen_size.dart';
import 'package:kodago/helper/textfield_lebal_text.dart';
import 'package:kodago/services/provider/profile_provider.dart';
import 'package:kodago/uitls/utils.dart';
import 'package:kodago/uitls/white_space_formatter.dart';
import 'package:kodago/widget/appBar_leading.dart';
import 'package:provider/provider.dart';
import '../../../uitls/mixins.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen>
    with MediaQueryScaleFactor {
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    callInitFunction();
    super.initState();
  }

  callInitFunction() async {
    final provider = Provider.of<ProfileProvider>(context, listen: false);
    provider.setControllersValues();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(builder: (context, myProvider, child) {
      return MediaQuery(
        data: mediaQuery,
        child: Scaffold(
            appBar: appBarWithLeading(title: 'Personal Information'),
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.only(left: 19, right: 20, top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextfieldLebalText(
                      title: 'Full Name',
                    ),
                    ScreenSize.height(6),
                    CustomTextField(
                      hintText: 'Enter full name',
                      controller: myProvider.nameController,
                      inputFormatters: [
                        CustomFormatter(),
                        FilteringTextInputFormatter.deny(
                            RegExp(Utils.regexToRemoveEmoji)),
                      ],
                      textInputAction: TextInputAction.next,
                      validator: (val) {
                        if (val.isEmpty) {
                          return "Enter your full name";
                        }
                      },
                    ),
                    ScreenSize.height(20),
                    TextfieldLebalText(
                      title: 'Email',
                    ),
                    ScreenSize.height(6),
                    CustomTextField(
                      hintText: 'Enter email',
                      controller: myProvider.emailController,
                      textInputAction: TextInputAction.next,
                      inputFormatters: [
                        CustomFormatter(),
                        FilteringTextInputFormatter.deny(
                            RegExp(Utils.regexToRemoveEmoji)),
                      ],
                      validator: (val) {
                        RegExp regExp = RegExp(Utils.emailPattern);
                        if (val.isEmpty) {
                          return 'Enter your email';
                        } else if (!regExp.hasMatch(val)) {
                          return "Enter valid email format";
                        }
                      },
                    ),
                    ScreenSize.height(20),
                    TextfieldLebalText(
                      title: 'Mobile no.',
                    ),
                    ScreenSize.height(6),
                    CustomTextField(
                      hintText: 'Enter mobile number',
                      controller: myProvider.mobileController,
                      textInputType: TextInputType.phone,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(10)
                      ],
                      validator: (val) {
                        if (val.isEmpty) {
                          return "Enter your phone number";
                        } else if (val.length < 10) {
                          return "Enter valid phone number";
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.only(left: 19, right: 20, bottom: 30),
              child: CustomBtn(
                  title: 'Save',
                  isLoading: myProvider.isLoading,
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      myProvider.isLoading
                          ? null
                          : myProvider.updateProfileApiFunction(false);
                    }
                  }),
            )),
      );
    });
  }
}
