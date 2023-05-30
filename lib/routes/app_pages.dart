import 'package:customer_app/app/ui/pages/my_account/about_screen.dart';
import 'package:customer_app/screens/root/splashscreen.dart';
import 'package:customer_app/widgets/all_chatview.dart';
import 'package:flutter/material.dart';
import 'package:customer_app/app/bindings/cartBindings.dart';
import 'package:customer_app/app/bindings/home_binding.dart';
import 'package:customer_app/app/bindings/my_wallet_binding.dart';
import 'package:customer_app/app/bindings/myaccount_binding.dart';
import 'package:customer_app/app/bindings/new_location_picker_binding.dart';
import 'package:customer_app/app/bindings/root_bindings.dart';
import 'package:customer_app/app/bindings/sigin_binding.dart';
import 'package:customer_app/app/data/model/order_model.dart';
import 'package:customer_app/app/ui/order/orderInformation.dart';
import 'package:customer_app/app/ui/pages/HelpAndSupport/AvailableBatches.dart';
import 'package:customer_app/app/ui/pages/HelpAndSupport/helpandsupport.dart';
import 'package:customer_app/app/ui/pages/HelpAndSupport/orderqueriespage.dart';
import 'package:customer_app/app/ui/pages/HelpAndSupport/questionAnswer.dart';
import 'package:customer_app/app/ui/pages/chat/ChatView.dart';
import 'package:customer_app/app/ui/pages/location_picker/address_model.dart';
import 'package:customer_app/app/ui/pages/location_picker/edit_address_screen.dart';
import 'package:customer_app/app/ui/pages/location_picker/new_location_picker.dart';
import 'package:customer_app/app/ui/pages/my_account/active_orders_screen.dart';
import 'package:customer_app/app/ui/pages/my_account/my_account_page.dart';
import 'package:customer_app/app/ui/pages/my_wallet/wallet_details_screen.dart';
import 'package:customer_app/app/ui/pages/my_wallet/wallet_offer_screen.dart';
import 'package:customer_app/app/ui/pages/my_wallet/wallet_screen.dart';
import 'package:customer_app/app/ui/pages/refer_and_earn/refer_and_earn_screen.dart';
import 'package:customer_app/app/ui/pages/search/explorescreen.dart';
import 'package:customer_app/app/ui/pages/search/instoreSearch.dart';
import 'package:customer_app/app/ui/pages/search/popularSearchScreen.dart';
import 'package:customer_app/app/ui/pages/signIn/phone_authentication_screen.dart';
import 'package:customer_app/app/ui/pages/stores/InStoreScreen.dart';
import 'package:customer_app/app/ui/pages/stores/StoreScreen.dart';
import 'package:customer_app/app/ui/pages/stores/checkoutScreen.dart';
import 'package:customer_app/app/ui/pages/stores/searchStoresScreen.dart';
import 'package:customer_app/app/ui/pages/stores/storedetailscreen.dart';
import 'package:customer_app/routes/app_list.dart';
import 'package:customer_app/scan_receipt/theBoss/view/TheBossCameraScreen.dart';
import 'package:customer_app/screens/addcart/addcart_list.dart';
import 'package:customer_app/screens/addcart/checkout_screen.dart';
import 'package:customer_app/screens/addcart/scheduletime_screen.dart';
import 'package:customer_app/screens/authentication/view/location_picker_screen.dart';
import 'package:customer_app/screens/base_screen.dart';
import 'package:customer_app/screens/confirm_location.dart';
import 'package:customer_app/screens/history/history_screen.dart';
import 'package:customer_app/screens/more_stores/morestore_productlist.dart';
import 'package:customer_app/screens/order/order_screen.dart';
import 'package:customer_app/screens/profile/edit_profile_screen.dart';
import 'package:customer_app/screens/profile/my_addresses_screen.dart';
import 'package:customer_app/screens/profile/refer_n_earn.dart';
import 'package:customer_app/screens/root/root.dart';
import 'package:customer_app/screens/scanReceipt/scan_recipet_search.dart';
import 'package:customer_app/screens/scanReceipt/search_recipt_screen.dart';
import 'package:customer_app/screens/scanReceipt/storeview_screen.dart';
import 'package:customer_app/screens/search/search_result_screen.dart';
import 'package:customer_app/screens/search/search_screen.dart';
import 'package:customer_app/screens/stores_screen.dart';
import 'package:customer_app/screens/wallet/loyaltycardscreen.dart';
import 'package:customer_app/screens/wallet/paymentScreen.dart';
import 'package:customer_app/screens/wallet/payview.dart';
import 'package:get/route_manager.dart';

import '../app/ui/pages/my_wallet/customer_wallet_details.dart';
import '../app/ui/pages/my_wallet/select_business_type.dart';
import '../screens/addcart/cartReviewScreen.dart';
import '../screens/scanReceipt/myCartScreen.dart';

