import 'package:car_rental/pages/login_page/login_page_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'constant.dart';
import 'flutter/flutter_theme.dart';
import 'flutter/flutter_util.dart';
import 'package:http/http.dart'as http;
import 'model/all_car_model.dart';
import 'model/carcetegorywise_model.dart';
import 'model/catergory_model.dart';
import 'model/fav_model.dart';
import 'model/profile_model.dart';
import 'model/promocode_model.dart';


class SeeAllCars extends StatefulWidget {
   String isSelected="";
   String category="";
   SeeAllCars({required this.isSelected,required this.category});
  // dynamic lat;
  // dynamic long;
  // String pickaddress="";
  // String details="";
  // String userimage="";
  // String carImage="";
  // String favStatus="";
  // String carName="";
  // String brandName="";
  // String carCost="";
  // String priceType="";
  // String vehicleCategory="";
  // String specification="";
  // String carSeat="";
  // dynamic length="";
  //
  // SeeAllCars({required this.carId, required this.lat, required this.long,
  //   required this.pickaddress,required this.details,required this.userimage,
  //   required this.favStatus,required this.carName,required this.brandName,
  // required this.carCost,required this.priceType,required this.vehicleCategory,
  // required this.specification,required this.carSeat,required this.carImage});

  @override
  _SeeAllCarsState createState() =>
      _SeeAllCarsState();
}

class _SeeAllCarsState extends State<SeeAllCars> {
  // late PromoCodeDetailPageModel _model;
  AddFavourite?_addFavourite;
  bool _hasData = true;
  bool _isVisible = false;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  Promocode?_promocodeModel;
  bool isFavourite = false;
  double? globalLatitude;
  double? globalLongitude;
  LatLng startLocation = LatLng(0, 0);
  String location = '';
  bool _isVisiblenew = false;
  bool _isLoading = false;
  UserProfileModel?_userProfileModel;
  AllCategoryModel?_allCategoryModel;
  AllCarsModel?_allCarsModel;
  CatergorywiseCar?_catergorywiseCar;


  @override
  void initState() {
    super.initState();
    // _model = createModel(context, () => PromoCodeDetailPageModel());
    getCurrentLocation();
    Helper.checkInternet(allcars());
    Helper.checkInternet(promocodeApi());
    Helper.checkInternet(userdetailsApi());
    Helper.checkInternet(categorywiselist(widget.isSelected));
  }

