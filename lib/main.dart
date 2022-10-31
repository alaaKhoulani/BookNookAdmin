import 'dart:ffi';
import 'package:book_nook_admin/business_logic/cubit/AddAdress/add_address_cubit.dart';
import 'package:book_nook_admin/business_logic/cubit/add_book/add_book_cubit.dart';
import 'package:book_nook_admin/business_logic/cubit/admin_information/admin_information_cubit.dart';
import 'package:book_nook_admin/business_logic/cubit/all_book/all_book_cubit.dart';
import 'package:book_nook_admin/business_logic/cubit/comment/comment_cubit.dart';
import 'package:book_nook_admin/business_logic/cubit/details/details_cubit.dart';
import 'package:book_nook_admin/business_logic/cubit/logOut/log_out_cubit.dart';
import 'package:book_nook_admin/business_logic/cubit/login_cubit/cubit/log_in_cubit.dart';
import 'package:book_nook_admin/business_logic/cubit/offer/offer_cubit.dart';
import 'package:book_nook_admin/business_logic/cubit/order/order_cubit.dart';
import 'package:book_nook_admin/business_logic/cubit/post_image/post_image_cubit.dart';
import 'package:book_nook_admin/business_logic/cubit/profile/profile_cubit.dart';
// import 'package:book_nook_admin/business_logic/cubit/quote/quotes_cubit.dart';
import 'package:book_nook_admin/business_logic/cubit/quotes/quotes_cubit.dart';
import 'package:book_nook_admin/business_logic/cubit/register_cubit/register_cubit.dart';
import 'package:book_nook_admin/business_logic/cubit/setting/seeting_cubit.dart';
import 'package:book_nook_admin/business_logic/cubit/verify/cubit/verify_cubit.dart';
import 'package:book_nook_admin/consts/constant.dart';
import 'package:book_nook_admin/data/models/Book.dart';
import 'package:book_nook_admin/data/models/address.dart';
import 'package:book_nook_admin/data/repository/admin_repository.dart';
import 'package:book_nook_admin/data/repository/quotes_repository.dart';
import 'package:book_nook_admin/data/web_services/admin_web_services.dart';
import 'package:book_nook_admin/data/web_services/quotes_web_services.dart';
import 'package:book_nook_admin/services/local_notification.dart';
import 'package:book_nook_admin/services/storage/store.dart';
import 'package:book_nook_admin/ui/Screens/Graph/graph_cubit.dart';
import 'package:book_nook_admin/ui/Screens/Graph/graph_screen.dart';
import 'package:book_nook_admin/ui/Screens/HomePage.dart';
import 'package:book_nook_admin/ui/Screens/add%20offer/add_offer_cubit.dart';
import 'package:book_nook_admin/ui/Screens/add%20offer/screen.dart';
import 'package:book_nook_admin/ui/Screens/addAddress.dart';
import 'package:book_nook_admin/ui/Screens/addBook.dart';
import 'package:book_nook_admin/ui/Screens/add_image.dart';
import 'package:book_nook_admin/ui/Screens/admin_information.dart';
import 'package:book_nook_admin/ui/Screens/all_book.dart';
import 'package:book_nook_admin/ui/Screens/all_quotes_screen.dart';
import 'package:book_nook_admin/ui/Screens/category_fav.dart';
import 'package:book_nook_admin/ui/Screens/changePassword/cubit.dart';
import 'package:book_nook_admin/ui/Screens/changePassword/screen.dart';
import 'package:book_nook_admin/ui/Screens/comment_screen.dart';
// import 'package:book_nook_admin/ui/Screens/comment.dart';
// import 'package:book_nook_admin/ui/Screens/commentS.dart';
import 'package:book_nook_admin/ui/Screens/detailes.dart';
import 'package:book_nook_admin/ui/Screens/edit_address.dart';
import 'package:book_nook_admin/ui/Screens/edit_book.dart';
// import 'package:book_nook_admin/ui/Screens/library_screen.dart';
import 'package:book_nook_admin/ui/Screens/loan%20and%20sold%20books/cubit.dart';
import 'package:book_nook_admin/ui/Screens/loan%20and%20sold%20books/screen.dart';
import 'package:book_nook_admin/ui/Screens/log_in.dart';
import 'package:book_nook_admin/ui/Screens/my_addresses.dart';
import 'package:book_nook_admin/ui/Screens/buy_book.dart';
import 'package:book_nook_admin/ui/Screens/myorders.dart';
import 'package:book_nook_admin/ui/Screens/offers_screen.dart';
import 'package:book_nook_admin/ui/Screens/register.dart';
import 'package:book_nook_admin/ui/Screens/search/search_screen.dart';
import 'package:book_nook_admin/ui/Screens/settings.dart';
import 'package:book_nook_admin/ui/Screens/start_screen.dart';
import 'package:book_nook_admin/ui/Screens/update_offer/update_offer_cubit.dart';
import 'package:book_nook_admin/ui/Screens/user_profile_screen.dart';
import 'package:book_nook_admin/ui/Screens/verification_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'services/firebase_options.dart';
import 'services/translate/codegen_loader.g.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  LocalNotification.initialize();
  var fire = await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  var observer = MyBlocObserver();

  // final fcmToken = await FirebaseMessaging.instance.getToken();
  // // // final token=await Firebase.instance.get
  // print("----fcmToken $fcmToken");

  // FirebaseMessaging.instance.onTokenRefresh.listen((fcmToken) {
  //   // TODO: If necessary send token to application server.
  // }).onError((err) {
  //   // Error getting token.
  // });
  // await FirebaseMessaging.instance.setAutoInitEnabled(true);
  // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //   print('------Got a message whilst in the foreground!');
  //   print('------Message data: ${message.data['title']}');

  //   if (message.notification != null) {
  //     print(
  //         '-----Message also contained a notification: ${message.notification!.body}');
  //   }
  //   LocalNotification.handle(message);
  // });
  // FirebaseMessaging messaging = FirebaseMessaging.instance;
  // NotificationSettings settings = await messaging.requestPermission(
  //   alert: true,
  //   announcement: false,
  //   badge: true,
  //   carPlay: false,
  //   criticalAlert: false,
  //   provisional: false,
  //   sound: true,
  // );
  // FirebaseMessaging.onMessageOpenedApp.listen((event) {
  //   print("forrrrrrrrrrrGround");
  //   print(event.data.toString());
  // });

  // FirebaseMessaging.onMessage.listen((event) {
  //   print(event.data.toString());
  // });
  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await GetStorage.init();
  Store.store = GetStorage();

  // Store.store.remove("token");
  Store.token = Store.store.read('token');
  Store.fcmToken = "fcmToken";
  Store.store.write("fcmToken", "fcmToken");

  if (Store.token != null)
    Store.myAdmin = await AdminRepository(AdminWebServices()).profile();

  // Store.store.remove('token');
  // runApp(EasyLocalization(
  //     path: 'assets/translate/',
  //     supportedLocales: const [Locale('ar'), Locale('en')],
  //     fallbackLocale: const Locale('en'),
  //     assetLoader: const CodegenLoader(),
  //     child: const MyApp()));
  runApp(MyApp());
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => RegisterCubit()),
        BlocProvider(create: (context) => VerifyCubit()),
        BlocProvider(create: (context) => AdminInformationCubit()),
        BlocProvider(create: (context) => LogInCubit()),
        BlocProvider(create: (context) => AllBookCubit()),
        BlocProvider(create: (context) => AddBookCubit()),
        BlocProvider(create: (context) => AddAddressCubit()),
        BlocProvider(create: (context) => ProfileCubit()),
        BlocProvider(create: (context) => PostImabeCubit()),
        BlocProvider(create: (context) => DetailsCubit()),
        BlocProvider(create: (context) => QuotesCubit()),
        BlocProvider(create: (context) => CommentCubit()),
        BlocProvider(create: (context) => GraphCubit()),
        BlocProvider(create: (context) => ChangePasswordCubit()),
        BlocProvider(create: (context) => LoanBooksCubit()),
        BlocProvider(create: (context) => OfferCubit()),
        BlocProvider(create: (context) => OrderCubit()),
        BlocProvider(create: (context) => SeetingCubit()),
        BlocProvider(create: (context) => AddOfferCubit()),
        BlocProvider(create: (context) => UpdateOfferCubit()),
        // BlocProvider(create: (context) => LogOutCubit()),
      ],
      child: MaterialApp(
        // supportedLocales: context.supportedLocales, //supported language
        // localizationsDelegates:
        //     context.localizationDelegates, //get fields ready
        // locale: context.locale,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'SfPro'),

        home:Store.token==null ?StartScreen():HomePage(), 
        onGenerateRoute: generateRoute,
      ),
    );
  }

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case 'SignUp':
        return MaterialPageRoute(builder: (_) => Register());
      case 'home':
        return MaterialPageRoute(builder: (_) => HomePage());
      case 'login':
        return MaterialPageRoute(builder: (_) => LogIn());
      case 'adminInformation':
        return MaterialPageRoute(builder: (_) => AdminInformation());
      case 'categoryFavotir':
        return MaterialPageRoute(builder: (_) => const CategoryFavourite());
      case 'addBook':
        return MaterialPageRoute(builder: (_) => AddBook());
      case 'editBook':
        var book = settings.arguments as BookInfo;
        return MaterialPageRoute(builder: (_) => EditBook(book: book,));
      case 'allBook':
        return MaterialPageRoute(builder: (_) => AllBook());
      case 'profile':
        return MaterialPageRoute(builder: (_) => UserProfile());
      case 'setting':
        return MaterialPageRoute(builder: (_) => Settings());
      case 'myAddresses':
        return MaterialPageRoute(builder: (_) => MyAddresses());
      case 'changPassword':
        return MaterialPageRoute(builder: (_) => ChangPassword());
      case 'verification':
        return MaterialPageRoute(builder: (_) => VerificationScreen());
      case 'myOrder':
        return MaterialPageRoute(builder: (_) => MyOrder());
      case 'addImage':
        return MaterialPageRoute(builder: (_) => AddImage());
      case 'loanBooksScreen':
        return MaterialPageRoute(builder: (_) => LoanBooksScreen());
      case 'addAddress':
        return MaterialPageRoute(builder: (_) => AddAddress());
      case 'graphScreen':
        return MaterialPageRoute(builder: (_) => GraphScreen());
      case 'addOfferScreen':
        return MaterialPageRoute(builder: (_) => AddOfferScreen());
      case 'editAdress':
        var address = settings.arguments as Address;
        return MaterialPageRoute(
            builder: (_) => EditAdress(
                  address: address,
                ));
      case 'myOffersScreen':
        int id = settings.arguments as int;
        return MaterialPageRoute(
            builder: (_) => MyOffersScreen(
                  id: id,
                ));
      case 'searchHomeScreen':
        return MaterialPageRoute(builder: (_) => SearchHomeScreen());
      case 'comment':
        var book = settings.arguments as BookInfo;
        return MaterialPageRoute(
            builder: (_) => CommentScreen(
                  book: book,
                ));
      case 'allQuotes':
        int id = settings.arguments as int;
        return MaterialPageRoute(
            builder: (_) => AllQuotes(
                  id: id,
                ));
      case 'buyBook':
        return MaterialPageRoute(builder: (_) => BuyBook());
      case 'details':
        final book = settings.arguments as BookInfo;
        return MaterialPageRoute(
            builder: (_) => Detailes(
                  book: book,
                ));
    }
  }
}

class MyBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    print('onCreate -- ${bloc.runtimeType}');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print('onChange -- ${bloc.runtimeType}, $change');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print('onError -- ${bloc.runtimeType}, $error');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    print('onClose -- ${bloc.runtimeType}');
  }
}
