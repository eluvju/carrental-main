import '../../constant.dart';
import '/backend/api_requests/api_calls.dart';
import '/flutter/flutter_icon_button.dart';
import '/flutter/flutter_theme.dart';
import '/flutter/flutter_util.dart';
import '/flutter/flutter_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'change_password_page_model.dart';
export 'change_password_page_model.dart';

class ChangePasswordPageWidget extends StatefulWidget {
  const ChangePasswordPageWidget({Key? key}) : super(key: key);

  @override
  _ChangePasswordPageWidgetState createState() =>
      _ChangePasswordPageWidgetState();
}

class _ChangePasswordPageWidgetState extends State<ChangePasswordPageWidget> {
  late ChangePasswordPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ChangePasswordPageModel());

    _model.oldPasswordController ??= TextEditingController();
    _model.oldPasswordFocusNode ??= FocusNode();

    _model.newPasswordController ??= TextEditingController();
    _model.newPasswordFocusNode ??= FocusNode();

    _model.confirmPasswordController ??= TextEditingController();
    _model.confirmPasswordFocusNode ??= FocusNode();
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
        //       'pmnplsci' /* Change Password */,
        //     ),
        //     style: FlutterTheme.of(context).titleMedium.override(
        //           fontFamily: 'Urbanist',
        //           color: FlutterTheme.of(context).primaryText,
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
          title: Text( FFLocalizations.of(context).getText(
          'pmnplsci' /* Change Password */,
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
          child: Align(
            alignment: AlignmentDirectional(0.00, 0.00),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                  child: Form(
                    key: _model.formKey,
                    autovalidateMode: AutovalidateMode.disabled,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 16.0),
                          child: TextFormField(
                            controller: _model.oldPasswordController,
                            focusNode: _model.oldPasswordFocusNode,
                            onFieldSubmitted: (_) async {
                              if (_model.formKey.currentState == null ||
                                  !_model.formKey.currentState!.validate()) {
                                return;
                              }
                            },
                            obscureText: !_model.oldPasswordVisibility,
                            decoration: InputDecoration(
                              labelText: FFLocalizations.of(context).getText(
                                'wi3e3bo4' /* Current Password */,
                              ),
                              hintStyle: FlutterTheme.of(context).bodyLarge,
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: FlutterTheme.of(context).alternatenew,
                                  width: 1.0,
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
                              suffixIcon: InkWell(
                                onTap: () => setState(
                                  () => _model.oldPasswordVisibility =
                                      !_model.oldPasswordVisibility,
                                ),
                                focusNode: FocusNode(skipTraversal: true),
                                child: Icon(
                                  _model.oldPasswordVisibility
                                      ? Icons.visibility_outlined
                                      : Icons.visibility_off_outlined,
                                  color: FlutterTheme.of(context)
                                      .alternatenew,
                                  size: 22.0,
                                ),
                              ),
                            ),
                            style: FlutterTheme.of(context).bodyLarge,
                            validator: _model.oldPasswordControllerValidator
                                .asValidator(context),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 16.0),
                          child: TextFormField(
                            controller: _model.newPasswordController,
                            focusNode: _model.newPasswordFocusNode,
                            onFieldSubmitted: (_) async {
                              if (_model.formKey.currentState == null ||
                                  !_model.formKey.currentState!.validate()) {
                                return;
                              }
                            },
                            obscureText: !_model.newPasswordVisibility,
                            decoration: InputDecoration(
                              labelText: FFLocalizations.of(context).getText(
                                'jtz7c2zs' /* New Password */,
                              ),
                              hintStyle: FlutterTheme.of(context).bodyLarge,
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: FlutterTheme.of(context).alternatenew,
                                  width: 1.0,
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
                              suffixIcon: InkWell(
                                onTap: () => setState(
                                  () => _model.newPasswordVisibility =
                                      !_model.newPasswordVisibility,
                                ),
                                focusNode: FocusNode(skipTraversal: true),
                                child: Icon(
                                  _model.newPasswordVisibility
                                      ? Icons.visibility_outlined
                                      : Icons.visibility_off_outlined,
                                  color: FlutterTheme.of(context)
                                      .alternatenew,
                                  size: 22.0,
                                ),
                              ),
                            ),
                            style: FlutterTheme.of(context).bodyLarge,
                            validator: _model.newPasswordControllerValidator
                                .asValidator(context),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 16.0),
                          child: TextFormField(
                            controller: _model.confirmPasswordController,
                            focusNode: _model.confirmPasswordFocusNode,
                            onFieldSubmitted: (_) async {
                              if (_model.formKey.currentState == null ||
                                  !_model.formKey.currentState!.validate()) {
                                return;
                              }
                            },
                            obscureText: !_model.confirmPasswordVisibility,
                            decoration: InputDecoration(
                              labelText: FFLocalizations.of(context).getText(
                                'djim67wx' /* Confirm Password */,
                              ),
                              hintStyle: FlutterTheme.of(context).bodyLarge,
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: FlutterTheme.of(context).alternatenew,
                                  width: 1.0,
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
                              suffixIcon: InkWell(
                                onTap: () => setState(
                                  () => _model.confirmPasswordVisibility =
                                      !_model.confirmPasswordVisibility,
                                ),
                                focusNode: FocusNode(skipTraversal: true),
                                child: Icon(
                                  _model.confirmPasswordVisibility
                                      ? Icons.visibility_outlined
                                      : Icons.visibility_off_outlined,
                                  color: FlutterTheme.of(context)
                                      .alternatenew,
                                  size: 22.0,
                                ),
                              ),
                            ),
                            style: FlutterTheme.of(context).bodyLarge,
                            validator: _model.confirmPasswordControllerValidator
                                .asValidator(context),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional(0.00, 0.00),
                  child: Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 16.0),
                    child: FFButtonWidget(
                      onPressed: valueOrDefault<bool>(
                                _model.oldPasswordController.text == null ||
                                    _model.oldPasswordController.text == '',
                                false,
                              ) &&
                              (_model.newPasswordController.text == null ||
                                  _model.newPasswordController.text == '') &&
                              (_model.confirmPasswordController.text == null ||
                                  _model.confirmPasswordController.text ==
                                      '') &&
                              valueOrDefault<bool>(
                                _model.newPasswordController.text ==
                                    _model.confirmPasswordController.text,
                                false,
                              )
                          ? null
                          : () async {
                              _model.changePassword =
                                  await BaseUrlGroup.changePasswordCall.call(
                                userId: FFAppState().UserId,
                                oldPassword: _model.oldPasswordController.text,
                                newPassword:
                                    _model.confirmPasswordController.text,
                              );
                              if ((_model.changePassword?.succeeded ?? true)) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      BaseUrlGroup.changePasswordCall
                                          .message(
                                            (_model.changePassword?.jsonBody ??
                                                ''),
                                          )
                                          .toString(),
                                      style: TextStyle(
                                        color: FlutterTheme.of(context)
                                            .primaryBtnText,
                                        fontSize: 18.0,
                                      ),
                                    ),
                                    duration: Duration(milliseconds: 3850),
                                    backgroundColor:
                                        FlutterTheme.of(context).secondary,
                                    action: SnackBarAction(
                                      label: 'Okay',
                                      onPressed: () async {
                                        if (Navigator.of(context).canPop()) {
                                          context.pop();
                                        }
                                        context.pushNamed('settings_page');
                                      },
                                    ),
                                  ),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      BaseUrlGroup.changePasswordCall
                                          .message(
                                            (_model.changePassword?.jsonBody ??
                                                ''),
                                          )
                                          .toString(),
                                      style: TextStyle(
                                        color: FlutterTheme.of(context)
                                            .primaryText,
                                      ),
                                    ),
                                    duration: Duration(milliseconds: 4000),
                                    backgroundColor:
                                        FlutterTheme.of(context).secondary,
                                  ),
                                );
                              }

                              setState(() {});
                            },
                      text: FFLocalizations.of(context).getText(
                        '248m3bha' /* Save Changes */,
                      ),
                      options: FFButtonOptions(
                        width: double.infinity,
                        height: 52.0,
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                        iconPadding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                        color: FlutterTheme.of(context).btnclr,
                        // color: Color(0xff1D1415),
                        textStyle:
                            FlutterTheme.of(context).titleSmall.override(
                                  fontFamily: 'Urbanist',
                                  color: Colors.white,
                                ),
                        elevation: 3.0,
                        borderRadius: BorderRadius.circular(10.0),
                        disabledColor: FlutterTheme.of(context).accent3,
                      ),
                    ),
                  ),
                ),
              ].addToStart(SizedBox(height: 20.0)),
            ),
          ),
        ),
      ),
    );
  }
}
