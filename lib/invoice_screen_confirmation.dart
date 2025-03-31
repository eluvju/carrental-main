import 'dart:io';
import 'package:external_path/external_path.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:flutter_svg/svg.dart'as svg;
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart';
import '../constant.dart';
import '../flutter/flutter_theme.dart';
import '../flutter/flutter_widgets.dart';
import '../flutter/internationalization.dart';

class InvoiceScreen extends StatefulWidget {
  String pdate = "";
  String ddate = "";
  String car_category;
  String payment_time ="";
  String payment_method ="";
  String customer_name ="";
  String coupon_amount ="";
  String car_owner ="";
  String totalFees ="";
  String car_type ="";
  String invoice_number ="";


  InvoiceScreen({required this.pdate,required this.ddate,required this.car_category,required this.coupon_amount,
    required this.payment_time,required this.payment_method,required this.customer_name,
    required this.car_owner,required this.totalFees,required this.car_type,required this.invoice_number});
  // DropOffAddress({required this.size, required this.catergory, required this.quantity,
  //   required this.vehicle_type, required this.name, required this.email, required this.order_number,
  //   required this.notes,required this.pickup_address,required this.pick_lat,required this.pick_long,required this.sender_number});

  @override
  State<InvoiceScreen> createState() => _InvoiceScreenState();
}

