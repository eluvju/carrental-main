// import 'dart:async';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../../constant.dart';
// import '../../model/chatlistModel.dart';
// import 'package:flutter/material.dart';
// import '../../search_demo.dart';
// import '../../user/message/message_page/message_page_widget.dart';
// import '/flutter/flutter_theme.dart';
// import '/flutter/flutter_util.dart';
// import 'package:auto_size_text/auto_size_text.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:provider/provider.dart';
// import 'user_message_cell_model.dart';
// export 'user_message_cell_model.dart';
// import 'package:http/http.dart'as http;
//
// class UserMessageCellWidget extends StatefulWidget {
//   const UserMessageCellWidget({Key? key}) : super(key: key);
//
//   @override
//   UserMessageCellWidgetState createState() => UserMessageCellWidgetState();
// }
//
// class _UserMessageCellWidgetState extends State<UserMessageCellWidget> {
//   late UserMessageCellModel _model;
//   bool _isVisible = false;
//   bool _hasData = true;
//   ChatListModel?_chatListModel;
//   StreamController<QuerySnapshot> _localStreamController = StreamController.broadcast();
//   // List<Data> _filteredData = [];
//   final List<Data> items = [];
//
//   List<Data> filteredItems = [];
//   // List<Map<String, dynamic>>? items = [];
//   //
//   // List<Map<String, dynamic>>filteredItems = [];
//
//
//
//
//
//   TextEditingController _searchController = TextEditingController();
//
//   @override
//   void setState(VoidCallback callback) {
//     super.setState(callback);
//     _model.onUpdate();
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     _model = createModel(context, () => UserMessageCellModel());
//     Helper.checkInternet(chatlist_Api());
//     // filteredItems = List.from(items!);
//     // print("filteritems=====${filteredItems}");
//     // _loadData();
//     FirebaseFirestore.instance.collection("chat").doc(SessionHelper().get(SessionHelper.USER_ID)).collection("opponent").orderBy("last_message_timestamp").snapshots().listen((QuerySnapshot querySnapshot) =>
//         _localStreamController.add(querySnapshot));
//   }
//
//   @override
//   void dispose() {
//     _model.maybeDispose();
//
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return  Stack(
//       children: [
//         _chatListModel == null
//             ? _hasData
//             ? Container()
//             : Container(
//           child: Center(
//             child: Text("NO DATA"),
//           ),
//         ):
//         SingleChildScrollView(
//           child: Column(
//             children: [
//               Padding(
//                 padding: EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
//                 child: Container(
//                   // decoration: BoxDecoration(
//                   //   borderRadius: BorderRadius.circular(20)
//                   // ),
//                   width: double.infinity,
//                   child: TextFormField(
//                     onChanged: (value) {
//                       // Perform search when text changes
//                       performSearch(value);
//                     },
//                     // controller: _model.textController,
//                     // focusNode: _model.textFieldFocusNode,
//                     // autofocus: true,
//                     // autofillHints: [AutofillHints.givenName],
//                     obscureText: false,
//                     decoration: InputDecoration(
//                       border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(20)
//                       ),
//                       hintText: 'Search',
//                       hintStyle: FlutterTheme.of(context).displaySmall.override(
//                         fontFamily: FlutterTheme.of(context).displaySmallFamily,
//                         fontSize: 16,
//                         useGoogleFonts: GoogleFonts.asMap().containsKey(
//                             FlutterTheme.of(context).displaySmallFamily),
//                       ),
//
//                       labelStyle: FlutterTheme.of(context).labelMedium.override(
//                         fontFamily: 'Montserrat',
//                         useGoogleFonts: GoogleFonts.asMap().containsKey(
//                             FlutterTheme.of(context).labelMediumFamily),
//                       ),
//                       enabledBorder: OutlineInputBorder(
//                         borderSide: const BorderSide(
//                           color: Colors.transparent,
//                         ),
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderSide: const BorderSide(
//                           color: Colors.transparent,
//                         ),
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                       errorBorder:OutlineInputBorder(
//                         borderSide: const BorderSide(
//                           color: Colors.transparent,
//                         ),
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                       fillColor: Colors.grey.withOpacity(0.2),
//                       filled: true,
//                       focusedErrorBorder: InputBorder.none,
//                       contentPadding: EdgeInsets.only(left: 20),
//                       suffixIcon: Icon(
//                         Icons.search,
//                       ),
//                     ),
//                     style: FlutterTheme.of(context).displaySmall.override(
//                       fontFamily: FlutterTheme.of(context).displaySmallFamily,
//                       fontSize: 18,
//                       useGoogleFonts: GoogleFonts.asMap()
//                           .containsKey(FlutterTheme.of(context).displaySmallFamily),
//                     ),
//                     cursorColor: FlutterTheme.of(context).btnNaviBlue,
//                     // validator: _model.textControllerValidator.asValidator(context),
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               ListView.builder(
//                   scrollDirection: Axis.vertical,
//                   physics: NeverScrollableScrollPhysics(),
//                   shrinkWrap: true,
//                   itemCount:filteredItems.isEmpty?_chatListModel!.data!.length: filteredItems.length,
//                   itemBuilder: (BuildContext context, int index) {
//                     print("_chatListModel!.data!.length===${_chatListModel!.data!.length}");
//                     return
//                       InkWell(
//                         onTap: () {
//                           Helper.moveToScreenwithPush(context, MessagePageWidget(user_id: _chatListModel!.data![index].userId.toString(),
//                             name: chatListModel!.data![index].userName.toString(), image: chatListModel!.data![index].profileImage.toString(),));
//                         },
//                         child:Container(
//                           width: double.infinity,
//                           height: 121.0,
//                           margin: EdgeInsets.only(bottom: 10),
//                           decoration: BoxDecoration(
//                             color: FlutterTheme.of(context).secondaryBackground,
//                             boxShadow: [
//                               BoxShadow(
//                                 blurRadius: 6.0,
//                                 color: Color(0x131C2340),
//                                 offset: Offset(0.0, 4.0),
//                               )
//                             ],
//                             borderRadius: BorderRadius.circular(20.0),
//                             border: Border.all(
//                               color: FlutterTheme.of(context).textColorbg,
//                               width: 1.0,
//                             ),
//                           ),
//                           child: Padding(
//                             padding: EdgeInsets.all(24.0),
//                             child: Row(
//                               mainAxisSize: MainAxisSize.max,
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: [
//                                 Container(
//                                   width: 45.0,
//                                   height: 45.0,
//                                   clipBehavior: Clip.antiAlias,
//                                   decoration: BoxDecoration(
//                                     shape: BoxShape.circle,
//                                   ),
//                                   child: Image.network(
//                                     filteredItems.isEmpty?_chatListModel!.data![index].profileImage.toString(): filteredItems[index].profileImage.toString(),
//                                     fit: BoxFit.cover,
//                                   ),
//                                 ),
//                                 Expanded(
//                                   child: Column(
//                                     mainAxisSize: MainAxisSize.max,
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     crossAxisAlignment: CrossAxisAlignment.stretch,
//                                     children: [
//                                       Text(
//                                         filteredItems.isEmpty?_chatListModel!.data![index].userName.toString():filteredItems[index].userName.toString(),
//                                         style: FlutterTheme.of(context).headlineLarge.override(
//                                           fontFamily: 'Montserrat',
//                                           color: FlutterTheme.of(context).btnNaviBlue,
//                                           fontSize: 16.0,
//                                           fontWeight: FontWeight.bold,
//                                           useGoogleFonts: GoogleFonts.asMap().containsKey(
//                                               FlutterTheme.of(context).headlineLargeFamily),
//                                         ),
//                                       ),
//                                       Row(
//                                         children: [
//                                           Text(
//                                             "Vehicle Type:-",
//                                             style: FlutterTheme.of(context).headlineLarge.override(
//                                               fontFamily: 'Montserrat',
//                                               color: FlutterTheme.of(context).btnNaviBlue,
//                                               fontSize: 14.0,
//                                               fontWeight: FontWeight.w300,
//                                               useGoogleFonts: GoogleFonts.asMap().containsKey(
//                                                   FlutterTheme.of(context).headlineLargeFamily),
//                                             ),
//                                           ),
//                                           Flexible(
//                                             flex: 1,
//                                             child: AutoSizeText(
//                                               filteredItems.isEmpty?_chatListModel!.data![index].vehicleType.toString():filteredItems[index].vehicleType.toString(),
//                                               style:
//                                               FlutterTheme.of(context).headlineLarge.override(
//                                                 fontFamily: 'Montserrat',
//                                                 color: FlutterTheme.of(context).liteRoad,
//                                                 fontSize: 14.0,
//                                                 fontWeight: FontWeight.w500,
//                                                 useGoogleFonts: GoogleFonts.asMap().containsKey(
//                                                     FlutterTheme.of(context)
//                                                         .headlineLargeFamily),
//                                               ),
//                                               minFontSize: 12.0,
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 // Text(
//                                 //   _chatListModel!.data![index].vehicleType.toString(),
//                                 //   textAlign: TextAlign.end,
//                                 //   style: FlutterTheme.of(context).headlineLarge.override(
//                                 //     fontFamily: 'Montserrat',
//                                 //     color: FlutterTheme.of(context).liteRoad,
//                                 //     fontSize: 14.0,
//                                 //     fontWeight: FontWeight.bold,
//                                 //     useGoogleFonts: GoogleFonts.asMap().containsKey(
//                                 //         FlutterTheme.of(context).headlineLargeFamily),
//                                 //   ),
//                                 // ),
//                               ].divide(SizedBox(width: 10.0)),
//                             ),
//                           ),
//                         ),
//                       );
//                   }),
//               // ListView.builder(
//               //     scrollDirection: Axis.vertical,
//               //     physics: NeverScrollableScrollPhysics(),
//               //     shrinkWrap: true,
//               //     itemCount:_chatListModel!.data!.length,
//               //     itemBuilder: (BuildContext context, int index) {
//               //       return
//               //         InkWell(
//               //         onTap: () {
//               //           Helper.moveToScreenwithPush(context, MessagePageWidget(user_id: _chatListModel!.data![index].userId.toString(),
//               //             name: chatListModel!.data![index].userName.toString(), image: chatListModel!.data![index].profileImage.toString(),));
//               //         },
//               //         child:Container(
//               //           width: double.infinity,
//               //           height: 121.0,
//               //           margin: EdgeInsets.only(bottom: 10),
//               //           decoration: BoxDecoration(
//               //             color: FlutterTheme.of(context).secondaryBackground,
//               //             boxShadow: [
//               //               BoxShadow(
//               //                 blurRadius: 6.0,
//               //                 color: Color(0x131C2340),
//               //                 offset: Offset(0.0, 4.0),
//               //               )
//               //             ],
//               //             borderRadius: BorderRadius.circular(20.0),
//               //             border: Border.all(
//               //               color: FlutterTheme.of(context).textColorbg,
//               //               width: 1.0,
//               //             ),
//               //           ),
//               //           child: Padding(
//               //             padding: EdgeInsets.all(24.0),
//               //             child: Row(
//               //               mainAxisSize: MainAxisSize.max,
//               //               crossAxisAlignment: CrossAxisAlignment.center,
//               //               children: [
//               //                 Container(
//               //                   width: 45.0,
//               //                   height: 45.0,
//               //                   clipBehavior: Clip.antiAlias,
//               //                   decoration: BoxDecoration(
//               //                     shape: BoxShape.circle,
//               //                   ),
//               //                   child: Image.network(
//               //                     _chatListModel!.data![index].profileImage.toString(),
//               //                     fit: BoxFit.cover,
//               //                   ),
//               //                 ),
//               //                 Expanded(
//               //                   child: Column(
//               //                     mainAxisSize: MainAxisSize.max,
//               //                     mainAxisAlignment: MainAxisAlignment.center,
//               //                     crossAxisAlignment: CrossAxisAlignment.stretch,
//               //                     children: [
//               //                       Text(
//               //                         _chatListModel!.data![index].userName.toString(),
//               //                         style: FlutterTheme.of(context).headlineLarge.override(
//               //                           fontFamily: 'Montserrat',
//               //                           color: FlutterTheme.of(context).btnNaviBlue,
//               //                           fontSize: 16.0,
//               //                           fontWeight: FontWeight.bold,
//               //                           useGoogleFonts: GoogleFonts.asMap().containsKey(
//               //                               FlutterTheme.of(context).headlineLargeFamily),
//               //                         ),
//               //                       ),
//               //                       InkWell(
//               //                         onTap: () {
//               //                           Helper.moveToScreenwithPush(context, MyAppNew());
//               //                         },
//               //                         child: Text(
//               //                           "bnvjbnjk",
//               //                           style: FlutterTheme.of(context).headlineLarge.override(
//               //                             fontFamily: 'Montserrat',
//               //                             color: FlutterTheme.of(context).btnNaviBlue,
//               //                             fontSize: 16.0,
//               //                             fontWeight: FontWeight.bold,
//               //                             useGoogleFonts: GoogleFonts.asMap().containsKey(
//               //                                 FlutterTheme.of(context).headlineLargeFamily),
//               //                           ),
//               //                         ),
//               //                       ),
//               //                       Row(
//               //                         children: [
//               //                           Text(
//               //                             "Vehicle Type:-",
//               //                             style: FlutterTheme.of(context).headlineLarge.override(
//               //                               fontFamily: 'Montserrat',
//               //                               color: FlutterTheme.of(context).btnNaviBlue,
//               //                               fontSize: 14.0,
//               //                               fontWeight: FontWeight.w300,
//               //                               useGoogleFonts: GoogleFonts.asMap().containsKey(
//               //                                   FlutterTheme.of(context).headlineLargeFamily),
//               //                             ),
//               //                           ),
//               //                           Flexible(
//               //                             flex: 1,
//               //                             child: AutoSizeText(
//               //                               _chatListModel!.data![index].vehicleType.toString(),
//               //                               style:
//               //                               FlutterTheme.of(context).headlineLarge.override(
//               //                                 fontFamily: 'Montserrat',
//               //                                 color: FlutterTheme.of(context).liteRoad,
//               //                                 fontSize: 14.0,
//               //                                 fontWeight: FontWeight.w500,
//               //                                 useGoogleFonts: GoogleFonts.asMap().containsKey(
//               //                                     FlutterTheme.of(context)
//               //                                         .headlineLargeFamily),
//               //                               ),
//               //                               minFontSize: 12.0,
//               //                             ),
//               //                           ),
//               //                         ],
//               //                       ),
//               //                     ],
//               //                   ),
//               //                 ),
//               //                 // Text(
//               //                 //   _chatListModel!.data![index].vehicleType.toString(),
//               //                 //   textAlign: TextAlign.end,
//               //                 //   style: FlutterTheme.of(context).headlineLarge.override(
//               //                 //     fontFamily: 'Montserrat',
//               //                 //     color: FlutterTheme.of(context).liteRoad,
//               //                 //     fontSize: 14.0,
//               //                 //     fontWeight: FontWeight.bold,
//               //                 //     useGoogleFonts: GoogleFonts.asMap().containsKey(
//               //                 //         FlutterTheme.of(context).headlineLargeFamily),
//               //                 //   ),
//               //                 // ),
//               //               ].divide(SizedBox(width: 10.0)),
//               //             ),
//               //           ),
//               //         ),
//               //         );
//               //     }),
//             ],
//           ),
//         ),
//         Helper.getProgressBarWhite(context, _isVisible)
//       ],
//     );
//   }
//
//   // Function to perform dynamic local search
//   void performSearch(String query) {
//
//     // items.forEach((userDetail) {
//     //   if (userDetail.userName!.contains(query)) filteredItems.add(userDetail);
//     //   print("=======items=====${items}");
//     //   print("=======filteredItems=====${filteredItems}");
//     // });
//
//     setState(() {
//       filteredItems = _chatListModel!.data!
//           .where((item) => item.userName!.toLowerCase().contains(query.toLowerCase()))
//           .toList();
//       print("=======filteredItems=====${filteredItems.first.userName}");
//     });
//   }
//
//   setProgress(bool show) {
//     if (mounted)
//       setState(() {
//         _isVisible = show;
//       });
//   }
//
//   Future<void> chatlist_Api() async {
//     print("<=========chatlist_Api=======>");
//     print("<========usertype======>${SessionHelper().get(SessionHelper.USERTYPE).toString()}");
//
//     SessionHelper session = await SessionHelper.getInstance(context);
//     String userId = session.get(SessionHelper.USER_ID) ?? "0";
//     setProgress(true);
//     _hasData=true;
//
//     Map data = {
//       'code':"bring7771",
//       'user_id':userId,
//       'type':(SessionHelper().get(SessionHelper.USERTYPE).toString())=="1"?"1":"2",
//     };
//
//     print("Request =============>" + data.toString());
//     try {
//       var res = await http.post(Uri.parse(Apis.User_chat_list), body: data);
//       print("Response ============>" + res.body);
//
//       if (res.statusCode == 200) {
//         try {
//           final jsonResponse = jsonDecode(res.body);
//           ChatListModel model = ChatListModel.fromJson(jsonResponse);
//
//           if (model.result == "success") {
//             // items = jsonResponse["data"];
//             items.add(model.data!.first);
//
//             print("Model status true");
//             SessionHelper sessionHelper = await SessionHelper.getInstance(context);
//             setProgress(false);
//             _hasData=false;
//             final jsonResp = jsonResponse["data"];
//             for (Map<String,dynamic> user in jsonResp) {
//
//               print("======data===${user}");
//               Data chatListdata = Data.fromJson(user);
//               items.add(chatListdata);
//               print("=====chatListdata====${chatListdata}");
//             }
//
//
//             print("=====items====${items}");
//
//             print("successs==============");
//             // ScaffoldMessenger.of(context).showSnackBar(
//             //   SnackBar(
//             //     content: Text(model.message.toString()),
//             //   ),
//             // );
//
//             setState(() {
//               _chatListModel=model;
//               //   for (Map user in jsonResponse) {
//               //     _userDetails.add(UserDetails.fromJson(user));
//               //   }
//               // });
//             });
//             // setState(() {
//             //   _chatListModel=model;
//             // });
//             //   Helper.moveToScreenwithPush(context, ConfirmationPageWidget(user_type: widget.userTypes,));
//             // (context, (route) => route.isFirst);
//           }
//           else {
//             setProgress(false);
//             _hasData=false;
//             print("false ### ============>");
//     // context.pushNamed('Registe