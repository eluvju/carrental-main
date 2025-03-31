//
// import 'dart:convert';
// import 'dart:io';
//
// // import 'package:aheadly_owner/Reg/login.dart';
// import 'package:aheadly_customer/Model/common_model.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:http/http.dart' as http;
//
// import '../Model/notification_model.dart';
// import '../constant.dart';
//
//
// class NotificationScreen extends StatefulWidget {
//   @override
//   State<NotificationScreen> createState() => _NotificationScreenState();
// }
//
// class _NotificationScreenState extends State<NotificationScreen> {
//
//   NotificationModel? _notificationModel;
//
//   bool _hashData = false ;
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     Helper.checkInternet(notificationApis());
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: Colors.black,
//         // appBar:  AppBar(
//         //   toolbarHeight: 75,
//         //   automaticallyImplyLeading: false,
//         //   flexibleSpace: Container(
//         //     height: MediaQuery.of(context).size.height,
//         //     decoration: BoxDecoration(
//         //       borderRadius: BorderRadius.only(
//         //         bottomLeft: Radius.circular(20),
//         //         bottomRight: Radius.circular(20),
//         //       ),
//         //       color: Color(0xFF333333),
//         //     ),
//         //     child: Column(
//         //       mainAxisAlignment: MainAxisAlignment.end,
//         //       // crossAxisAlignment: CrossAxisAlignment.end,
//         //       children: [
//         //         Row(
//         //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         //           crossAxisAlignment: CrossAxisAlignment.end,
//         //           children: [
//         //             Row(
//         //               mainAxisAlignment: MainAxisAlignment.center,
//         //               crossAxisAlignment: CrossAxisAlignment.center,
//         //               children: [
//         //                 Container(
//         //                   height: 45,
//         //                   width: 45,
//         //                   margin: EdgeInsets.all(12),
//         //                   decoration: BoxDecoration(
//         //                     color: Colors.white,
//         //                     shape: BoxShape.circle,
//         //                   ),
//         //                   child: IconButton(
//         //                     onPressed: (){
//         //                       Helper.popScreen(context);
//         //                     },
//         //                     icon: Icon(Icons.arrow_back,color: Colors.black,),
//         //                   ),
//         //                 ),
//         //                 SizedBox(width: 10,),
//         //                 Text("NOTIFICATION",
//         //                   style: TextStyle(
//         //                       color: Colors.white,
//         //                       fontWeight: FontWeight.w500,
//         //                       fontSize: 20
//         //                   ),
//         //                 ),
//         //               ],
//         //             ),
//         //           ],
//         //         ),
//         //       ],
//         //     ),
//         //   ),
//         //   backgroundColor: Colors.black,
//         // ),
//         appBar: AppBar(
//           toolbarHeight: 80,
//           backgroundColor: Colors.transparent,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.vertical(
//               bottom: Radius.circular(20),
//             ),
//           ),
//           // leading: Padding(
//           //   padding: EdgeInsets.only(left: 15),
//           //   child: Container(
//           //     height: 25,width: 25,
//           //     decoration: BoxDecoration(
//           //       color: Colors.white,
//           //       shape: BoxShape.circle,
//           //     ),
//           //     child: IconButton(
//           //       icon: Icon(Icons.arrow_back),
//           //       color: Colors.black,
//           //       iconSize: 20,
//           //       onPressed: () {
//           //         Helper.popScreen(context);
//           //       },
//           //     ),
//           //   ),
//           // ),
//           leading: Padding(
//             padding: EdgeInsets.all(18),
//             child: InkWell(
//                 onTap: (){
//                   Helper.popScreen(context);
//                 },
//                 child: Image.asset(Img.close,
//                   height: 20,width: 20,
//                 )
//             ),
//           ),
//           centerTitle: true,
//           title: Text(
//             "Notifications",
//             style: GoogleFonts.poppins(
//                 fontWeight: FontWeight.w700,
//                 color: Colors.white, fontSize: 16),
//           ),
//         ),
//         body: Stack(
//           children: [
//             _notificationModel == null
//                 ?_hashData
//                 ?Container()
//                 :Container(
//               width: MediaQuery.of(context).size.width,
//               height: MediaQuery.of(context).size.height,
//               color: Colors.black,
//               child: Center(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Image.asset(Img.EmptySet,height: 60,width: 60,),
//                     SizedBox(height:5,),
//                     Text(
//                       "It’s empty in here.",
//                       style: TextStyle(
//                           decoration: TextDecoration.lineThrough,
//                           fontSize: 14,
//                           color: Colors.white,
//                         fontWeight: FontWeight.w700
//                       ),
//                     ),
//                   ],
//                 )
//             ),
//             )
//             :Container(
//                 color: Colors.black,
//                 height: MediaQuery.of(context).size.height,
//                 width: MediaQuery.of(context).size.width,
//                 child: SingleChildScrollView(
//                   child: Padding(
//                     padding:  EdgeInsets.symmetric(horizontal: 10,vertical: 10),
//                     child: Column(
//                       children: [
//                        ListView.builder(
//                          itemCount: _notificationModel!.data!.length,
//                            shrinkWrap: true,
//                            physics: NeverScrollableScrollPhysics(),
//                            itemBuilder: (BuildContext , index){
//                              return InkWell(
//                                onTap: (){
//                                  if(_notificationModel!.data![index].messageType.toString()=="3"){
//                                    print("send user to chat window");
//                                    Helper.moveToScreenwithPush(context, ChatScreen(
//                                      shop_id: _notificationModel!.data![index].shopId.toString(),
//                                      shop_name:
//                                      _notificationModel!.data![index].shopName.toString(),
//                                      shop_image:
//                                      _notificationModel!.data![index].shopImage.toString(),
//                                      owner_id:
//                                      _notificationModel!.data![index].ownerId.toString(),
//                                    )
//                                    );
//
//                                  }else{
//                                    print("Do nothing if its not a message");
//                                  }
//                                },
//                                child: Container(
//                                  height: 92,
//                                  margin:EdgeInsets.all(10),
//                                  padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
//                                  decoration: BoxDecoration(
//                                      borderRadius: BorderRadius.circular(10),
//                                      // color: AppColor.secondaryColor
//                                    color: Color(0xFF141414)
//                                  ),
//                                  child: Row(
//                                    mainAxisAlignment: MainAxisAlignment.center,
//                                    children: [
//                                      ClipOval(
//                                          child: CachedNetworkImage(
//                                            imageUrl: _notificationModel!.data![index].image.toString(),
//                                            fit: BoxFit.fill,
//                                            width: 33,
//                                            height: 30,
//                                            placeholder: (context, url) =>
//                                                LinearProgressIndicator(
//                                                  color: Colors.white
//                                                      .withOpacity(0.2),
//                                                  backgroundColor:Colors.white
//                                                      .withOpacity(.5),
//                                                ),
//                                            errorWidget: (context, url, error) =>
//                                                ClipOval(
//                                                  child: Container(
//                                                    width: 33,
//                                                    height: 30,
//                                                    // padding: EdgeInsets.symmetric(vertical: 25.0),
//                                                    decoration: BoxDecoration(
//                                                        borderRadius: BorderRadius.all(
//                                                          Radius.circular(20),
//                                                        ),
//                                                        color:Color(0xFFD9D9D9)
//                                                    ),
//                                                    child: Center(
//                                                      child: Icon(
//                                                        Icons.person,
//                                                        size: 40,
//                                                        color: Colors.grey,
//                                                      ),
//                                                    ),
//                                                  ),
//                                                ),
//                                          )
//                                      ),
//                                      SizedBox(width: 20,),
//                                      Container(
//                                      width:MediaQuery.of(context).size.width*0.60,
//                                      child: Text(_notificationModel!.data![index].notification.toString(),
//                                        overflow: TextOverflow.ellipsis,
//                                        maxLines: 2,
//                                        style: GoogleFonts.poppins(
//                                          color: Colors.white,
//                                          fontWeight: FontWeight.w600,
//                                          fontSize: 12,
//                                        ),
//                                      ),
//                                    ),
//                                      // Column(
//                                      //   crossAxisAlignment: CrossAxisAlignment.start,
//                                      //   children: [
//                                      //     Container(
//                                      //      // color: Colors.red,
//                                      //       width:MediaQuery.of(context).size.width*0.60,
//                                      //       child: Text(
//                                      //       _notificationModel!.data![index].shopName.toString(),
//                                      //         overflow: TextOverflow.ellipsis,
//                                      //         style: TextStyle(
//                                      //           color: Colors.white,
//                                      //           fontWeight: FontWeight.w500,
//                                      //           fontSize: 20,
//                                      //         ),
//                                      //       ),
//                                      //     ),
//                                      //     SizedBox(height: 5,),
//                                      //     Container(
//                                      //      // color: Colors.red,
//                                      //       width:MediaQuery.of(context).size.width*0.60,
//                                      //       child: Text(_notificationModel!.data![index].notification.toString(),
//                                      //         overflow: TextOverflow.ellipsis,
//                                      //         maxLines: 2,
//                                      //         style: TextStyle(
//                                      //
//                                      //           color: Colors.white,
//                                      //           fontWeight: FontWeight.w400,
//                                      //           fontSize: 16,
//                                      //         ),
//                                      //       ),
//                                      //     ),
//                                      //   ],
//                                      // )
//                                    ],
//                                  ),
//                                ),
//                              );
//                            }
//                        )
//                       ],
//                     ),
//                   ),
//                 )
//             ),
//            Helper.getProgressBarWhite(context, _isVisible)
//           ],
//         )
//     );
//   }
//
//
//   bool _isVisible = false;
//
//   setProgress(bool show) {
//     if (mounted)
//       setState(() {
//         _isVisible = show;
//       });
//   }
//
//   Future<void> notificationApi() async {
//     print("<=============notificationApi=============>");
//
//     SessionHelper session = await SessionHelper.getInstance(context);
//     String userId = session.get(SessionHelper.USER_ID) ?? "0";
//     setProgress(true);
//
//     Map data = {
//       'code': "bring7771",
//       'user_id':userId
//     };
//
//     print("Request =============>" + data.toString());
//     try {
//       var res = await http.post(Uri.parse(Apis.login), body: data);
//       print("Response ============>" + res.body);
//
//       if (res.statusCode == 200) {
//         try {
//           final jsonResponse = jsonDecode(res.body);
//           LoginApiModel model = LoginApiModel.fromJson(jsonResponse);
//
//           if (model.result == "success") {
//             print("Model status true");
//             _saveRememberMeStatus();
//             SessionHelper sessionHelper =
//             await SessionHelper.getInstance(context);
//             sessionHelper.put(SessionHelper.USER_ID, model.data!.userId.toString());
//             sessionHelper.put(SessionHelper.FIRSTNAME, model.data!.firstname.toString());
//             sessionHelper.put(SessionHelper.COMPANY_NAME, model.data!.companyName.toString());
//             sessionHelper.put(SessionHelper.LASTNAME, model.data!.lastname.toString());
//             sessionHelper.put(SessionHelper.EMAIL, model.data!.email.toString());
//             sessionHelper.put(SessionHelper.PHONE, model.data!.phone.toString());
//             sessionHelper.put(SessionHelper.IMAGE, model.data!.profileImage.toString());
//             sessionHelper.put(SessionHelper.STREETNAME, model.data!.street.toString());
//             sessionHelper.put(SessionHelper.CITY, model.data!.city.toString());
//             sessionHelper.put(SessionHelper.STATE, model.data!.state.toString());
//             sessionHelper.put(SessionHelper.COUNTRY, model.data!.countryName.toString());
//             sessionHelper.put(SessionHelper.ZIPCODE, model.data!.zipcode.toString());
//             sessionHelper.put(SessionHelper.USERTYPE, model.data!.userType.toString());
//             // sessionHelper.put(SessionHelper.NUMBER,widget.number);
//
//             setProgress(false);
//
//             print("successs==============");
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(
//                 content: Text(model.message.toString()),
//               ),
//             );
//             if(widget.user_type=="user"){
//               Helper.moveToScreenwithPush(context, UserHomePageWidget());
//             }else{
//               Helper.moveToScreenwithPush(context, CruzerHomePageWidget());
//             }
//             // context.pushNamed('UserHomePage');
//             // ToastMessage.msg(model.message.toString());
//             // Navigator.pushAndRemoveUntil(
//             //     context, MaterialPageRoute(builder: (context) => BottomNavBar()), (
//             //     route) => false);
//           } else {
//             setProgress(false);
//             print("false ### ============>");
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(
//                 content: Text(model.message.toString()),
//               ),
//             );
//           }
//         } catch (e) {
//           print("false ============>");
//           ToastMessage.msg(StaticMessages.API_ERROR);
//           print('exception ==> ' + e.toString());
//         }
//       } else {
//         print("status code ==> " + res.statusCode.toString());
//         //  ToastMessage.msg(StaticMessages.API_ERROR);
//       }
//     } catch (e) {
//       ToastMessage.msg(StaticMessages.API_ERROR);
//       print('Exception ======> ' + e.toString());
//     }
//     setProgress(false);
//   }
//
// }