class _InvoiceScreenState extends State<InvoiceScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Container(
            height: double.infinity,
            width: double.infinity,
            child: Padding(
              padding:  EdgeInsets.symmetric(horizontal: 10.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 60,
                    ),
                    Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 0.0),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Color(0xffEEEEEE))
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            SvgPicture.asset(
                              'assets/images/invoice_logo.svg',
                              // width: 170.0,
                              //  height: 130.0,
                              fit: BoxFit.contain,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            SvgPicture.asset(
                              'assets/images/Success Icon.svg',
                              // width: 170.0,
                              //  height: 130.0,
                              fit: BoxFit.contain,
                            ),

                            Text(
                              "Payment Success!",
                              style: GoogleFonts.raleway(
                                  fontSize: 16,
                                  color: Color(0xff474747),
                                  fontWeight: FontWeight.w400 // Ensure the text is visible over the gradient
                              ),

                            ),
                            Text(
                              "${widget.totalFees}",
                              style: GoogleFonts.raleway(
                                  fontSize: 24,
                                  color: Color(0xff474747),
                                  fontWeight: FontWeight.w800 // Ensure the text is visible over the gradient
                              ),

                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Divider(
                              color: Color(0xffEDEDED),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Schedule Date ",
                                  style: GoogleFonts.raleway(
                                      fontSize: 13,
                                      color: Color(0xff707070),
                                      fontWeight: FontWeight.w400 // Ensure the text is visible over the gradient
                                  ),

                                ),
                                Text(
                                  "${widget.pdate}-${widget.ddate}",
                                  style: GoogleFonts.raleway(
                                      fontSize: 13,
                                      color: Color(0xff121212),
                                      fontWeight: FontWeight.w600 // Ensure the text is visible over the gradient
                                  ),

                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //   children: [
                            //     Text(
                            //       "Car Category ",
                            //       style: GoogleFonts.raleway(
                            //           fontSize: 13,
                            //           color: Color(0xff707070),
                            //           fontWeight: FontWeight.w400 // Ensure the text is visible over the gradient
                            //       ),
                            //
                            //     ),
                            //     Text(
                            //       "${widget.car_type}",
                            //       style: GoogleFonts.raleway(
                            //           fontSize: 13,
                            //           color: Color(0xff121212),
                            //           fontWeight: FontWeight.w600 // Ensure the text is visible over the gradient
                            //       ),
                            //
                            //     ),
                            //   ],
                            // ),
                            // SizedBox(
                            //   height: 10,
                            // ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Payment Time ",
                                  style: GoogleFonts.raleway(
                                      fontSize: 13,
                                      color: Color(0xff707070),
                                      fontWeight: FontWeight.w400 // Ensure the text is visible over the gradient
                                  ),

                                ),
                                Text(
                                  widget.payment_time,
                                  style: GoogleFonts.raleway(
                                      fontSize: 13,
                                      color: Color(0xff121212),
                                      fontWeight: FontWeight.w600 // Ensure the text is visible over the gradient
                                  ),

                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Payment Method ",
                                  style: GoogleFonts.raleway(
                                      fontSize: 13,
                                      color: Color(0xff707070),
                                      fontWeight: FontWeight.w400 // Ensure the text is visible over the gradient
                                  ),

                                ),
                                Text(
                                  widget.payment_method,
                                  style: GoogleFonts.raleway(
                                      fontSize: 13,
                                      color: Color(0xff121212),
                                      fontWeight: FontWeight.w600 // Ensure the text is visible over the gradient
                                  ),

                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Customer Name",
                                  style: GoogleFonts.raleway(
                                      fontSize: 13,
                                      color: Color(0xff707070),
                                      fontWeight: FontWeight.w400 // Ensure the text is visible over the gradient
                                  ),

                                ),
                                Text(
                                  widget.customer_name,
                                  style: GoogleFonts.raleway(
                                      fontSize: 13,
                                      color: Color(0xff121212),
                                      fontWeight: FontWeight.w600 // Ensure the text is visible over the gradient
                                  ),

                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //   children: [
                            //     Text(
                            //       "Car Owner",
                            //       style: GoogleFonts.raleway(
                            //           fontSize: 13,
                            //           color: Color(0xff707070),
                            //           fontWeight: FontWeight.w400 // Ensure the text is visible over the gradient
                            //       ),
                            //
                            //     ),
                            //     Text(
                            //       widget.car_owner,
                            //       style: GoogleFonts.raleway(
                            //           fontSize: 13,
                            //           color: Color(0xff121212),
                            //           fontWeight: FontWeight.w600 // Ensure the text is visible over the gradient
                            //       ),
                            //
                            //     ),
                            //   ],
                            // ),
                            // SizedBox(
                            //   height: 10,
                            // ),
                            Divider(
                              color: Color(0xffEDEDED),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Total Amount",
                                  style: GoogleFonts.raleway(
                                      fontSize: 13,
                                      color: Color(0xff707070),
                                      fontWeight: FontWeight.w400 // Ensure the text is visible over the gradient
                                  ),

                                ),
                                Text(
                                  widget.totalFees,
                                  style: GoogleFonts.raleway(
                                      fontSize: 13,
                                      color: Color(0xff121212),
                                      fontWeight: FontWeight.w600 // Ensure the text is visible over the gradient
                                  ),

                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Coupon Amount",
                                  style: GoogleFonts.raleway(
                                      fontSize: 13,
                                      color: Color(0xff707070),
                                      fontWeight: FontWeight.w400 // Ensure the text is visible over the gradient
                                  ),

                                ),
                                Text(
                                  widget.coupon_amount,
                                  style: GoogleFonts.raleway(
                                      fontSize: 13,
                                      color: Color(0xff121212),
                                      fontWeight: FontWeight.w600 // Ensure the text is visible over the gradient
                                  ),

                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Divider(
                              color: Color(0xffEDEDED),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Grand Total",
                                  style: GoogleFonts.raleway(
                                      fontSize: 13,
                                      color: Color(0xff707070),
                                      fontWeight: FontWeight.w400 // Ensure the text is visible over the gradient
                                  ),

                                ),
                                Text(
                                  widget.totalFees,
                                  style: GoogleFonts.raleway(
                                      fontSize: 13,
                                      color: Color(0xff121212),
                                      fontWeight: FontWeight.w600 // Ensure the text is visible over the gradient
                                  ),

                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),

                          ],
                        ),
                      ),

                    ),
                    SizedBox(
                      height: 40,
                    ),
                    InkWell(
                      onTap: () async {
                        await requestPermissions();
                        await generatePdf(
                            widget.pdate,
                            widget.ddate,
                            widget.car_category,
                            widget.payment_time,
                            widget.payment_method,
                            widget.customer_name,
                            widget.coupon_amount,
                            widget.car_owner,
                            widget.totalFees,
                            widget.car_type,context
                        );
                      },

                      child: Container(
                        height: 46.0,
                        width: MediaQuery.of(context).size.width/1.2,
                        padding: EdgeInsetsDirectional.fromSTEB(
                            40.0, 0.0, 40.0, 0.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            border: Border.all(color:FlutterTheme.of(context).secondary,width: 1.0, )
                        ),
                        child: Center(
                          child: Text(
                            "Download Invoice",     style: GoogleFonts.raleway(
                              fontSize: 16,
                              color:FlutterTheme.of(context).secondary,
                              fontWeight: FontWeight.w400 // Ensure the text is visible over the gradient
                          ),),
                        ),
                      ),
                    ),

                    // FFButtonWidget(
                    //   onPressed: () async {
                    //     await generatePdf(
                    //       widget.pdate,
                    //       widget.ddate,
                    //       widget.car_category,
                    //       widget.payment_time,
                    //       widget.payment_method,
                    //       widget.customer_name,
                    //       widget.coupon_amount,
                    //       widget.car_owner,
                    //       widget.totalFees,
                    //       widget.car_type,
                    //     );
                    //     // Handle success message or open the PDF
                    //   },
                    //
                    //   text: "Download Invoice",
                    //   options: FFButtonOptions(
                    //
                    //     height: 46.0,
                    //     width: MediaQuery.of(context).size.width/1.2,
                    //     padding: EdgeInsetsDirectional.fromSTEB(
                    //         40.0, 0.0, 40.0, 0.0),
                    //     iconPadding: EdgeInsetsDirectional.fromSTEB(
                    //         0.0, 0.0, 0.0, 0.0),
                    //     color: Color(0xffF0F0F0),
                    //     textStyle: FlutterTheme.of(context)
                    //         .titleSmall
                    //         .override(
                    //       fontFamily: 'Urbanist',fontSize: 16,fontWeight: FontWeight.w400,
                    //       color: FlutterTheme.of(context).secondary,
                    //     ),
                    //     elevation: 3.0,
                    //     borderSide: BorderSide(
                    //       color: Colors.transparent,
                    //       width: 1.0,
                    //     ),
                    //     borderRadius: BorderRadius.circular(8.0),
                    //   ),
                    // ),
                    SizedBox(
                      height: 20,
                    ),
                    FFButtonWidget(
                      onPressed: () async {
                        context.pushNamed('HomePage');
                      },
                      text: FFLocalizations.of(context).getText(
                        'feux1yxi' /* Go To Home */,
                      ),
                      options: FFButtonOptions(
                        height: 46.0,
                        width: MediaQuery.of(context).size.width/1.2,
                        padding: EdgeInsetsDirectional.fromSTEB(
                            40.0, 0.0, 40.0, 0.0),
                        iconPadding: EdgeInsetsDirectional.fromSTEB(
                            0.0, 0.0, 0.0, 0.0),
                        color: FlutterTheme.of(context).btnclr,
                        textStyle: FlutterTheme.of(context)
                            .titleSmall
                            .override(
                          fontFamily: 'Urbanist',fontSize: 16,fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                        elevation: 3.0,
                        borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ],
                ),
              ),
            )
        ),
      ),
    );
  }


  Future<void> requestPermissions() async {
    if (await Permission.storage.isGranted && await Permission.manageExternalStorage.isGranted) {
      print('Permissions already granted');
    } else {
      var storagePermission = await Permission.storage.request();
      var manageStoragePermission = await Permission.manageExternalStorage.request();

      if (storagePermission.isGranted && manageStoragePermission.isGranted) {
        print('Permissions granted');
      } else {
        print('Permissions denied');
        openAppSettings();
      }
    }
  }


  Future<void> requestManageExternalStoragePermission() async {
    if (await Permission.manageExternalStorage.isGranted) {
      print('Manage external storage permission already granted');
    } else {
      var result = await Permission.manageExternalStorage.request();
      if (result.isGranted) {
        print('Manage external storage permission granted');
      } else {
        print('Manage external storage permission denied');
        openAppSettings();
      }
    }
  }


  Future<void> generatePdf(
      String pdate,
      String ddate,
      String carCategory,
      String paymentTime,
      String paymentMethod,
      String customerName,
      String couponAmount,
      String carOwner,
      String totalFees,
      String carType,
      BuildContext context,
      ) async {
    final pdf = pw.Document();
    final svgData = await rootBundle.loadString('assets/images/invoice_logo.svg');
    final svgDatanew = await rootBundle.loadString('assets/images/Success Icon.svg');

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Container(
          padding: pw.EdgeInsets.all(32),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.center,
            children: [
              pw.SvgImage(width: 150, height: 150, svg: svgData),
              pw.SizedBox(height: 8),
              // pw.SvgImage(width: 56, height: 56, svg: svgDatanew),
              // pw.SizedBox(height: 8),
              pw.Text(
                'Car Rental INVOICE',
                style: pw.TextStyle(fontSize: 30, fontWeight: pw.FontWeight.bold),
              ),
              // pw.Text(
              //   'INVOICE',
              //   style: pw.TextStyle(fontSize: 30, fontWeight: pw.FontWeight.bold),
              // ),
              pw.SizedBox(height: 16),
              pw.Divider(color: PdfColors.grey),
              pw.SizedBox(height: 16),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text('Schedule Date',
                      style: pw.TextStyle(
                          color: PdfColors.grey,
                          fontSize: 13,
                          fontWeight: pw.FontWeight.normal)),
                  pw.Text("$pdate - $ddate",
                      style: pw.TextStyle(
                          fontSize: 13, fontWeight: pw.FontWeight.bold)),
                ],
              ),
              pw.SizedBox(height: 8),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text('Booking Time',
                      style: pw.TextStyle(
                          color: PdfColors.grey,
                          fontSize: 13,
                          fontWeight: pw.FontWeight.normal)),
                  pw.Text(paymentTime,
                      style: pw.TextStyle(
                          fontSize: 13, fontWeight: pw.FontWeight.bold)),
                ],
              ),
              pw.SizedBox(height: 8),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text('Payment Method',
                      style: pw.TextStyle(
                          color: PdfColors.grey,
                          fontSize: 13,
                          fontWeight: pw.FontWeight.normal)),
                  pw.Text(paymentMethod,
                      style: pw.TextStyle(
                          fontSize: 13, fontWeight: pw.FontWeight.bold)),
                ],
              ),
              pw.SizedBox(height: 8),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text('Customer Name',
                      style: pw.TextStyle(
                          color: PdfColors.grey,
                          fontSize: 13,
                          fontWeight: pw.FontWeight.normal)),
                  pw.Text(customerName,
                      style: pw.TextStyle(
                          fontSize: 13, fontWeight: pw.FontWeight.bold)),
                ],
              ),
              pw.SizedBox(height: 8),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text('Coupon Amount',
                      style: pw.TextStyle(
                          color: PdfColors.grey,
                          fontSize: 13,
                          fontWeight: pw.FontWeight.normal)),
                  pw.Text(couponAmount,
                      style: pw.TextStyle(
                          fontSize: 13, fontWeight: pw.FontWeight.bold)),
                ],
              ),
              pw.SizedBox(height: 8),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text('Total Amount',
                      style: pw.TextStyle(
                          color: PdfColors.grey,
                          fontSize: 13,
                          fontWeight: pw.FontWeight.normal)),
                  pw.Text(totalFees,
                      style: pw.TextStyle(
                          fontSize: 13, fontWeight: pw.FontWeight.bold)),
                ],
              ),
              pw.Spacer(),
              pw.Divider(),
              pw.Center(
                child: pw.Text(
                  'Thank you for your business!',
                  style: pw.TextStyle(
                      fontSize: 16, fontStyle: pw.FontStyle.italic),
                ),
              ),
            ],
          ),
        ),
      ),
    );

    try {
      final bytes = await pdf.save();

      // Use the Downloads directory to save the PDF
      final directory = Directory('/storage/emulated/0/Download');
      if (!await directory.exists()) {
        await directory.create(recursive: true);
      }
      final path = '${directory.path}/invoice.pdf';
      final file = File(path);
      await file.writeAsBytes(bytes);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Invoice saved to $path"),
        ),
      );
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Failed to save PDF: $e"),
        ),
      );
    }
  }


}