// import 'dart:convert';
// import 'dart:io';
// import 'package:aheadly_customer/Helper/project_img.dart';
// import 'package:aheadly_customer/profile/Help.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:http/http.dart' as http;
// import 'package:image_picker/image_picker.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:permission_handler/permission_handler.dart';
// import '../Model/receiptModel.dart';
// import '../bottom_nav/bottom_nav.dart';
// import '../helper/constant.dart';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'package:path_provider/path_provider.dart';
// import 'package:image/image.dart' as img;
//
// import '../notificationservice/local_notification_service.dart';
// import '../notificationservice/notification_screen.dart';
// class Receipt extends StatefulWidget {
//   String bookingId = '';
//   String totalAmount = '';
//   String whichScreen = '';
//   Receipt({required this.bookingId,
//     required this.totalAmount,
//     required this.whichScreen
//   });
//
//   @override
//   State<Receipt> createState() => _ReceiptState();
// }
//
// class _ReceiptState extends State<Receipt> {
//
//   List<ChatModell> _chatListt = [
//     ChatModell(
//       service: "HAIR CUTTING",
//       time: "45min",
//       price: "1000",
//     ),
//     ChatModell(
//       service: "CUSTOMISED HAIRCUT",
//       time: "45min",
//       price: "2500",
//     ),
//     ChatModell(
//       service: "KERATINE",
//       time: "2hrs",
//       price: "500",
//     ),
//   ];
//
//   bool _isVisible = false;
//   bool _visible = false;
//
//   GetReceiptModel? _getReceiptModel;
//   List service = [];
//
//
//   int noti_count=0;
//   bool hasNewMessages = false;
//
//   updateNotiCount(int gotNotiCount) async {
//     print("updateNotiCount=======>${gotNotiCount.toString()}");
//     SessionHelper session = await SessionHelper.getInstance(context);
//
//
//     setState(() {
//       session.put(SessionHelper.NOTI_COUNT,gotNotiCount.toString());
//
//       // passowrdController.text = number;
//     });
//     print("value=======>${session.get(SessionHelper.NOTI_COUNT).toString()}");
//   }
//
//   void initState() {
//     HelperClass.checkInternet(GetReceiptApi());
//     checkPermissionAndAccessFile();
//     // accessFile();
//     getdata();
//     FirebaseMessaging.instance.getInitialMessage().then(
//           (message) {
//         print("FirebaseMessaging.instance.getInitialMessage");
//         if (message != null) {
//           print("New Notification");
//           // if (message.data['_id'] != null) {
//           //   Navigator.of(context).push(
//           //     MaterialPageRoute(
//           //       builder: (context) => NotificationPage( serviceId: message.data['_id'],
//           //       ),
//           //     ),
//           //   );
//           // }
//
//         }
//       },
//     );
//
//     FirebaseMessaging.onMessage.listen(
//           (message) {
//         if (kDebugMode) {
//           print("FirebaseMessaging.onMessage.listen");
//         }
//         if (message.notification != null) {
//           if (kDebugMode) {
//             print(message.notification!.title);
//           }
//           if (kDebugMode) {
//             print(message.notification!.body);
//           }
//           if (kDebugMode) {
//             print("message.data11 ${message.data}");
//           }
//
//           LocalNotificationService.createanddisplaynotification(message);
//           setState(() {
//             noti_count++;
//             updateNotiCount(noti_count);
//             hasNewMessages=true;
//
//           });
//         }
//       },
//     );
//     FirebaseMessaging.onMessageOpenedApp.listen(
//           (message) {
//         print("FirebaseMessaging.onMessageOpenedApp.listen");
//         if (message.notification != null) {
//           print(message.notification!.title);
//           print(message.notification!.body);
//           print("message.data22 ${message.data['_id']}");
//           setState(() {
//             noti_count++;
//             updateNotiCount(noti_count);
//             hasNewMessages=true;
//           });
//         }
//         LocalNotificationService.enableIOSNotifications();
//
//       },
//     );
//   }
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar:
//       widget.whichScreen=="upcoming" || widget.whichScreen=="past"?
//       AppBar(
//         toolbarHeight: 75,
//         automaticallyImplyLeading: false,
//         centerTitle: false,
//         leading:
//         widget.whichScreen=="upcoming" || widget.whichScreen=="past"
//           ?
//         InkWell(
//           onTap: () {
//             Helper.popScreen(context);
//           },
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Image.asset(
//               Img.arrow,
//               height: 25,
//               width: 25,
//             ),
//           ),
//         ):
//         Padding(
//             padding: EdgeInsets.only(left:0),
//             child:
//             Container(
//               height: 25,
//               width: 25,
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 shape: BoxShape.circle,
//               ),
//               child: IconButton(
//                 icon: Icon(Icons.arrow_back),
//                 color: Colors.black,
//                 iconSize: 15,
//                 onPressed: () {
//                   Helper.popScreen(context);
//                 },
//               ),
//             )
//         ),
//         title: Text(
//           "Receipt",
//           style: GoogleFonts.poppins(
//             textStyle: TextStyle(
//                 color: Colors.white,
//                 fontWeight: FontWeight.w500,
//                 fontSize: 20),
//           ),
//         ),
//         backgroundColor: Colors.black,
//         actions: [
//           InkWell(
//               onTap: () {
//                 setState(() {
//                   hasNewMessages=false;
//                   updateNotiCount(0);
//                   Helper.moveToScreenwithPush(context, NotificationScreen()).then(
//                           (value) => getdata()
//                   );
//                 });
//               },
//               child: Stack(
//                 children: [
//                   Container(
//                     height: 40,
//                     width: 40,
//                     margin: EdgeInsets.all(10),
//                     decoration: BoxDecoration(
//                       color: Colors.black,
//                       shape: BoxShape.circle,
//                     ),
//                     child:Icon(Icons.notifications_outlined,color: Colors.white,),
//                     //Image.asset(ProjectImage.image,)
//                   ),
//                   noti_count>0?
//                   Positioned(
//                       top: 10,
//                       left: 10,
//                       child: Container(
//                         // height: 15,
//                         //width: 15,
//                         padding: EdgeInsets.all(3),
//                         decoration: BoxDecoration(
//                             color: Colors.white,
//                             shape: BoxShape.circle
//                         ),
//                         constraints: BoxConstraints(
//                           minWidth: 15,
//                           minHeight: 15,
//                         ),
//                         child: Padding(
//                           padding: const EdgeInsets.only(left: 0),//3
//                           child: Text(noti_count.toString(),
//                             style: TextStyle(color: Colors.black, fontSize: 10),
//                             textAlign: TextAlign.center,),
//                         ),
//                       )
//                   )
//                       :SizedBox()
//                 ],
//               )
//           ),
//         ],
//       ):
//       AppBar(
//         toolbarHeight: 75,
//         automaticallyImplyLeading: false,
//         centerTitle: false,
//         title: Text(
//           "Receipt",
//           style: GoogleFonts.poppins(
//             textStyle: TextStyle(
//                 color: Colors.white,
//                 fontWeight: FontWeight.w500,
//                 fontSize: 20),
//           ),
//         ),
//         backgroundColor: Colors.black,
//         actions: [
//           InkWell(
//               onTap: () {
//                 setState(() {
//                   hasNewMessages=false;
//                   updateNotiCount(0);
//                   Helper.moveToScreenwithPush(context, NotificationScreen()).then(
//                           (value) => getdata()
//                   );
//                 });
//               },
//               child: Stack(
//                 children: [
//                   Container(
//                     height: 40,
//                     width: 40,
//                     margin: EdgeInsets.all(10),
//                     decoration: BoxDecoration(
//                       color: Colors.black,
//                       shape: BoxShape.circle,
//                     ),
//                     child:Icon(Icons.notifications_outlined,color: Colors.white,),
//                     //Image.asset(ProjectImage.image,)
//                   ),
//                   noti_count>0?
//                   Positioned(
//                       top: 10,
//                       left: 10,
//                       child: Container(
//                         // height: 15,
//                         //width: 15,
//                         padding: EdgeInsets.all(3),
//                         decoration: BoxDecoration(
//                             color: Colors.white,
//                             shape: BoxShape.circle
//                         ),
//                         constraints: BoxConstraints(
//                           minWidth: 15,
//                           minHeight: 15,
//                         ),
//                         child: Padding(
//                           padding: const EdgeInsets.only(left: 0),//3
//                           child: Text(noti_count.toString(),
//                             style: TextStyle(color: Colors.black, fontSize: 10),
//                             textAlign: TextAlign.center,),
//                         ),
//                       )
//                   )
//                       :SizedBox()
//                 ],
//               )
//           ),
//         ],
//       ),
//       body: Stack(
//         children: [
//           if (_getReceiptModel == null)
//             Container()
//           else
//             Container(
//               height: MediaQuery.of(context).size.height,
//               width: MediaQuery.of(context).size.width,
//               child: Stack(
//                 children: [
//                   SingleChildScrollView(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const SizedBox(
//                           height: 20,
//                         ),
//                         Container(
//                           padding: EdgeInsets.symmetric(horizontal: 25),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     "Order ID: " +
//                                         _getReceiptModel!.data!.orderId.toString(),
//                                     style: GoogleFonts.poppins(
//                                         fontSize: 18,
//                                         fontWeight: FontWeight.w500,
//                                         color: Colors.white),
//                                   ),
//                                   SizedBox(
//                                     height: 5,
//                                   ),
//                                   Text(
//                                     _getReceiptModel!.data!.date.toString(),
//                                     style: TextStyle(
//                                         fontSize: 12,
//                                         fontWeight: FontWeight.w500,
//                                         color: Color(0xFFC7C7C7)),
//                                   ),
//                                 ],
//                               ),
//                               InkWell(
//                                 onTap: (){
//                                   requestPermissions();
//                                  // requestPermissions2();
//                                  // showAlertDialog( context);
//                                   },
//                                 child: Image.asset(
//                                   Img.downloading,
//                                   height: 30,
//                                   width: 30,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         const SizedBox(
//                           height: 20,
//                         ),
//                         Container(
//                           margin: const EdgeInsets.symmetric(
//                               horizontal: 20, vertical: 20),
//                           width: MediaQuery.of(context).size.width,
//                           decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(20),
//                               color: Color(0xFF141414)),
//                           child: Padding(
//                             padding: EdgeInsets.all(20.0),
//                             child: Column(
//                               children: [
//                                 Row(
//                                   children: [
//                                     // const Icon(
//                                     //   Icons.restore,
//                                     //   color: Colors.white,
//                                     // ),
//                                     Image.asset(Img.AppointmentTime,
//                                       height: 20,width: 24,
//                                     ),
//                                     const SizedBox(
//                                       width: 10,
//                                     ),
//                                     // Flexible(
//                                     //     child: Text(
//                                     //   "Apointment Time: " +
//                                     //       _getReceiptModel!.data!.time
//                                     //           .toString() +
//                                     //       "-" +
//                                     //       _getReceiptModel!.data!.date
//                                     //           .toString(),
//                                     //   style:  GoogleFonts.poppins(
//                                     //       fontSize: 14,
//                                     //       fontWeight: FontWeight.w500,
//                                     //       color: Colors.white),
//                                     // )),
//                                     Row(
//                                       children: [
//                                         Text("Apointment Time: ",
//                                           style:  GoogleFonts.poppins(
//                                                   fontSize: 12,
//                                                   fontWeight: FontWeight.w500,
//                                                   color: Colors.white),
//                                         ),
//                                         Text( _getReceiptModel!.data!.date.toString(),
//                                           style:  GoogleFonts.poppins(
//                                               fontSize: 14,
//                                               fontWeight: FontWeight.w500,
//                                               color: Colors.white),
//                                         ),
//                                       ],
//                                     )
//                                   ],
//                                 ),
//                                 const SizedBox(
//                                   height: 10,
//                                 ),
//                                 const Divider(
//                                   color: Color(0xFF4D4D4D),
//                                   thickness: 1,
//                                 ),
//                                 const SizedBox(
//                                   height: 10,
//                                 ),
//                                 Row(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     // const Icon(
//                                     //   Icons.location_on_outlined,
//                                     //   size: 25,
//                                     //   color: Colors.white,
//                                     // ),
//                                     Image.asset(Img.saloonLocation,
//                                       height: 20,width: 24,
//                                     ),
//                                     const SizedBox(
//                                       width: 10,
//                                     ),
//                                     // Flexible(
//                                     //     child: Text(
//                                     //   "Location: ${_getReceiptModel!.data!.location.toString()}",
//                                     //   style:  GoogleFonts.poppins(
//                                     //       fontSize: 14,
//                                     //       fontWeight: FontWeight.w500,
//                                     //       color: Colors.white),
//                                     // )),
//                                     Row(
//                                       crossAxisAlignment: CrossAxisAlignment.start,
//                                       mainAxisAlignment: MainAxisAlignment.center,
//                                       children: [
//                                         Column(
//                                           crossAxisAlignment: CrossAxisAlignment.start,
//                                           children: [
//                                             Text("Location: ",
//                                               style: GoogleFonts.poppins(
//                                                   fontSize: 12,
//                                                   fontWeight: FontWeight.w500,
//                                                   color: Colors.white),
//                                             ),
//                                             Text("Location:",
//                                               style:  GoogleFonts.poppins(
//                                                   fontSize: 12,
//                                                   fontWeight: FontWeight.w500,
//                                                   color: Colors.transparent),
//                                             ),
//                                           ],
//                                         ),
//                                         Container(
//                                           width: 185,
//                                           child: Text(_getReceiptModel!.data!.address.toString(),
//                                             style: GoogleFonts.poppins(
//                                                 fontSize: 14,
//                                                 fontWeight: FontWeight.w500,
//                                                 color: Colors.white),
//                                                 maxLines: 2,
//                                           ),
//                                         ),
//                                       ],
//                                     )
//                                   ],
//                                 ),
//                                 const SizedBox(
//                                   height: 10,
//                                 ),
//                                 _getReceiptModel!.data!.fullname.toString() ==
//                                         "staffName"
//                                     ? const SizedBox()
//                                     : Column(
//                                         children: [
//                                           const Divider(
//                                             color: Color(0xFF4D4D4D),
//                                             thickness: 1,
//                                           ),
//                                           const SizedBox(
//                                             height: 10,
//                                           ),
//                                           Row(
//                                             children: [
//                                               // const Icon(
//                                               //   Icons.location_on_outlined,
//                                               //   size: 25,
//                                               //   color: Colors.white,
//                                               // ),
//                                               Image.asset(Img.Barbericon,
//                                                   height: 20,width: 24,
//                                               ),
//                                               const SizedBox(
//                                                 width: 10,
//                                               ),
//                                               Row(
//                                                   children: [
//                                                     Text("Barber: ",
//                                                       style:  GoogleFonts.poppins(
//                                                           fontSize: 12,
//                                                           fontWeight: FontWeight.w500,
//                                                           color: Colors.white),
//                                                     ),
//                                                     Text(_getReceiptModel!.data!.fullname.toString(),
//                                                       style: GoogleFonts.poppins(
//                                                           fontSize: 14,
//                                                           fontWeight: FontWeight.w500,
//                                                           color: Colors.white),
//                                                       maxLines: 2,
//                                                     ),
//                                                   ],
//                                               ),
//                                               // Text(
//                                               //   "Barber: " +
//                                               //       _getReceiptModel!.data!.fullname.toString(),
//                                               //   style:  GoogleFonts.poppins(
//                                               //       fontSize: 14,
//                                               //       fontWeight: FontWeight.w500,
//                                               //       color: Colors.white),
//                                               // ),
//                                             ],
//                                           ),
//                                           const SizedBox(
//                                             height: 10,
//                                           ),
//                                           // _getReceiptModel!.data!.coupon.toString()==""?
//                                           //     SizedBox():
//                                           // const Divider(
//                                           //   color: Color(0xFF4D4D4D),
//                                           //   thickness: 1,
//                                           // ),
//                                           // _getReceiptModel!.data!.coupon.toString()==""?
//                                           //     SizedBox():
//                                           // const SizedBox(
//                                           //   height: 10,
//                                           // ),
//                                           // _getReceiptModel!.data!.coupon.toString()==""?
//                                           //     SizedBox():
//                                           // Row(
//                                           //   children: [
//                                           //     Image.asset(Img.SalePrice,
//                                           //         height: 25, width: 25),
//                                           //     SizedBox(
//                                           //       width: 10,
//                                           //     ),
//                                           //     Container(
//                                           //       //color: Colors.red,
//                                           //       width:
//                                           //       MediaQuery.of(context)
//                                           //           .size
//                                           //           .width *
//                                           //           0.60,
//                                           //       child: Text(
//                                           //         "Promo : ${_getReceiptModel!.data!.coupon.toString()}",
//                                           //         overflow:
//                                           //         TextOverflow.ellipsis,
//                                           //         maxLines: 2,
//                                           //         style:  GoogleFonts.poppins(
//                                           //             fontSize: 14,
//                                           //             fontWeight: FontWeight.w500,
//                                           //             color: Colors.white),
//                                           //       ),
//                                           //     ),
//                                           //   ],
//                                           // ),
//                                         ],
//                                       ),
//                                 const SizedBox(
//                                   height: 5,
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 20.0, vertical: 10),
//                           child: ListView.builder(
//                               scrollDirection: Axis.vertical,
//                               itemCount: _getReceiptModel!.services!.length,
//                               shrinkWrap: true,
//                               physics: NeverScrollableScrollPhysics(),
//                               itemBuilder: (context, index) {
//                                 var _services =
//                                     _getReceiptModel!.services![index];
//                                 return Container(
//                                     width: MediaQuery.of(context).size.width,
//                                     height: 80,
//                                     margin: const EdgeInsets.only(
//                                       top: 5,
//                                       bottom: 5,
//                                       right: 10,
//                                     ),
//                                     padding: const EdgeInsets.symmetric(
//                                       horizontal: 10,
//                                     ),
//                                     decoration: BoxDecoration(
//                                       color: Color(0xFF141414),
//                                       borderRadius: BorderRadius.circular(20),
//                                     ),
//                                     child: Row(
//                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         Row(
//                                           children: [
//                                             Container(
//                                               height: 40,
//                                               width: 40,
//                                               padding: const EdgeInsets.all(5),
//                                               margin: const EdgeInsets.all(5),
//                                               decoration: const BoxDecoration(
//                                                 color: Colors.black,
//                                                 shape: BoxShape.circle,
//                                               ),
//                                               child: const Icon(
//                                                 Icons.check,
//                                                 color: Colors.white,
//                                               ),
//                                             ),
//                                             Column(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment.center,
//                                               crossAxisAlignment:
//                                                   CrossAxisAlignment.start,
//                                               children: [
//                                                 Container(
//                                                   width: MediaQuery.of(context)
//                                                           .size
//                                                           .width *
//                                                       0.40,
//                                                   // color: Colors.red,
//                                                   child: Text(
//                                                     _getReceiptModel!
//                                                         .services![index]
//                                                         .toString(),
//                                                     style: GoogleFonts.poppins(
//                                                       textStyle:
//                                                           const TextStyle(
//                                                               fontSize: 14,
//                                                               color: Colors.white,
//                                                           fontWeight: FontWeight.w500),
//                                                     ),
//                                                   ),
//                                                 ),
//                                                 Container(
//                                                   width: MediaQuery.of(context)
//                                                           .size
//                                                           .width *
//                                                       0.40,
//                                                   // color: Colors.red,
//                                                   child: Text(
//                                                     _getReceiptModel!
//                                                         .duration![index]
//                                                         .toString(),
//                                                     style: GoogleFonts.poppins(
//                                                       textStyle:
//                                                           const TextStyle(
//                                                               fontSize: 12,
//                                                               fontWeight: FontWeight.w400,
//                                                               color: Color(0xFFC7C7C7)),
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                           ],
//                                         ),
//                                         Row(
//                                           children: [
//                                             // Image.asset(
//                                             //   Img.curr,
//                                             //   height: 20,
//                                             //   width: 30,
//                                             // ),
//                                             Text(
//                                               "₦${_getReceiptModel!.price![index].toString()}",
//                                               style: GoogleFonts.poppins(
//                                                 textStyle: const TextStyle(
//                                                     fontSize: 24,
//                                                     color: Colors.white,
//                                                     fontWeight: FontWeight.w500),
//                                               ),
//                                             ),
//                                           ],
//                                         )
//                                       ],
//                                     ));
//                               }),
//                         ),
//                         // const SizedBox(
//                         //   height: 20,
//                         // ),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 20.0, vertical: 10),
//                           child: Container(
//                               width: MediaQuery.of(context).size.width,
//                               height: 80,
//                               margin: const EdgeInsets.only(
//                                 top: 5,
//                                 bottom: 5,
//                                 right: 10,
//                               ),
//                               padding: const EdgeInsets.symmetric(horizontal: 10,
//                               ),
//                               decoration: BoxDecoration(
//                                 color: Color(0xFF141414),
//                                 borderRadius: BorderRadius.circular(20),
//                               ),
//                               child: Row(
//                                 mainAxisAlignment:
//                                 MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Row(
//                                     children: [
//                                       Image.asset(Img.discountReceipt,
//                                           height: 30,width: 30,
//                                       ),
//                                       SizedBox(width: 5,),
//                                       Column(
//                                         mainAxisAlignment:
//                                         MainAxisAlignment.center,
//                                         crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                         children: [
//                                           Container(
//                                             width: MediaQuery.of(context)
//                                                 .size
//                                                 .width *
//                                                 0.40,
//                                             // color: Colors.red,
//                                             child: Text(
//                                              "Discount",
//                                               style: GoogleFonts.poppins(
//                                                 textStyle:
//                                                 const TextStyle(
//                                                     fontSize: 15,
//                                                     color: Colors.white,
//                                                     fontWeight: FontWeight.w600),
//                                               ),
//                                             ),
//                                           ),
//                                           // Container(
//                                           //   width: MediaQuery.of(context)
//                                           //       .size
//                                           //       .width *
//                                           //       0.40,
//                                           //   // color: Colors.red,
//                                           //   child: Text(
//                                           //     _getReceiptModel!
//                                           //         .duration![index]
//                                           //         .toString(),
//                                           //     style: GoogleFonts.poppins(
//                                           //       textStyle:
//                                           //       const TextStyle(
//                                           //           fontSize: 12,
//                                           //           fontWeight: FontWeight.w400,
//                                           //           color: Color(0xFFC7C7C7)),
//                                           //     ),
//                                           //   ),
//                                           // ),
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//                                   Row(
//                                     children: [
//                                       // Image.asset(
//                                       //   Img.curr,
//                                       //   height: 20,
//                                       //   width: 30,
//                                       // ),
//                                       Text(
//                                         _getReceiptModel!.data!.discount.toString()==""?
//                                         "₦0":
//                                         "₦${_getReceiptModel!.data!.discount.toString()}",
//                                         style: GoogleFonts.poppins(
//                                           textStyle: const TextStyle(
//                                               fontSize: 24,
//                                               color: Colors.white,
//                                               fontWeight:
//                                               FontWeight.w500),
//                                         ),
//                                       ),
//                                     ],
//                                   )
//                                 ],
//                               )),
//                         ),
//                         // Container(
//                         //   width: MediaQuery.of(context).size.width,
//                         //   height: 80,
//                         //   margin: const EdgeInsets.only(
//                         //     top: 5,
//                         //     bottom: 5,
//                         //     right: 10,
//                         //   ),
//                         //   padding: const EdgeInsets.symmetric(horizontal: 10,
//                         //   ),
//                         //   decoration: BoxDecoration(
//                         //     color: Color(0xFF141414),
//                         //     borderRadius: BorderRadius.circular(20),
//                         //   ),
//                         //   child: Row(
//                         //     children: [
//                         //       Image.asset(Img.SalePrice,
//                         //           height: 20, width: 20),
//                         //       SizedBox(
//                         //         width: 10,
//                         //       ),
//                         //       Container(
//                         //         //color: Colors.red,
//                         //         width:
//                         //         MediaQuery.of(context)
//                         //             .size
//                         //             .width *
//                         //             0.60,
//                         //         child: Text(
//                         //           "Promo: ${_getReceiptModel!.data!.coupon.toString()}",
//                         //           overflow:
//                         //           TextOverflow.ellipsis,
//                         //           maxLines: 2,
//                         //           style: TextStyle(
//                         //               color: Colors.white,
//                         //               fontSize: 12,
//                         //               fontWeight:
//                         //               FontWeight.w500),
//                         //         ),
//                         //       ),
//                         //     ],
//                         //   ),
//                         // ),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 20.0, vertical: 10),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Column(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     "Services (${SessionHelper().get(SessionHelper.NO_OF_SERVICES).toString()})",
//                                     style: GoogleFonts.poppins(
//                                         fontSize: 16,
//                                         fontWeight: FontWeight.w400,
//                                         color: Colors.white),
//                                   ),
//                                   Row(
//                                     children: [
//                                       Text(
//                                         "TOTAL  ",
//                                         style: GoogleFonts.poppins(
//                                             fontSize: 16,
//                                             fontWeight: FontWeight.w400,
//                                             color: Colors.white),
//                                       ),
//                                       Text(
//                                         "₦${_getReceiptModel!.amountPaid.toString()}",
//                                         style:  GoogleFonts.poppins(
//                                             fontSize: 16,
//                                             fontWeight: FontWeight.w500,
//                                             color: Colors.white),
//                                       ),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                               Column(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     "${SessionHelper().get(SessionHelper.NO_OF_SERVICES).toString()} Services",
//                                     style: const TextStyle(
//                                         fontSize: 13,
//                                         fontWeight: FontWeight.w300,
//                                         color: Colors.transparent),
//                                   ),
//                                   _getReceiptModel!.paidFull.toString()=="Full"?
//                                   Row(
//                                     children: [
//                                       Text(
//                                         "PAID IN FULL  ",
//                                         style: GoogleFonts.poppins(
//                                             fontSize: 16,
//                                             fontWeight: FontWeight.w500,
//                                             color: Colors.white),
//                                       ),
//                                       Text(
//                                         "₦${_getReceiptModel!.amountPaid.toString()}",
//                                         style: GoogleFonts.poppins(
//                                             fontSize: 16,
//                                             fontWeight: FontWeight.w600,
//                                             color: Colors.white),
//                                       ),
//                                     ],
//                                   )
//                                       :
//                                   Row(
//                                     children: [
//                                       Text(
//                                         "PAID IN HALF  ",
//                                         style: GoogleFonts.poppins(
//                                             fontSize: 16,
//                                             fontWeight: FontWeight.w500,
//                                             color: Colors.white),
//                                       ),
//                                       Text(
//                                         "₦${_getReceiptModel!.amountPaid.toString()}",
//                                         style: GoogleFonts.poppins(
//                                             fontSize: 16,
//                                             fontWeight: FontWeight.bold,
//                                             color: Colors.white),
//                                       ),
//                                     ],
//                                   )
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                         const SizedBox(
//                           height: 30,
//                         ),
//                         widget.whichScreen=="upcoming" || widget.whichScreen=="past"?
//                             Container():
//                         Padding(
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 20.0, vertical: 10),
//                           child: MaterialButton(
//                             color: AppColor.primeryColor,
//                             shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(10)),
//                             onPressed: () {
//                               Navigator.of(context).pushAndRemoveUntil(
//                                   MaterialPageRoute(
//                                       builder: (context) => BottomNavBar()),
//                                   (Route<dynamic> route) => false);
//                               // Helper.moveToScreenwithPushreplaceemt(context, BottomNavBar());
//                             },
//                             minWidth: 320,
//                             height: 45,
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text(
//                                   "FINISH",
//                                   style: GoogleFonts.quicksand(
//                                     textStyle: const TextStyle(
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.bold,
//                                       color: Colors.black,
//                                     ),
//                                   ),
//                                 ),
//                                 const Icon(Icons.arrow_forward)
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   // Positioned(
//                   //   bottom: 0,
//                   //   child: Container(
//                   //     width: MediaQuery.of(context).size.width,
//                   //     decoration: BoxDecoration(
//                   //         color: Colors.white,
//                   //         borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight:Radius.circular(30) )
//                   //     ),
//                   //     child: Padding(
//                   //       padding: const EdgeInsets.all(15.0),
//                   //       child: Row(
//                   //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   //         children: [
//                   //           Column(
//                   //             mainAxisAlignment: MainAxisAlignment.center,
//                   //             crossAxisAlignment: CrossAxisAlignment.start,
//                   //             children: [
//                   //               Text("${ SessionHelper().get(SessionHelper.NO_OF_SERVICES).toString()} Services",
//                   //                 style: TextStyle(fontSize: 13,fontWeight: FontWeight.w300,color: Colors.black),),
//                   //               Text("TOTAL ₦${widget.totalAmount}",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.black),),
//                   //             ],
//                   //           ),
//                   //           MaterialButton(
//                   //             color:AppColor.primeryColor,
//                   //             minWidth: 160,
//                   //             child: Row(
//                   //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   //               children: [
//                   //                 Text("FINISH",
//                   //                     style: GoogleFonts.quicksand(
//                   //                       textStyle: TextStyle(
//                   //                         fontSize: 16, fontWeight: FontWeight.bold, color:Colors.black,),
//                   //                     ),
//                   //                 ),
//                   //                 Icon(Icons.arrow_forward)
//                   //               ],
//                   //             ),
//                   //             shape: RoundedRectangleBorder(
//                   //                 borderRadius: BorderRadius.circular(5)),
//                   //             onPressed: () {
//                   //               Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
//                   //                   BottomNavBar()), (Route<dynamic> route) => false);
//                   //              // Helper.moveToScreenwithPushreplaceemt(context, BottomNavBar());
//                   //             },
//                   //           ),
//                   //         ],
//                   //       ),
//                   //     ),
//                   //   ),
//                   // )
//                 ],
//               ),
//             ),
//           Helper.getProgressBar(context, _isVisible)
//         ],
//       ),
//     );
//   }
//
//   getdata() async {
//     SessionHelper session = await SessionHelper.getInstance(context);
//     String fullNAme = session.get(SessionHelper.FULLNAME) ?? "";
//     String image = session.get(SessionHelper.IMAGE) ?? "";
//     String noti_counthere  = session.get(SessionHelper.NOTI_COUNT.toString())?? "0";
//
//     setState(() {
//
//       // name = fullNAme;
//       // imagesource = image;
//       noti_count=int.parse(noti_counthere);
//       print("noticount in get data===>${noti_count.toString()}");
//     });
//   }
//
//   pw.Document generateReceipt(String customerName, double amount) {
//     print("generateReceipt");
//     final pdf = pw.Document();
//     pdf.addPage(
//         pw.MultiPage(
//             pageFormat: PdfPageFormat.a4,
//             // header:(context){
//             //       return
//             //         pw.Container(
//             //             color: PdfColors.black,
//             //             width: 700,
//             //             height: 600,
//             //             child: pw.Column(
//             //               crossAxisAlignment: pw.CrossAxisAlignment.start,
//             //               children: [
//             //                 pw.Text('Receipt',
//             //                     style: pw.TextStyle(fontSize: 20,color: PdfColors.white,
//             //                     )
//             //                 ),
//             //                 pw.Text('Customer Name: $customerName',
//             //                     style: pw.TextStyle(fontSize: 20,color: PdfColors.white,
//             //                     )
//             //                 ),
//             //                 pw.Text('Amount: \$${amount.toStringAsFixed(2)}',
//             //                     style: pw.TextStyle(fontSize: 20,color: PdfColors.white,
//             //                     )
//             //                 ),
//             //               ],
//             //             )
//             //         );
//             // },
//             // build: (context){
//             // return [
//             //   pw.Container(
//             //       color: PdfColors.black,
//             //       width: 700,
//             //       height: 600,
//             //       child: pw.Column(
//             //         crossAxisAlignment: pw.CrossAxisAlignment.start,
//             //         children: [
//             //           pw.Text('Receipt',
//             //               style: pw.TextStyle(fontSize: 20,color: PdfColors.white,
//             //               )
//             //           ),
//             //           pw.Text('Customer Name: $customerName',
//             //               style: pw.TextStyle(fontSize: 20,color: PdfColors.white,
//             //               )
//             //           ),
//             //           pw.Text('Amount: \$${amount.toStringAsFixed(2)}',
//             //               style: pw.TextStyle(fontSize: 20,color: PdfColors.white,
//             //               )
//             //           ),
//             //         ],
//             //       )
//             //   )
//             // ] ;
//             // },
//             header: (context) {
//               return pw.Column(
//                   crossAxisAlignment: pw.CrossAxisAlignment.start,
//                   mainAxisAlignment: pw.MainAxisAlignment.start,
//                   children: [
//                     pw.Row(
//                         crossAxisAlignment: pw.CrossAxisAlignment.center,
//                         mainAxisAlignment: pw.MainAxisAlignment.center,
//                         children: [
//                           pw.Text(
//                             // checkQuotation ? 'QUOTATION' : 'INVOICE',
//                             "Aheadly Receipt",
//                             style: pw.TextStyle(
//                                 fontSize: 18, fontWeight: pw.FontWeight.bold),
//                           ),
//                         ]),
//                     pw.Row(
//                         mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//                         crossAxisAlignment: pw.CrossAxisAlignment.center,
//                         children: [
//                           pw.Column(
//                               mainAxisAlignment: pw.MainAxisAlignment.start,
//                               crossAxisAlignment: pw.CrossAxisAlignment.start,
//                               children: [
//                                 pw.Text(
//                                   // "Vijay Saloon",
//                                   _getReceiptModel!.data!.shopName.toString(),
//                                   style: pw.TextStyle(
//                                       fontSize: 12,
//                                       fontWeight: pw.FontWeight.bold),
//                                 ),
//                                 // pw.SizedBox(height: 5),
//                                 // pw.Text(
//                                 //   // companyModel.name
//                                 //   "Saloon",
//                                 //   style: const pw.TextStyle(fontSize: 11),
//                                 // ),
//                                 pw.SizedBox(height: 5),
//                                 pw.Text(
//                                   // "Indore",
//                                   _getReceiptModel!.data!.address.toString(),
//                                   style: const pw.TextStyle(fontSize: 11),
//                                 ),
//                                 pw.SizedBox(height: 5),
//                                 // if (companyModel.mobileNumber.trim().isNotEmpty)
//                                 pw.Row(children: [
//                                   // pw.Text(
//                                   //   // "8827676790",
//                                   //   _getReceiptModel!.data!.phone.toString(),
//                                   //   style: const pw.TextStyle(fontSize: 11,
//                                   //       color: PdfColors.black
//                                   //   ),
//                                   // ),
//                                   pw.SizedBox(width: 10),
//
//                                 ]),
//                               ]),
//                           // if (companyModel.logoImage != null)
//                           //   pw.Container(
//                           //       height: 100,
//                           //       width: 100,
//                           //       child: pw.Image(
//                           //           pw.MemoryImage(companyModel.logoImage!),
//                           //           fit: pw.BoxFit.fill))
//                         ]),
//                     // pw.SizedBox(
//                     //   height: 5,
//                     // ),
//                     // pw.Divider(
//                     //   color: PdfColors.grey,
//                     //   thickness: 1,
//                     // ),
//                     // pw.SizedBox(
//                     //   height: 5,
//                     // ),
//                     pw.Column(
//                         mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//                         crossAxisAlignment: pw.CrossAxisAlignment.start,
//                         children: [
//                           // pw.Column(
//                           //     mainAxisAlignment: pw.MainAxisAlignment.start,
//                           //     crossAxisAlignment: pw.CrossAxisAlignment.start,
//                           //     children: [
//                           //       pw.Text(
//                           //         // 'To,\n${model.companyName}',
//                           //         "Saloon Name",
//                           //         style: pw.TextStyle(
//                           //             fontSize: 11, fontWeight: pw.FontWeight.bold),
//                           //       ),
//                           //       pw.Text(
//                           //         // model.name,
//                           //         "name",
//                           //         style: const pw.TextStyle(fontSize: 11),
//                           //       ),
//                           //       // if (model.mobileNumber.trim().isNotEmpty)
//                           //         pw.Text(
//                           //           "${"model.countryCode.dialCode"} ${"model.mobileNumber"}",
//                           //           style: const pw.TextStyle(fontSize: 11),
//                           //         ),
//                           //       pw.Text(
//                           //         // model.email,
//                           //         "email",
//                           //         style: const pw.TextStyle(fontSize: 11),
//                           //       ),
//                           //     ]),
//                           pw.Container(
//                             padding: pw.EdgeInsets.symmetric(horizontal: 0),
//                             child: pw.Column(
//                               mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//                               crossAxisAlignment: pw.CrossAxisAlignment.start,
//                               children: [
//                                 ///order id,date
//                                 pw.Column(
//                                   crossAxisAlignment: pw.CrossAxisAlignment.start,
//                                   children: [
//                                     pw.Text(
//                                       "Order ID: ${_getReceiptModel!.data!.orderId.toString()}" ,
//                                       // _getReceiptModel!.data!.orderId
//                                       //     .toString(),
//                                       style: pw.TextStyle(
//                                           fontSize: 11,
//                                           fontWeight: pw.FontWeight.normal,
//                                           color: PdfColors.black),
//                                     ),
//                                     // pw.SizedBox(
//                                     //   height: 5,
//                                     // ),
//                                     // pw.Text(
//                                     //   // "Sept 04,2023",
//                                     //   _getReceiptModel!.data!.date.toString(),
//                                     //   style: pw.TextStyle(
//                                     //       fontSize: 11,
//                                     //       fontWeight: pw.FontWeight.normal,
//                                     //       color: PdfColors.black),
//                                     // ),
//                                   ],
//                                 ),
//                                 pw.SizedBox(
//                                   height: 5,
//                                 ),
//                                 ///Appointment Time,Location,Barber Name
//                                 pw.Row(
//                                   mainAxisAlignment: pw.MainAxisAlignment.start,
//                                   children: [
//                                     /*pw.Icon(
//                                         Icons.restore,
//                                         color: PdfColors.black,
//                                       ),*/
//                                     // pw.SizedBox(
//                                     //   width: 10,
//                                     // ),
//                                     pw.Flexible(
//                                         child: pw.Text(
//                                           // "Apointment Time :04.32PM - 04/09/2023 " ,
//                                           "Apointment Time:${_getReceiptModel!.data!.time.toString()}"
//                                               " - ${_getReceiptModel!.data!.date.toString()}" ,
//                                           style: pw.TextStyle(
//                                               fontSize: 11,
//                                               fontWeight: pw.FontWeight.normal,
//                                               color: PdfColors.black),
//                                         )),
//                                   ],
//                                 ),
//                                 // pw.SizedBox(
//                                 //   height: 5,
//                                 // ),
//                                 // pw.Divider(
//                                 //   color: PdfColors.grey,
//                                 //   thickness: 1,
//                                 // ),
//                                 pw.SizedBox(
//                                   height: 5,
//                                 ),
//                                 pw.Row(
//                                   mainAxisAlignment: pw.MainAxisAlignment.start,
//                                   children: [
//                                     // pw.Icon(
//                                     //   Icons.loca tion_on_outlined,
//                                     //   size: 25,
//                                     //   color: PdfColors.black,
//                                     // ),
//                                     // pw.SizedBox(
//                                     //   width: 10,
//                                     // ),
//                                     // pw.Flexible(
//                                     //     child: pw.Text(
//                                     //       // "Salon Location - Vijay Nagar"
//                                     //       "Salon Location - ${_getReceiptModel!.data!.location.toString()}",
//                                     //       style:pw.TextStyle(
//                                     //           fontSize: 11,
//                                     //           fontWeight: pw.FontWeight.normal,
//                                     //           color: PdfColors.black),
//                                     //     )),
//                                   ],
//                                 ),
//                                 // pw.
//                                 // SizedBox(
//                                 //   height: 5,
//                                 // ),
//                                 // _getReceiptModel!.data!.fullname.toString() ==
//                                 //     "staffName"
//                                 //     ? const SizedBox()
//                                 //     :
//                                 pw.Column(
//                                   children: [
//                                     // pw.Divider(
//                                     //   // color: Color(0xFF4D4D4D),
//                                     //   color: PdfColors.grey,
//                                     //   thickness: 1,
//                                     // ),
//                                     // pw.SizedBox(
//                                     //   height: 5,
//                                     // ),
//                                     pw.Row(
//                                       mainAxisAlignment: pw.MainAxisAlignment.start,
//                                       children: [
//                                         // pw.Icon(
//                                         //   pdf.location_on_outlined,
//                                         //   size: 25,
//                                         //   color: PdfColors.black,
//                                         // ),PAID IN FULL  115,600
//                                         // pw.SizedBox(
//                                         //   width: 10,
//                                         // ),
//                                         pw.Text(
//                                           // "Barber: Chandra"
//                                           "Barber: ${_getReceiptModel!.data!.fullname.toString()}",
//                                           style: pw.TextStyle(
//                                               fontSize: 11,
//                                               fontWeight: pw.FontWeight.normal,
//                                               color: PdfColors.black),
//                                         ),
//
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//                                 // _getReceiptModel!.data!.coupon.toString()==""?
//                                 // pw.SizedBox():
//                                 // pw.SizedBox(
//                                 //   height: 5,
//                                 // ),
//                                 //
//                                 // _getReceiptModel!.data!.coupon.toString()==""?
//                                 //     pw.SizedBox():
//                                 // pw.Text(
//                                 //   "Promo : ${_getReceiptModel!.data!.coupon.toString()}",
//                                 //   // overflow: TextOverflow.ellipsis,
//                                 //   maxLines: 2,
//                                 //   style:  pw.TextStyle(
//                                 //       fontSize: 11,
//                                 //       fontWeight: pw.FontWeight.normal,
//                                 //       color: PdfColors.black),
//                                 // ),
//
//                                 pw.SizedBox(
//                                   height: 10,
//                                 ),
//                                 // Image.asset(
//                                 //   Img.downloading,
//                                 //   height: 30,
//                                 //   width: 30,
//                                 // ),
//                               ],
//                             ),
//                           ),
//                           // pw.Row(
//                           //     mainAxisAlignment: pw.MainAxisAlignment.start,
//                           //     crossAxisAlignment: pw.CrossAxisAlignment.end,
//                           //     children: [
//                           //       pw.Column(
//                           //           mainAxisAlignment: pw.MainAxisAlignment.end,
//                           //           crossAxisAlignment: pw.CrossAxisAlignment.end,
//                           //           children: [
//                           //             pw.Text(
//                           //               // "${checkQuotation ? "Quote" : "Invoice"} No. :",
//                           //               "Invoice",
//                           //               style: pw.TextStyle(
//                           //                   fontSize: 14,
//                           //                   fontWeight: pw.FontWeight.bold),
//                           //             ),
//                           //             pw.Text(
//                           //               'Date :',
//                           //               style: pw.TextStyle(
//                           //                   fontSize: 11,
//                           //                   fontWeight: pw.FontWeight.bold),
//                           //             ),
//                           //             // if (poNumber.isNotEmpty)
//                           //               pw.Text(
//                           //                 'PO : ',
//                           //                 style: pw.TextStyle(
//                           //                     fontSize: 11,
//                           //                     fontWeight: pw.FontWeight.bold),
//                           //               ),
//                           //             // if (dueDate != null)
//                           //               pw.Text(
//                           //                 'Due Date :',
//                           //                 style: pw.TextStyle(
//                           //                     fontSize: 11,
//                           //                     fontWeight: pw.FontWeight.bold),
//                           //               ),
//                           //           ]),
//                           //       pw.SizedBox(width: 10),
//                           //       pw.Column(
//                           //           mainAxisAlignment: pw.MainAxisAlignment.end,
//                           //           crossAxisAlignment: pw.CrossAxisAlignment.end,
//                           //           children: [
//                           //             pw.Text(
//                           //               // "${length + 1}",
//                           //               "akd",
//                           //               style: const pw.TextStyle(fontSize: 14),
//                           //             ),
//                           //             pw.Text(
//                           //               "${"time.day"}-${"time.month"}-${"time.year"}",
//                           //               style: const pw.TextStyle(fontSize: 11),
//                           //             ),
//                           //             // if (poNumber.isNotEmpty)
//                           //               pw.Text(
//                           //                 "poNumber",
//                           //                 style: const pw.TextStyle(fontSize: 11),
//                           //               ),
//                           //             // if (dueDate != null)
//                           //               pw.Text(
//                           //                 "${"dueDate.day"}-${"dueDate.month"}-${"dueDate.year"}",
//                           //                 style: const pw.TextStyle(fontSize: 11),
//                           //               ),
//                           //           ]),
//                           //     ]),
//                         ]),
//                     // pw.SizedBox(height: 5),
//                     pw.ListView.builder(
//                       itemCount: _getReceiptModel!.services!.length,
//                       itemBuilder: (context1, index) {
//                         return
//                           pw.Container(
//                               margin: pw.EdgeInsets.only(
//                                   top: 10
//                               ),
//                               child:
//                               pw.Row(
//                                 mainAxisAlignment:
//                                 pw.MainAxisAlignment.spaceBetween,
//                                 crossAxisAlignment: pw.CrossAxisAlignment.start,
//                                 children: [
//                                   pw.Row(
//                                     children: [
//                                       pw.Container(
//                                         height: 10,
//                                         width: 10,
//                                         padding: pw.EdgeInsets.all(5),
//                                         // margin: pw.EdgeInsets.all(5),
//                                         decoration: const pw.BoxDecoration(
//                                             color: PdfColors.black,
//                                             shape: pw.BoxShape.circle),
//                                         // child: const Icon(
//                                         //   Icons.check,
//                                         //   color: Colors.white,
//                                         // ),
//                                       ),
//                                       pw.SizedBox(width: 5),
//                                       pw.Column(
//                                         mainAxisAlignment:
//                                         pw.MainAxisAlignment.center,
//                                         crossAxisAlignment:
//                                         pw.CrossAxisAlignment.start,
//                                         children: [
//                                           pw.Container(
//                                             // width: MediaQuery.of(context)
//                                             //   .size
//                                             //   .width *
//                                             //   0.40,
//                                             // color: Colors.red,
//                                             child: pw.Text(
//                                               // _getReceiptModel!.services![index].toString(),
//                                               _getReceiptModel!
//                                                   .services![index]
//                                                   .toString(),
//                                               style:  pw.TextStyle(
//                                                   fontSize: 11,
//                                                   fontWeight:
//                                                   pw.FontWeight.normal,
//                                                   color:
//                                                   PdfColors.black),
//                                             ),
//                                           ),
//                                           pw.Container(
//                                             // width: MediaQuery.of(context)
//                                             //     .size
//                                             //     .width *
//                                             //     0.40,
//                                             // color: Colors.red,
//                                             child: pw.Text(
//                                               _getReceiptModel!.duration![index].toString(),
//                                               // _getReceiptModel!.duration![index].toString(),
//                                               style:
//                                               pw.TextStyle(
//                                                   fontSize: 10,
//                                                   fontWeight:
//                                                   pw.FontWeight.normal,
//                                                   color:
//                                                   PdfColors.black),
//
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//                                   pw.Row(
//                                     children: [
//                                       // Image.asset(
//                                       //   Img.curr,
//                                       //   height: 20,
//                                       //   width: 30,
//                                       // ),
//                                       // pw.Image(image),
//                                       pw.Text(
//                                         // _getReceiptModel!.price![index].toString(),
//                                         "${_getReceiptModel!.price![index].toString()} NGN",
//                                         style:pw.TextStyle(
//                                             fontSize: 11,
//                                             color: PdfColors.black,
//                                             fontWeight:
//                                             pw.FontWeight.normal),
//
//                                       ),
//                                     ],
//                                   )
//                                 ],
//                               )
//                           );
//                       },
//                     ),
//
//                     // _getReceiptModel!.data!.discount.toString()==""?
//                     // pw.SizedBox():
//                     pw.SizedBox(
//                       height: 10,
//                     ),
//                     pw.Row(
//                       mainAxisAlignment:
//                       pw.MainAxisAlignment.spaceBetween,
//                       crossAxisAlignment: pw.CrossAxisAlignment.start,
//                       children: [
//                         pw.Row(
//                           children: [
//                             pw.Container(
//                               height: 10,
//                               width: 10,
//                               padding: pw.EdgeInsets.all(5),
//                               // margin: pw.EdgeInsets.all(5),
//                               decoration: const pw.BoxDecoration(
//                                   color: PdfColors.black,
//                                   shape: pw.BoxShape.circle),
//                               // child: const Icon(
//                               //   Icons.check,
//                               //   color: Colors.white,
//                               // ),
//                             ),
//                             pw.SizedBox(width: 5),
//                             pw.Column(
//                               mainAxisAlignment:
//                               pw.MainAxisAlignment.center,
//                               crossAxisAlignment:
//                               pw.CrossAxisAlignment.start,
//                               children: [
//                                 pw.Container(
//                                   // width: MediaQuery.of(context)
//                                   //   .size
//                                   //   .width *
//                                   //   0.40,
//                                   // color: Colors.red,
//                                   child: pw.Text(
//                                     // _getReceiptModel!.services![index].toString(),
//                                     "Discount",
//                                     style:  pw.TextStyle(
//                                         fontSize: 11,
//                                         fontWeight:
//                                         pw.FontWeight.normal,
//                                         color:
//                                         PdfColors.black),
//                                   ),
//                                 ),
//                                 // pw.Container(
//                                 //   // width: MediaQuery.of(context)
//                                 //   //     .size
//                                 //   //     .width *
//                                 //   //     0.40,
//                                 //   // color: Colors.red,
//                                 //   child: pw.Text(
//                                 //     _getReceiptModel!.data!.discount.toString(),
//                                 //     // _getReceiptModel!.duration![index].toString(),
//                                 //     style:
//                                 //     pw.TextStyle(
//                                 //         fontSize: 10,
//                                 //         fontWeight:
//                                 //         pw.FontWeight.normal,
//                                 //         color:
//                                 //         PdfColors.black),
//                                 //   ),
//                                 // ),
//                               ],
//                             ),
//                           ],
//                         ),
//                         pw.Row(
//                           children: [
//                             // Image.asset(
//                             //   Img.curr,
//                             //   height: 20,
//                             //   width: 30,
//                             // ),
//                             // pw.Image(image),
//                             pw.Text(
//                               _getReceiptModel!.data!.discount.toString()==""?
//                                   "0NGN":
//                               "${_getReceiptModel!.data!.discount.toString()}NGN",
//                               style:pw.TextStyle(
//                                   fontSize: 11,
//                                   color: PdfColors.black,
//                                   fontWeight:
//                                   pw.FontWeight.normal),
//
//                             ),
//                           ],
//                         )
//                       ],
//                     ),
//
//
//
//                     pw.SizedBox(height: 5),
//                     // pw.Row(
//                     //   mainAxisAlignment:
//                     //   pw.MainAxisAlignment.spaceBetween,
//                     //   crossAxisAlignment: pw.CrossAxisAlignment.start,
//                     //   children: [
//                     //     pw.Row(
//                     //       children: [
//                     //         pw.Container(
//                     //           height: 10,
//                     //           width: 10,
//                     //           padding: pw.EdgeInsets.all(5),
//                     //           // margin: pw.EdgeInsets.all(5),
//                     //           decoration: const pw.BoxDecoration(
//                     //               color: PdfColors.black,
//                     //               shape: pw.BoxShape.circle),
//                     //           // child: const Icon(
//                     //           //   Icons.check,
//                     //           //   color: Colors.white,
//                     //           // ),
//                     //         ),
//                     //         pw.SizedBox(width: 5),
//                     //         pw.Column(
//                     //           mainAxisAlignment:
//                     //           pw.MainAxisAlignment.center,
//                     //           crossAxisAlignment:
//                     //           pw.CrossAxisAlignment.start,
//                     //           children: [
//                     //             pw.Container(
//                     //               // width: MediaQuery.of(context)
//                     //               //   .size
//                     //               //   .width *
//                     //               //   0.40,
//                     //               // color: Colors.red,
//                     //               child: pw.Text(
//                     //                 // _getReceiptModel!.services![index].toString(),
//                     //                 "Keratine",
//                     //                 style:  pw.TextStyle(
//                     //                     fontSize: 11,
//                     //                     fontWeight:
//                     //                     pw.FontWeight.normal,
//                     //                     color:
//                     //                     PdfColors.black),
//                     //
//                     //               ),
//                     //             ),
//                     //             pw.Container(
//                     //               // width: MediaQuery.of(context)
//                     //               //     .size
//                     //               //     .width *
//                     //               //     0.40,
//                     //               // color: Colors.red,
//                     //               child: pw.Text(
//                     //                 "30 min",
//                     //                 // _getReceiptModel!.duration![index].toString(),
//                     //                 style:
//                     //                 pw.TextStyle(
//                     //                     fontSize: 10,
//                     //                     fontWeight:
//                     //                     pw.FontWeight.normal,
//                     //                     color:
//                     //                     PdfColors.black),
//                     //
//                     //               ),
//                     //             ),
//                     //           ],
//                     //         ),
//                     //       ],
//                     //     ),
//                     //     pw.Row(
//                     //       children: [
//                     //         // Image.asset(
//                     //         //   Img.curr,
//                     //         //   height: 20,
//                     //         //   width: 30,
//                     //         // ),
//                     //         pw.Text(
//                     //           // _getReceiptModel!.price![index].toString(),
//                     //           "500",
//                     //           style:pw.TextStyle(
//                     //               fontSize: 11,
//                     //               color: PdfColors.black,
//                     //               fontWeight:
//                     //               pw.FontWeight.normal),
//                     //
//                     //         ),
//                     //       ],
//                     //     )
//                     //   ],
//                     // ),
//                     // pw.Row(
//                     //     children: [
//                     //   pw.Text(
//                     //     "Subject : ",
//                     //     style: pw.TextStyle(
//                     //         fontSize: 11, fontWeight: pw.FontWeight.bold),
//                     //   ),
//                     //   pw.Text(
//                     //     // subjectModel.subject,
//                     //     "subject - haircut",
//                     //     style: const pw.TextStyle(fontSize: 11),
//                     //   ),
//                     // ]),
//                     // pw.SizedBox(height: 5),
//                     // pw.Text(
//                     //   "Dear Sir/Mam,",
//                     //   style: const pw.TextStyle(fontSize: 11),
//                     // ),
//                     // pw.SizedBox(height: 10),
//                     // pw.Text(
//                     //   "Thank you for your valuable inquiry. We are pleased to quote as below:",
//                     //   style: const pw.TextStyle(fontSize: 11),
//                     // ),
//                     pw.SizedBox(height: 5),
//                     pw.Container(height: 1, ),
//                     pw.SizedBox(height: 5),
//                     pw.Table(
//                       border: null,
//                       columnWidths: {
//                         0: const pw.FractionColumnWidth(0.1),
//                         1: const pw.FractionColumnWidth(0.39),
//                         2: const pw.FractionColumnWidth(0.11),
//                         3: const pw.FractionColumnWidth(0.13),
//                         4: const pw.FractionColumnWidth(0.12),
//                         5: const pw.FractionColumnWidth(0.11),
//                         6: const pw.FractionColumnWidth(0.18),
//                       },
//                       // children: tableHeaderRow,
//                       children: [
//
//                       ],
//                     ),
//                     // pw.SizedBox(height: 5),
//                     pw.Container(height: 1, color: PdfColors.black),
//                     pw.SizedBox(height: 5),
//                     pw.Row(
//                         mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//                         children: [
//                           pw.Column(
//                               crossAxisAlignment: pw.CrossAxisAlignment.start,
//                               children: [
//                                 pw.Text('Services (${SessionHelper().get(SessionHelper.NO_OF_SERVICES).toString()})',
//                                   style:pw.TextStyle(
//                                       fontSize: 11,
//                                       color: PdfColors.black,
//                                       fontWeight:
//                                       pw.FontWeight.normal),
//                                 ),
//                                 pw.SizedBox(height: 5),
//                                 pw.Text("TOTAL ${_getReceiptModel!.amountPaid.toString()} NGN",
//                                   style:pw.TextStyle(
//                                       fontSize: 12,
//                                       color: PdfColors.black,
//                                       fontWeight:
//                                       pw.FontWeight.bold),
//                                 ),
//                               ]
//                           ),
//                           pw.Column(
//                               children: [
//                                 pw.Text('Services (3)',
//                                   style:pw.TextStyle(
//                                       fontSize: 11,
//                                       color: PdfColors.white,
//                                       fontWeight:
//                                       pw.FontWeight.normal),
//                                 ),
//                                 _getReceiptModel!.paidFull.toString()=="Full"?
//                                 pw.Text("PAID IN FULL  ${_getReceiptModel!.amountPaid.toString()} NGN",
//                                   style:pw.TextStyle(
//                                       fontSize: 11,
//                                       color: PdfColors.black,
//                                       fontWeight:
//                                       pw.FontWeight.normal),
//                                 ):
//                                 pw.Text("PAID IN HALF  ${_getReceiptModel!.amountPaid.toString()} NGN",
//                                   style:pw.TextStyle(
//                                       fontSize: 11,
//                                       color: PdfColors.black,
//                                       fontWeight:
//                                       pw.FontWeight.normal),
//                                 ),
//                               ]
//                           ),
//                         ]
//                     ),
//
//
//                   ]);
//             },
//             footer: (context) {
//               return pw.Container(
//                 alignment: pw.Alignment.bottomRight,
//                 child: pw.Column(
//                     crossAxisAlignment: pw.CrossAxisAlignment.end,
//                     mainAxisAlignment: pw.MainAxisAlignment.end,
//                     children: [
//                       pw.Container(height: 1, color: PdfColors.black),
//                       pw.SizedBox(height: 10),
//                       pw.Text('Page ${context.pageNumber}/${context.pagesCount}')
//                     ]),
//               );
//             },
//             build: (context) {
//               return [
//                 // pw.Container(height: 1, color: PdfColors.black),
//                 // pw.SizedBox(height: 10),
//                 pw.Container(),
//                 // pw.Table(
//                 //   border: null,
//                 //   columnWidths: {
//                 //     0: const pw.FractionColumnWidth(0.1),
//                 //     1: const pw.FractionColumnWidth(0.39),
//                 //     2: const pw.FractionColumnWidth(0.11),
//                 //     3: const pw.FractionColumnWidth(0.13),
//                 //     4: const pw.FractionColumnWidth(0.12),
//                 //     5: const pw.FractionColumnWidth(0.11),
//                 //     6: const pw.FractionColumnWidth(0.18),
//                 //   },
//                 //   // children: tableRows,
//                 // ),
//                 // pw.Container(height: 1, color: PdfColors.black),
//                 // pw.SizedBox(height: 3),
//                 // pw.Row(
//                 //     mainAxisAlignment: pw.MainAxisAlignment.end,
//                 //     crossAxisAlignment: pw.CrossAxisAlignment.start,
//                 //     children: [
//                 //       pw.Container(
//                 //           width: 200,
//                 //           child: pw.Column(children: [
//                 //             pw.Row(
//                 //                 mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//                 //                 crossAxisAlignment: pw.CrossAxisAlignment.start,
//                 //                 children: [
//                 //                   pw.Text(
//                 //                     "SUB Total",
//                 //                     style: const pw.TextStyle(fontSize: 11),
//                 //                   ),
//                 //                   pw.Text(
//                 //                     // subTotal.toStringAsFixed(2),
//                 //                     "subTotal.toStringAsFixed(2)",
//                 //                     style: const pw.TextStyle(fontSize: 11),
//                 //                   ),
//                 //                 ]),
//                 //             // pw.Row(
//                 //             //     mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//                 //             //     crossAxisAlignment: pw.CrossAxisAlignment.start,
//                 //             //     children: [
//                 //             //       pw.Text(
//                 //             //         "Tax",
//                 //             //         style: const pw.TextStyle(fontSize: 11),
//                 //             //       ),
//                 //             //       pw.Text(
//                 //             //         // totalGST.toStringAsFixed(2),
//                 //             //         "totalGST.toStringAsFixed(2)",
//                 //             //         style: const pw.TextStyle(fontSize: 11),
//                 //             //       ),
//                 //             //     ]),
//                 //             pw.SizedBox(height: 5),
//                 //             pw.Container(height: 1, color: PdfColors.black),
//                 //             pw.SizedBox(height: 2),
//                 //             pw.Row(
//                 //                 mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//                 //                 crossAxisAlignment: pw.CrossAxisAlignment.start,
//                 //                 children: [
//                 //                   pw.Text(
//                 //                     "Net Total",
//                 //                     style: const pw.TextStyle(fontSize: 11),
//                 //                   ),
//                 //                   pw.Text(
//                 //                     "grandTotal",
//                 //                     style: const pw.TextStyle(fontSize: 11),
//                 //                   ),
//                 //                 ]),
//                 //             pw.SizedBox(height: 2),
//                 //             pw.Container(height: 1, color: PdfColors.black),
//                 //           ]))
//                 //     ]),
//                 // pw.SizedBox(height: 5),
//                 // if (companyModel.message.isNotEmpty)
//                 ///amit
// //                     pw.Text(
// //                      " companyModel.message",
// //                       style: const pw.TextStyle(fontSize: 11),
// //                     ),
// //                   // if (companyModel.message.isNotEmpty)
// //
// //                     pw.SizedBox(height: 5),
// //                   // if (terms.isNotEmpty)
// //                     pw.Text(
// //                       "Terms & Conditions",
// //                       style: pw.TextStyle(fontSize: 11, fontWeight: pw.FontWeight.bold),
// //                     ),
// //                   // if (terms.isNotEmpty)
// //                     pw.SizedBox(height: 5),
// //                   pw.ListView.builder(
// //                       itemBuilder: (context1, index) {
// //                         return pw.Row(
// //                             mainAxisAlignment: pw.MainAxisAlignment.start,
// //                             crossAxisAlignment: pw.CrossAxisAlignment.center,
// //                             children: [
// //                               pw.Container(
// //                                   height: 5,
// //                                   width: 5,
// //                                   decoration: const pw.BoxDecoration(
// //                                       color: PdfColors.black,
// //                                       shape: pw.BoxShape.circle)),
// //                               pw.SizedBox(width: 10),
// //                               pw.Container(
// //                                   child: pw.Text(
// //                                     "terms[index].terms",
// //                                     style: const pw.TextStyle(fontSize: 11),
// //                                   ),
// //                                   constraints: const pw.BoxConstraints(maxWidth: 500))
// //                             ]);
// //                       },
// //                       itemCount: 2),
// //                   // if (companyModel.bankType.trim().isNotEmpty ||
// //                   //     companyModel.bankSwift.trim().isNotEmpty ||
// //                   //     companyModel.bankIFSE.trim().isNotEmpty ||
// //                   //     companyModel.bankBranchName.trim().isNotEmpty ||
// //                   //     companyModel.bankAccountNumber.trim().isNotEmpty ||
// //                   //     companyModel.bankHolderName.trim().isNotEmpty)
// //                     pw.Text(
// //                       "Bank Details :",
// //                       style: pw.TextStyle(fontSize: 11, fontWeight: pw.FontWeight.bold),
// //                     ),
// //                   pw.Row(
// //                       mainAxisAlignment: pw.MainAxisAlignment.start,
// //                       crossAxisAlignment: pw.CrossAxisAlignment.start,
// //                       children: [
// //                         pw.Column(
// //                             mainAxisAlignment: pw.MainAxisAlignment.start,
// //                             crossAxisAlignment: pw.CrossAxisAlignment.start,
// //                             children: [
// //                               // if (companyModel.bankHolderName.trim().isNotEmpty)
// //                                 pw.Text(
// //                                   "Account Holder Name",
// //                                   style: pw.TextStyle(
// //                                       fontSize: 11, fontWeight: pw.FontWeight.bold),
// //                                 ),
// //                               // if (companyModel.bankAccountNumber.trim().isNotEmpty)
// //                                 pw.Text(
// //                                   "Account Number",
// //                                   style: pw.TextStyle(
// //                                       fontSize: 11, fontWeight: pw.FontWeight.bold),
// //                                 ),
// //                               // if (companyModel.bankIFSE.trim().isNotEmpty)
// //                                 pw.Text(
// //                                   "IFSC",
// //                                   style: pw.TextStyle(
// //                                       fontSize: 11, fontWeight: pw.FontWeight.bold),
// //                                 ),
// //                               // if (companyModel.bankType.trim().isNotEmpty)
// //                                 pw.Text(
// //                                   "Bank Type",
// //                                   style: pw.TextStyle(
// //                                       fontSize: 11, fontWeight: pw.FontWeight.bold),
// //                                 ),
// //                               // if (companyModel.bankSwift.trim().isNotEmpty)
// //                                 pw.Text(
// //                                   "Bank Swift Code",
// //                                   style: pw.TextStyle(
// //                                       fontSize: 11, fontWeight: pw.FontWeight.bold),
// //                                 ),
// //                             ]),
// //                         pw.SizedBox(width: 10),
// //
// //                         pw.Column(
// //                             mainAxisAlignment: pw.MainAxisAlignment.start,
// //                             crossAxisAlignment: pw.CrossAxisAlignment.start,
// //                             children: [
// //                               // if (companyModel.bankHolderName.trim().isNotEmpty)
// //                                 pw.Text(
// //                                   ":",
// //                                   style: pw.TextStyle(
// //                                       fontSize: 11, fontWeight: pw.FontWeight.bold),
// //                                 ),
// //                               // if (companyModel.bankAccountNumber.trim().isNotEmpty)
// //                                 pw.Text(
// //                                   ":",
// //                                   style: pw.TextStyle(
// //                                       fontSize: 11, fontWeight: pw.FontWeight.bold),
// //                                 ),
// //                               // if (companyModel.bankIFSE.trim().isNotEmpty)
// //                                 pw.Text(
// //                                   ":",
// //                                   style: pw.TextStyle(
// //                                       fontSize: 11, fontWeight: pw.FontWeight.bold),
// //                                 ),
// //                               // if (companyModel.bankType.trim().isNotEmpty)
// //                                 pw.Text(
// //                                   ":",
// //                                   style: pw.TextStyle(
// //                                       fontSize: 11, fontWeight: pw.FontWeight.bold),
// //                                 ),
// //                               // if (companyModel.bankSwift.trim().isNotEmpty)
// //                                 pw.Text(
// //                                   ":",
// //                                   style: pw.TextStyle(
// //                                       fontSize: 11, fontWeight: pw.FontWeight.bold),
// //                                 ),
// //                             ]),
// //                         pw.SizedBox(width: 10),
// //                         pw.Column(
// //                             mainAxisAlignment: pw.MainAxisAlignment.start,
// //                             crossAxisAlignment: pw.CrossAxisAlignment.start,
// //                             children: [
// //                               // if (companyModel.bankHolderName.trim().isNotEmpty)
// //
// //                                 pw.Text(
// //                                   "companyModel.bankHolderName.trim()",
// //                                   style: const pw.TextStyle(
// //                                     fontSize: 11,
// //                                   ),),
// //                               // if (companyModel.bankAccountNumber.trim().isNotEmpty)
// //
// //                                 pw.Text(
// //                                 "  companyModel.bankAccountNumber.trim()",
// //                                   style: const pw.TextStyle(
// //                                     fontSize: 11,
// //                                   ),),
// //                               // if (companyModel.bankIFSE.trim().isNotEmpty)
// //                                 pw.Text(
// //                                   "companyModel.bankIFSE.trim()",
// //                                   style: const pw.TextStyle(
// //                                     fontSize: 11,
// //                                   ),),
// //                               // if (companyModel.bankType.trim().isNotEmpty)
// //                                 pw.Text(
// //                                  " companyModel.bankType.trim()",
// //                                   style: const pw.TextStyle(
// //                                     fontSize: 11,
// //                                   ),),
// //                               // if (companyModel.bankSwift.trim().isNotEmpty)
// //                                 pw.Text(
// //                                   "companyModel.bankSwift.trim()",
// //                                   style: const pw.TextStyle(
// //                                     fontSize: 11,
// //                                   ),),
// //                             ]),
// //                       ]),
// //                   pw.SizedBox(height: 15),
// //                   pw.Row(
// //                       mainAxisAlignment: pw.MainAxisAlignment.end,
// //                       crossAxisAlignment: pw.CrossAxisAlignment.start,
// //                       children: [
// //                         pw.Text(
// //                           "For, ${"companyModel.name"}",
// //                           style: pw.TextStyle(
// //                               fontSize: 11, fontWeight: pw.FontWeight.bold),
// //                         ),
// //                       ]),
// //                   pw.SizedBox(height: 20),
// //                   pw.Row(
// //                       mainAxisAlignment: pw.MainAxisAlignment.end,
// //                       crossAxisAlignment: pw.CrossAxisAlignment.start,
// //                       children: [
// //                         pw.Column(children: [
// //                           // companyModel.signatureImage.buffer.lengthInBytes == 0
// //                           //     ?
// //                           // pw.Container()
// //                           //     :
// //                           // pw.Container(
// //                           //     height: 100,
// //                           //     width: 100,
// //                           //     child:
// //                           //     pw.Image(
// //                           //         pw.MemoryImage(
// //                           //             companyModel.signatureImage.buffer
// //                           //             .asUint8List()),
// //                           //         fit: pw.BoxFit.fill)),
// //                           pw.Text(
// //                             "Authorized Signature",
// //                             style: const pw.TextStyle(fontSize: 11),
// //                           ),
// //                         ]),
// //                       ])
//               ];
//             }
//         )
//       // pw.Page(build: (context) {
//       //     return pw.Container(
//       //       color: PdfColors.black,
//       //       width: 700,
//       //       height: 600,
//       //       child: pw.Column(
//       //         crossAxisAlignment: pw.CrossAxisAlignment.start,
//       //         children: [
//       //           pw.Text('Receipt',
//       //               style: pw.TextStyle(fontSize: 20,color: PdfColors.white,
//       //               )
//       //           ),
//       //           pw.Text('Customer Name: $customerName'),
//       //           pw.Text('Amount: \$${amount.toStringAsFixed(2)}'),
//       //         ],
//       //       )
//       //     );
//       //   },),
//     );
//     return pdf;
//   }
//   showAlertDialog(BuildContext context) {
//     // set up the AlertDialog
//
//     AlertDialog alert = AlertDialog(
//       scrollable: false,
//       insetPadding: EdgeInsets.symmetric(horizontal: 0),
//       backgroundColor: Colors.transparent,
//       elevation: 0,
//       content: Container(
//           padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
//           margin: EdgeInsets.only(top: 50),
//           height: 300,
//           width: 380,
//           decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(30), color: Colors.white),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               SizedBox(height: 10),
//               InkWell(
//                   onTap: (){
//                     Helper.popScreen(context);
//                   },
//                   child: Image.asset(Img.Cancel_popup,height: 50,)),
//               Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 20.0),
//                 child: Text(
//                   "In order to save receipt on your device, You need to agree \"All files access\"",textAlign: TextAlign.center,
//                   style: GoogleFonts.poppins(
//                       textStyle: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w500,
//                         color: Colors.black,
//                       )),
//                 ),
//               ),
//
//               Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 10.0),
//                 child: MaterialButton(
//                   onPressed: (){
//                     // Helper.moveToScreenwithPushreplaceemt(context, BottomNavBar());
//                     Helper.popScreen(context);
//                     requestPermissions();
//                   },
//                   minWidth: 350,
//                   height: 45,
//                   color: AppColor.primeryColor,
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10)
//                   ),
//                   child: Text("Agree",
//                     style: GoogleFonts.poppins(
//                         color: Colors.black,
//                         fontSize: 18,
//                         fontWeight: FontWeight.w600
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           )),
//     );
//
//     // show the dialog
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (BuildContext context) {
//         return alert;
//       },
//     );
//   }
//   Future<void> requestPermissions2() async {
//     print("-----------------requestPermissions---------------");
//     final List<Permission> permissions = [
//       Permission.storage,
//     ];
//
//     final Map<Permission, PermissionStatus> permissionStatus = await permissions.request();
//
//     if (permissionStatus[Permission.storage] == PermissionStatus.granted) {
//       saveReceipts();
//       // You now have permission to access storage
//     } else {
//      // saveReceipts();
//       showAlertDialog(context);
//
//       // Permission denied
//     }
//   }
//
//   Future<void> requestPermissions() async {
//     print("-----------------requestPermissions---------------");
//     final List<Permission> permissions = [
//       Permission.storage,
//     ];
//
//     final Map<Permission, PermissionStatus> permissionStatus = await permissions.request();
//
//     if (permissionStatus[Permission.storage] == PermissionStatus.granted) {
//       saveReceipts();
//       // You now have permission to access storage
//     } else {
//       saveReceipts();
//
//
//       // Permission denied
//     }
//   }
//
//
//
//
//
//   Future<void> saveReceipts() async {
//     print("saveReceipts");
//     if (defaultTargetPlatform == TargetPlatform.android){
//       // Android specific code
//       // Replace with your receipt data or use a loop to generate multiple receipts
//       final receipt1 = generateReceipt('John Doe', 50.0);
//       final receipt2 = generateReceipt('Jane Smith', 75.5);
//
//       final directory = await getExternalStorageDirectory();
//
//       final file1 = File('${directory!.path}/receipt1.pdf');
//       final file2 =  File('${directory.path}/receipt2.pdf');
//
//       await file1.writeAsBytes(await receipt1.save());
//       await file2.writeAsBytes(await receipt2.save());
//
//
//       print("file1------------${file1.toString()}");
//
//       final specificPath = '/storage/emulated/0/Download/${_getReceiptModel!.data!.orderId.toString()}.pdf'; // Specify your desired path here
//       final file = File(specificPath);
//       // await file.writeAsBytes(await receipt2.save());
//       await file.writeAsBytes(await receipt2.save());
//
//       await Clipboard.setData(ClipboardData(text: ""))
//           .then((value) => {
//         ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text("Receipt downloaded..."))
//         )
//       });
//       // copied successfully
//
//     }
//     else if (defaultTargetPlatform == TargetPlatform.iOS){
//       //iOS specific code
//       // Replace with your receipt data or use a loop to generate multiple receipts
//       final receipt1 = generateReceipt('John Doe', 50.0);
//       final receipt2 = generateReceipt('Jane Smith', 75.5);
//
//       // Get the documents directory on Android and iOS
//       final directory = await getApplicationDocumentsDirectory();
//
//       // Create files in the documents directory
//       final file1 = File('${directory.path}/receipt1.pdf');
//       final file2 = File('${directory.path}/receipt2.pdf');
//
//       // Write receipt data to the files
//       // await file1.writeAsBytes(await receipt1.save());
//       //await file2.writeAsBytes(await receipt2.save());
//
//       print("file1------------${file1.toString()}");
//
//       // On iOS, you can use a specific path in the 'Documents' directory
//       final specificPath = '${directory.path}/${_getReceiptModel!.data!.orderId.toString()}.pdf'; // Specify your desired path here
//       print("specificPath------------${specificPath.toString()}");
//       final file = File(specificPath);
//
//       // Write receipt data to the file
//       await file.writeAsBytes(await receipt2.save());
//       print("file last ios------------${file.toString()}");
//       await Clipboard.setData(ClipboardData(text: ""))
//           .then((value) => {
//         ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text("Receipt downloaded..."))
//         )
//       });
//     }
//     else {
//       //web or desktop specific code
//     }
//
//   }
//
//   Future<void> checkPermissionAndAccessFile() async {
//     print("checkPermissionAndAccessFile");
//     PermissionStatus status = await Permission.storage.status;
//
//     if (status.isGranted) {
//       // You have permission to access storage
//       // Now, you can try to access the file
//       accessFile();
//     } else if (status.isDenied) {
//       // Permission has been denied. Request it again or inform the user.
//     } else if (status.isPermanentlyDenied) {
//       // Permission is permanently denied. Open app settings to enable it.
//       openAppSettings();
//     }
//   }
//
//   Future<void> accessFile() async {
//     print("accessFile");
//
//     final directory = await getExternalStorageDirectory();
//     final filePath = '${directory!.path}/Download/receipt.pdf';
//       print("filePath-------------${filePath}");
//     // Now, you can try to access the file at filePath
//   }
//   visible(bool show) {
//     setState(() {
//       _visible = show;
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
//   Future<void> GetReceiptApi() async {
//     print("<============= GetReceiptApi =============>");
//
//     SessionHelper sessionHelper = await SessionHelper.getInstance(context);
//     String userId = sessionHelper.get(SessionHelper.USER_ID) ?? "0";
//
//     print("<=============userId =============>" + userId);
//
//     setProgress(true);
//     Map data = {
//       'user_id': userId,
//       'id': widget.bookingId,
//     };
//
//     print("Request =============>" + data.toString());
//     try {
//       var res = await http.post(Uri.parse(Apis.getReceipt), body: data);
//       print("Response ============>" + res.body);
//
//       if (res.statusCode == 200) {
//         try {
//           final jsonResponse = jsonDecode(res.body);
//           GetReceiptModel model = GetReceiptModel.fromJson(jsonResponse);
//
//           if (model.status == "true") {
//             print("Model status true");
//
//             setProgress(false);
//
//             // print(
//             //     "model.data!.service1  = = = = = = = = = = = = = = = =  ${model.data!.service1}");
//
//             setState(() {
//               _getReceiptModel = model;
//               // service = servicesList;
//             });
//            // ToastMessage.msg(model.message.toString());
//           } else {
//             setProgress(false);
//             print("false ### ============>");
//             ToastMessage.msg(model.message.toString());
//           }
//         } catch (e) {
//           print("false ============>");
//           ToastMessage.msg(StaticMessages.API_ERROR);
//           print('exception ==> ' + e.toString());
//         }
//       } else {
//         print("status code ==> " + res.statusCode.toString());
//         ToastMessage.msg(StaticMessages.API_ERROR);
//       }
//     } catch (e) {
//       ToastMessage.msg(StaticMessages.API_ERROR);
//       print('Exception ======> ' + e.toString());
//     }
//     setProgress(false);
//   }
//
//
// }
//
// class ChatModell {
//   String time = "";
//   String service = "";
//   String price = "";
//
//   ChatModell({required this.time, required this.service, required this.price});
// }