  @override
  void dispose() {
    // _model.dispose();

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

    return GestureDetector(
      // onTap: () => _model.unfocusNode.canRequestFocus
      //     ? FocusScope.of(context).requestFocus(_model.unfocusNode)
      //     : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        // backgroundColor: FlutterTheme.of(context).backgraund,
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
          title: Text("All Cars",
            // FFLocalizations.of(context).getText(
            //   'p6r3ar1p' /* More Filter */,
            // ),
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
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.all(0.0),
                child:

                widget.isSelected == "All Cars"
                    ? (_allCarsModel == null||_allCarsModel!.data!.isEmpty
                    ? (_hasData
                    ? Container(
                  // height: 270,
                )
                    : Container(
                  height: 270,
                  child: Center(
                    child: Text(""),
                  ),
                ))
                    : Container(
                  // height: 273,
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.vertical,
                    // itemCount: _catergorywiseCar!.data!.length,
                    itemCount: _allCarsModel!.data!.length,
                    itemBuilder: (context, item) {
                      // double distance =   calculateDistance(double.parse(_allCarsModel!.data![item].pickLat1.toString()), double.parse(_allCarsModel!.data![item].pickLong1.toString()) ,double.parse(  _allCarsModel!.data![item].pickLat2.toString()),
                      //     double.parse(_allCarsModel!.data![item].pickLong2.toString()));
                      // String travelTime = calculateTravelTime(double.parse(_allCarsModel!.data![item].pickLat1.toString()), double.parse(_allCarsModel!.data![item].pickLong1.toString()) ,double.parse(  _allCarsModel!.data![item].pickLat2.toString()),
                      //     double.parse(_allCarsModel!.data![item].pickLong2.toString()), 80);

                      final category = _allCarsModel!.data![item];
                      // final imagePath = eachCategoryWithImages[category];
                      //  isSelected = _allCategoryModel!.data![item].categoryName;
                      //  print("====isSelected ghjegej===${isSelected}");
                      return InkWell(
                        onTap: () {
                          print("=====_allCarsModel!.data!.length111======${_allCarsModel!.data!.length}");
                          print("=====_isSelected11111=====${widget.isSelected}");
                          context.pushNamed(
                            'product_detail_page',
                            queryParameters: {
                              'carId':_allCarsModel !.data![item].carId.toString(),
                              'lat':double.parse( _allCarsModel!.data![item].pickLat1.toString()).toString(),
                              'long':double.parse( _allCarsModel!.data![item].pickLong1.toString()).toString(),
                              'pickaddress':  _allCarsModel!.data![item].pickAddress1.toString(),
                              'time':'',
                              'distance': '',
                            }.withoutNulls,
                          );
                          // context.pushNamed('product_detail_page');
                          // Helper.moveToScreenwithPush(context, ProductDetailPageWidget(hnmjh));
                          // Helper.checkInternet(categorywiselist(_allCategoryModel!.data![item].categoryName.toString()));
                        },
                        child:   Container(
                          height: 273,
                          margin: EdgeInsets.only(bottom: 10),
                          width: MediaQuery.of(context).size.width/1.1,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: Color(0xffFAFAFA),width: 1.5
                              )
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        _allCarsModel!.data![item].userimage.toString()==""?Image.asset( 'assets/images/default_profile_image.png',height: 25,width: 25,):
                                        ClipOval(child: Image.network(_allCarsModel!.data![item].userimage.toString(),height: 25,width: 25,)),
                                        SizedBox(
                                          width: 8.8,
                                        ),
                                        Container(
                                          width: 60,
                                          height: 24,
                                          decoration: BoxDecoration(
                                            color: Color(0xffFAF9FE
                                            ),
                                            border: Border.all(
                                              color: Color(0xff0D0C0F),
                                            ),
                                            borderRadius: BorderRadius.circular(8.0),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 0.0,vertical: 0),
                                            child: Row(
                                              children: [
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Icon(Icons.star,size: 10,color: Color(0xffFFBB35),),
                                                SizedBox(
                                                  width: 5,
                                                ),

                                                Text(
                                                  _allCarsModel!.data![item].rating!
                                                      .toString()=="0.00"?"5.0":_allCarsModel!.data![item].rating!
                                                      .toString(), style: FlutterTheme.of(context).titleSmall.override(
                                                    fontFamily: 'Urbanist',
                                                    color: Color(0xff0D0C0F),fontSize: 12
                                                ),
                                                ),

                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 8.8,
                                        ),

                                        Container(
                                          width: 90,
                                          height: 24,
                                          decoration: BoxDecoration(
                                            color: Color(0xff4ADB06).withOpacity(0.06),
                                            borderRadius: BorderRadius.circular(6.0),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 4.0,vertical: 0),
                                            child: Center(
                                              child: Text(
                                                "Available now", style: FlutterTheme.of(context).titleSmall.override(
                                                  fontFamily: 'Urbanist',
                                                  color: Color(0xff4ADB06),fontSize: 12
                                              ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        // SizedBox(
                                        //   width: 5.8,
                                        // ),
                                        // Icon(Icons.directions_walk,color: Color(0xff7C8BA0),size: 12,),
                                        // Text(
                                        //   " ${distance.toStringAsFixed(2)} km",
                                        //   style: FlutterTheme.of(context).titleSmall.override(
                                        //       fontFamily: 'Urbanist',
                                        //       color: Color(0xff0D0C0F),fontSize: 10
                                        //   ),
                                        // ),
                                        // Text(
                                        //   "(${travelTime})",overflow: TextOverflow.ellipsis, style: FlutterTheme.of(context).titleSmall.override(
                                        //   fontFamily: 'Urbanist',fontSize: 10,
                                        //   color: Color(0xff7C8BA0),
                                        // ),
                                        // ),
                                      ],
                                    ),
                                    _userProfileModel==null||_userProfileModel!.profileData!.userId.toString()==""||
                                        _userProfileModel!.profileData!.userId.toString()==null?   InkWell(
                                      onTap: () {
                                        // setState(() {
                                        //   isFavourite = !isFavourite;
                                        // });

                                        Helper.moveToScreenwithPush(context, LoginPageWidget());
                                        // setState(() {
                                        //   if (_allCarsModel!.data![item].favStatus.toString()=="0") {
                                        //     _allCarsModel!.data![item].favStatus="1";
                                        //     Helper.checkInternet(favourite(_allCarsModel!.data![item].carId.toString()));
                                        //   } else {
                                        //     _allCarsModel!.data![item].favStatus="0";
                                        //     Helper.checkInternet(Unfavourite(_allCarsModel!.data![item].carId.toString()));
                                        //   }
                                        // });
                                      },
                                      child: SvgPicture.asset(

                                        'assets/images/bookmark_outline-03.svg',
                                        width: 30.33,
                                        height: 28.5,
                                      ),
                                    ):
                                    InkWell(
                                      onTap: () {
                                        // setState(() {
                                        //   isFavourite = !isFavourite;
                                        // });


                                        setState(() {
                                          if (_allCarsModel!.data![item].favStatus.toString()=="0") {
                                            _allCarsModel!.data![item].favStatus="1";
                                            Helper.checkInternet(favourite(_allCarsModel!.data![item].carId.toString()));
                                          } else {
                                            _allCarsModel!.data![item].favStatus="0";
                                            Helper.checkInternet(Unfavourite(_allCarsModel!.data![item].carId.toString()));
                                          }
                                        });
                                      },
                                      child: SvgPicture.asset(
                                        (_allCarsModel!.data![item].favStatus.toString()=="1")
                                            ? 'assets/images/bookmark-03.svg'
                                            : 'assets/images/bookmark_outline-03.svg',
                                        width: 30.33,
                                        height: 28.5,
                                      ),
                                    ),
                                    // InkWell(
                                    //   onTap: () {
                                    //     Helper.checkInternet(favourite(_allCarsModel!.data![item].carId.toString()));
                                    //   },
                                    //   child: SvgPicture.asset(
                                    //     'assets/images/heart_line.svg',
                                    //     width: 30.33,
                                    //     height: 28.5,
                                    //   ),
                                    // ),
                                    // SvgPicture.asset(
                                    //   'assets/images/heart_line.svg',
                                    //   width: 30.33,
                                    //   height: 28.5,
                                    // ),
                                  ],
                                ),
                                Image.network(
                                  _allCarsModel == null?"":_allCarsModel!.data![item].carImage![0].image.toString(),
                                  width: 240.33,
                                  height: 130.5,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          _allCarsModel == null?"":  _allCarsModel!.data![item].carName.toString(), style: FlutterTheme.of(context).titleSmall.override(
                                          fontFamily: 'Urbanist',fontSize: 14,fontWeight: FontWeight.w400,
                                          color: Color(0xff7C8BA0),
                                        ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          _allCarsModel == null?"":   _allCarsModel!.data![item].brandName.toString(), style: FlutterTheme.of(context).titleSmall.override(
                                          fontFamily: 'Urbanist',fontSize: 16,fontWeight: FontWeight.w400,
                                          color: Color(0xff0D0C0F),
                                        ),
                                        ),
                                      ],

                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "\$${_allCarsModel!.data![item].carCost.toString()}", style: FlutterTheme.of(context).titleSmall.override(
                                            fontFamily: 'Urbanist',
                                            color: Color(0xff0D0C0F),fontSize: 16
                                        ),
                                        ),
                                        Text(
                                          _allCarsModel!.data![item].priceType.toString(), style: FlutterTheme.of(context).titleSmall.override(
                                          fontFamily: 'Urbanist',fontSize: 12,
                                          color: Color(0xff7C8BA0),
                                        ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                Divider(
                                  color: Color(0xffAD3CFD6),
                                  thickness: 0.5,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                          'assets/images/sedan.svg',
                                          width: 18.33,
                                          height: 16.5,
                                        ),
                                        SizedBox(
                                          width: 8.8,
                                        ),
                                        Text(
                                          _allCarsModel!.data![item].vehicleCategory.toString(), style: FlutterTheme.of(context).titleSmall.override(
                                          fontFamily: 'Urbanist',fontSize: 14,fontWeight: FontWeight.w400,
                                          color: Color(0xff7C8BA0),
                                        ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                          'assets/images/diesel.svg',
                                          width: 18.33,
                                          height: 16.5,
                                        ),
                                        SizedBox(
                                          width: 8.8,
                                        ),
                                        Text(
                                          _allCarsModel!.data![item].specification.toString(), style: FlutterTheme.of(context).titleSmall.override(
                                          fontFamily: 'Urbanist',fontSize: 14,fontWeight: FontWeight.w400,
                                          color: Color(0xff7C8BA0),
                                        ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                          'assets/images/seater.svg',
                                          width: 18.33,
                                          height: 16.5,
                                        ),
                                        SizedBox(
                                          width: 8.8,
                                        ),
                                        Text(
                                          "${ _allCarsModel!.data![item].carSeat.toString()} Seater", style: FlutterTheme.of(context).titleSmall.override(
                                          fontFamily: 'Urbanist',fontSize: 14,fontWeight: FontWeight.w400,
                                          color: Color(0xff7C8BA0),
                                        ),
                                        ),
                                      ],
                                    ),

                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ))
                    : (_catergorywiseCar == null||_catergorywiseCar!.data!.isEmpty
                    ? (_hasData
                    ? Container(
                  // height: 273,
                )
                    : Container(
                  height: 273,
                  child: Center(
                    child: Text(""),
                  ),
                ))
                    :   Container(
                  // height: 273,
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.vertical,
                    itemCount: _catergorywiseCar!.data!.length,
                    // itemCount: _allCategoryModel!.data!.length,
                    itemBuilder: (context, item) {
                      print("=====_allCategoryModel!.data!.length======${_catergorywiseCar!.data!.length}");
                      // double distance =   calculateDistance(double.parse(_catergorywiseCar!.data![item].pickLat1.toString()), double.parse(_catergorywiseCar!.data![item].pickLong1.toString()) ,double.parse(  _catergorywiseCar!.data![item].pickLat2.toString()),
                      //     double.parse(_catergorywiseCar!.data![item].pickLong2.toString()));
                      // String travelTime = calculateTravelTime(double.parse(_catergorywiseCar!.data![item].pickLat1.toString()), double.parse(_catergorywiseCar!.data![item].pickLong1.toString()) ,double.parse(  _catergorywiseCar!.data![item].pickLat2.toString()),
                      //     double.parse(_catergorywiseCar!.data![item].pickLong2.toString()), 80);
                      // print("=====_isSelected2222=====${isSelected}");
                      final category = _catergorywiseCar!.data![item];
                      // final imagePath = eachCategoryWithImages[category];
                      //  isSelected = _allCategoryModel!.data![item].categoryName;
                      //  print("====isSelected ghjegej===${isSelected}");
                      return InkWell(
                        onTap: () {
                          context.pushNamed(
                            'product_detail_page',
                            queryParameters: {
                              'carId': _catergorywiseCar!.data![item].carId.toString(),
                              'lat':double.parse( _catergorywiseCar!.data![item].pickLat1.toString()).toString(),
                              'long':double.parse( _catergorywiseCar!.data![item].pickLong1.toString()).toString(),
                              'pickaddress':_catergorywiseCar!.data![item].pickAddress1.toString(),
                              'time':'',
                              'distance': '',
                            }.withoutNulls,
                          );
                          // context.pushNamed('product_detail_page');
                          // Helper.moveToScreenwithPush(context, ProductDetailPageWidget(hnmjh));
                          // Helper.checkInternet(categorywiselist(_allCategoryModel!.data![item].categoryName.toString()));
                        },
                        child:   Container(
                          height: 273,
                          margin: EdgeInsets.only(bottom: 10),
                          width: MediaQuery.of(context).size.width/1.1,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: Color(0xffFAFAFA),width: 1.5
                              )
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        _catergorywiseCar!.data![item].userimage.toString()==""?Image.asset( 'assets/images/default_profile_image.png',height: 25,width: 25,):
                                        ClipOval(child: Image.network(_catergorywiseCar!.data![item].userimage.toString(),height: 25,width: 25,)),
                                        SizedBox(
                                          width: 8.8,
                                        ),
                                        Container(
                                          width: 60,
                                          height: 24,
                                          decoration: BoxDecoration(
                                            color: Color(0xffFAF9FE
                                            ),
                                            border: Border.all(
                                              color: Color(0xff0D0C0F),
                                            ),
                                            borderRadius: BorderRadius.circular(8.0),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 0.0,vertical: 0),
                                            child: Row(
                                              children: [
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Icon(Icons.star,size: 10,color: Color(0xffFFBB35),),
                                                SizedBox(
                                                  width: 5,
                                                ),

                                                Text(
                                                  _catergorywiseCar!.data![item].rating!
                                                      .toString()=="0.00"?"5.0":_catergorywiseCar!.data![item].rating!
                                                      .toString(), style: FlutterTheme.of(context).titleSmall.override(
                                                    fontFamily: 'Urbanist',
                                                    color: Color(0xff0D0C0F),fontSize: 12
                                                ),
                                                ),

                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 8.8,
                                        ),

                                        Container(
                                          width: 85,
                                          height: 24,
                                          decoration: BoxDecoration(
                                            color: Color(0xff4ADB06).withOpacity(0.06),
                                            borderRadius: BorderRadius.circular(6.0),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 2.0,vertical: 0),
                                            child: Center(
                                              child: Text(
                                                "Available now", style: FlutterTheme.of(context).titleSmall.override(
                                                  fontFamily: 'Urbanist',
                                                  color: Color(0xff4ADB06),fontSize: 12
                                              ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5.8,
                                        ),
                                        // Icon(Icons.directions_walk,color: Color(0xff7C8BA0),size: 12,),
                                        // Text(
                                        //   " ${distance.toStringAsFixed(2)} km",
                                        //   style: FlutterTheme.of(context).titleSmall.override(
                                        //       fontFamily: 'Urbanist',
                                        //       color: Color(0xff0D0C0F),fontSize: 10
                                        //   ),
                                        // ),
                                        // Text(
                                        //   "(${travelTime})",overflow: TextOverflow.ellipsis, style: FlutterTheme.of(context).titleSmall.override(
                                        //   fontFamily: 'Urbanist',fontSize: 10,
                                        //   color: Color(0xff7C8BA0),
                                        // ),
                                        // ),
                                      ],
                                    ),
                                    _userProfileModel==null||_userProfileModel!.profileData!.userId.toString()==""||
                                        _userProfileModel!.profileData!.userId.toString()==null?   InkWell(
                                      onTap: () {
                                        // setState(() {
                                        //   isFavourite = !isFavourite;
                                        // });

                                        Helper.moveToScreenwithPush(context, LoginPageWidget());
                                        // setState(() {
                                        //   if (_allCarsModel!.data![item].favStatus.toString()=="0") {
                                        //     _allCarsModel!.data![item].favStatus="1";
                                        //     Helper.checkInternet(favourite(_allCarsModel!.data![item].carId.toString()));
                                        //   } else {
                                        //     _allCarsModel!.data![item].favStatus="0";
                                        //     Helper.checkInternet(Unfavourite(_allCarsModel!.data![item].carId.toString()));
                                        //   }
                                        // });
                                      },
                                      child: SvgPicture.asset(

                                        'assets/images/bookmark_outline-03.svg',
                                        width: 30.33,
                                        height: 28.5,
                                      ),
                                    ):      _userProfileModel==null||_userProfileModel!.profileData!.userId.toString()==""||
                                        _userProfileModel!.profileData!.userId.toString()==null?   InkWell(
                                      onTap: () {
                                        // setState(() {
                                        //   isFavourite = !isFavourite;
                                        // });

                                        Helper.moveToScreenwithPush(context, LoginPageWidget());
                                        // setState(() {
                                        //   if (_allCarsModel!.data![item].favStatus.toString()=="0") {
                                        //     _allCarsModel!.data![item].favStatus="1";
                                        //     Helper.checkInternet(favourite(_allCarsModel!.data![item].carId.toString()));
                                        //   } else {
                                        //     _allCarsModel!.data![item].favStatus="0";
                                        //     Helper.checkInternet(Unfavourite(_allCarsModel!.data![item].carId.toString()));
                                        //   }
                                        // });
                                      },
                                      child: SvgPicture.asset(

                                        'assets/images/bookmark_outline-03.svg',
                                        width: 30.33,
                                        height: 28.5,
                                      ),
                                    ):
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          if (_catergorywiseCar!.data![item].favStatus.toString()=="0") {
                                            _catergorywiseCar!.data![item].favStatus="1";
                                            Helper.checkInternet(favourite(_catergorywiseCar!.data![item].carId.toString()));
                                          } else {
                                            _catergorywiseCar!.data![item].favStatus="0";
                                            Helper.checkInternet(Unfavourite(_catergorywiseCar!.data![item].carId.toString()));
                                          }
                                        });
                                        // setState(() {
                                        //   isFavourite = !isFavourite;
                                        // });
                                        //
                                        // if (isFavourite) {
                                        //   Helper.checkInternet(favourite(_catergorywiseCar!.data![item].carId.toString()));
                                        // } else {
                                        //   Helper.checkInternet(Unfavourite(_catergorywiseCar!.data![item].carId.toString()));
                                        // }
                                      },
                                      child: SvgPicture.asset(
                                        _catergorywiseCar!.data![item].favStatus=="1"
                                            ? 'assets/images/bookmark-03.svg'
                                            : 'assets/images/bookmark_outline-03.svg',
                                        width: 30.33,
                                        height: 28.5,
                                      ),
                                    ),
                                    // InkWell(
                                    //   onTap: () {
                                    //     Helper.checkInternet(favourite(_catergorywiseCar!.data![item].carId.toString()));
                                    //   },
                                    //   child: SvgPicture.asset(
                                    //     'assets/images/bookmark-03.svg',
                                    //     width: 30.33,
                                    //     height: 28.5,
                                    //   ),
                                    // ),
                                    // InkWell(
                                    //   onTap: () {
                                    //     Helper.checkInternet(Unfavourite(_catergorywiseCar!.data![item].carId.toString()));
                                    //   },
                                    //   child: SvgPicture.asset(
                                    //     'assets/images/bookmark_outline-03.svg',
                                    //     width: 30.33,
                                    //     height: 28.5,
                                    //   ),
                                    // ),
                                  ],
                                ),
                                Image.network(
                                  _catergorywiseCar!.data![item].carImage.toString(),
                                  width: 240.33,
                                  height: 130.5,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          _catergorywiseCar!.data![item].carName.toString(), style: FlutterTheme.of(context).titleSmall.override(
                                          fontFamily: 'Urbanist',fontSize: 14,fontWeight: FontWeight.w400,
                                          color: Color(0xff7C8BA0),
                                        ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          _catergorywiseCar!.data![item].brandName.toString(), style: FlutterTheme.of(context).titleSmall.override(
                                          fontFamily: 'Urbanist',fontSize: 16,fontWeight: FontWeight.w400,
                                          color: Color(0xff0D0C0F),
                                        ),
                                        ),
                                      ],

                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "\$${_catergorywiseCar!.data![item].carCost.toString()}", style: FlutterTheme.of(context).titleSmall.override(
                                            fontFamily: 'Urbanist',
                                            color: Color(0xff0D0C0F),fontSize: 16
                                        ),
                                        ),
                                        Text(
                                          _catergorywiseCar!.data![item].priceType.toString(), style: FlutterTheme.of(context).titleSmall.override(
                                          fontFamily: 'Urbanist',fontSize: 12,
                                          color: Color(0xff7C8BA0),
                                        ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                Divider(
                                  color: Color(0xffAD3CFD6),
                                  thickness: 0.5,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                          'assets/images/sedan.svg',
                                          width: 18.33,
                                          height: 16.5,
                                        ),
                                        SizedBox(
                                          width: 8.8,
                                        ),
                                        Text(
                                          _catergorywiseCar!.data![item].vehicleCategory.toString(), style: FlutterTheme.of(context).titleSmall.override(
                                          fontFamily: 'Urbanist',fontSize: 14,fontWeight: FontWeight.w400,
                                          color: Color(0xff7C8BA0),
                                        ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                          'assets/images/diesel.svg',
                                          width: 18.33,
                                          height: 16.5,
                                        ),
                                        SizedBox(
                                          width: 8.8,
                                        ),
                                        Text(
                                          _catergorywiseCar!.data![item].specification.toString(), style: FlutterTheme.of(context).titleSmall.override(
                                          fontFamily: 'Urbanist',fontSize: 14,fontWeight: FontWeight.w400,
                                          color: Color(0xff7C8BA0),
                                        ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                          'assets/images/seater.svg',
                                          width: 18.33,
                                          height: 16.5,
                                        ),
                                        SizedBox(
                                          width: 8.8,
                                        ),
                                        Text(
                                          "${ _catergorywiseCar!.data![item].carSeat.toString()} Seater", style: FlutterTheme.of(context).titleSmall.override(
                                          fontFamily: 'Urbanist',fontSize: 14,fontWeight: FontWeight.w400,
                                          color: Color(0xff7C8BA0),
                                        ),
                                        ),
                                      ],
                                    ),

                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                )),
              ),
              Helper.getProgressBarWhite(context, _isVisible)
            ],
          ),
        ),
      ),
    );
  }

  void getCurrentLocation() async {
    print("========current location=======");
    try {
      LocationPermission permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();

        if (permission == LocationPermission.denied) {
          print('Location permission denied by user');
          return;
        }
      }

      final position = await Geolocator.getCurrentPosition();

      // Set global latitude and longitude
      globalLatitude = position.latitude;
      globalLongitude = position.longitude;

      print('Current Position: ${globalLatitude}, ${globalLongitude}');

      List<Placemark> placemarks =
      await placemarkFromCoordinates(position.latitude, position.longitude);

      setState(() {
        startLocation = LatLng(position.latitude, position.longitude);
        print("====startLocation=====${startLocation}");
        location = placemarks.first.street.toString() +
            ", " +
            placemarks.first.subLocality.toString() +
            ", " +
            placemarks.first.administrativeArea.toString();
        _isVisiblenew = true;
        setProgress(false);
        print("=====location======${location}");
      });
    } catch (e) {
      print("Error getting current location: $e");
      // Handle error or provide user feedback.
    }
  }

