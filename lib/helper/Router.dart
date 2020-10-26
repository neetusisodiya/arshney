import 'package:arshney/helper/route_constant.dart';
import 'package:arshney/language/language_selector_page.dart';
import 'package:arshney/ui/login_screen.dart';
import 'package:arshney/ui/parents_details.dart';
import 'package:arshney/ui/splash_screen.dart';
import '../choose_lag.dart';
import 'file:///E:/Talha/varshney/app/arshney/lib/ui/profile_details.dart';
import 'package:arshney/ui/home_screen.dart';
import 'package:arshney/ui/view_profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Routerr {

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashScreen:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case homeRoute:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case profileDetails:
        return MaterialPageRoute(builder: (_) => ProfileDetails(""));
      case parentsScreens:
        return MaterialPageRoute(builder: (_) => ParentsScreen());
     case viewProfile:
        return MaterialPageRoute(builder: (_) => ViewDetails());
      case signIn:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case langScreen:
        return MaterialPageRoute(builder: (_) => LanguageSelectorPage());

     /* case notificationRoute:
        return MaterialPageRoute(builder: (_) => NotificationScreen());
      case cartRoute:
        return MaterialPageRoute(builder: (_) => CartScreen());

      case forgotPassword:
        return MaterialPageRoute(builder: (_) => ForgotPasswordPage());
      case searchList:
        return CupertinoPageRoute(builder: (_) => SearchScreen());

      case storeDetails:
        var argsStore = settings.arguments;
        return MaterialPageRoute(builder: (_) => StoreDetails(argsStore));
      case otpScreen:
        return MaterialPageRoute(
            builder: (_) => OtpScreenPage('2323', '43443434'));
      case changePasswordRoute:
        return MaterialPageRoute(
            builder: (_) => ChangePasswordScreen('7597100610'));
      case signUp:
        return MaterialPageRoute(builder: (_) => SignUp());
      case userProfile:
        return MaterialPageRoute(builder: (_) => ProfileDetails());
      case editProfile:
        return MaterialPageRoute(builder: (_) => EditProfile());
      case storeProduct:
        return MaterialPageRoute(
            builder: (_) => StoreProductListing(settings.arguments));
      case productDetails:
        final ProductDetails args = settings.arguments;
        return CupertinoPageRoute(
            builder: (_) => ProductDetails(args.productsPojo, args.userId));

      case previousOrders:
        return MaterialPageRoute(builder: (_) => PreviousOrders());
      case detailsOrders:
        return MaterialPageRoute(
            builder: (_) => DetailsOrders(settings.arguments));
      case storeDetails:
        var argument = settings.arguments;
        return MaterialPageRoute(builder: (_) => StoreDetails(argument));
      case promotedStoreListing:
        final PromotedVendorListing args2 = settings.arguments;
        return MaterialPageRoute(
            builder: (_) => PromotedVendorListing(args2.categoryId));
      case favVendors:
        return MaterialPageRoute(builder: (_) => FavoriteVendors());

      */
    }
  }
}

class UndefinedView extends StatelessWidget {
  final String name;

  const UndefinedView({Key key, this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Route for $name is not defined'),
      ),
    );
  }
}
