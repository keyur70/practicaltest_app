import 'package:flutter/material.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:practical_app/constant/colors.dart';
import 'package:practical_app/constant/image.dart';
import 'package:practical_app/constant/strings.dart';
import 'package:practical_app/controller/property_provider.dart';
import 'package:practical_app/model/property_data_model.dart';
import 'package:practical_app/view/map/map_screen.dart';
import 'package:practical_app/widgets/image_view.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //-------------------------------------------------- Controller -----------------------------------------------------//
  PropertyController propertyController = PropertyController();
  CarouselSliderController sliderController = CarouselSliderController();

  late GoogleMapController controller;

  //--------------------------------------------------- Variable --------------------------------------------------------//
  int currentIndex = 0;

  @override
  void initState() {
    propertyController =
        Provider.of<PropertyController>(context, listen: false);
    propertyController.propertyController();
    setCustomeMarker();
    super.initState();
  }

  final Set<Marker> _markers = {};
  BitmapDescriptor? mapMarker;

  void setCustomeMarker() async {
    mapMarker = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(),
      ConstImages.markerImg,
    );
  }

  //-------------------------------------------------- UI -------------------------------------------------------------//
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      left: false,
      right: false,
      bottom: false,
      child: Scaffold(
        body: Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.fromSwatch(
              accentColor: Colors.white,
            ),
          ),
          child: _buildBodyView(size),
        ),
      ),
    );
  }

  // Body View
  Widget _buildBodyView(Size size) {
    return Container(
      height: size.height,
      width: size.width,
      padding: EdgeInsets.symmetric(
        vertical: size.height * 0.025,
        horizontal: size.width * 0.03,
      ),
      child: Card(
        elevation: 7,
        clipBehavior: Clip.hardEdge,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Consumer<PropertyController>(
          builder: (context, propertyData, child) {
            if (propertyData.fetchPropertyData.responseData == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              var propertyValue = propertyData
                  .fetchPropertyData.responseData?.propertyData?.properties;

              return SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildCardView(size, propertyValue ?? []),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: size.height * 0.015,
                          vertical: size.height * 0.02),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildDesciptionView(
                              size, (propertyValue ?? [])[currentIndex]),
                          SizedBox(height: size.height * 0.03),
                          _buildLocationView(
                              size, (propertyValue ?? [])[currentIndex]),
                          SizedBox(height: size.height * 0.03),
                          _buildKeyFeaturesView(
                              size, (propertyValue ?? [])[currentIndex]),
                          SizedBox(height: size.height * 0.03),
                          _buildGalleryView(
                              size, (propertyValue ?? [])[currentIndex]),
                          SizedBox(height: size.height * 0.04),
                          _buildBasicInfo(
                              size, (propertyValue ?? [])[currentIndex]),
                        ],
                      ),
                    )
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildCardView(Size size, List<Properties> propertyValue) {
    return Stack(
      children: [
        _buildSlider(size, propertyValue),
        darkShadowView(size),
        _buildHeaderCardView(
          size,
          propertyValue[currentIndex],
        ),
        _buildCardBottomView(
          size,
          propertyValue[currentIndex],
        ),
      ],
    );
  }

//------------------------------------------ Build Widget --------------------------------------------//

//Card View
  Widget _buildCardBottomView(Size size, Properties propertyValue) {
    return Positioned(
      bottom: 0,
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: size.height * 0.02, horizontal: size.width * 0.03),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "₤ ${propertyValue.monthlyPrice}",
              style: TextStyle(
                color: ConstColor.whiteColor,
                fontWeight: FontWeight.bold,
                fontSize: size.height * 0.034,
              ),
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            Row(
              children: [
                const Icon(
                  Icons.king_bed_sharp,
                  color: ConstColor.pinkColor,
                ),
                SizedBox(
                  width: size.width * 0.02,
                ),
                Text(
                  propertyValue.bedrooms.toString(),
                  style: TextStyle(
                    color: ConstColor.whiteColor,
                    fontWeight: FontWeight.bold,
                    fontSize: size.height * 0.017,
                  ),
                ),
                SizedBox(
                  width: size.width * 0.02,
                ),
                const Icon(
                  Icons.bathtub,
                  color: ConstColor.blueColor,
                ),
                SizedBox(width: size.width * 0.02),
                Text(
                  propertyValue.bedrooms.toString(),
                  style: TextStyle(
                    color: ConstColor.whiteColor,
                    fontWeight: FontWeight.bold,
                    fontSize: size.height * 0.017,
                  ),
                ),
                Text(
                  ' • ',
                  style: TextStyle(
                    color: ConstColor.whiteColor,
                    fontWeight: FontWeight.bold,
                    fontSize: size.height * 0.02,
                  ),
                ),
                Text(
                  propertyValue.nearestLocation.toString(),
                  style: TextStyle(
                    color: ConstColor.whiteColor,
                    fontWeight: FontWeight.w600,
                    fontSize: size.height * 0.017,
                  ),
                ),
                Text(
                  ' • ',
                  style: TextStyle(
                    color: ConstColor.whiteColor,
                    fontWeight: FontWeight.bold,
                    fontSize: size.height * 0.02,
                  ),
                ),
                Text(
                  propertyValue.nearestLocationTime.toString(),
                  style: TextStyle(
                    color: ConstColor.whiteColor,
                    fontWeight: FontWeight.w600,
                    fontSize: size.height * 0.017,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  // slider view
  Widget _buildSlider(Size size, List<Properties> propertyValue) {
    return Container(
      height: size.height / 1.15,
      width: size.width * 1,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: CarouselSlider.builder(
        controller: sliderController,
        onSlideChanged: (value) {
          setState(() {
            currentIndex = value;
          });
        },
        slideBuilder: (index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: CommanImageView(
              imageUrl: propertyValue[index].user?.profileImage ?? '',
            ),
          );
        },
        slideTransform: const RotateUpTransform(rotationAngle: 10),
        itemCount: propertyValue.length,
        initialPage: 0,
        enableAutoSlider: false,
      ),
    );
  }

  // shadow
  Widget darkShadowView(Size size) {
    return Container(
      height: size.height * 0.3,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            ConstColor.blackColor.withOpacity(0.1),
            ConstColor.blackColor.withOpacity(0.01),
          ],
        ),
      ),
    );
  }

  // head card view
  Widget _buildHeaderCardView(Size size, Properties propertyValue) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.06, vertical: size.height * 0.04),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: size.height * 0.02,
              ),
              Text(
                propertyValue.addressArea ?? '',
                style: TextStyle(
                  color: ConstColor.whiteColor,
                  fontSize: size.height * 0.03,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              Container(
                decoration: const BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Text(
                  propertyValue.status ?? '',
                  style: TextStyle(
                    color: ConstColor.whiteColor,
                    fontSize: size.height * 0.015,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              )
            ],
          ),
          Column(
            children: [
              Stack(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    clipBehavior: Clip.hardEdge,
                    width: size.width * 0.18,
                    height: size.height * 0.11,
                    child: CommanImageView(
                      imageUrl: propertyValue.user?.profileImage ?? '',
                    ),
                  ),
                  const Positioned(
                    bottom: 0,
                    left: 20,
                    child: CircleAvatar(
                      maxRadius: 15,
                      backgroundColor: ConstColor.pinkColor,
                      child: Icon(
                        Icons.message,
                        size: 15,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              SvgPicture.asset(
                ConstImages.sendImg,
                color: ConstColor.whiteColor,
                height: size.height * 0.04,
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              Icon(
                Icons.play_arrow,
                size: size.height * 0.05,
                color: ConstColor.whiteColor,
              )
            ],
          )
        ],
      ),
    );
  }

  // Description View
  Widget _buildDesciptionView(Size size, Properties propertyValue) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeadLineText(title: ConstStrings.descriptionStr),
        SizedBox(height: size.height * 0.01),
        Text(
          propertyValue.description ?? '',
          style: const TextStyle(
            color: ConstColor.grayColor,
          ),
        ),
      ],
    );
  }

  // Location View
  Widget _buildLocationView(Size size, Properties propertyValue) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeadLineText(title: ConstStrings.locationStr),
        SizedBox(
          height: size.height * 0.01,
        ),
        Text(
          propertyValue.addressStreetName ?? '',
          style: const TextStyle(
            color: ConstColor.grayColor,
          ),
        ),
        SizedBox(
          height: size.height * 0.01,
        ),
        Container(
          height: size.height * 0.2,
          width: size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          child: GoogleMap(
            onTap: (argument) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FullScreenMap(
                    propertyLatLng: LatLng(propertyValue.latitude ?? 0,
                        propertyValue.longitude ?? 0),
                  ),
                ),
              );
            },
            initialCameraPosition: CameraPosition(
              target: LatLng(
                  propertyValue.latitude ?? 0, propertyValue.longitude ?? 0),
              zoom: 16,
            ),
            mapType: MapType.normal,
            myLocationEnabled: false,
            zoomControlsEnabled: false,
            myLocationButtonEnabled: false,
            mapToolbarEnabled: false,
            markers: _markers,
            onMapCreated: (mapController) {
              controller = mapController;
              setState(() {
                _markers.add(
                  Marker(
                    markerId: const MarkerId("1"),
                    position: LatLng(propertyValue.latitude ?? 0,
                        propertyValue.longitude ?? 0),
                    icon: mapMarker!,
                  ),
                );
              });
              controller.animateCamera(
                CameraUpdate.newCameraPosition(
                  CameraPosition(
                      target: LatLng(propertyValue.latitude ?? 0,
                          propertyValue.longitude ?? 0),
                      zoom: 16),
                ),
              );
            },
          ),
        )
      ],
    );
  }

  // Key features View
  Widget _buildKeyFeaturesView(Size size, Properties propertyValue) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeadLineText(title: ConstStrings.keyFeaturesStr),
        SizedBox(
          height: size.height * 0.02,
        ),
        SizedBox(
          height: size.height * 0.14,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: propertyValue.keyFeatures?.length,
            itemBuilder: (context, index) {
              var keyFeaturesData = propertyValue.keyFeatures?[index];
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Container(
                  width: size.width * 0.27,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: ConstColor.darkPinkColor,
                      ),
                      borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: size.height * 0.05,
                          child: CommanImageView(
                            imageUrl: keyFeaturesData?.colorIconUrl ?? '',
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        Text(
                          keyFeaturesData?.name ?? '',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }

  // Gallery View
  Widget _buildGalleryView(Size size, Properties propertyValue) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeadLineText(title: ConstStrings.galleryStr),
        SizedBox(
          height: size.height * 0.01,
        ),
        Container(
          height: size.height * 0.25,
          width: size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
          ),
          child: CarouselSlider.builder(
            controller: sliderController,
            slideBuilder: (index) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: CommanImageView(
                  imageUrl:
                      propertyValue.propertyImages?[index].thumbnail ?? '',
                ),
              );
            },
            slideIndicator: CircularSlideIndicator(
              padding: EdgeInsets.only(bottom: size.height * 0.025),
              indicatorBorderColor: Colors.transparent,
              indicatorBorderWidth: 1,
              indicatorRadius: 4,
              itemSpacing: 15,
              indicatorBackgroundColor: ConstColor.whiteColor.withOpacity(0.3),
              currentIndicatorColor: ConstColor.whiteColor,
            ),
            itemCount: propertyValue.propertyImages?.length ?? 0,
            initialPage: 0,
            enableAutoSlider: false,
          ),
        ),
      ],
    );
  }

  // Basic Info View
  Widget _buildBasicInfo(Size size, Properties propertyValue) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeadLineText(title: ConstStrings.basicInfoStr),
        SizedBox(
          height: size.height * 0.02,
        ),
        _buildBasicInfoDataView(
          size: size,
          title: 'Listing Type',
          value: propertyValue.listingType == 'WP' ? 'Whole property' : 'Room',
        ),
        _buildBasicInfoDataView(
          size: size,
          title: 'Property Type',
          value: propertyValue.propertyType == 'F' ? 'Flat' : 'Home',
        ),
        _buildBasicInfoDataView(
          size: size,
          title: 'Room Type',
          value: propertyValue.roomType == 'SR' ? 'Single Room' : '',
        ),
        _buildBasicInfoDataView(
          size: size,
          title: 'Move in date',
          value: propertyValue.moveInDate == 'an'
              ? 'Available Now'
              : propertyValue.moveInDate.toString(),
        ),
        _buildBasicInfoDataView(
          size: size,
          title: 'Length of stay',
          value: propertyValue.lengthOfStay == 'SL' ? 'Short let' : 'Long let',
        ),
        _buildBasicInfoDataView(
          size: size,
          title: 'Type',
          value: propertyValue.type == "F"
              ? 'Furnished'
              : propertyValue.type.toString(),
        ),
        _buildBasicInfoDataView(
          size: size,
          title: 'For Students',
          value: propertyValue.isSuitableForStudent == 1 ? 'true' : 'false',
        ),
        _buildBasicInfoDataView(
          size: size,
          title: 'Deposit amount',
          value: propertyValue.depositAmount.toString(),
        ),
      ],
    );
  }

//------------------------------------------ Helper Widget --------------------------------------------//
  Widget _buildBasicInfoDataView({
    required Size size,
    required String title,
    required String value,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: size.height * 0.01),
      child: Row(
        children: [
          SizedBox(
            width: size.width / 3,
            child: Text(
              title,
              style: TextStyle(
                fontSize: size.height * 0.017,
                color: ConstColor.grayColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: size.height * 0.017,
              color: ConstColor.blackColor,
              fontWeight: FontWeight.w400,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildHeadLineText({required String title}) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 20,
        color: ConstColor.blackColor,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