  setProgress(bool show) {
    if (mounted)
      setState(() {
        _isVisible = show;
      });
  }
  Future<void> categorywiselist(String category) async {


    print("<=============categorywiselist== hello===========>");

    SessionHelper session = await SessionHelper.getInstance(context);
    String userId = session.get(SessionHelper.USER_ID) ?? "0";
    // String city = session.get(SessionHelper.CITY) ?? "0";
    setProgress(true);
    _hasData=true;

    Map data = {
      'app_token':'booking12345',
      'category':category,
      'user_id': FFAppState().UserId,
      'city':''
    };

    print("Request =============>" + data.toString());
    // print("city =============>" + city);
    try {
      var res = await http.post(Uri.parse(Apis.category_wise_car), body: data);
      print("Response ============>" + res.body);

      if (res.statusCode == 200) {
        try {
          final jsonResponse = jsonDecode(res.body);
          CatergorywiseCar model = CatergorywiseCar.fromJson(jsonResponse);

          if (model.response == "true") {
            print("Model status true");
            setProgress(false);
            _hasData=false;

            setState(() {
              _catergorywiseCar=model;
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


            // ScaffoldMessenger.of(context).showSnackBar(
            //   SnackBar(
            //     content: Text(model.message.toString()),
            //   ),
            // );
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
  Future<void> allcars() async {


    print("<=============allcategory=click============>");

    SessionHelper session = await SessionHelper.getInstance(context);
    String userId = session.get(SessionHelper.USER_ID) ?? "0";
    // String city = session.get(SessionHelper.CITY) ?? "0";
    setProgress(true);
    _hasData=true;

    Map data = {
      'app_token':'booking12345',
      'user_id': FFAppState().UserId,
       'city':'',
    };

    print("Request =============>" + data.toString());
    // print("city =============>" + city);
    try {
      var res = await http.post(Uri.parse(Apis.all_cars), body: data);
      print("Response ============>" + res.body);

      if (res.statusCode == 200) {
        try {
          final jsonResponse = jsonDecode(res.body);
          AllCarsModel model = AllCarsModel.fromJson(jsonResponse);

          if (model.response == true) {
            print("Model status true");
            setProgress(false);
            _hasData=false;

            setState(() {
              _allCarsModel=model;
              print("=====  _allCarsModel!.data!.length.toString()====${  _allCarsModel!.data!.length.toString()}");

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


            // ScaffoldMessenger.of(context).showSnackBar(
            //   SnackBar(
            //     content: Text(model.message.toString()),
            //   ),
            // );
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
  Future<void> favourite(String car_id) async {


    print("<============favourite== hello===========>");

    SessionHelper session = await SessionHelper.getInstance(context);
    String userId = session.get(SessionHelper.USER_ID) ?? "0";
    setProgress(true);
    _hasData=true;

    Map data = {
      'app_token':'booking12345',
      'car_id':car_id,
      'user_id': FFAppState().UserId,
    };

    print("Request =============>" + data.toString());
    try {
      var res = await http.post(Uri.parse(Apis.Add_favourite), body: data);
      print("Response ============>" + res.body);

      if (res.statusCode == 200) {
        try {
          final jsonResponse = jsonDecode(res.body);
          AddFavourite model = AddFavourite.fromJson(jsonResponse);

          if (model.response == true) {
            print("Model status true");
            setProgress(false);
            _hasData=false;

            setState(() {
              _addFavourite=model;
              // Helper.checkInternet(categoryapi());
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


            // ScaffoldMessenger.of(context).showSnackBar(
            //   SnackBar(
            //     content: Text(model.message.toString()),
            //   ),
            // );
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


            // ScaffoldMessenger.of(context).showSnackBar(
            //   SnackBar(
            //     content: Text(model.message.toString()),
            //   ),
            // );
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


  Future<void> Unfavourite(String car_id) async {


    print("<============unfav== hello===========>");

    SessionHelper session = await SessionHelper.getInstance(context);
    String userId = session.get(SessionHelper.USER_ID) ?? "0";
    setProgress(true);
    _hasData=true;

    Map data = {
      'app_token':'booking12345',
      'car_id':car_id,
      'user_id': FFAppState().UserId,
    };

    print("Request =============>" + data.toString());
    try {
      var res = await http.post(Uri.parse(Apis.Unfavourite), body: data);
      print("Response ============>" + res.body);

      if (res.statusCode == 200) {
        try {
          final jsonResponse = jsonDecode(res.body);
          AddFavourite model = AddFavourite.fromJson(jsonResponse);

          if (model.response == true) {
            print("Model status true");
            setProgress(false);
            _hasData=false;

            setState(() {
              _addFavourite=model;
              // Helper.checkInternet(categoryapi());
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


            // ScaffoldMessenger.of(context).showSnackBar(
            //   SnackBar(
            //     content: Text(model.message.toString()),
            //   ),
            // );
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
  Future<void> promocodeApi() async {


    print("<=============promocodeApi=============>");

    SessionHelper session = await SessionHelper.getInstance(context);
    String userId = session.get(SessionHelper.USER_ID) ?? "0";
    setProgress(true);
    _hasData=true;

    Map data = {
      'app_token':'booking12345',
    };

    print("Request =============>" + data.toString());
    try {
      var res = await http.post(Uri.parse(Apis.promocode), body: data);
      print("Response ============>" + res.body);

      if (res.statusCode == 200) {
        try {
          final jsonResponse = jsonDecode(res.body);
          Promocode model = Promocode.fromJson(jsonResponse);

          if (model.result == "success") {
            print("Model status true");
            setProgress(false);
            _hasData=false;

            setState(() {
              _promocodeModel=model;
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
