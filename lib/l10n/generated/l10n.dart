import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'l10n_en.dart';
import 'l10n_ko.dart';

/// Callers can lookup localized strings with an instance of S
/// returned by `S.of(context)`.
///
/// Applications need to include `S.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/l10n.dart';
///
/// return MaterialApp(
///   localizationsDelegates: S.localizationsDelegates,
///   supportedLocales: S.supportedLocales,
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
/// be consistent with the languages listed in the S.supportedLocales
/// property.
abstract class S {
  S(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S)!;
  }

  static const LocalizationsDelegate<S> delegate = _SDelegate();

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
    Locale('ko')
  ];

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// No description provided for @terms1.
  ///
  /// In en, this message translates to:
  /// **'By proceeding to the next step, you agree to the '**
  String get terms1;

  /// No description provided for @termsOfUse.
  ///
  /// In en, this message translates to:
  /// **'Terms of Use'**
  String get termsOfUse;

  /// No description provided for @terms2.
  ///
  /// In en, this message translates to:
  /// **' and '**
  String get terms2;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// No description provided for @terms3.
  ///
  /// In en, this message translates to:
  /// **'.'**
  String get terms3;

  /// Text when account is not registered
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get doNoHaveAccount;

  /// No description provided for @signIn.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get signIn;

  /// No description provided for @signOutAsk.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to sign out?'**
  String get signOutAsk;

  /// No description provided for @errorUserNotFound.
  ///
  /// In en, this message translates to:
  /// **'User is not found. Please sign up beforehand.'**
  String get errorUserNotFound;

  /// No description provided for @errorUserDisabled.
  ///
  /// In en, this message translates to:
  /// **'Current user is disabled. Please contact customer service.'**
  String get errorUserDisabled;

  /// No description provided for @errorManyRequests.
  ///
  /// In en, this message translates to:
  /// **'Too many attempts. Please try again later.'**
  String get errorManyRequests;

  /// No description provided for @errorOperationNotAllowed.
  ///
  /// In en, this message translates to:
  /// **'Current operation is not allowed. Please try again later.'**
  String get errorOperationNotAllowed;

  /// No description provided for @emailNotVerified.
  ///
  /// In en, this message translates to:
  /// **'Your email is not verified. Please check your inbox and verify your email address.'**
  String get emailNotVerified;

  /// No description provided for @resendEmail.
  ///
  /// In en, this message translates to:
  /// **'Re-send email'**
  String get resendEmail;

  /// No description provided for @success.
  ///
  /// In en, this message translates to:
  /// **'success'**
  String get success;

  /// No description provided for @passwordResetLinkSent.
  ///
  /// In en, this message translates to:
  /// **'Password reset link has been sent to your email. Please check your inbox.'**
  String get passwordResetLinkSent;

  /// No description provided for @signingInWithGoogle.
  ///
  /// In en, this message translates to:
  /// **'Signing in with Google...'**
  String get signingInWithGoogle;

  /// No description provided for @signUp.
  ///
  /// In en, this message translates to:
  /// **'Sign up'**
  String get signUp;

  /// No description provided for @signUpSuccessTitle.
  ///
  /// In en, this message translates to:
  /// **'Registered'**
  String get signUpSuccessTitle;

  /// No description provided for @signUpSuccessContent.
  ///
  /// In en, this message translates to:
  /// **'Thanks for registering to WeCount. Please check your email to verify your email address. Or your email may be already registered.'**
  String get signUpSuccessContent;

  /// No description provided for @signUpErrorTitle.
  ///
  /// In en, this message translates to:
  /// **'Registered Failed'**
  String get signUpErrorTitle;

  /// No description provided for @signUpErrorContent.
  ///
  /// In en, this message translates to:
  /// **'Unexpected error occurred. Please check your internet connection and try again later.'**
  String get signUpErrorContent;

  /// No description provided for @homeMonthly.
  ///
  /// In en, this message translates to:
  /// **'Monthly'**
  String get homeMonthly;

  /// No description provided for @homeList.
  ///
  /// In en, this message translates to:
  /// **'List'**
  String get homeList;

  /// No description provided for @homeStatistic.
  ///
  /// In en, this message translates to:
  /// **'Statistic'**
  String get homeStatistic;

  /// No description provided for @homeSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get homeSettings;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'email'**
  String get email;

  /// No description provided for @emailHint.
  ///
  /// In en, this message translates to:
  /// **'Please write email address'**
  String get emailHint;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @passwordHint.
  ///
  /// In en, this message translates to:
  /// **'Please write your password'**
  String get passwordHint;

  /// No description provided for @passwordConfirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm password'**
  String get passwordConfirm;

  /// No description provided for @passwordConfirmHint.
  ///
  /// In en, this message translates to:
  /// **'Please confirm password'**
  String get passwordConfirmHint;

  /// No description provided for @displayName.
  ///
  /// In en, this message translates to:
  /// **'Display name'**
  String get displayName;

  /// No description provided for @displayNameHint.
  ///
  /// In en, this message translates to:
  /// **'Please write your display name (min 3 letters)'**
  String get displayNameHint;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @nameHint.
  ///
  /// In en, this message translates to:
  /// **'Please write your name (min 3 letters)'**
  String get nameHint;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Did you forgot password'**
  String get forgotPassword;

  /// No description provided for @findPassword.
  ///
  /// In en, this message translates to:
  /// **'Find password'**
  String get findPassword;

  /// No description provided for @sendEmail.
  ///
  /// In en, this message translates to:
  /// **'Send email'**
  String get sendEmail;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// No description provided for @noValidEmail.
  ///
  /// In en, this message translates to:
  /// **'Not a valid email address'**
  String get noValidEmail;

  /// No description provided for @noValidPassword.
  ///
  /// In en, this message translates to:
  /// **'Password should be alphanumeric with more than 5 letters'**
  String get noValidPassword;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'Ok'**
  String get ok;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @intro.
  ///
  /// In en, this message translates to:
  /// **'Create App!'**
  String get intro;

  /// No description provided for @person.
  ///
  /// In en, this message translates to:
  /// **'Person'**
  String get person;

  /// No description provided for @people.
  ///
  /// In en, this message translates to:
  /// **'People'**
  String get people;

  /// No description provided for @more.
  ///
  /// In en, this message translates to:
  /// **'more'**
  String get more;

  /// No description provided for @addLedger.
  ///
  /// In en, this message translates to:
  /// **'Add Ledger'**
  String get addLedger;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Setting'**
  String get settings;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @ledgerNameHint.
  ///
  /// In en, this message translates to:
  /// **'Please write name of your ledger'**
  String get ledgerNameHint;

  /// No description provided for @ledgerDescriptionHint.
  ///
  /// In en, this message translates to:
  /// **'Please write description of ledger'**
  String get ledgerDescriptionHint;

  /// No description provided for @color.
  ///
  /// In en, this message translates to:
  /// **'Color'**
  String get color;

  /// No description provided for @currency.
  ///
  /// In en, this message translates to:
  /// **'Currency'**
  String get currency;

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// No description provided for @update.
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get update;

  /// No description provided for @nickname.
  ///
  /// In en, this message translates to:
  /// **'Nickname'**
  String get nickname;

  /// No description provided for @phone.
  ///
  /// In en, this message translates to:
  /// **'Phone number'**
  String get phone;

  /// No description provided for @statusMessage.
  ///
  /// In en, this message translates to:
  /// **'Status message'**
  String get statusMessage;

  /// No description provided for @statusMessageHint.
  ///
  /// In en, this message translates to:
  /// **'Please write your status message.'**
  String get statusMessageHint;

  /// No description provided for @announcement.
  ///
  /// In en, this message translates to:
  /// **'Announcement'**
  String get announcement;

  /// No description provided for @shareOpinion.
  ///
  /// In en, this message translates to:
  /// **'Share opinion'**
  String get shareOpinion;

  /// No description provided for @shareOpinionHint.
  ///
  /// In en, this message translates to:
  /// **'Please send us your comments about BooKoo.'**
  String get shareOpinionHint;

  /// No description provided for @faq.
  ///
  /// In en, this message translates to:
  /// **'FAQ'**
  String get faq;

  /// No description provided for @notification.
  ///
  /// In en, this message translates to:
  /// **'Notification'**
  String get notification;

  /// No description provided for @lock.
  ///
  /// In en, this message translates to:
  /// **'Lock'**
  String get lock;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Sign out'**
  String get logout;

  /// No description provided for @version.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get version;

  /// No description provided for @announcement1.
  ///
  /// In en, this message translates to:
  /// **'BooKoo Promises'**
  String get announcement1;

  /// No description provided for @announcementTxt1.
  ///
  /// In en, this message translates to:
  /// **'We will always update our app to support better experience to users. We will listen to you as much as we can.\n'**
  String get announcementTxt1;

  /// No description provided for @announcement2.
  ///
  /// In en, this message translates to:
  /// **'Release note'**
  String get announcement2;

  /// No description provided for @announcementTxt2.
  ///
  /// In en, this message translates to:
  /// **'BooKoo is released on apple app store and android playstore. Thank you for all your supports.\n'**
  String get announcementTxt2;

  /// No description provided for @faq1.
  ///
  /// In en, this message translates to:
  /// **'How do I withdraw from BooKoo?'**
  String get faq1;

  /// No description provided for @faqTxt1.
  ///
  /// In en, this message translates to:
  /// **'Since we can have some information that may be sensitive to users, we decided to confirm the withdrawal before it is actually done. Send us an email which is dooboolab@gmail.com. We will throughly review your withdrawals and send you email back when it is done.\n'**
  String get faqTxt1;

  /// No description provided for @faq2.
  ///
  /// In en, this message translates to:
  /// **'How do I create ledger?'**
  String get faq2;

  /// No description provided for @faqTxt2.
  ///
  /// In en, this message translates to:
  /// **'First, click on the hamburger button which is placed at the top left corner of Main page and open the dashboard. Then click on Add Ledger at the bottom of the dashboard. Then write the title and description and choose the color. Finally click on [Done] button to actually create one.\n'**
  String get faqTxt2;

  /// No description provided for @faq3.
  ///
  /// In en, this message translates to:
  /// **'What do BooKoo earn?'**
  String get faq3;

  /// No description provided for @faqTxt3.
  ///
  /// In en, this message translates to:
  /// **'We earn your love. We will be fast growing as much as we get more attraction from you.\n'**
  String get faqTxt3;

  /// No description provided for @faq4.
  ///
  /// In en, this message translates to:
  /// **'What is different from ledger and ledger item?'**
  String get faq4;

  /// No description provided for @faqTxt4.
  ///
  /// In en, this message translates to:
  /// **'Ledger is just an account book which contains all the ledger items. We named it this way not to confuse ourselves during developing our app.\n'**
  String get faqTxt4;

  /// No description provided for @faq5.
  ///
  /// In en, this message translates to:
  /// **'How do I create ledger item?'**
  String get faq5;

  /// No description provided for @faqTxt5.
  ///
  /// In en, this message translates to:
  /// **'First you need to have your ledger created or you should be invited to another ledger. Then in main page, click on [+] button at the top right corner. You will see left and right screen. Left one is adding consume item and right one is adding income item. Which one you prefer, just select category and fill out amount input box which is minimum information you need to add the item. Finally click on [Done] button to finish adding.\n'**
  String get faqTxt5;

  /// No description provided for @faq6.
  ///
  /// In en, this message translates to:
  /// **'How can I invite member to my ledger?'**
  String get faq6;

  /// No description provided for @faqTxt6.
  ///
  /// In en, this message translates to:
  /// **'Ask email address to member whom you want to invite. Then in dashboard, click on [more] button and move to ledger detail page. Click on [+] button placed right of your profile which is placed at the bottom. Write an email address. You can also write multiple addresses by adding spaces.\n'**
  String get faqTxt6;

  /// No description provided for @faq7.
  ///
  /// In en, this message translates to:
  /// **'Can owner of ledger only invite member?'**
  String get faq7;

  /// No description provided for @faqTxt7.
  ///
  /// In en, this message translates to:
  /// **'Yes. Since ledger can have some sensitive information (personally). Only owner can invite members.\n'**
  String get faqTxt7;

  /// No description provided for @faq8.
  ///
  /// In en, this message translates to:
  /// **'Where can I send my upgrade request for BooKoo?'**
  String get faq8;

  /// No description provided for @faqTxt8.
  ///
  /// In en, this message translates to:
  /// **'If you want to send us any opinion, go to [Share Opinion] in setting page. Then write us any opinion you want to send us.\n'**
  String get faqTxt8;

  /// No description provided for @faq9.
  ///
  /// In en, this message translates to:
  /// **'Can I use this app in other devices?'**
  String get faq9;

  /// No description provided for @faqTxt9.
  ///
  /// In en, this message translates to:
  /// **'Yes. Since our service is based on sns, you can use our app in different phone.\n'**
  String get faqTxt9;

  /// No description provided for @faq10.
  ///
  /// In en, this message translates to:
  /// **'How is BooKoo different from other ledger app?'**
  String get faq10;

  /// No description provided for @faqTxt10.
  ///
  /// In en, this message translates to:
  /// **'Basically, BooKoo is a social ledger service which you can share it with other members. Right now, there is many personal ledger app but there is no social ledger service yet. You can manage your own ledger with BooKoo but also with other people. You can only manage your own ledger yourself but also multiple ledgers by creating new ones or get invited.\n'**
  String get faqTxt10;

  /// No description provided for @faq11.
  ///
  /// In en, this message translates to:
  /// **'Why did you think you need to make Bookoo?'**
  String get faq11;

  /// No description provided for @faqTxt11.
  ///
  /// In en, this message translates to:
  /// **'Firstly, we found out that there are many troubles when someone manage other people\"s money like membership fee. When we were university students, there were also trouble since manager did not manage ledger transparently. Actually, BooKoo is more needed for people to whom wants to be shared more than those who wants to share. We really needed this service personally so we created one. We will keep working on it for your better experience. Be with us!\n'**
  String get faqTxt11;

  /// No description provided for @send.
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get send;

  /// No description provided for @addingLedgerItem.
  ///
  /// In en, this message translates to:
  /// **'Adding ledger item'**
  String get addingLedgerItem;

  /// No description provided for @updatingLedgerItem.
  ///
  /// In en, this message translates to:
  /// **'Updating ledger item'**
  String get updatingLedgerItem;

  /// No description provided for @recordIt.
  ///
  /// In en, this message translates to:
  /// **'Record it'**
  String get recordIt;

  /// No description provided for @tutorial1Detail.
  ///
  /// In en, this message translates to:
  /// **'Record income and\nexpenses conveniently.'**
  String get tutorial1Detail;

  /// No description provided for @shareIt.
  ///
  /// In en, this message translates to:
  /// **'Share it'**
  String get shareIt;

  /// No description provided for @tutorial2Detail.
  ///
  /// In en, this message translates to:
  /// **'Able to manage and\nshare ledger with friends'**
  String get tutorial2Detail;

  /// No description provided for @takeCare.
  ///
  /// In en, this message translates to:
  /// **'Take care'**
  String get takeCare;

  /// No description provided for @tutorial3Detail.
  ///
  /// In en, this message translates to:
  /// **'Analyze graph at a glance.\nYou can manage your income and expenses.'**
  String get tutorial3Detail;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @cafe.
  ///
  /// In en, this message translates to:
  /// **'Cafe'**
  String get cafe;

  /// No description provided for @drink.
  ///
  /// In en, this message translates to:
  /// **'Drink'**
  String get drink;

  /// No description provided for @snack.
  ///
  /// In en, this message translates to:
  /// **'Snack'**
  String get snack;

  /// No description provided for @meal.
  ///
  /// In en, this message translates to:
  /// **'Meal'**
  String get meal;

  /// No description provided for @dating.
  ///
  /// In en, this message translates to:
  /// **'Dating'**
  String get dating;

  /// No description provided for @movie.
  ///
  /// In en, this message translates to:
  /// **'Movie'**
  String get movie;

  /// No description provided for @pet.
  ///
  /// In en, this message translates to:
  /// **'Pet'**
  String get pet;

  /// No description provided for @transport.
  ///
  /// In en, this message translates to:
  /// **'Transport'**
  String get transport;

  /// No description provided for @exercise.
  ///
  /// In en, this message translates to:
  /// **'Exercise'**
  String get exercise;

  /// No description provided for @wear.
  ///
  /// In en, this message translates to:
  /// **'Wear'**
  String get wear;

  /// No description provided for @sleep.
  ///
  /// In en, this message translates to:
  /// **'Sleep'**
  String get sleep;

  /// No description provided for @baby.
  ///
  /// In en, this message translates to:
  /// **'Baby'**
  String get baby;

  /// No description provided for @gift.
  ///
  /// In en, this message translates to:
  /// **'Gift'**
  String get gift;

  /// No description provided for @electronic.
  ///
  /// In en, this message translates to:
  /// **'Electronic'**
  String get electronic;

  /// No description provided for @furniture.
  ///
  /// In en, this message translates to:
  /// **'Furniture'**
  String get furniture;

  /// No description provided for @travel.
  ///
  /// In en, this message translates to:
  /// **'Travel'**
  String get travel;

  /// No description provided for @hospital.
  ///
  /// In en, this message translates to:
  /// **'Hospital'**
  String get hospital;

  /// No description provided for @mobileFee.
  ///
  /// In en, this message translates to:
  /// **'Mobile'**
  String get mobileFee;

  /// No description provided for @car.
  ///
  /// In en, this message translates to:
  /// **'Car'**
  String get car;

  /// No description provided for @culture.
  ///
  /// In en, this message translates to:
  /// **'Culture'**
  String get culture;

  /// No description provided for @education.
  ///
  /// In en, this message translates to:
  /// **'Education'**
  String get education;

  /// No description provided for @electric.
  ///
  /// In en, this message translates to:
  /// **'Electric'**
  String get electric;

  /// No description provided for @insurance.
  ///
  /// In en, this message translates to:
  /// **'Insurance'**
  String get insurance;

  /// No description provided for @maintenance.
  ///
  /// In en, this message translates to:
  /// **'Maintenance'**
  String get maintenance;

  /// No description provided for @membership.
  ///
  /// In en, this message translates to:
  /// **'Membership'**
  String get membership;

  /// No description provided for @stuffs.
  ///
  /// In en, this message translates to:
  /// **'Stuffs'**
  String get stuffs;

  /// No description provided for @tax.
  ///
  /// In en, this message translates to:
  /// **'Tax'**
  String get tax;

  /// No description provided for @noLedgerDescription.
  ///
  /// In en, this message translates to:
  /// **'You do not have an account book.\nPlease add your household account book.'**
  String get noLedgerDescription;

  /// No description provided for @price.
  ///
  /// In en, this message translates to:
  /// **'Price'**
  String get price;

  /// No description provided for @category.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get category;

  /// No description provided for @date.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get date;

  /// No description provided for @location.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get location;

  /// No description provided for @picture.
  ///
  /// In en, this message translates to:
  /// **'Picture'**
  String get picture;

  /// No description provided for @consume.
  ///
  /// In en, this message translates to:
  /// **'Consume'**
  String get consume;

  /// No description provided for @income.
  ///
  /// In en, this message translates to:
  /// **'Income'**
  String get income;

  /// No description provided for @showAll.
  ///
  /// In en, this message translates to:
  /// **'Show All'**
  String get showAll;

  /// No description provided for @camera.
  ///
  /// In en, this message translates to:
  /// **'Camera'**
  String get camera;

  /// No description provided for @gallery.
  ///
  /// In en, this message translates to:
  /// **'Gallery'**
  String get gallery;

  /// No description provided for @walletMoney.
  ///
  /// In en, this message translates to:
  /// **'Wallet'**
  String get walletMoney;

  /// No description provided for @salary.
  ///
  /// In en, this message translates to:
  /// **'Salary'**
  String get salary;

  /// No description provided for @bonus.
  ///
  /// In en, this message translates to:
  /// **'Bonus'**
  String get bonus;

  /// No description provided for @salesOfGood.
  ///
  /// In en, this message translates to:
  /// **'Sale of goods'**
  String get salesOfGood;

  /// No description provided for @award.
  ///
  /// In en, this message translates to:
  /// **'Award'**
  String get award;

  /// No description provided for @present.
  ///
  /// In en, this message translates to:
  /// **'Present'**
  String get present;

  /// No description provided for @extra.
  ///
  /// In en, this message translates to:
  /// **'Extra'**
  String get extra;

  /// No description provided for @categoryAdd.
  ///
  /// In en, this message translates to:
  /// **'Add category'**
  String get categoryAdd;

  /// No description provided for @categoryAddHint.
  ///
  /// In en, this message translates to:
  /// **'Please write category name.'**
  String get categoryAddHint;

  /// No description provided for @iconSelect.
  ///
  /// In en, this message translates to:
  /// **'Select icon'**
  String get iconSelect;

  /// No description provided for @categoryAdded.
  ///
  /// In en, this message translates to:
  /// **'Successfully added category.'**
  String get categoryAdded;

  /// No description provided for @categoryAddError.
  ///
  /// In en, this message translates to:
  /// **'There was an error while adding category. Please try again.'**
  String get categoryAddError;

  /// No description provided for @categoryDeleted.
  ///
  /// In en, this message translates to:
  /// **'Successfully deleted category.'**
  String get categoryDeleted;

  /// No description provided for @categoryDeleteError.
  ///
  /// In en, this message translates to:
  /// **'There was an error while deleting category. Please try again.'**
  String get categoryDeleteError;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @deleteAsk.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete?'**
  String get deleteAsk;

  /// No description provided for @leaveAsk.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to leave?'**
  String get leaveAsk;

  /// No description provided for @errorCategoryName.
  ///
  /// In en, this message translates to:
  /// **'Please write category name.'**
  String get errorCategoryName;

  /// No description provided for @errorCategoryIcon.
  ///
  /// In en, this message translates to:
  /// **'Please select icon.'**
  String get errorCategoryIcon;

  /// No description provided for @exportExcel.
  ///
  /// In en, this message translates to:
  /// **'Export'**
  String get exportExcel;

  /// No description provided for @member.
  ///
  /// In en, this message translates to:
  /// **'Member'**
  String get member;

  /// No description provided for @seeAll.
  ///
  /// In en, this message translates to:
  /// **'See all'**
  String get seeAll;

  /// No description provided for @lockHint.
  ///
  /// In en, this message translates to:
  /// **'Please Enter PIN code.'**
  String get lockHint;

  /// No description provided for @fingerprintLogin.
  ///
  /// In en, this message translates to:
  /// **'Unlock with Fingerprint'**
  String get fingerprintLogin;

  /// No description provided for @fingerprintSetup.
  ///
  /// In en, this message translates to:
  /// **'FingerPrint Setup'**
  String get fingerprintSetup;

  /// No description provided for @pinMismatch.
  ///
  /// In en, this message translates to:
  /// **'PIN code mismatch'**
  String get pinMismatch;

  /// No description provided for @membershipChange.
  ///
  /// In en, this message translates to:
  /// **'Change membership'**
  String get membershipChange;

  /// No description provided for @owner.
  ///
  /// In en, this message translates to:
  /// **'Owner'**
  String get owner;

  /// No description provided for @admin.
  ///
  /// In en, this message translates to:
  /// **'Admin'**
  String get admin;

  /// No description provided for @guest.
  ///
  /// In en, this message translates to:
  /// **'Guest'**
  String get guest;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @searchUserHint.
  ///
  /// In en, this message translates to:
  /// **'Search user...'**
  String get searchUserHint;

  /// No description provided for @plzSearch.
  ///
  /// In en, this message translates to:
  /// **'Please search...'**
  String get plzSearch;

  /// No description provided for @noData.
  ///
  /// In en, this message translates to:
  /// **'No data exists.'**
  String get noData;

  /// No description provided for @leave.
  ///
  /// In en, this message translates to:
  /// **'Leave'**
  String get leave;

  /// No description provided for @shouldTransferOwnership.
  ///
  /// In en, this message translates to:
  /// **'You should transfer ownership before leaving your ledger.'**
  String get shouldTransferOwnership;
}

class _SDelegate extends LocalizationsDelegate<S> {
  const _SDelegate();

  @override
  Future<S> load(Locale locale) {
    return SynchronousFuture<S>(lookupS(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'ko'].contains(locale.languageCode);

  @override
  bool shouldReload(_SDelegate old) => false;
}

S lookupS(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return SEn();
    case 'ko': return SKo();
  }

  throw FlutterError(
    'S.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
