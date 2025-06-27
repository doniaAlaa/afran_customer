import 'dart:convert';

import 'package:afran/constant/app_apis.dart';
import 'package:afran/constant/app_strings.dart';
import 'package:afran/constant/dio_client.dart';
import 'package:afran/constant/secure_storage.dart';
import 'package:afran/entity/product_category_model.dart';
import 'package:afran/entity/user_model.dart';
import 'package:afran/home/models/product_model.dart';
import 'package:afran/notifications/widgets/top_sliding_notification.dart';
import 'package:afran/track_order/pusher/pusher_configration.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

class HomeController extends GetxController{

  RxInt selectedProductTypeIndex = 0.obs;
  RxBool loading = true.obs;
  RxBool productCategoryLoading = true.obs;
  RxBool addToFavoriteLoading = false.obs;
  RxBool categoriesLoading = true.obs;
  RxList<ProductModel> products = <ProductModel>[].obs;
  RxList<ProductModel> productsByCategory = <ProductModel>[].obs;
  ////////////////
  RxList<ProductCategoryModel> categories  = <ProductCategoryModel>[].obs;
  RxBool productCategoriesLoading = false.obs;
  RxBool notificationNotReaded = false.obs;
  RxInt notificationCounter = 0.obs;
  RxList<dynamic> notificationsList = [].obs;
  final secureStorage = SecureStorageService();

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance!.addPostFrameCallback((_) async{
      // executes after build

      String? result =  await secureStorage.read(notReadedNotification);
      print(result);
      print('objectooooooooooooooooooooo$result');

      if(result != null && result == 'true'){
        notificationNotReaded.value = true;
      }else{
        notificationNotReaded.value = false;
      }
    });
     getProductCategories();
    _listenToPusher();

  }



  void _listenToPusher() async {
    final pusher = PusherService.instance;


  String? userData = await secureStorage.read(user);

 try{
   if(userData != null){
     UserModel userModel = UserModel.fromJson(jsonDecode(userData));
     final String channelName = "notifications.${userModel.id}"; // Interpolated once correctly
     // final String channelName = "my-channel"; // Interpolated once correctly
     print(userModel.id);
     await pusher.init(
       logToConsole: true,
       // apiKey: "89b897f40a812084df08",
       apiKey: "ef482180ec86015c2ee1",
       cluster: "ap2",
       onConnectionStateChange: (currentState, previousState) {
         print("Connection: $currentState");
       },
       onError: (message, code, error) {
         print("Error: $message ($code) $error");
       },
       onEvent: (PusherEvent event) async{
         print(" Event received: ${event.eventName} on ${event.channelName}");

         // Filter event using correctly interpolated channel name
         if (event.channelName == channelName && event.eventName == "new-notification") {
         // if (event.channelName == channelName && event.eventName == "my-event") {
           print('✅ Matched event: ${event.data}');
           Map<String, dynamic> data = jsonDecode(event.data);

           NotificationService.show('📦${data['title']} ', '${data['description']}');
           await secureStorage.write(notReadedNotification,'true');
           notificationNotReaded.value = true;
           // final data = event.data != null ? jsonDecode(event.data!) : null;
           // if (data != null) {
           //   print('📦 Order Status: ${data['status']}');
           // }
         }
       },
     );

     await pusher.connect();
     await pusher.subscribe(channelName: channelName);
     print("📡 Subscribed to channel: $channelName");


   }
 }catch(e){
   print(e);
 }
  }







  ////NOTIFICATION///
  // void showNotificationOverlay(BuildContext context, String title, String message) {
  //   OverlayEntry? entry;
  //   entry = OverlayEntry(
  //     builder: (context) => Positioned(
  //       top: MediaQuery.of(context).padding.top + 8,
  //       left: 16,
  //       right: 16,
  //       child: Material(
  //         elevation: 6,
  //         borderRadius: BorderRadius.circular(12),
  //         child: NotificationBanner(title: title, message: message),
  //       ),
  //     ),
  //   );
  //
  //   Overlay.of(context).insert(entry!);
  //
  //   Future.delayed(Duration(seconds: 3), () => entry?.remove());
  // }


  ////GET PRODUCTS LIST///
  getProducts() async{
    print('kjjjjjjjjjj');
    loading.value = true;
    await DioClient().getAPI(
      '${baseUrl}/products?lat=29.786005&long=31.306943',

    ).then((result) async {
      loading.value = false;
      print(',,,,,,,,,,,,,$result');
      if(result['data']['status'] == true){
        products.clear();
        List<dynamic> data = result['data']['data'];
        print('nnnnnnnnnnnn${data.length}');

        try{
          data.forEach((e){
            products.add(ProductModel.fromJson(e));
          });
        }catch(e){
          loading.value = false;

        }



      }
    }).catchError((err){
      loading.value = false;

    });
  }

  ////GET PRODUCTS LIST BY CATEGORY ID///
  getProductsByCategory(int categoryId) async{

    productCategoriesLoading.value = true;
    productsByCategory.clear();
    await DioClient().getAPI(
      '${baseUrl}/products?lat=29.787310&long=31.301227&category_id=$categoryId',

    ).then((result) async {
      productCategoriesLoading.value = false;

      if(result['data']['status'] == true){
        // productsByCategory.clear();
        List<dynamic> data = result['data']['data'];

        try{
          data.forEach((e){
            productsByCategory.add(ProductModel.fromJson(e));
          });
        }catch(e){
          productCategoriesLoading.value = false;

        }



      }
    }).catchError((err){
      loading.value = false;

    });
  }

  ////GET PRODUCT CATEGORIES///
  getProductCategories() async{
    categoriesLoading.value = true;
    await DioClient().getAPI(
      getProductCategoriesApi,


    ).then((result) async{
      categoriesLoading.value = false;
      if(result != null && result['data']['status'] == true){
        getProducts();

        List<dynamic> data = result['data']['data'];
        categories.clear();
        data.forEach((e){
          categories.add(ProductCategoryModel.fromJson(e));
        });

      }else {}
    }).catchError((error){
      categoriesLoading.value = false;
    });
  }

  ////ADD PRODUCT TO MY FAVORITES///
  addToFavorite(BuildContext context,int id,int itemIndex) async{
    addToFavoriteLoading.value = true;
    await DioClient().postAPI(
        '$baseUrl/favorites/$id',
       {}

    ).then((result) async{
      addToFavoriteLoading.value = false;

      if(result['statusCode'] == 200 || result['statusCode'] == 201){
        if(result != null && result['data']['status'] == true){


          const snackBar = SnackBar(

              backgroundColor: Colors.green,
              content: Text('تم إضافة العنصر للعناصر المفضلة لك',textAlign: TextAlign.end,));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          products[itemIndex] = products[itemIndex].copyWith(is_favorite: true);


        }else{
          addToFavoriteLoading.value = false;
          const snackBar = SnackBar(

              backgroundColor: Colors.red,
              content: Text('حدث خطأ ، يرجى المحاولة مرة أخرى',textAlign: TextAlign.end,));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      }

    }).catchError((error){
      addToFavoriteLoading.value = false;
    });



  }



  //TODO:ADDING LAT AND LONG
  getNearestProvider() async{

    /////////////////////////

    loading.value = true;
    await DioClient().getAPI(
      '${baseUrl}/getNearestProviders?lat=30.198775&long=31.344515',

    ).then((result) async {
      loading.value = false;

      if(result['data']['status'] == true){
        products.clear();
        List<dynamic> data = result['data']['data'];
        print('nnnnnnnnnnnn${data.length}');

        try{
          data.forEach((e){
            products.add(ProductModel.fromJson(e));
          });
        }catch(e){
          loading.value = false;

        }



      }
    }).catchError((err){
      loading.value = false;

    });


  }

  getProductsWithOffers() async{
    loading.value = true;
    await DioClient().getAPI(
      '${baseUrl}/getProductsWithOffers?lat=29.787310&long=31.301227',

    ).then((result) async {

      loading.value = false;
      // if(result['status'])
      products.clear();

      if(result['data']['status'] == true){
        List<dynamic> data = result['data']['data'];

        try{
          data.forEach((e){
            products.add(ProductModel.fromJson(e));
          });
        }catch(e){
          loading.value = false;

        }



      }
    }).catchError((err){
      print('kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk');
      products.clear();
      loading.value = false;

    });


  }

  getProvidersSortedByRate() async{
    loading.value = true;
    await DioClient().getAPI(
      '${baseUrl}/getProvidersSortedByRate?lat=29.787310&long=31.301227',

    ).then((result) async {
      loading.value = false;
      if(result['data']['status'] == true){
        products.clear();

        List<dynamic> data = result['data']['data'];
        print('yyyyyyyyyyyy${data}');

        try{
          data.forEach((e){
            products.add(ProductModel.fromJson(e));
          });
        }catch(e){
          print(e);
          loading.value = false;

        }



      }
    }).catchError((err){
      loading.value = false;

    });


  }

  getProductsByDescId() async{
    loading.value = true;
    await DioClient().getAPI(
      '${baseUrl}/getProductsByDescId',

    ).then((result) async {
      loading.value = false;

      if(result['data']['status'] == true){
        products.clear();
        List<dynamic> data = result['data']['data'];

        try{
          data.forEach((e){
            products.add(ProductModel.fromJson(e));
          });
        }catch(e){
          loading.value = false;

        }



      }
    }).catchError((err){
      loading.value = false;

    });


  }

  getProductsOrderedByMostOrdered() async{
    print('getProductsOrderedByMostOrdered');
    loading.value = true;
    await DioClient().getAPI(
      '${baseUrl}/getProductsOrderedByMostOrdered?lat=29.787310&long=31.301227',

    ).then((result) async {
      loading.value = false;

      if(result['data']['status'] == true){
        products.clear();
        List<dynamic> data = result['data']['data']['products'];
        try{
          data.forEach((e){
            products.add(ProductModel.fromJson(e));
          });
          print(products.first.id);
        }catch(e){
          print(e);
          loading.value = false;

        }



      }
    }).catchError((err){
      loading.value = false;

    });


  }

  RxBool providerProductsLoading = false.obs;
  RxList<ProductModel> providerProducts = <ProductModel>[].obs;
  getProductsByProviderId(int providerId) async{
    providerProductsLoading.value = true;
    await DioClient().getAPI(
      '${baseUrl}/products?lat=29.787310&long=31.301227&provider_id=$providerId',

    ).then((result) async {
      providerProductsLoading.value = false;

      if(result['data']['status'] == true){
        providerProducts.clear();
        List<dynamic> data = result['data']['data'];
        print(data.first['name']);
        try{
          data.forEach((e){
            providerProducts.add(ProductModel.fromJson(e));
          });
        }catch(e){
          providerProductsLoading.value = false;

        }



      }
    }).catchError((err){
      loading.value = false;

    });


  }




  // RxList<ItemModel> items1 = <ItemModel>[].obs;
  // RxList<ItemModel> items2 = <ItemModel>[].obs;

  void setupFirebaseMessaging() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;


    // Get the FCM token (send this to your backend)
    String? token = await messaging.getToken();
    print("FCM Token: $token");

    // Foreground message
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("📩 Foreground: ${message.notification?.title}");
      // Show custom UI if needed (use flutter_local_notifications)
    });

    // Background tap handler
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("📦 Notification tapped from background: ${message.data}");
      // Navigate to screen using data (e.g., orderId)
    });

    // App opened from terminated state
    RemoteMessage? initialMessage =
    await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      print("🚀 App launched from terminated via notification: ${initialMessage.data}");
      // Handle navigation or logic
    }
  }



}