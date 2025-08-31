import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_hi.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('hi')
  ];

  /// No description provided for @signUp.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signUp;

  /// No description provided for @onlyJPGPNGorPDF.
  ///
  /// In en, this message translates to:
  /// **'Only JPG, PNG, or PDF files. Max size: 5 MB'**
  String get onlyJPGPNGorPDF;

  /// No description provided for @onlyJPGPNG.
  ///
  /// In en, this message translates to:
  /// **'Only JPG, or PNG files. Max size: 5 MB'**
  String get onlyJPGPNG;

  /// No description provided for @createYourAccount.
  ///
  /// In en, this message translates to:
  /// **'Create Your Account'**
  String get createYourAccount;

  /// No description provided for @fullName.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get fullName;

  /// No description provided for @enterYourFullName.
  ///
  /// In en, this message translates to:
  /// **'Enter your full name'**
  String get enterYourFullName;

  /// No description provided for @emailAddress.
  ///
  /// In en, this message translates to:
  /// **'Email Address'**
  String get emailAddress;

  /// No description provided for @enterPointToWithdraw.
  ///
  /// In en, this message translates to:
  /// **'Enter Point to Withdraw'**
  String get enterPointToWithdraw;

  /// No description provided for @mobileNumber.
  ///
  /// In en, this message translates to:
  /// **'Mobile Number'**
  String get mobileNumber;

  /// No description provided for @createPassword.
  ///
  /// In en, this message translates to:
  /// **'Create Password'**
  String get createPassword;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @areyousureyouwanttologout.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to logout?'**
  String get areyousureyouwanttologout;

  /// No description provided for @enterYourMobileNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter your mobile number'**
  String get enterYourMobileNumber;

  /// No description provided for @enterYourPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter your Password'**
  String get enterYourPassword;

  /// No description provided for @confirmedPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirmed Password'**
  String get confirmedPassword;

  /// No description provided for @alreadyHaveAnAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account? [Login]'**
  String get alreadyHaveAnAccount;

  /// No description provided for @welcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Welcome Back!'**
  String get welcomeBack;

  /// No description provided for @emailId.
  ///
  /// In en, this message translates to:
  /// **'Email Id'**
  String get emailId;

  /// No description provided for @permanentAddress.
  ///
  /// In en, this message translates to:
  /// **'Permanent Address'**
  String get permanentAddress;

  /// No description provided for @totalCoins.
  ///
  /// In en, this message translates to:
  /// **'TOTAL COINS'**
  String get totalCoins;

  /// No description provided for @kkdCard.
  ///
  /// In en, this message translates to:
  /// **'KKD Card'**
  String get kkdCard;

  /// No description provided for @editDetails.
  ///
  /// In en, this message translates to:
  /// **'editDetails'**
  String get editDetails;

  /// No description provided for @enteravalidemailordigitmobilenumber.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email or 10-digit mobile number'**
  String get enteravalidemailordigitmobilenumber;

  /// No description provided for @category.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get category;

  /// No description provided for @update.
  ///
  /// In en, this message translates to:
  /// **'update'**
  String get update;

  /// No description provided for @pleasefillmobilenumber.
  ///
  /// In en, this message translates to:
  /// **'Please fill mobile number'**
  String get pleasefillmobilenumber;

  /// No description provided for @couldntfindanyavailablenetworks.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t find any available networks'**
  String get couldntfindanyavailablenetworks;

  /// No description provided for @nameisrequired.
  ///
  /// In en, this message translates to:
  /// **'Name is Required'**
  String get nameisrequired;

  /// No description provided for @passworisrequired.
  ///
  /// In en, this message translates to:
  /// **'Password is required '**
  String get passworisrequired;

  /// No description provided for @emailormobilenumberisrequired.
  ///
  /// In en, this message translates to:
  /// **'Email or mobile number is required'**
  String get emailormobilenumberisrequired;

  /// No description provided for @loginToContinue.
  ///
  /// In en, this message translates to:
  /// **'Log in to continue using your account.'**
  String get loginToContinue;

  /// No description provided for @emailOrMobile.
  ///
  /// In en, this message translates to:
  /// **'Email / Mobile Number'**
  String get emailOrMobile;

  /// No description provided for @enterYourEmailOrMobile.
  ///
  /// In en, this message translates to:
  /// **'Enter your Email / Mobile Number'**
  String get enterYourEmailOrMobile;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @thisQrCodeHasAlreadyBeenUsedBy.
  ///
  /// In en, this message translates to:
  /// **'This QR code has already been used by'**
  String get thisQrCodeHasAlreadyBeenUsedBy;

  /// No description provided for @needHelp.
  ///
  /// In en, this message translates to:
  /// **'Need help?'**
  String get needHelp;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @contactSupportAt.
  ///
  /// In en, this message translates to:
  /// **'Contact support at support@birlaopus.com'**
  String get contactSupportAt;

  /// No description provided for @passwordsdonotmatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passwordsdonotmatch;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @dontHaveAnAccount.
  ///
  /// In en, this message translates to:
  /// **'Don’t have an account? [Sign Up]'**
  String get dontHaveAnAccount;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @product.
  ///
  /// In en, this message translates to:
  /// **'Product'**
  String get product;

  /// No description provided for @qrScan.
  ///
  /// In en, this message translates to:
  /// **'QR Scan'**
  String get qrScan;

  /// No description provided for @withdraw.
  ///
  /// In en, this message translates to:
  /// **'Withdraw'**
  String get withdraw;

  /// No description provided for @enteravaliddigitmobile.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid 10‑digit mobile'**
  String get enteravaliddigitmobile;

  /// No description provided for @enteravalidemail.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email'**
  String get enteravalidemail;

  /// No description provided for @filter.
  ///
  /// In en, this message translates to:
  /// **'Filter'**
  String get filter;

  /// No description provided for @interior.
  ///
  /// In en, this message translates to:
  /// **'Interior'**
  String get interior;

  /// No description provided for @exterior.
  ///
  /// In en, this message translates to:
  /// **'Exterior'**
  String get exterior;

  /// No description provided for @waterproofing.
  ///
  /// In en, this message translates to:
  /// **'Waterpro'**
  String get waterproofing;

  /// No description provided for @woodFinish.
  ///
  /// In en, this message translates to:
  /// **'Woodfinish'**
  String get woodFinish;

  /// No description provided for @wallpaper.
  ///
  /// In en, this message translates to:
  /// **'Wallpaper'**
  String get wallpaper;

  /// No description provided for @enamel.
  ///
  /// In en, this message translates to:
  /// **'Enamel'**
  String get enamel;

  /// No description provided for @enterYourEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter your email'**
  String get enterYourEmail;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @price.
  ///
  /// In en, this message translates to:
  /// **'Price'**
  String get price;

  /// No description provided for @clean.
  ///
  /// In en, this message translates to:
  /// **'Clean'**
  String get clean;

  /// No description provided for @outOf.
  ///
  /// In en, this message translates to:
  /// **'out of 3 complete'**
  String get outOf;

  /// No description provided for @applyChanges.
  ///
  /// In en, this message translates to:
  /// **'Apply Changes'**
  String get applyChanges;

  /// No description provided for @estherHoward.
  ///
  /// In en, this message translates to:
  /// **'Esthefds'**
  String get estherHoward;

  /// No description provided for @contractor.
  ///
  /// In en, this message translates to:
  /// **'Contractor'**
  String get contractor;

  /// No description provided for @completeYourProfile.
  ///
  /// In en, this message translates to:
  /// **'Complete your profile'**
  String get completeYourProfile;

  /// No description provided for @thisHelpsBuildTrust.
  ///
  /// In en, this message translates to:
  /// **'This helps builds trust, encouraging members'**
  String get thisHelpsBuildTrust;

  /// No description provided for @personalDetails.
  ///
  /// In en, this message translates to:
  /// **'Personal details'**
  String get personalDetails;

  /// No description provided for @contactNumber.
  ///
  /// In en, this message translates to:
  /// **'Contact Number'**
  String get contactNumber;

  /// No description provided for @dateOfBirth.
  ///
  /// In en, this message translates to:
  /// **'Date of Birth'**
  String get dateOfBirth;

  /// No description provided for @pinCode.
  ///
  /// In en, this message translates to:
  /// **'Pin Code'**
  String get pinCode;

  /// No description provided for @state.
  ///
  /// In en, this message translates to:
  /// **'State'**
  String get state;

  /// No description provided for @country.
  ///
  /// In en, this message translates to:
  /// **'Country'**
  String get country;

  /// No description provided for @kyc.
  ///
  /// In en, this message translates to:
  /// **'Kyc'**
  String get kyc;

  /// No description provided for @panCard.
  ///
  /// In en, this message translates to:
  /// **'Pancard'**
  String get panCard;

  /// No description provided for @aadharCard.
  ///
  /// In en, this message translates to:
  /// **'Aadhar Card'**
  String get aadharCard;

  /// No description provided for @bankDetails.
  ///
  /// In en, this message translates to:
  /// **'Bank details'**
  String get bankDetails;

  /// No description provided for @accountNumber.
  ///
  /// In en, this message translates to:
  /// **'Account Number'**
  String get accountNumber;

  /// No description provided for @accountHolder.
  ///
  /// In en, this message translates to:
  /// **'Account holder'**
  String get accountHolder;

  /// No description provided for @bankName.
  ///
  /// In en, this message translates to:
  /// **'Bank Name'**
  String get bankName;

  /// No description provided for @viewDetails.
  ///
  /// In en, this message translates to:
  /// **'View Details'**
  String get viewDetails;

  /// No description provided for @verified.
  ///
  /// In en, this message translates to:
  /// **'verified'**
  String get verified;

  /// No description provided for @availablePoint.
  ///
  /// In en, this message translates to:
  /// **'Available Point'**
  String get availablePoint;

  /// No description provided for @availableCoins.
  ///
  /// In en, this message translates to:
  /// **'availableCoins'**
  String get availableCoins;

  /// No description provided for @offers.
  ///
  /// In en, this message translates to:
  /// **'Offers'**
  String get offers;

  /// No description provided for @transactionHistory.
  ///
  /// In en, this message translates to:
  /// **'Transaction History'**
  String get transactionHistory;

  /// No description provided for @secureYourAccount.
  ///
  /// In en, this message translates to:
  /// **'Secure Your Account in Seconds'**
  String get secureYourAccount;

  /// No description provided for @uploadYour.
  ///
  /// In en, this message translates to:
  /// **'Upload Your'**
  String get uploadYour;

  /// No description provided for @uploadImage.
  ///
  /// In en, this message translates to:
  /// **'Upload Image'**
  String get uploadImage;

  /// No description provided for @uploadProfile.
  ///
  /// In en, this message translates to:
  /// **'Upload Profile Image'**
  String get uploadProfile;

  /// No description provided for @uploadPassbookImage.
  ///
  /// In en, this message translates to:
  /// **'Upload Passbook Image'**
  String get uploadPassbookImage;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @passbook.
  ///
  /// In en, this message translates to:
  /// **'Passbook'**
  String get passbook;

  /// No description provided for @ifsc.
  ///
  /// In en, this message translates to:
  /// **'IFSC'**
  String get ifsc;

  /// No description provided for @withdrawalRequestEncrypted.
  ///
  /// In en, this message translates to:
  /// **'Your withdrawal request is encrypted and secure.'**
  String get withdrawalRequestEncrypted;

  /// No description provided for @youCanWithdrawUpToPoint.
  ///
  /// In en, this message translates to:
  /// **'You can withdraw up to your available Point.'**
  String get youCanWithdrawUpToPoint;

  /// No description provided for @pointWithdraw.
  ///
  /// In en, this message translates to:
  /// **'Point Withdraw'**
  String get pointWithdraw;

  /// No description provided for @enterCoinsToWithdraw.
  ///
  /// In en, this message translates to:
  /// **'Enter Coins to Withdraw'**
  String get enterCoinsToWithdraw;

  /// No description provided for @yourWithdrawalRequestIsEncrypted.
  ///
  /// In en, this message translates to:
  /// **'Your withdrawal request is encrypted and secure.'**
  String get yourWithdrawalRequestIsEncrypted;

  /// No description provided for @request.
  ///
  /// In en, this message translates to:
  /// **'Request'**
  String get request;

  /// No description provided for @redeem.
  ///
  /// In en, this message translates to:
  /// **'Redeem'**
  String get redeem;

  /// No description provided for @congratulations.
  ///
  /// In en, this message translates to:
  /// **'Congratulations'**
  String get congratulations;

  /// No description provided for @coins.
  ///
  /// In en, this message translates to:
  /// **'coins'**
  String get coins;

  /// No description provided for @haveBeenAddedToWallet.
  ///
  /// In en, this message translates to:
  /// **'have been added to your Wallet.'**
  String get haveBeenAddedToWallet;

  /// No description provided for @oops.
  ///
  /// In en, this message translates to:
  /// **'Oops!'**
  String get oops;

  /// No description provided for @productDetails.
  ///
  /// In en, this message translates to:
  /// **'Product Details'**
  String get productDetails;

  /// No description provided for @hyundaiCreta.
  ///
  /// In en, this message translates to:
  /// **'Hyundai Creta'**
  String get hyundaiCreta;

  /// No description provided for @hyundaiCretaVersion.
  ///
  /// In en, this message translates to:
  /// **'Hyundai Creta (E 1.5 petrol Version)'**
  String get hyundaiCretaVersion;

  /// No description provided for @purchasingPoints.
  ///
  /// In en, this message translates to:
  /// **'Purchasing Points: '**
  String get purchasingPoints;

  /// No description provided for @hyundaiCretaPetrol.
  ///
  /// In en, this message translates to:
  /// **'Hyundai Creta (E 1.5 petrol is available in Manual transmission.'**
  String get hyundaiCretaPetrol;

  /// No description provided for @qrCodeUsedMessage.
  ///
  /// In en, this message translates to:
  /// **''**
  String get qrCodeUsedMessage;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @username.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get username;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @helpSupport.
  ///
  /// In en, this message translates to:
  /// **'Help & Support'**
  String get helpSupport;

  /// No description provided for @privacypolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacypolicy;

  /// No description provided for @deleteaccount.
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get deleteaccount;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @noconnection.
  ///
  /// In en, this message translates to:
  /// **'No Connection'**
  String get noconnection;

  /// No description provided for @pleasecheckyourinternetconnectivityandtryagain.
  ///
  /// In en, this message translates to:
  /// **'Please check your internet connectivity \n and try again'**
  String get pleasecheckyourinternetconnectivityandtryagain;

  /// No description provided for @namemustbelessthancharacters.
  ///
  /// In en, this message translates to:
  /// **'Name must be less than 50 characters'**
  String get namemustbelessthancharacters;

  /// No description provided for @emailtoolong.
  ///
  /// In en, this message translates to:
  /// **'Email too long'**
  String get emailtoolong;

  /// No description provided for @required.
  ///
  /// In en, this message translates to:
  /// **'Required'**
  String get required;

  /// No description provided for @mincharacters.
  ///
  /// In en, this message translates to:
  /// **'Min 6 characters'**
  String get mincharacters;

  /// No description provided for @iagreetothe.
  ///
  /// In en, this message translates to:
  /// **'I agree to the'**
  String get iagreetothe;

  /// No description provided for @and.
  ///
  /// In en, this message translates to:
  /// **'and'**
  String get and;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @withdrawhistoryisempty.
  ///
  /// In en, this message translates to:
  /// **'Withdraw History is empty'**
  String get withdrawhistoryisempty;

  /// No description provided for @totalPendingreguest.
  ///
  /// In en, this message translates to:
  /// **'Total Pending Reguest'**
  String get totalPendingreguest;

  /// No description provided for @scanhistoryisempty.
  ///
  /// In en, this message translates to:
  /// **'Scan History is empty'**
  String get scanhistoryisempty;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @callus.
  ///
  /// In en, this message translates to:
  /// **'Call us 24*7'**
  String get callus;

  /// No description provided for @pendingrequestisempty.
  ///
  /// In en, this message translates to:
  /// **'Pending request is empty'**
  String get pendingrequestisempty;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @withdrawhistory.
  ///
  /// In en, this message translates to:
  /// **'Withdraw History'**
  String get withdrawhistory;

  /// No description provided for @scanhistory.
  ///
  /// In en, this message translates to:
  /// **'Scan History'**
  String get scanhistory;

  /// No description provided for @emailusyourqueries.
  ///
  /// In en, this message translates to:
  /// **'Email us your queries'**
  String get emailusyourqueries;

  /// No description provided for @termsconditions.
  ///
  /// In en, this message translates to:
  /// **'Terms & Conditions'**
  String get termsconditions;

  /// No description provided for @areyousuretodelteaccount.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete your account?\n\nIf you do not log in within 7 days, your account and all associated data will be permanently deleted.\n\nIf you log in again before 7 days, the deletion request will be cancelled automatically.'**
  String get areyousuretodelteaccount;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'hi'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'hi': return AppLocalizationsHi();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
