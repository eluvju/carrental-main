import 'package:flutter_svg/svg.dart';
import '../../constant.dart';
import '../../map_screen.dart';
import '../../model/catergory_model.dart';
import '../../model/find_car_model.dart';
import '../find_cars.dart';
import '/backend/api_requests/api_calls.dart';
import '/flutter/flutter_drop_down.dart';
import '/flutter/flutter_icon_button.dart';
import '/flutter/flutter_theme.dart';
import '/flutter/flutter_util.dart';
import '/flutter/flutter_widgets.dart';
import '/flutter/form_field_controller.dart';
import '/flutter/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'more_filter_page_model.dart';
export 'more_filter_page_model.dart';
import 'package:http/http.dart'as http;

class MoreFilterPageWidget extends StatefulWidget {
  const MoreFilterPageWidget({Key? key}) : super(key: key);

  @override
  _MoreFilterPageWidgetState createState() => _MoreFilterPageWidgetState();
}

class _MoreFilterPageWidgetState extends State<MoreFilterPageWidget> {
  late MoreFilterPageModel _model;
  List<String> eachCategoryList = [
    'All car',
    'suv',
    'seden',
    'coupe',
    'van',

  ];

  Map<String, String> eachCategoryWithImages = {
    'All car': 'assets/images/allcar.svg',
    'suv': 'assets/images/Fly.svg',
    'seden': 'assets/images/Fly-1.svg',
    'coupe': 'assets/images/Fly-2.svg',
    'van': 'assets/images/Fly-2.svg',

  };
  int value =5;
  int _min = 5;
  int _max = 50;
  TimeOfDay? startTime;
  TimeOfDay? endTime;
  bool _isSliderEnabled = true;
  bool _hasData = true;
  bool _isVisible = false;
  DateTime? selectedStartDate;
  DateTime? selectedStartDatetime;
  String? formattedStartDateday;
  String? formattedEndDateday;
  DateTime? selectedEndDate;
  AllCategoryModel?_allCategoryModel;
  TextEditingController pickup_address1=TextEditingController();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String? selectedCategory;
  bool _showTimePicker = false;
  bool _fortheday = false;
  String selecdayshrs='';
  RangeValues _values = RangeValues(500, 10000);
  FindCarModel?_findCarModel;
  String? isSelected;
  dynamic lat ;
  dynamic long ;
  double _value = 5.0;
  final double _minnew = 0.0;
  final double _maxnew = 10.0;
  bool _isSliderEnablednew = true;
  String? formattedStartDate;
  String? formattedendDateday;
  DateTime? startDate;
  DateTime? endDate;
  @override
  void initState() {
    Helper.checkInternet(categoryapi());
    super.initState();
    _model = createModel(context, () => MoreFilterPageModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
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
        backgroundColor: FlutterTheme.of(context).primaryBackground,
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
          title: Text(
            FFLocalizations.of(context).getText(
              'filter_button' /* Filter */,
            ),
            style: FlutterTheme.of(context).headlineMedium.override(
              fontFamily: 'Urbanist',
              color: FlutterTheme.of(context).primaryText,
              fontSize: 18.0,
              fontWeight: FontWeight.w600
            ),
          ),
          actions: [],
          centerTitle: false,
          // elevation: 2.0,
        ),
        body: SafeArea(
          top: true,
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 12.0, 0.0),
            child: Stack(
              children: [
                _allCategoryModel==null
                    ? _hasData
                    ? Container()
                    : Container(
                  child: Center(
                    child: Text("NO DATA"),
                  ),
                ):
                SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Card(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            color: FlutterTheme.of(context).secondaryBackground,
                            elevation: 0.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 0.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Image.asset('assets/images/location_map.png',height: 14,width: 14,),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        FFLocalizations.of(context).getText('pickup_location'),
                                        style: TextStyle(
                                          fontFamily: 'SFProDisplay',
                                          fontSize: 17,
                                          color: Color(0xff0D0C0F),
                                          fontWeight: FontWeight.w400,
                                          fontStyle: FontStyle.normal,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Opacity(
                                    opacity: 0.5,
                                    child: Container(
                                      width: double.infinity,
                                      height: 50.0,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(24.0),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 8.0, 0.0),
                                        child: Container(
                                          width: double.infinity,
                                          child: TextFormField(
                                            controller: pickup_address1,
                                            enabled: true,
                                            autofocus: false,
                                            cursorColor: Colors.black, // Set the cursor color to black or any desired color
                                            onTap: () {
                                              Helper.moveToScreenwithPush(context, PriceCalculationLocation(callback: (String, Lat, Lng, lat2, long2, lat3, long3) {
                                                pickup_address1.text = String;
                                                lat = Lat;
                                                long = Lng;
                                                print("=====String address====${String}");
                                                print("=====String lat====${Lat}");
                                                print("=====String Lng====${Lng}");
                                              },));
                                            },
                                            obscureText: false,
                                            decoration: InputDecoration(
                                              hintText: FFLocalizations.of(context).getText('pickup_location'),
                                              hintStyle: FlutterTheme.of(context).displaySmall.override(
                                                fontFamily: FlutterTheme.of(context).displaySmallFamily,
                                                color: Color(0XFF0D0C0F),
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16.0,
                                                useGoogleFonts: GoogleFonts.asMap().containsKey(
                                                    FlutterTheme.of(context).displaySmallFamily),
                                              ),
                                              labelStyle: FlutterTheme.of(context).labelMedium.override(
                                                fontFamily: 'Montserrat',
                                                useGoogleFonts: GoogleFonts.asMap().containsKey(
                                                    FlutterTheme.of(context).labelMediumFamily),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.black, // Set the border color to black
                                                  width: 1.0,
                                                ),
                                                borderRadius: BorderRadius.circular(8.0),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.black, // Set the border color to black
                                                  width: 1.0,
                                                ),
                                                borderRadius: BorderRadius.circular(8.0),
                                              ),
                                              errorBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.black, // Set the border color to black
                                                  width: 1.0,
                                                ),
                                                borderRadius: BorderRadius.circular(8.0),
                                              ),
                                              focusedErrorBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.black, // Set the border color to black
                                                  width: 1.0,
                                                ),
                                                borderRadius: BorderRadius.circular(8.0),
                                              ),
                                              contentPadding: EdgeInsets.all(8.0),
                                            ),
                                            style: FlutterTheme.of(context).displaySmall.override(
                                              fontFamily: FlutterTheme.of(context).displaySmallFamily,
                                              fontSize: 18.0,
                                              color: Color(0XFF0D0C0F),
                                              fontWeight: FontWeight.w600,
                                              useGoogleFonts: GoogleFonts.asMap().containsKey(
                                                  FlutterTheme.of(context).displaySmallFamily),
                                            ),
                                          ),


                                        ),
                                      ),
                                    ),
                                  ),

                                ].divide(SizedBox(height: 8.0)),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                FFLocalizations.of(context).getText('cars_category'),
                                style: TextStyle(
                                  fontFamily: 'SFProDisplay',
                                  fontSize: 17,
                                  color: Color(0xff0D0C0F),
                                  fontWeight: FontWeight.w400, // Adjust the fontWeight as needed
                                  fontStyle: FontStyle.normal, // Adjust the fontStyle as needed
                                ),
                                // style: FlutterTheme.of(context)
                                //     .bodyMedium
                                //     .override(
                                //     fontFamily: 'Urbanist',
                                //     fontSize: 16.0,
                                //     fontWeight: FontWeight.w400,color: Color(0xff0D0C0F)
                                // ),
                              ),


                              // Row(
                              //   children: [
                              //     Text(
                              //       "See All",
                              //       style: FlutterTheme.of(context)
                              //           .bodyMedium
                              //           .override(
                              //           fontFamily: 'Urbanist',
                              //           fontSize: 17.0,
                              //           fontWeight: FontWeight.w500,color: FlutterTheme.of(context).secondary,
                              //       ),
                              //     ),
                              //     Icon(Icons.arrow_right,color: FlutterTheme.of(context).secondary,size: 24,)
                              //   ],
                              // ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          // Container(
                          //   height: 100,
                          //   color: Colors.transparent,
                          //   child: ListView.builder(
                          //     padding: EdgeInsets.zero,
                          //     scrollDirection: Axis.horizontal,
                          //     itemCount: eachCategoryList.length,
                          //     itemBuilder: (context, eachCategoryListIndex) {
                          //       final category = eachCategoryList[eachCategoryListIndex];
                          //       final imagePath = eachCategoryWithImages[category];
                          //       bool isSelected = selectedCategory == category;
                          //
                          //       return Container(
                          //         height: 85,
                          //         width: 80,
                          //         color: Colors.transparent,
                          //         margin: EdgeInsets.only(right: 10),
                          //         child: InkWell(
                          //           onTap: () {
                          //             setState(() {
                          //               if (selectedCategory == category) {
                          //                 selectedCategory = null; // Unselect the category
                          //               } else {
                          //                 selectedCategory = category; // Select the category
                          //               }
                          //               // Additional logic if needed
                          //             });
                          //           },
                          //           splashColor: Colors.transparent, // Set splashColor to transparent
                          //           highlightColor: Colors.transparent, // Set highlightColor to transparent
                          //           child: Column(
                          //             children: [
                          //               imagePath != null
                          //                   ? Container(
                          //                 width: 80.42,
                          //                 height:60,
                          //                 decoration: BoxDecoration(
                          //                   borderRadius: BorderRadius.circular(8),
                          //                   border: Border.all(color: Color(0xffE8ECF4)),
                          //                   color:isSelected ? FlutterTheme.of(context).secondary : Colors.white,
                          //                 ),
                          //                 child: Padding(
                          //                   padding: const EdgeInsets.all(12.0),
                          //                   child: SvgPicture.asset(
                          //                     imagePath,
                          //                     width: 30,
                          //                     height: 30,
                          //                   ),
                          //                 ),
                          //               )
                          //                   : Container(),
                          //               SizedBox(
                          //                 height: 10,
                          //               ),// Display nothing if image path is not available
                          //               Text(category, style: FlutterTheme.of(context)
                          //                   .bodyMedium
                          //                   .override(
                          //                 fontFamily: 'Urbanist',
                          //                 fontSize: 14.0,
                          //                 fontWeight: FontWeight.w600,color: Colors.black,
                          //               ),),
                          //             ],
                          //           ),
                          //         ),
                          //
                          //       );
                          //     },
                          //   ),
                          // ),
                          // Container(
                          //   height: 100,
                          //   color: Colors.transparent,
                          //   child: ListView.builder(
                          //     padding: EdgeInsets.zero,
                          //     scrollDirection: Axis.horizontal,
                          //     itemCount: _allCategoryModel!.data!.length,
                          //     itemBuilder: (context, item) {
                          //       final category = _allCategoryModel!.data![item];
                          //       // final imagePath = eachCategoryWithImages[category];
                          //       //  isSelected = _allCategoryModel!.data![item].categoryName;
                          //       //  print("====isSelected ghjegej===${isSelected}");
                          //       return InkWell(
                          //         onTap: () {
                          //           setState(() {
                          //             isSelected=_allCategoryModel!.data![item].categoryName.toString();
                          //           });
                          //           // Helper.checkInternet(categorywiselist(_allCategoryModel!.data![item].categoryName.toString()));
                          //           print("======helllooo=====");
                          //           print("======category=====${_allCategoryModel!.data![item].categoryName.toString()}");
                          //         },
                          //         child: Container(
                          //           height: 85,
                          //           width: 80,
                          //           color: Colors.transparent,
                          //           margin: EdgeInsets.only(right: 10),
                          //           child: InkWell(
                          //             onTap: () {
                          //               // Helper.checkInternet(categorywiselist(_allCategoryModel!.data![item].categoryName.toString()));
                          //               print("======helllooo=====");
                          //               print("======category=====${_allCategoryModel!.data![item].categoryName.toString()}");
                          //               setState(() {
                          //                 isSelected=_allCategoryModel!.data![item].categoryName.toString();
                          //                 // if (isSelected == category) {
                          //                 //   selectedCategory = null; // Unselect the category
                          //                 // } else {
                          //                 //   isSelected = category.toString(); // Select the category
                          //                 // }
                          //                 // Additional logic if needed
                          //               });
                          //             },
                          //             splashColor: Colors.transparent, // Set splashColor to transparent
                          //             highlightColor: Colors.transparent, // Set highlightColor to transparent
                          //             child: Column(
                          //               children: [
                          //                 // imagePath != null
                          //                 Container(
                          //                   width: 80.42,
                          //                   height:60,
                          //                   decoration: BoxDecoration(
                          //                     borderRadius: BorderRadius.circular(8),
                          //                     border: Border.all(color: Color(0xffE8ECF4)),
                          //                     color:isSelected== _allCategoryModel!.data![item].categoryName.toString() ? FlutterTheme.of(context).secondary : Colors.white,
                          //                   ),
                          //                   child: Padding(
                          //                     padding: const EdgeInsets.all(12.0),
                          //                     child: SvgPicture.asset(
                          //                       _allCategoryModel!.data![item].categoryName.toString() == "Sedan"
                          //                           ? 'assets/images/allcar.svg' // Display this image if category is Sedan
                          //                           : _allCategoryModel!.data![item].categoryName.toString() == "Suv"
                          //                           ? 'assets/images/Fly.svg'// Display this image if category is AnotherCategory
                          //                           : 'assets/images/Fly-2.svg', // Display a default image if category is not matched
                          //                       width: 30,
                          //                       height: 30,
                          //                     ),
                          //                   ),
                          //                 ),
                          //                 // : Container(),
                          //                 SizedBox(
                          //                   height: 10,
                          //                 ),// Display nothing if image path is not available
                          //                 Text(_allCategoryModel!.data![item].categoryName.toString(), style: FlutterTheme.of(context)
                          //                     .bodyMedium
                          //                     .override(
                          //                   fontFamily: 'Urbanist',
                          //                   fontSize: 14.0,
                          //                   fontWeight: FontWeight.w600,color: Colors.black,
                          //                 ),),
                          //               ],
                          //             ),
                          //           ),
                          //
                          //         ),
                          //       );
                          //     },
                          //   ),
                          //
                          // ),

                          Container(
                            height: 100,
                            color: Colors.transparent,
                            child: ListView.builder(
                              padding: EdgeInsets.zero,
                              scrollDirection: Axis.horizontal,
                              itemCount: _allCategoryModel!.data!.length,
                              itemBuilder: (context, item) {
                                final category = _allCategoryModel!.data![item];
                                // final imagePath = eachCategoryWithImages[category];
                                //  isSelected = _allCategoryModel!.data![item].categoryName;
                                //  print("====isSelected ghjegej===${isSelected}");
                                return InkWell(
                                  onTap: () {
                                    setState(() {
                                      isSelected=_allCategoryModel!.data![item].categoryName.toString();
                                    });
                                    // Helper.checkInternet(categorywiselist(_allCategoryModel!.data![item].categoryName.toString()));
                                    print("======helllooo=====");
                                    print("======category=====${_allCategoryModel!.data![item].categoryName.toString()}");
                                  },
                                  child: Container(
                                    height: 85,
                                    width: 80,
                                    color: Colors.transparent,
                                    margin: EdgeInsets.only(right: 10),
                                    child: InkWell(
                                      onTap: () {

                                        // Helper.checkInternet(categorywiselist(_allCategoryModel!.data![item].categoryName.toString()));
                                        print("======helllooo=====");
                                        print("======category=====${_allCategoryModel!.data![item].categoryName.toString()}");
                                        setState(() {
                                          isSelected=_allCategoryModel!.data![item].categoryName.toString();
                                          // if (isSelected == category) {
                                          //   selectedCategory = null; // Unselect the category
                                          // } else {
                                          //   isSelected = category.toString(); // Select the category
                                          // }
                                          // Additional logic if needed
                                        });
                                      },

                                      splashColor: Colors.transparent, // Set splashColor to transparent
                                      highlightColor: Colors.transparent, // Set highlightColor to transparent
                                      child: Column(
                                        children: [
                                          // imagePath != null
                                          Container(
                                            width: 80.42,
                                            height:60,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(8),
                                              border: Border.all(color: Color(0xffE8ECF4)),
                                              color:
                                              isSelected== _allCategoryModel!.data![item].categoryName.toString() ? FlutterTheme.of(context).plumpPurple : Colors.white,
                                            ),
                                            child: Padding(
                                                padding: const EdgeInsets.all(10.0),
                                                child:
                                                // ||isSelected=="All Cars"
                                                // _allCategoryModel!.data![item].categoryName.toString()=="All Cars"?
                                                // Image.asset('assets/images/ALL_CARS.png',height: 50,width: 70,fit: BoxFit.contain,):
                                                Image.network(_allCategoryModel!.data![item].categoryImage.toString(),height: 50,width: 70,fit: BoxFit.contain,)
                                              // SvgPicture.asset(
                                              //   _allCategoryModel!.data![item].categoryName.toString() == "Sedan"
                                              //       ? 'assets/images/allcar.svg' // Display this image if category is Sedan
                                              //       : _allCategoryModel!.data![item].categoryName.toString() == "Suv"
                                              //       ? 'assets/images/Fly.svg'// Display this image if category is AnotherCategory
                                              //       : 'assets/images/Fly-2.svg', // Display a default image if category is not matched
                                              //   width: 30,
                                              //   height: 30,
                                              // ),
                                            ),
                                          ),
                                          // : Container(),
                                          SizedBox(
                                            height: 10,
                                          ),// Display nothing if image path is not available
                                          Container(
                                            width: 60,
                                            child: Text(_allCategoryModel!.data![item].categoryName.toString(),overflow: TextOverflow.ellipsis, style: FlutterTheme.of(context)
                                                .bodyMedium
                                                .override(
                                              fontFamily: 'Urbanist',
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.w600,color: Colors.black,
                                            ),),
                                          ),
                                        ],
                                      ),
                                    ),

                                  ),
                                );
                              },
                            ),

                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: 10,
                            child: Divider(
                              thickness: 0.5,
                              color: Color(0xffD3CFD6),
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  FFLocalizations.of(context).getText('price'),
                                  style: FlutterTheme.of(context)
                                      .bodyMedium
                                      .override(
                                    fontFamily: 'Urbanist',
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Theme(
                                  data: Theme.of(context).copyWith(
                                    sliderTheme: SliderTheme.of(context).copyWith(
                                      valueIndicatorColor: FlutterTheme.of(context).plumpPurple, // Change the color here
                                      valueIndicatorTextStyle: TextStyle(
                                        color: Colors.white, // Text color inside the value indicator
                                      ),
                                    ),
                                  ),
                                  child: RangeSlider(
                                    values: _values,
                                    onChanged: (RangeValues newValues) {
                                      setState(() {
                                        _values = newValues;
                                      });
                                    },
                                    min: 500.0,
                                    max: 10000.0,
                                    divisions: ((10000 - 500) / 500).round(), // Calculate the number of divisions
                                    labels: RangeLabels(
                                      _values.start.toStringAsFixed(0), // Display as integer values
                                      _values.end.toStringAsFixed(0),
                                    ),
                                  ),
                                ),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('${FFLocalizations.of(context).getText('starting_price')}: ${_values.start.toStringAsFixed(2)}',
                                      style: FlutterTheme.of(context)
                                          .displaySmall
                                          .override(
                                        fontFamily:
                                        FlutterTheme.of(context)
                                            .displaySmallFamily,
                                        fontSize: 14.0,
                                        color: Color(0XFF0D0C0F) ,fontWeight: FontWeight.w400,
                                        useGoogleFonts: GoogleFonts
                                            .asMap()
                                            .containsKey(
                                            FlutterTheme.of(
                                                context)
                                                .displaySmallFamily),
                                      ),
                                    ),
                                    Text('${FFLocalizations.of(context).getText('ending_price')}: ${_values.end.toStringAsFixed(2)}',
                                      style: FlutterTheme.of(context)
                                          .displaySmall
                                          .override(
                                        fontFamily:
                                        FlutterTheme.of(context)
                                            .displaySmallFamily,
                                        fontSize: 14.0,
                                        color: Color(0XFF0D0C0F) ,fontWeight: FontWeight.w400,
                                        useGoogleFonts: GoogleFonts
                                            .asMap()
                                            .containsKey(
                                            FlutterTheme.of(
                                                context)
                                                .displaySmallFamily),
                                      ),
                                    ),
                                  ],
                                ),

                                // Row(
                                //   children: [
                                //     Text('$_minnew'),
                                //     Expanded(
                                //       child: Slider(
                                //         value: _value,
                                //         min: _minnew,
                                //         max: _maxnew,
                                //         divisions: 10,
                                //         label: '$_value',
                                //         activeColor: Color(0xffA33FA5),
                                //         inactiveColor: Colors.grey,
                                //         onChanged: _isSliderEnabled
                                //             ? (value) {
                                //           setState(() {
                                //             _value = value;
                                //           });
                                //         }
                                //             : null,
                                //       ),
                                //     ),
                                //     Text('$_max'),
                                //   ],
                                // ),
                                // Text(
                                //   'Selected Value: ${_value.toStringAsFixed(1)}',
                                //   style: TextStyle(fontSize: 24),
                                // ),
                                // FutureBuilder<ApiCallResponse>(
                                //   future: BaseUrlGroup.brandCall.call(),
                                //   builder: (context, snapshot) {
                                //     // Customize what your widget looks like when it's loading.
                                //     if (!snapshot.hasData) {
                                //       return Center(
                                //         child: SizedBox(
                                //           width: 40.0,
                                //           height: 40.0,
                                //           child: CircularProgressIndicator(
                                //             valueColor:
                                //                 AlwaysStoppedAnimation<Color>(
                                //               FlutterTheme.of(context)
                                //                   .secondary,
                                //             ),
                                //           ),
                                //         ),
                                //       );
                                //     }
                                //     final dropDownbrandBrandResponse =
                                //         snapshot.data!;
                                //     return FlutterDropDown<String>(
                                //       controller:
                                //           _model.dropDownbrandValueController ??=
                                //               FormFieldController<String>(null),
                                //       options: (BaseUrlGroup.brandCall.brandName(
                                //         dropDownbrandBrandResponse.jsonBody,
                                //       ) as List)
                                //           .map<String>((s) => s.toString())
                                //           .toList()!
                                //           .map((e) => e.toString())
                                //           .toList(),
                                //       onChanged: (val) => setState(
                                //           () => _model.dropDownbrandValue = val),
                                //       width: double.infinity,
                                //       height: 50.0,
                                //       textStyle:
                                //           FlutterTheme.of(context).bodyMedium,
                                //       hintText: FFLocalizations.of(context).getText(
                                //         '86l9nq6i' /* Please select band */,
                                //       ),
                                //       icon: Icon(
                                //         Icons.keyboard_arrow_down_rounded,
                                //         color: FlutterTheme.of(context)
                                //             .secondaryText,
                                //         size: 24.0,
                                //       ),
                                //       fillColor: FlutterTheme.of(context)
                                //           .secondaryBackground,
                                //       elevation: 2.0,
                                //       borderColor:
                                //           FlutterTheme.of(context).alternate,
                                //       borderWidth: 2.0,
                                //       borderRadius: 8.0,
                                //       margin: EdgeInsetsDirectional.fromSTEB(
                                //           0.0, 4.0, 16.0, 4.0),
                                //       hidesUnderline: true,
                                //       isSearchable: false,
                                //       isMultiSelect: false,
                                //     );
                                //   },
                                // ),
                              ],
                            ),
                          ),

                          SizedBox(
                            height: 20,
                          ),
                          Flexible(
                            child: Container(
                              width: double.infinity,
                              height: 58.0,
                              decoration: BoxDecoration(),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  FFButtonWidget(
                                    onPressed: () async {
                                      setState(() {
                                        selecdayshrs = 'For the day';
                                        _showTimePicker=false;
                                        formattedStartDateday=null;
                                        formattedendDateday=null;

                                      });
                                    },
                                    text: FFLocalizations.of(context).getText('for_the_day'),
                                    options: FFButtonOptions(
                                      width: MediaQuery.of(context).size.width / 2.3,
                                      height: 46.0,
                                      color: selecdayshrs == 'For the day'
                                          ? FlutterTheme.of(context).plumpPurple
                                          : Colors.white,
                                      textStyle: FlutterTheme.of(context).titleSmall.override(
                                        fontFamily: 'Urbanist',
                                        color: selecdayshrs == 'For the day'
                                            ? FlutterTheme.of(context).primaryBtnText
                                            : FlutterTheme.of(context).primary,
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      elevation: 3.0,
                                      borderSide: BorderSide(
                                        color: FlutterTheme.of(context).plumpPurple,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                  ),
                                  FFButtonWidget(
                                    onPressed: () async {
                                      setState(() {
                                        selecdayshrs = 'For the hour';
                                        _showTimePicker = !_showTimePicker;
                                        formattedStartDate=null;
                                        startTime=null;
                                        endTime=null;
                                      });
                                    },
                                    text: FFLocalizations.of(context).getText('for_the_hour'),
                                    options: FFButtonOptions(
                                      width: MediaQuery.of(context).size.width / 2.3,
                                      height: 46.0,
                                      color: selecdayshrs == 'For the hour'
                                          ? FlutterTheme.of(context).plumpPurple
                                          : Colors.white,
                                      textStyle: FlutterTheme.of(context).titleSmall.override(
                                        fontFamily: 'Urbanist',
                                        color: selecdayshrs == 'For the hour'
                                            ? FlutterTheme.of(context).primaryBtnText
                                            : FlutterTheme.of(context).primary,
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      elevation: 3.0,
                                      borderSide: BorderSide(
                                        color: FlutterTheme.of(context).plumpPurple,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Builder(
                                builder: (context) {
                                  if (selecdayshrs == 'For the day') {


                                    return Container(
                                      width: double.infinity,
                                      height: 58.0,
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          // Start date picker
                                          FFButtonWidget(
                                            onPressed: () async {
                                              final ThemeData customTheme = ThemeData(
                                                colorScheme: ColorScheme.light(
                                                  primary: FlutterTheme.of(context).plumpPurple,
                                                  onPrimary: Colors.white,
                                                  onSurface: Colors.black,
                                                ),
                                                // backgroundColor: Colors.white,
                                              );
                                              final pickedStartDate = await showDatePicker(
                                                context: context,
                                                initialDate: DateTime.now(),
                                                firstDate: DateTime.now(), // Prevent selection of dates before today
                                                lastDate: DateTime.now().add(Duration(days: 365)),
                                                builder: (BuildContext context, Widget? child) {
                                                  return Theme(
                                                    data: customTheme, // Add your custom theme if needed
                                                    child: child!,
                                                  );
                                                },
                                              );
                                              if (pickedStartDate != null) {
                                                setState(() {
                                                  selectedStartDate = pickedStartDate;
                                                  formattedStartDateday = DateFormat('MMM d, yyyy').format(selectedStartDate!);
                                                });
                                                print("Selected Start Date: $formattedStartDateday");
                                              }
                                            },
                                            text: formattedStartDateday != null ? "${formattedStartDateday}" : "Start date",
                                            options: FFButtonOptions(
                                              width: MediaQuery.of(context).size.width / 2.3,
                                              height: 46.0,
                                              color: FlutterTheme.of(context).plumpPurple,
                                              textStyle: FlutterTheme.of(context).titleSmall.override(
                                                fontFamily: 'Urbanist',
                                                color: Colors.white,
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.w500,
                                              ),
                                              elevation: 3.0,
                                              borderSide: BorderSide(
                                                color: Colors.transparent,
                                                width: 1.0,
                                              ),
                                              borderRadius: BorderRadius.circular(8.0),
                                            ),
                                          ),
                                          FFButtonWidget(
                                            onPressed: () async {
                                              if (selectedStartDate == null) {
                                                // Handle case where start date is not selected
                                                return;
                                              }
                                              final ThemeData customTheme = ThemeData(
                                                colorScheme: ColorScheme.light(
                                                  primary: FlutterTheme.of(context).plumpPurple,
                                                  onPrimary: Colors.white,
                                                  onSurface: Colors.black,
                                                ),
                                                // backgroundColor: Colors.white,
                                              );
                                              final pickedEndDate = await showDatePicker(
                                                context: context,
                                                initialDate: selectedStartDate!,
                                                firstDate: selectedStartDate!,
                                                lastDate: selectedStartDate!.add(Duration(days: 10)), // Restrict end date to 10 days from start date
                                                builder: (BuildContext context, Widget? child) {
                                                  return Theme(
                                                    data: customTheme, // Add your custom theme if needed
                                                    child: child!,
                                                  );
                                                },
                                              );

                                              if (pickedEndDate != null && pickedEndDate.isAfter(selectedStartDate!)) {
                                                setState(() {
                                                  selectedEndDate = pickedEndDate;
                                                  formattedendDateday = DateFormat('MMM d, yyyy').format(selectedEndDate!);
                                                });

                                                print("Selected End Date: $formattedendDateday");
                                              } else {
                                                // Handle case where end date is not selected or not greater than start date
                                                print("Invalid end date");
                                              }
                                            },
                                            text: formattedendDateday != null ? "${formattedendDateday}" : "End date",
                                            options: FFButtonOptions(
                                              width: MediaQuery.of(context).size.width / 2.3,
                                              height: 46.0,
                                              color: FlutterTheme.of(context).plumpPurple,
                                              textStyle: FlutterTheme.of(context).titleSmall.override(
                                                fontFamily: 'Urbanist',
                                                color: Colors.white,
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.w500,
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
                                    );
                                  }
                                  else if (selecdayshrs == 'For the hour') {
                                    return Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        InkWell(
                                          onTap: () async {
                                            final ThemeData customTheme = ThemeData(
                                              colorScheme: ColorScheme.light(
                                                primary: FlutterTheme.of(context).plumpPurple,
                                                onPrimary: Colors.white,
                                                onSurface: Colors.black,
                                              ),
                                              // backgroundColor: Colors.white,
                                            );
                                            final pickedStartDate = await showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime.now().subtract(Duration(days: 365)),
                                              lastDate: DateTime.now().add(Duration(days: 365)),
                                              builder: (BuildContext context, Widget? child) {
                                                return Theme(
                                                  data: customTheme, // Add your custom theme if needed
                                                  child: child!,
                                                );
                                              },
                                            );
                                            if (pickedStartDate != null) {
                                              setState(() {
                                                selectedStartDatetime = pickedStartDate;
                                                formattedStartDate = DateFormat('MMM d, yyyy').format(selectedStartDatetime!);
                                              });
                                              print("Selected Start Date: $formattedStartDate");
                                            }
                                          },
                                          child: Container(
                                            width: MediaQuery.of(context).size.width / 2.3,
                                            height: 46.0,
                                            decoration: BoxDecoration(
                                              color: Color(0xffFAF9FE),
                                              borderRadius: BorderRadius.circular(10),
                                              border: Border.all(
                                                color: FlutterTheme.of(context).plumpPurple,
                                              ),
                                            ),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [

                                                SvgPicture.asset(
                                                  'assets/images/calender.svg',
                                                ),


                                                SizedBox(width: 5),
                                                Text(
                                                  formattedStartDate == null
                                                      ? "Date"
                                                      : "${formattedStartDate}",
                                                  style: FlutterTheme.of(context).titleSmall.override(
                                                    fontFamily: 'Urbanist',
                                                    color: FlutterTheme.of(context).plumpPurple,
                                                    fontSize: 14.0,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        // InkWell(
                                        //   onTap: () {
                                        //
                                        //   },
                                        //   child: Container(
                                        //     width: MediaQuery.of(context).size.width / 2.3,
                                        //     height: 46.0,
                                        //     decoration: BoxDecoration(
                                        //       color: Color(0xffFAF9FE),
                                        //       borderRadius: BorderRadius.circular(10),
                                        //       // border: Border.all(
                                        //       //   color:FlutterTheme.of(context).secondary,
                                        //       // )
                                        //     ),
                                        //     child: Row(
                                        //       children: [
                                        //         SizedBox(
                                        //           width: 20,
                                        //         ),
                                        //         Image.asset('assets/images/clock_gray.png'),
                                        //         SizedBox(
                                        //           width: 5,
                                        //         ),
                                        //         // Image.asset('assets/images/clock_blue.png'),
                                        //         Text("Time",style: FlutterTheme.of(context).titleSmall.override(
                                        //           fontFamily: 'Urbanist',
                                        //           color: Color(0xff7C8BA0),
                                        //           fontSize: 14.0,
                                        //           fontWeight: FontWeight.w500,
                                        //         ),)
                                        //       ],
                                        //     ),
                                        //   ),
                                        // )
                                      ],
                                    );
                                    //   Row(
                                    //   mainAxisSize: MainAxisSize.max,
                                    //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    //   children: [
                                    //     // Start time picker
                                    //     FFButtonWidget(
                                    //       onPressed: () async {
                                    //         final selectedTime = await showTimePicker(
                                    //           context: context,
                                    //           initialTime: TimeOfDay.now(),
                                    //         );
                                    //         if (selectedTime != null) {
                                    //           setState(() {
                                    //             startTime = selectedTime;
                                    //           });
                                    //         }
                                    //       },
                                    //       text: "Start time",
                                    //       options: FFButtonOptions(
                                    //         height: 40.0,
                                    //         width: MediaQuery.of(context).size.width / 2.3,
                                    //         color: FlutterTheme.of(context).secondary,
                                    //         textStyle: FlutterTheme.of(context).titleSmall.override(
                                    //           fontFamily: 'Urbanist',
                                    //           color: Colors.white,
                                    //           fontSize: 14.0,
                                    //           fontWeight: FontWeight.w500,
                                    //         ),
                                    //         elevation: 3.0,
                                    //         borderSide: BorderSide(
                                    //           color: Colors.transparent,
                                    //           width: 1.0,
                                    //         ),
                                    //         borderRadius: BorderRadius.circular(8.0),
                                    //       ),
                                    //     ),
                                    //
                                    //     FFButtonWidget(
                                    //       onPressed: () async {
                                    //         final selectedTime = await showTimePicker(
                                    //           context: context,
                                    //           initialTime: TimeOfDay.now(),
                                    //         );
                                    //         if (selectedTime != null) {
                                    //           setState(() {
                                    //             endTime = selectedTime;
                                    //           });
                                    //         }
                                    //       },
                                    //       text: "End time",
                                    //       options: FFButtonOptions(
                                    //         height: 40.0,
                                    //         width: MediaQuery.of(context).size.width / 2.3,
                                    //         color: FlutterTheme.of(context).secondary,
                                    //         textStyle: FlutterTheme.of(context).titleSmall.override(
                                    //             fontFamily: 'Urbanist',
                                    //             color: Colors.white,
                                    //             fontSize: 14,
                                    //             fontWeight: FontWeight.w400
                                    //         ),
                                    //         elevation: 3.0,
                                    //         borderSide: BorderSide(
                                    //           color: Colors.transparent,
                                    //           width: 1.0,
                                    //         ),
                                    //         borderRadius: BorderRadius.circular(8.0),
                                    //       ),
                                    //     ),
                                    //
                                    //
                                    //   ],
                                    // );
                                  } else {
                                    return Container(); // Placeholder or default widget
                                  }
                                },
                              ),
                              SizedBox(
                                height: 20,
                              ),

                              Column(
                                children: [
                                  _showTimePicker?
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Column(
                                        children: [
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            "Start Time",
                                            style: FlutterTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                fontFamily: 'Urbanist',
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.w500,color: Color(0xff7C8BA0)
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          InkWell(
                                            onTap: () async {
                                              final selectedTime = await showTimePicker(
                                                context: context,
                                                initialTime: TimeOfDay.now(),
                                              );
                                              if (selectedTime != null) {
                                                setState(() {
                                                  startTime = selectedTime;
                                                  print("----Start time=====${startTime!.format(context)}");
                                                });
                                              }

                                            },
                                            child: Container(
                                              height: 30,
                                              width: 83,
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(5),
                                                  border: Border.all(
                                                      color: Color(0xff7C8BA0)
                                                  )
                                              ),
                                              // child:startTime==null?"ST":startTime;
                                              child: startTime==null?Center(child: Text("Start Time")):Center(child: Text("${startTime!.format(context)}")),
                                              // if (startTime != null) Text("${startTime!.format(context)}"),
                                            ),
                                          ),
                                          // SizedBox(
                                          //   height: 10,
                                          // ),
                                          // Container(
                                          //   height: 26,
                                          //   width: 42,
                                          //   decoration: BoxDecoration(
                                          //     color: FlutterTheme.of(context).secondary,
                                          //     borderRadius: BorderRadius.circular(5),
                                          //   ),
                                          //   child: Center(
                                          //     child: Text(
                                          //       startTime != null ? (startTime!.period == DayPeriod.am ? "AM" : "PM") : "", // Check if endTime is not null and display AM/PM accordingly
                                          //       style: FlutterTheme.of(context).bodyMedium.override(
                                          //         fontFamily: 'Urbanist',
                                          //         fontSize: 10.0,
                                          //         fontWeight: FontWeight.w600,
                                          //         color: startTime != null ? (startTime!.period == DayPeriod.am ? Color(0xffFFFFFF) : Color(0xffFFFFFF)) : Colors.transparent, // Set color based on AM or PM if endTime is not null, otherwise make it transparent
                                          //       ),
                                          //     ),
                                          //   ),
                                          // ),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            "End Time",
                                            style: FlutterTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                fontFamily: 'Urbanist',
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.w500,color: Color(0xff7C8BA0)
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          InkWell(
                                            onTap: () async {
                                              final selectedTime = await showTimePicker(
                                                context: context,
                                                initialTime: TimeOfDay.now(),
                                              );
                                              if (selectedTime != null) {
                                                setState(() {
                                                  endTime = selectedTime;
                                                  print("----endTime time=====${endTime!.format(context)}");

                                                });
                                              }
                                            },
                                            child: Container(
                                              height: 30,
                                              width: 83,
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(5),
                                                  border: Border.all(
                                                      color: Color(0xff7C8BA0)
                                                  )
                                              ), child:endTime==null?Center(child: Text("End Time")):Center(child: Text("${endTime!.format(context)}")),
                                            ),
                                          ),
                                          // SizedBox(
                                          //   height: 10,
                                          // ),
                                          // Container(
                                          //   height: 26,
                                          //   width: 42,
                                          //   decoration: BoxDecoration(
                                          //     color: FlutterTheme.of(context).secondary,
                                          //     borderRadius: BorderRadius.circular(5),
                                          //   ),
                                          //   child: Center(
                                          //     child: Text(
                                          //       endTime != null ? (endTime!.period == DayPeriod.am ? "AM" : "PM") : "", // Check if endTime is not null and display AM/PM accordingly
                                          //       style: FlutterTheme.of(context).bodyMedium.override(
                                          //         fontFamily: 'Urbanist',
                                          //         fontSize: 10.0,
                                          //         fontWeight: FontWeight.w600,
                                          //         color: endTime != null ? (endTime!.period == DayPeriod.am ? Color(0xffFFFFFF) : Color(0xffFFFFFF)) : Colors.transparent, // Set color based on AM or PM if endTime is not null, otherwise make it transparent
                                          //       ),
                                          //     ),
                                          //   ),
                                          // ),

                                        ],
                                      ),
                                    ],
                                  )
                                      : Container(),
                                ],
                              ),
                            ],
                          ),
                          // Container(
                          //   width: double.infinity,
                          //   decoration: BoxDecoration(),
                          //   child: Column(
                          //     mainAxisSize: MainAxisSize.min,
                          //     mainAxisAlignment: MainAxisAlignment.start,
                          //     crossAxisAlignment: CrossAxisAlignment.start,
                          //     children: [
                          //       Text(
                          //         FFLocalizations.of(context).getText(
                          //           'ldt9x460' /* Fuel Type */,
                          //         ),
                          //         style: FlutterTheme.of(context)
                          //             .bodyMedium
                          //             .override(
                          //               fontFamily: 'Urbanist',
                          //               fontSize: 20.0,
                          //               fontWeight: FontWeight.bold,
                          //             ),
                          //       ),
                          //       FlutterDropDown<String>(
                          //         controller:
                          //             _model.dropDownFuelTypeValueController ??=
                          //                 FormFieldController<String>(
                          //           _model.dropDownFuelTypeValue ??=
                          //               FFLocalizations.of(context).getText(
                          //             'wg341w1p' /* Disel */,
                          //           ),
                          //         ),
                          //         options: [
                          //           FFLocalizations.of(context).getText(
                          //             '6sti7o4o' /* Disel */,
                          //           ),
                          //           FFLocalizations.of(context).getText(
                          //             'mzxaq16c' /* Petrol */,
                          //           ),
                          //           FFLocalizations.of(context).getText(
                          //             'z0m3r4h7' /* EV */,
                          //           ),
                          //           FFLocalizations.of(context).getText(
                          //             'uyodmq21' /* CNG */,
                          //           )
                          //         ],
                          //         onChanged: (val) => setState(
                          //             () => _model.dropDownFuelTypeValue = val),
                          //         width: double.infinity,
                          //         height: 50.0,
                          //         textStyle:
                          //             FlutterTheme.of(context).bodyMedium,
                          //         hintText: FFLocalizations.of(context).getText(
                          //           'pghdrqrf' /* Please select Fule type */,
                          //         ),
                          //         icon: Icon(
                          //           Icons.keyboard_arrow_down_rounded,
                          //           color:
                          //               FlutterTheme.of(context).secondaryText,
                          //           size: 24.0,
                          //         ),
                          //         fillColor: FlutterTheme.of(context)
                          //             .secondaryBackground,
                          //         elevation: 2.0,
                          //         borderColor:
                          //             FlutterTheme.of(context).alternate,
                          //         borderWidth: 2.0,
                          //         borderRadius: 8.0,
                          //         margin: EdgeInsetsDirectional.fromSTEB(
                          //             0.0, 4.0, 16.0, 4.0),
                          //         hidesUnderline: true,
                          //         isSearchable: false,
                          //         isMultiSelect: false,
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          // Container(
                          //   width: double.infinity,
                          //   decoration: BoxDecoration(),
                          //   child: Column(
                          //     mainAxisSize: MainAxisSize.min,
                          //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                          //     crossAxisAlignment: CrossAxisAlignment.start,
                          //     children: [
                          //       Text(
                          //         FFLocalizations.of(context).getText(
                          //           '09wgunbd' /* Days And Hourly */,
                          //         ),
                          //         style: FlutterTheme.of(context)
                          //             .bodyMedium
                          //             .override(
                          //               fontFamily: 'Urbanist',
                          //               fontSize: 20.0,
                          //               fontWeight: FontWeight.bold,
                          //             ),
                          //       ),
                          //       FlutterDropDown<String>(
                          //         controller: _model.dropDownDaysValueController ??=
                          //             FormFieldController<String>(
                          //           _model.dropDownDaysValue ??=
                          //               FFLocalizations.of(context).getText(
                          //             '63rynpmm' /* Days */,
                          //           ),
                          //         ),
                          //         options: [
                          //           FFLocalizations.of(context).getText(
                          //             'li5iqc87' /* Days */,
                          //           ),
                          //           FFLocalizations.of(context).getText(
                          //             '4hc07c3a' /* Hourly */,
                          //           )
                          //         ],
                          //         onChanged: (val) => setState(
                          //             () => _model.dropDownDaysValue = val),
                          //         width: double.infinity,
                          //         height: 50.0,
                          //         textStyle:
                          //             FlutterTheme.of(context).bodyMedium,
                          //         hintText: FFLocalizations.of(context).getText(
                          //           'ic9zni57' /* Please select days and hourly */,
                          //         ),
                          //         icon: Icon(
                          //           Icons.keyboard_arrow_down_rounded,
                          //           color:
                          //               FlutterTheme.of(context).secondaryText,
                          //           size: 24.0,
                          //         ),
                          //         fillColor: FlutterTheme.of(context)
                          //             .secondaryBackground,
                          //         elevation: 2.0,
                          //         borderColor:
                          //             FlutterTheme.of(context).alternate,
                          //         borderWidth: 2.0,
                          //         borderRadius: 8.0,
                          //         margin: EdgeInsetsDirectional.fromSTEB(
                          //             0.0, 4.0, 16.0, 4.0),
                          //         hidesUnderline: true,
                          //         isSearchable: false,
                          //         isMultiSelect: false,
                          //       ),
                          //     ],
                          //   ),
                          // ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            child: FFButtonWidget(
                              onPressed: () async {

                                if(pickup_address1.text==""||pickup_address1.text==null){
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Enter Address'),
                                    ),
                                  );
                                }

                                else if(isSelected==""||isSelected==null){
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Enter Category'),
                                    ),
                                  );
                                }
                                else if(selecdayshrs==""||selecdayshrs.isEmpty){
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Enter price type'),
                                    ),
                                  );
                                }

                                else if(selecdayshrs == 'For the day'){

                                  if(formattedStartDateday==null){
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('Please select start date'),
                                      ),
                                    );
                                    return;
                                  }
                                  else if(
                                  formattedendDateday==null){
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('Please select End date'),
                                      ),
                                    );
                                    return;
                                  }
                                  else{
                                    Helper.moveToScreenwithPush(context,
                                        FindCarsWidget(lat: lat.toString(),
                                          long: long.toString(),
                                          vehicle_category: isSelected
                                              .toString(),
                                          price: value.toString(),
                                          start_date: selecdayshrs ==
                                              'For the day'
                                              ? formattedStartDateday.toString()
                                              : formattedStartDate
                                              .toString() + startTime.toString()
                                          ,
                                          end_date: selecdayshrs == 'For the day'
                                              ? formattedendDateday.toString()
                                              : formattedStartDate
                                              .toString() + endTime.toString(),
                                          start_price: _values.start
                                              .toStringAsFixed(2),
                                          end_price: _values.end.toStringAsFixed(
                                              2),
                                          price_type: selecdayshrs.toString() ==
                                              'For the day' ? 'Days' : 'Hour',
                                        ));
                                  }


                                }



                                else if(selecdayshrs == 'For the hour'){

                                  if(formattedStartDate==null){
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('Please select date'),
                                      ),
                                    );
                                    return;
                                  }
                                  else if(
                                  startTime==null){
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('Please select Start time'),
                                      ),
                                    );
                                    return;

                                  }
                                  else if(
                                  endTime==null){
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('Please select end time'),
                                      ),
                                    );
                                    return;

                                  }
                                  else{
                                    Helper.moveToScreenwithPush(context,
                                        FindCarsWidget(lat: lat.toString(),
                                          long: long.toString(),
                                          vehicle_category: isSelected
                                              .toString(),
                                          price: value.toString(),
                                          start_date: selecdayshrs ==
                                              'For the day'
                                              ? formattedStartDateday.toString()
                                              : formattedStartDate
                                              .toString() +""+ startTime!.format(context).toString()
                                          ,
                                          end_date: selecdayshrs == 'For the day'
                                              ? formattedendDateday.toString()
                                              : formattedStartDate
                                              .toString() +""+ endTime!.format(context).toString(),
                                          start_price: _values.start
                                              .toStringAsFixed(2),
                                          end_price: _values.end.toStringAsFixed(
                                              2),
                                          price_type: selecdayshrs.toString() ==
                                              'For the day' ? 'Days' : 'Hour',
                                        ));
                                  }


                                }
                                else {
                                  Helper.moveToScreenwithPush(context,
                                      FindCarsWidget(lat: lat.toString(),
                                        long: long.toString(),
                                        vehicle_category: isSelected
                                            .toString(),
                                        price: value.toString(),
                                        start_date: selecdayshrs ==
                                            'For the day'
                                            ? formattedStartDateday.toString()
                                            : formattedStartDate
                                            .toString() +""+ startTime!.format(context).toString()
                                        ,
                                        end_date: selecdayshrs == 'For the day'
                                            ? formattedendDateday.toString()
                                            : formattedStartDate
                                            .toString() +""+ endTime!.format(context).toString(),
                                        start_price: _values.start
                                            .toStringAsFixed(2),
                                        end_price: _values.end.toStringAsFixed(
                                            2),
                                        price_type: selecdayshrs.toString() ==
                                            'For the day' ? 'Days' : 'Hour',
                                      ));


                                  ///commented previously
                                }


                                // _model.apiSearchCars =
                                //     await BaseUrlGroup.searchCall.call(
                                //   lat: functions
                                //       .latLongConverString(FFAppState().latLog!),
                                //   vehicleCategory: _model.dropDownCategoryValue,
                                //   brand: _model.dropDownbrandValue,
                                // );
                                // if (getJsonField(
                                //       (_model.apiSearchCars?.jsonBody ?? ''),
                                //       r'''$.data''',
                                //     ) !=
                                //     null) {
                                //   context.pushNamed(
                                //     'search_page',
                                //     queryParameters: {
                                //       'vihecalList': serializeParam(
                                //         BaseUrlGroup.searchCall.data(
                                //           (_model.apiSearchCars?.jsonBody ?? ''),
                                //         ),
                                //         ParamType.JSON,
                                //         true,
                                //       ),
                                //     }.withoutNulls,
                                //   );
                                // } else {
                                //   await showDialog(
                                //     context: context,
                                //     builder: (alertDialogContext) {
                                //       return AlertDialog(
                                //         title: Text('Notice'),
                                //         content: Text(BaseUrlGroup.searchCall
                                //             .message(
                                //               (_model.apiSearchCars?.jsonBody ??
                                //                   ''),
                                //             )
                                //             .toString()),
                                //         actions: [
                                //           TextButton(
                                //             onPressed: () =>
                                //                 Navigator.pop(alertDialogContext),
                                //             child: Text('Ok'),
                                //           ),
                                //         ],
                                //       );
                                //     },
                                //   );
                                // }
                                //
                                // setState(() {});
                              },
                              text: FFLocalizations.of(context).getText('find_cars'),
                              options: FFButtonOptions(
                                height: 48.0,
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    24.0, 0.0, 24.0, 0.0),
                                iconPadding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 0.0),
                                color: FlutterTheme.of(context).btnclr,
                                textStyle: FlutterTheme.of(context)
                                    .titleSmall
                                    .override(
                                  fontFamily: 'Urbanist',
                                  color: Colors.white,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w500,
                                ),
                                elevation: 3.0,
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                  width: 0.0,
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          ),
                        ].divide(SizedBox(width: 12.0)),
                      ),
                    ].divide(SizedBox(height: 12.0)).around(SizedBox(height: 12.0)),
                  ),
                ),
                Helper.getProgressBarWhite(context, _isVisible)
              ],
            ),
          ),
        ),
      ),
    );
  }

  void clearDates() {
    setState(() {
      selectedStartDate = null;
      selectedEndDate = null;
      formattedStartDateday = null;
      formattedEndDateday = null;
    });
  }
  String _getTimeString(TimeOfDay time) {
    final hour = time.hourOfPeriod;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.period == DayPeriod.am ? 'AM' : 'PM';
    return '$hour:$minute $period';
  }
  setProgress(bool show) {
    if (mounted)
      setState(() {
        _isVisible = show;
      });
  }
  Future<void> categoryapi() async {


    print("<=============categoryapi=============>");

    SessionHelper session = await SessionHelper.getInstance(context);
    String userId = session.get(SessionHelper.USER_ID) ?? "0";
    setProgress(true);
    _hasData=true;

    Map data = {
      'app_token':"booking12345",
    };

    print("Request =============>" + data.toString());
    try {
      var res = await http.post(Uri.parse(Apis.category), body: data);
      print("Response ============>" + res.body);

      if (res.statusCode == 200) {
        try {
          final jsonResponse = jsonDecode(res.body);
          AllCategoryModel model = AllCategoryModel.fromJson(jsonResponse);

          if (model.response == true) {
            print("Model status true");
            setProgress(false);
            _hasData=false;

            setState(() {
              _allCategoryModel=model;
              print("Before insertion, data length: ${_allCategoryModel!.data?.length}");

              // Add a new category at the zero index
              // _allCategoryModel!.addCategoryAtZeroIndex("newCatId", "All Cars");
              //
              // // Check the state of the data list after insertion
              // print("After insertion, data length: ${_allCategoryModel!.data?.length}");
              // print("Category at zero index: ${_allCategoryModel!.data![0].categoryName}");
            });

            print("successs==============");
            // ScaffoldMessenger.of(context).showSnackBar(
            //   SnackBar(
            //     content: Text(model.message.toString()),
            //   ),
            // );


          }
          else {
            setProgress(false);
            _hasData=false;
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
    _hasData=false;
  }

  Future<void> findcar(String vehicle_category) async {


    print("<=============categorywiselist=============>");

    SessionHelper session = await SessionHelper.getInstance(context);
    String userId = session.get(SessionHelper.USER_ID) ?? "0";
    setProgress(true);
    _hasData=true;
    print('=======selectedStartDate.toString()=====${selectedStartDate.toString()}');
    print('=======selectedEndDate.toString()=====${selectedEndDate.toString()}');
    Map data = {
      'app_token':'booking12345',
      'lat':lat.toString(),
      'vehicle_category':vehicle_category.toString(),
      'price':value.toString(),
      'long':long.toString(),
      'start_date':formattedStartDateday.toString(),
      'end_date':formattedEndDateday.toString(),
      // 'start_date':
      // 'end_date':
      // 'start_time':
      //  'end_time':
      // 'hour_date':
    };

    print("Request =============>" + data.toString());
    try {
      var res = await http.post(Uri.parse(Apis.search_car), body: data);
      print("Response ============>" + res.body);

      if (res.statusCode == 200) {
        try {
          final jsonResponse = jsonDecode(res.body);
          FindCarModel model = FindCarModel.fromJson(jsonResponse);

          if (model.response == "true") {
            print("Model status true");
            setProgress(false);
            _hasData=false;

            setState(() {
              _findCarModel=model;
            });

            print("successs==============");

            // ScaffoldMessenger.of(context).showSnackBar(
            //   SnackBar(
            //     content: Text(model.message.toString()),
            //   ),
            // );


          }
          else {
            setProgress(false);
            _hasData=false;
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
    _hasData=false;
  }
}

