import 'dart:convert';
import 'dart:io';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart'as http;
import '../../constant.dart';
import '../../model/edit_profile_model.dart';
import '../../model/profile_model.dart';
import '/backend/api_requests/api_calls.dart';
import '/flutter/flutter_icon_button.dart';
import '/flutter/flutter_theme.dart';
import '/flutter/flutter_util.dart';
import '/flutter/flutter_widgets.dart';
import '/flutter/upload_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'edit_profile_model.dart';
export 'edit_profile_model.dart';

class EditProfileWidget extends StatefulWidget {
  const EditProfileWidget({Key? key}) : super(key: key);

  @override
  _EditProfileWidgetState createState() => _EditProfileWidgetState();
}

class _EditProfileWidgetState extends State<EditProfileWidget> {
  late EditProfileModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController email_controller=TextEditingController();
  TextEditingController full_name=TextEditingController();
  TextEditingController phone_number=TextEditingController();
  File? _image;
  String imagesource = "";
  final _picker = ImagePicker();
  UserProfileModel?_userProfileModel;
  bool _hasData = true;
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EditProfileModel());
    Helper.checkInternet(userdetailsApi());

    _model.fullNameFocusNode ??= FocusNode();

    _model.emailFocusNode ??= FocusNode();

    _model.phoneNumberFocusNode ??= FocusNode();
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isiOS) {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarBrightness: Theme.of(context).brightness,
          systemStatusBarContrastEnforced: true,
        ),
      );
    }

    context.watch<FFAppState>();

    return FutureBuilder<ApiCallResponse>(
      future: BaseUrlGroup.getProfileCall.call(
        userId: FFAppState().UserId,
      ),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: FlutterTheme.of(context).secondaryBackground,
            body: Center(
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(8.0, 8.0, 8.0, 8.0),
                child: SizedBox(
                  width: 40.0,
                  height: 40.0,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      FlutterTheme.of(context).secondary,
                    ),
                  ),
                ),
              ),
            ),
          );
        }
        final editProfileGetProfileResponse = snapshot.data!;
        return GestureDetector(
          onTap: () => _model.unfocusNode.canRequestFocus
              ? FocusScope.of(context).requestFocus(_model.unfocusNode)
              : FocusScope.of(context).unfocus(),
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: FlutterTheme.of(context).secondaryBackground,
            // appBar: AppBar(
            //   backgroundColor: FlutterTheme.of(context).secondaryBackground,
            //   automaticallyImplyLeading: false,
            //   leading: FlutterIconButton(
            //     borderColor: Colors.transparent,
            //     borderRadius: 30.0,
            //     borderWidth: 1.0,
            //     buttonSize: 60.0,
            //     icon: Icon(
            //       Icons.arrow_back,
            //       color: FlutterTheme.of(context).primaryText,
            //       size: 30.0,
            //     ),
            //     onPressed: () async {
            //       context.pop();
            //     },
            //   ),
            //   title: Text(
            //     FFLocalizations.of(context).getText(
            //       'i4u53ivf' /* Edit Page */,
            //     ),
            //     style: FlutterTheme.of(context).headlineMedium.override(
            //           fontFamily: 'Urbanist',
            //           color: FlutterTheme.of(context).primaryText,
            //           fontSize: 22.0,
            //         ),
            //   ),
            //   actions: [],
            //   centerTitle: true,
            //   elevation: 2.0,
            // ),
            appBar: AppBar(
              backgroundColor: FlutterTheme.of(context).secondaryBackground,
              automaticallyImplyLeading: false,
              leading: InkWell(
                onTap: () {
                  Helper.popScreen(context);
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0,top: 15,right: 0,bottom: 10),
                  child: Image.asset('assets/images/back_icon_with_bg.png',height: 30,width: 30,),
                ),
              ),
              title: Text(   FFLocalizations.of(context).getText(
                'i4u53ivf' /* Edit Page */,
              ),
                style: FlutterTheme.of(context).headlineMedium.override(
                    fontFamily: 'Urbanist',
                    color: FlutterTheme.of(context).primaryText,
                    fontSize: 18.0,fontWeight: FontWeight.w600
                ),
              ),
              actions: [],
              centerTitle: false,
              // elevation: 2.0,
            ),
            body: SafeArea(
              top: true,
              child:
              Stack(
                children: [
                  _userProfileModel==null
                      ? _hasData
                      ? Container()
                      : Container(
                    child: Center(
                      child: Text("NO DATA"),
                    ),
                  ):
                  SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // InkWell(
                        //   splashColor: Colors.transparent,
                        //   focusColor: Colors.transparent,
                        //   hoverColor: Colors.transparent,
                        //   highlightColor: Colors.transparent,
                        //   onTap: () async {
                        //     final selectedMedia =
                        //         await selectMediaWithSourceBottomSheet(
                        //       context: context,
                        //       imageQuality: 100,
                        //       allowPhoto: true,
                        //       backgroundColor:
                        //           FlutterTheme.of(context).customColor1,
                        //       textColor: Color(0xFF5C47A8),
                        //     );
                        //     if (selectedMedia != null &&
                        //         selectedMedia.every((m) =>
                        //             validateFileFormat(m.storagePath, context))) {
                        //       setState(() => _model.isDataUploading = true);
                        //       var selectedUploadedFiles = <FFUploadedFile>[];
                        //
                        //       try {
                        //         selectedUploadedFiles = selectedMedia
                        //             .map((m) => FFUploadedFile(
                        //                   name: m.filePath,
                        //                   bytes: m.bytes,
                        //                   height: m.dimensions?.height,
                        //                   width: m.dimensions?.width,
                        //                   blurHash: m.blurHash,
                        //                 ))
                        //             .toList();
                        //       } finally {
                        //         _model.isDataUploading = false;
                        //       }
                        //       if (selectedUploadedFiles.length ==
                        //           selectedMedia.length) {
                        //         setState(() {
                        //           _model.uploadedLocalFile =
                        //               selectedUploadedFiles.first;
                        //         });
                        //       } else {
                        //         setState(() {});
                        //         return;
                        //       }
                        //     }
                        //   },
                        //   child: Container(
                        //     width: 100.0,
                        //     height: 100.0,
                        //     clipBehavior: Clip.antiAlias,
                        //     decoration: BoxDecoration(
                        //       shape: BoxShape.circle,
                        //     ),
                        //     child: Image.memory(
                        //       _model.uploadedLocalFile.bytes ??
                        //           Uint8List.fromList([]),
                        //       fit: BoxFit.cover,
                        //     ),
                        //   ),
                        // ),

                        // InkWell(
                        //   onTap: () {
                        //     _showPicker(context);
                        //   },
                        //   child:_image == null? Stack(
                        //     children: [
                        //       Container(
                        //         width: 85.0,
                        //         height: 85.0,
                        //         clipBehavior: Clip.antiAlias,
                        //         decoration: BoxDecoration(
                        //           shape: BoxShape.circle,
                        //         ),
                        //         child:imagesource!="https://www.cruzcoservices.com/cruzcoservice/image/default.jpg"? Image.network(
                        //           imagesource,
                        //           fit: BoxFit.cover,
                        //         ):Image.network(
                        //           'https://www.cruzcoservices.com/cruzcoservice/image/default.jpg',
                        //           fit: BoxFit.cover,
                        //         ),
                        //       ),
                        //       Positioned(
                        //           right: 0,
                        //           bottom:5 ,
                        //           child: Icon(Icons.camera_alt))
                        //     ],
                        //   ):
                        //   Stack(
                        //     children: [
                        //       Container(
                        //         width: 85.0,
                        //         height: 85.0,
                        //         clipBehavior: Clip.antiAlias,
                        //         decoration: BoxDecoration(
                        //           shape: BoxShape.circle,
                        //         ),
                        //         child: Image.file(
                        //           _image!,
                        //           fit: BoxFit.cover,
                        //         ),
                        //       ),
                        //       Positioned(
                        //           right: 0,
                        //           bottom:5 ,
                        //           child: Icon(Icons.camera_alt))
                        //     ],
                        //   ),
                        // ),

                        InkWell(
                          onTap: () {
                            _showPicker(context);
                          },
                          child:_image == null? Stack(
                            children: [
                              Container(
                                  width: 112.0,
                                  height: 112.0,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child:_userProfileModel!.profileData!.userProfilePic.toString()==""?Image.asset(
                                    'assets/images/default_profile_image.png',
                                    // BaseUrlGroup.getProfileCall
                                    //     .userProfileUrl(
                                    //       settingsPageGetProfileResponse
                                    //           .jsonBody,
                                    //     )
                                    //     .toString(),
                                    fit: BoxFit.cover,
                                  ):Image.network(
                                    _userProfileModel!.profileData!.userProfilePic.toString(),
                                    // BaseUrlGroup.getProfileCall
                                    //     .userProfileUrl(
                                    //       settingsPageGetProfileResponse
                                    //           .jsonBody,
                                    //     )
                                    //     .toString(),
                                    fit: BoxFit.cover,
                                  )
                              ),
                              Positioned(
                                  right: 0,
                                  bottom:5 ,
                                  child: Icon(Icons.camera_alt))
                            ],
                          ):
                          Stack(
                            children: [
                              Container(
                                width: 85.0,
                                height: 85.0,
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                child: Image.file(
                                  _image!,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                  right: 0,
                                  bottom:5 ,
                                  child: Icon(Icons.camera_alt))
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              16.0, 16.0, 16.0, 16.0),
                          child: TextFormField(
                            controller: full_name,
                            // controller: _model.fullNameController ??= TextEditingController(
                            //   text: valueOrDefault<String>(
                            //     BaseUrlGroup.getProfileCall
                            //         .contact(
                            //           editProfileGetProfileResponse.jsonBody,
                            //         )
                            //         .toString(),
                            //     '',
                            //   ),
                            // ),
                            focusNode: _model.fullNameFocusNode,
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: FFLocalizations.of(context).getText(
                                '4gks486y' /* Full Name */,
                              ),
                              hintText: FFLocalizations.of(context).getText(
                                't8xpkwki' /* Enter your full name */,
                              ),
                              hintStyle: FlutterTheme.of(context).bodyLarge,
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: FlutterTheme.of(context).primary,
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0x00000000),
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0x00000000),
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0x00000000),
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                            ),
                            style: FlutterTheme.of(context).bodyMedium,
                            validator: _model.fullNameControllerValidator
                                .asValidator(context),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              16.0, 16.0, 16.0, 16.0),
                          child: TextFormField(
                            // controller: _model.emailController ??=
                            //     TextEditingController(
                            //   text: valueOrDefault<String>(
                            //     BaseUrlGroup.getProfileCall
                            //         .email(
                            //           editProfileGetProfileResponse.jsonBody,
                            //         )
                            //         .toString(),
                            //     '',
                            //   ),
                            // ),
                            controller: email_controller,
                            focusNode: _model.emailFocusNode,
                            readOnly: true,
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: FFLocalizations.of(context).getText(
                                'tgovzoq7' /* Email Address */,
                              ),
                              hintText: FFLocalizations.of(context).getText(
                                '5mrcu7r1' /* Enter your email address */,
                              ),
                              hintStyle: FlutterTheme.of(context).bodyLarge,
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: FlutterTheme.of(context).primary,
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0x00000000),
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0x00000000),
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0x00000000),
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                            ),
                            style: FlutterTheme.of(context).bodyMedium,
                            validator: _model.emailControllerValidator
                                .asValidator(context),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              16.0, 16.0, 16.0, 16.0),
                          child: TextFormField(
                            controller: phone_number,
                            // controller: _model.phoneNumberController ??=
                            //     TextEditingController(
                            //   text: valueOrDefault<String>(
                            //     BaseUrlGroup.getProfileCall
                            //         .contact(
                            //           editProfileGetProfileResponse.jsonBody,
                            //         )
                            //         .toString(),
                            //     '',
                            //   ),
                            // ),
                            focusNode: _model.phoneNumberFocusNode,
                            obscureText: false,
                            readOnly: true,
                            decoration: InputDecoration(
                              labelText: FFLocalizations.of(context).getText(
                                'x49fyvee' /* Phone Number */,
                              ),
                              hintText: FFLocalizations.of(context).getText(
                                'bqy57d8r' /* Enter your phone number */,
                              ),
                              hintStyle: FlutterTheme.of(context).bodyLarge,
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: FlutterTheme.of(context).primary,
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0x00000000),
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0x00000000),
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0x00000000),
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                            ),
                            style: FlutterTheme.of(context).bodyMedium,
                            keyboardType: TextInputType.number,
                            validator: _model.phoneNumberControllerValidator
                                .asValidator(context),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              16.0, 16.0, 16.0, 16.0),
                          child: FFButtonWidget(
                            onPressed: () {
                              _buttonSubmit();
                            },
                            // onPressed: () async {
                            //   _model.reponseUpdateProfile =
                            //       await BaseUrlGroup.updateUserProfileCall.call(
                            //     userName: _model.fullNameController.text,
                            //     userId: FFAppState().UserId,
                            //     email: _model.emailController.text,
                            //     contact: _model.phoneNumberController.text,
                            //     image: _model.uploadedLocalFile.name,
                            //   );
                            //   if (getJsonField(
                            //     (_model.reponseUpdateProfile?.jsonBody ?? ''),
                            //     r'''$..response''',
                            //   )) {
                            //     ScaffoldMessenger.of(context).showSnackBar(
                            //       SnackBar(
                            //         content: Text(
                            //           getJsonField(
                            //             (_model.reponseUpdateProfile?.jsonBody ??
                            //                 ''),
                            //             r'''$.message''',
                            //           ).toString(),
                            //           style: TextStyle(
                            //             color: FlutterTheme.of(context)
                            //                 .primaryText,
                            //           ),
                            //         ),
                            //         duration: Duration(milliseconds: 4000),
                            //         backgroundColor:
                            //             FlutterTheme.of(context).secondary,
                            //       ),
                            //     );
                            //   } else {
                            //     ScaffoldMessenger.of(context).showSnackBar(
                            //       SnackBar(
                            //         content: Text(
                            //           getJsonField(
                            //             (_model.reponseUpdateProfile?.jsonBody ??
                            //                 ''),
                            //             r'''$.message''',
                            //           ).toString(),
                            //           style: TextStyle(
                            //             color: FlutterTheme.of(context)
                            //                 .primaryText,
                            //           ),
                            //         ),
                            //         duration: Duration(milliseconds: 4000),
                            //         backgroundColor:
                            //             FlutterTheme.of(context).secondary,
                            //       ),
                            //     );
                            //   }
                            //
                            //   setState(() {});
                            // },
                            text: FFLocalizations.of(context).getText(
                              'z5ykg1jz' /* Save Changes */,
                            ),
                            options: FFButtonOptions(
                              width: double.infinity,
                              height: 48.0,
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 0.0),
                              iconPadding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 0.0),
                              color: FlutterTheme.of(context).btnclr,
                              textStyle:
                                  FlutterTheme.of(context).titleSmall.override(
                                        fontFamily: 'Urbanist',
                                        color: Colors.white,
                                      ),
                              elevation: 3.0,
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            showLoadingIndicator: false,
                          ),
                        ),
                      ]
                          .addToStart(SizedBox(height: 10.0))
                          .addToEnd(SizedBox(height: 10.0)),
                    ),
                  ),
                  Helper.getProgressBarWhite(context, _isVisible)
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  _imgFromCamera() async {
    XFile? image = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
    );

    if (image != null) {
      CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: image.path,
        aspectRatio: CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
        compressQuality: 100,
        maxHeight: 1000,
        maxWidth: 1000,
        compressFormat: ImageCompressFormat.jpg,
      );

      setState(() {
        _image = File(croppedFile!.path);
        String path = _image.toString();
        print("path" + _image!.path);
      });
    }
  }

  _imgFromGallery() async {
    XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );


    if (image != null) {
      CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: image.path,
        aspectRatio: CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
        compressQuality: 100,
        maxHeight: 1000,
        maxWidth: 1000,
        compressFormat: ImageCompressFormat.jpg,

      );

      setState(() {

        _image = File(croppedFile!.path);
        String path = _image.toString();
        print("path" + _image!.path);


      });
    }
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  setProgress(bool show) {
    if (mounted)
      setState(() {
        _isVisible = show;
      });
  }

  Future<void> userdetailsApi() async {


    print("<=============userdetailsApi=============>${FFAppState().UserId}");

    SessionHelper session = await SessionHelper.getInstance(context);
    String userId = session.get(SessionHelper.USER_ID) ?? "0";
    setProgress(true);

    Map data = {
      'app_token':"booking12345",
      'user_id': FFAppState().UserId,
    };

    print("Request =============>" + data.toString());
    try {
      var res = await http.post(Uri.parse(Apis.profile), body: data);
      print("Response ============>" + res.body);

      if (res.statusCode == 200) {
        try {
          final jsonResponse = jsonDecode(res.body);
          UserProfileModel model = UserProfileModel.fromJson(jsonResponse);

          if (model.response == true) {
            print("Model status true");
            setProgress(false);

            setState(() {
              _userProfileModel=model;
              full_name.text = _userProfileModel!.profileData!.userName.toString() ?? "";
              phone_number.text=_userProfileModel!.profileData!.contact.toString()?? "";
              email_controller.text= _userProfileModel!.profileData!.email.toString() ?? "";
              imagesource = _userProfileModel!.profileData!.userProfilePic.toString() ?? "";
              print("======full_name.text===${full_name.text}");
              print("======phone_number.text===${phone_number.text}");
              print("======email_controller.text===${email_controller.text}");
              // last_name_controller.text= _profileModel!.data!.lastname.toString() ?? "";
              // street_controller.text = _profileModel!.data!.address.toString() ?? "";
              // zipcode_controller.text =_profileModel!.data!.zipcode.toString() ?? "";
            });

            print("successs==============");
            // ScaffoldMessenger.of(context).showSnackBar(
            //   SnackBar(
            //     content: Text(model.message.toString()),
            //   ),
            // );



            // context.pushNamed('RegisterCrozerVehicalPage');

            //  ToastMessage.msg(model.message.toString());
            // Navigator.pushAndRemoveUntil(
            //     context, MaterialPageRoute(builder: (context) => BottomNavBar()), (
            //     route) => false);



          }
          else {
            setProgress(false);
            print("false ### ============>");

            // context.pushNamed('RegisterCrozerVehicalPage');


            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(model.message.toString()),
              ),
            );
            // ToastMessage.msg(model.message.toString());
          }
        }
        catch (e) {
          print("false ============>");
          //ToastMessage.msg(StaticMessages.API_ERROR);
          print('exception ==> ' + e.toString());
        }
      } else {
        print("status code ==> " + res.statusCode.toString());
        //  ToastMessage.msg(StaticMessages.API_ERROR);
      }
    } catch (e) {
      //  ToastMessage.msg(StaticMessages.API_ERROR);
      print('Exception ======> ' + e.toString());
    }
    setProgress(false);
  }

  Future<void> editProfileApi() async {


    print("<=============edit profile=============>");

    SessionHelper session = await SessionHelper.getInstance(context);
    String userId = session.get(SessionHelper.USER_ID) ?? "0";
    setProgress(true);

    Map data = {
      'app_token':"booking12345",
      'user_id': FFAppState().UserId,
      'user_name':full_name.text.trim().toString(),
      'email':email_controller.text.trim().toString(),
       'contact':phone_number.text.toString().replaceAll(' ', ''),
      'profile_image':""
    };

    print("Request =============>" + data.toString());
    try {
      // var res = await http.post(Uri.parse(SessionHelper().get(SessionHelper.USERTYPE).toString()=="2"?Apis.Edit_Profile_Driver:Apis.Edit_Profile_User), body: data);
      var res = await http.post(Uri.parse(Apis.update_User_Profile), body: data);

      print("Response ============>" + res.body);

      if (res.statusCode == 200) {
        try {
          final jsonResponse = jsonDecode(res.body);
          EditProfileModelNew model = EditProfileModelNew.fromJson(jsonResponse);

          if (model.response == "true") {
            print("Model status true");
            SessionHelper sessionHelper = await SessionHelper.getInstance(context);
            sessionHelper.put(SessionHelper.USER_ID, model.data!.userId.toString());
            sessionHelper.put(SessionHelper.FIRSTNAME, model.data!.userName.toString());
            sessionHelper.put(SessionHelper.PHONE, model.data!.contact.toString());
            sessionHelper.put(SessionHelper.IMAGE, model.data!.image.toString());
            sessionHelper.put(SessionHelper.IMAGE, model.data!.email.toString());
            setProgress(false);

            print("successs==============");
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(model.message.toString()),
              ),
            );
            Helper.popScreen(context);
            // context.pushNamed(
            //   'ConfirmationPage',
            //   queryParameters: {
            //     'userType': serializeParam(
            //       UserRole.user,
            //       ParamType.Enum,
            //     ),
            //   }.withoutNulls,
            // ).then((_) {
            //   Navigator.popUntil(context, (route) => route.isFirst);
            // });


            // context.pushNamed('RegisterCrozerVehicalPage');

            //  ToastMessage.msg(model.message.toString());
            // Navigator.pushAndRemoveUntil(
            //     context, MaterialPageRoute(builder: (context) => BottomNavBar()), (
            //     route) => false);



          }
          else {
            setProgress(false);
            print("false ### ============>");

            // context.pushNamed('RegisterCrozerVehicalPage');


            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(model.message.toString()),
              ),
            );
            // ToastMessage.msg(model.message.toString());
          }
        }
        catch (e) {
          print("false ============>");
          //ToastMessage.msg(StaticMessages.API_ERROR);
          print('exception ==> ' + e.toString());
        }
      } else {
        print("status code ==> " + res.statusCode.toString());
        //  ToastMessage.msg(StaticMessages.API_ERROR);
      }
    } catch (e) {
      //  ToastMessage.msg(StaticMessages.API_ERROR);
      print('Exception ======> ' + e.toString());
    }
    setProgress(false);
  }
  _buttonSubmit() {
    print("=========hello1======");
    if (_image == null) {
      print("Api called without Image");
      Helper.checkInternet(editProfileApi());
    } else {
      print("Api called with Image");
      Helper.checkInternet(editProfileApiWithImagenew(_image!.path));
    }


  }
  Future<void> editProfileApiWithImagenew(filename) async {
    SessionHelper session = await SessionHelper.getInstance(context);
    String userId = session.get(SessionHelper.USER_ID) ?? "0";

    setProgress(true);
    var headers = {
      'Cookie': 'ci_session=4b771fd78a19ed32ac275394c82d01bc9afca4f2'
    };

    var request = http.MultipartRequest('POST', Uri.parse(Apis.update_User_Profile),);
    request.fields.addAll({
      'app_token':"booking12345",
      'user_id': FFAppState().UserId,
      'user_name':full_name.text.trim().toString(),
      'email':email_controller.text.trim().toString(),
      'contact':phone_number.text.toString().replaceAll(' ', ''),
    });
    request.files.add(await http.MultipartFile.fromPath('image', filename));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print("gjmklrtjh");
      setProgress(false);
      try {
        response.stream.transform(utf8.decoder).listen((value) async {
          final jsonResponse = jsonDecode(value);
          EditProfileModelNew model = EditProfileModelNew.fromJson(jsonResponse);
          print("=======response===${jsonResponse.toString()}");
          if (model.response == "true") {
            print("=======success===${filename}");
            // ToastMessage.msg("Image uploaded successfully");

            SessionHelper sessionHelper = await SessionHelper.getInstance(context);
            sessionHelper.put(SessionHelper.USER_ID, model.data!.userId.toString());
            sessionHelper.put(SessionHelper.FIRSTNAME, model.data!.userName.toString());
            sessionHelper.put(SessionHelper.PHONE, model.data!.contact.toString());
            sessionHelper.put(SessionHelper.IMAGE, model.data!.image.toString());
            sessionHelper.put(SessionHelper.IMAGE, model.data!.email.toString());



            print("successs==============");
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(model.message.toString()),
              ),
            );

            Helper.popScreen(context);

            // context.pushNamed(
            //   'ConfirmationPage',
            //   queryParameters: {
            //     'userType': serializeParam(
            //       UserRole.user,
            //       ParamType.Enum,
            //     ),
            //   }.withoutNulls,
            // ).then((_) {
            //   Navigator.popUntil(context, (route) => route.isFirst);
            // });
          }
          else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(model.message.toString()),
              ),
            );
          }
        });
      } catch (e) {
        print('exception ==> ' + e.toString());
        ToastMessage.msg(StaticMessages.API_ERROR);
      }
    } else {
      print("status code ==> " + response.statusCode.toString());
      ToastMessage.msg(StaticMessages.API_ERROR);
    }

    setProgress(false);
  }



}