class AppPages {
  static var list = [
    GetPage(name: AppRoutes.Root, page: () => Root(), binding: RootBinding()),
    GetPage(name: AppRoutes.SplashScreen, page: () => SplashScreen()),
    GetPage(
      name: AppRoutes.Authentication,
      page: () => SignInScreen(),
      binding: SignInScreenBindings(),
    ),
    GetPage(
      name: AppRoutes.NewLocationScreen,
      page: () => AddLocationScreen(
        key: UniqueKey(),
      ),
      binding: NewLocationScreenBindings(),
    ),
    GetPage(
      name: AppRoutes.AddressModel,
      page: () => AddressModel(),
      binding: NewLocationScreenBindings(),
    ),
    GetPage(
      name: AppRoutes.CustomerWalletDetails,
      page: () => CustomerWalletDetails(),
      binding: MyWalletBinding()
      // binding: NewLocationScreenBindings(),
    ),
    GetPage(
      name: AppRoutes.SelectBusinessType,
      page: () => SelectBusinessType(),
      // binding: MyWalletBinding()
      
    ),
    GetPage(
        name: AppRoutes.BaseScreen,
        page: () => BaseScreen(),
        binding: HomeControllerBindings()),
    GetPage(
        name: AppRoutes.MyAccount,
        page: () => MyAccountPage(),
        binding: MyAccountBinding()),
    GetPage(name: AppRoutes.Search, page: () => SearchScreen()),
    GetPage(name: AppRoutes.SearchResult, page: () => SearchResultScreen()),
    GetPage(name: AppRoutes.Stores, page: () => StoresScreen()),
    GetPage(
        name: AppRoutes.Orders,
        page: () => OrderScreen(
              order: OrderData(),
            )),
    GetPage(name: AppRoutes.ReferNEarn, page: () => ReferNEarnScreen()),
    GetPage(name: AppRoutes.History, page: () => HistoryScreen()),
    GetPage(name: AppRoutes.ReferAndEarn, page: () => ReferAndEarnScreen()),
    GetPage(
        name: AppRoutes.Wallet,
        page: () => WalletScreen(),
        binding: MyWalletBinding()),
    GetPage(
        name: AppRoutes.WalletDetails,
        page: () => WalletDetailsScreen(),
        binding: MyWalletBinding()),
    GetPage(name: AppRoutes.WalletOffer, page: () => WalletOfferScreen()),
    // GetPage(name: AppRoutes.MyAddresses, page: () => MyAddressesScreen()),
    // GetPage(
    //     name: AppRoutes.LocationPickerScreen,
    //     page: () => LocationPickerScreen()),
    GetPage(
        name: AppRoutes.ConfirmLocation, page: () => ConfirmLocationScreen()),
    GetPage(name: AppRoutes.EditProfile, page: () => EditProfileScreen()),
    GetPage(
        name: AppRoutes.ScanStoreViewScreen, page: () => ScanStoreViewScreen()),
    GetPage(
        name: AppRoutes.TheBossCameraScreen, page: () => TheBossCameraScreen()),
    GetPage(
      name: AppRoutes.CheckOutScreen,
      page: () => CheckOutScreen(),
      binding: CartBinding(),
    ),
    GetPage(name: AppRoutes.StoreScreen, page: () => StoreScreen()),
    GetPage(
        name: AppRoutes.MoreStoreProductView,
        page: () => MoreStoreProductView()),
    GetPage(
        name: AppRoutes.SearchStoresScreen, page: () => SearchStoresScreen()),
    GetPage(name: AppRoutes.InStoreSearch, page: () => InstoreSearch()),
    GetPage(name: AppRoutes.ExploreScreen, page: () => ExploreScreen()),
    GetPage(
        name: AppRoutes.PopularSearchScreen, page: () => PopularSearchScreen()),
    GetPage(name: AppRoutes.InStoreScreen, page: () => InStoreScreen()),
    GetPage(name: AppRoutes.StoreListScreen, page: () => StoreListScreen()),
    GetPage(name: AppRoutes.ChatView, page: () => AllChats()),
    GetPage(name: AppRoutes.HelpSupport, page: () => HelpSupport()),
    GetPage(name: AppRoutes.OrderInformation, page: () => OrderInformation()),
    GetPage(
        name: AppRoutes.QuestionsAndAnswers, page: () => QuestionsAndAnswers()),
    GetPage(name: AppRoutes.OrderListpage, page: () => OrdersListPage()),
    GetPage(name: AppRoutes.OrderQueriespage, page: () => OrderQueriesPage()),
    GetPage(name: AppRoutes.LoyaltyCardScreen, page: () => LoyaltyCardScreen()),
    GetPage(
        name: AppRoutes.ScheduleTimeScreen, page: () => ScheduleTimeScreen()),
    GetPage(name: AppRoutes.AddCartListScreen, page: () => AddCartListScreen()),
    GetPage(name: AppRoutes.CartReviewScreen, page: () => CartReviewScreen()),
    GetPage(
        name: AppRoutes.orderCheckOutScreen, page: () => OrderCheckOutScreen()),
    GetPage(name: AppRoutes.EditAddressScreen, page: () => EditAddressScreen()),
    GetPage(name: AppRoutes.ScanRecipetSearch, page: () => ScanRecipetSearch()),
    // GetPage(
    //   name: AppRoutes.EnterNumberScreen,
    //   page: () => EnterNumberScreen(),
    //   binding: SignInScreenBindings(),
    // ),
    GetPage(
        name: AppRoutes.SearchRecipeScreen, page: () => SearchRecipeScreen()),
    GetPage(name: AppRoutes.paymentList, page: () => PaymentModeScreen()),
    GetPage(name: AppRoutes.PayView, page: () => PayView()),
    GetPage(name: AppRoutes.MyCartScreen, page: () => MyCartScreen()),

    // GetPage(name: AppRoutes.OrderTreckScreen, page: () => OrderTreckScreen()),
    // GetPage(name: AppRoutes.ProductRawItemScreen, page: () => ProductRawItemScreen()),
    // GetPage(name: AppRoutes.ShopItemsScreen, page: () => ShopItemsScreen()),
    GetPage(
      name: AppRoutes.ActiveOrders,
      page: () => ActiveOrdersScreen(),
      // binding: MyAccountBinding(),
    ),
    GetPage(
      name: AppRoutes.About,
      page: () => AboutScreen(),
    ),
    GetPage(
      name: AppRoutes.SelectLocationAddress,
      page: () => SelectLocationAddress(),
      binding: NewLocationScreenBindings(),
    ),
  ];
}
