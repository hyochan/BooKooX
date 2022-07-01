// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Loading...`
  String get LOADING {
    return Intl.message(
      'Loading...',
      name: 'LOADING',
      desc: '',
      args: [],
    );
  }

  /// `Sign in`
  String get SIGN_IN {
    return Intl.message(
      'Sign in',
      name: 'SIGN_IN',
      desc: '',
      args: [],
    );
  }

  /// `This field cannot be empty.`
  String get EMPTY_WARNING {
    return Intl.message(
      'This field cannot be empty.',
      name: 'EMPTY_WARNING',
      desc: '',
      args: [],
    );
  }

  /// `Your email is invalid. Please check your email address.`
  String get ERROR_INVALID_EMAIL {
    return Intl.message(
      'Your email is invalid. Please check your email address.',
      name: 'ERROR_INVALID_EMAIL',
      desc: '',
      args: [],
    );
  }

  /// `Password is incorrect. Please check your password.`
  String get ERROR_WRONG_PASSWORD {
    return Intl.message(
      'Password is incorrect. Please check your password.',
      name: 'ERROR_WRONG_PASSWORD',
      desc: '',
      args: [],
    );
  }

  /// `User is not found. Please sign up beforehand.`
  String get ERROR_USER_NOT_FOUND {
    return Intl.message(
      'User is not found. Please sign up beforehand.',
      name: 'ERROR_USER_NOT_FOUND',
      desc: '',
      args: [],
    );
  }

  /// `Current user is disabled. Please contact customer service.`
  String get ERROR_USER_DISABLED {
    return Intl.message(
      'Current user is disabled. Please contact customer service.',
      name: 'ERROR_USER_DISABLED',
      desc: '',
      args: [],
    );
  }

  /// `Too many attempts. Please try again later.`
  String get ERROR_TOO_MANY_REQUESTS {
    return Intl.message(
      'Too many attempts. Please try again later.',
      name: 'ERROR_TOO_MANY_REQUESTS',
      desc: '',
      args: [],
    );
  }

  /// `Current operation is not allowed. Please try again later.`
  String get ERROR_OPERATION_NOT_ALLOWED {
    return Intl.message(
      'Current operation is not allowed. Please try again later.',
      name: 'ERROR_OPERATION_NOT_ALLOWED',
      desc: '',
      args: [],
    );
  }

  /// `Your email is not verified. Please check your inbox and verify your email address.`
  String get EMAIL_NOT_VERIFIED {
    return Intl.message(
      'Your email is not verified. Please check your inbox and verify your email address.',
      name: 'EMAIL_NOT_VERIFIED',
      desc: '',
      args: [],
    );
  }

  /// `Re-send email`
  String get RESEND_EMAIL {
    return Intl.message(
      'Re-send email',
      name: 'RESEND_EMAIL',
      desc: '',
      args: [],
    );
  }

  /// `Password reset link has been sent to your email. Please check your inbox.`
  String get PASSWORD_RESET_LINK_SENT {
    return Intl.message(
      'Password reset link has been sent to your email. Please check your inbox.',
      name: 'PASSWORD_RESET_LINK_SENT',
      desc: '',
      args: [],
    );
  }

  /// `Signing in with Google...`
  String get SIGNING_IN_WITH_GOOGLE {
    return Intl.message(
      'Signing in with Google...',
      name: 'SIGNING_IN_WITH_GOOGLE',
      desc: '',
      args: [],
    );
  }

  /// `Sign up`
  String get SIGN_UP {
    return Intl.message(
      'Sign up',
      name: 'SIGN_UP',
      desc: '',
      args: [],
    );
  }

  /// `Registered`
  String get SIGN_UP_SUCCESS_TITLE {
    return Intl.message(
      'Registered',
      name: 'SIGN_UP_SUCCESS_TITLE',
      desc: '',
      args: [],
    );
  }

  /// `Thanks for registering to WeCount. Please check your email to verify your email address. Or your email may be already registered.`
  String get SIGN_UP_SUCCESS_CONTENT {
    return Intl.message(
      'Thanks for registering to WeCount. Please check your email to verify your email address. Or your email may be already registered.',
      name: 'SIGN_UP_SUCCESS_CONTENT',
      desc: '',
      args: [],
    );
  }

  /// `Registered Failed`
  String get SIGN_UP_ERROR_TITLE {
    return Intl.message(
      'Registered Failed',
      name: 'SIGN_UP_ERROR_TITLE',
      desc: '',
      args: [],
    );
  }

  /// `Unexpected error occurred. Please check your internet connection and try again later.`
  String get SIGN_UP_ERROR_CONTENT {
    return Intl.message(
      'Unexpected error occurred. Please check your internet connection and try again later.',
      name: 'SIGN_UP_ERROR_CONTENT',
      desc: '',
      args: [],
    );
  }

  /// `Don't have an account?`
  String get DO_NOT_HAVE_ACCOUNT {
    return Intl.message(
      'Don\'t have an account?',
      name: 'DO_NOT_HAVE_ACCOUNT',
      desc: '',
      args: [],
    );
  }

  /// `By proceeding to the next step, you agree to the `
  String get TERMS_1 {
    return Intl.message(
      'By proceeding to the next step, you agree to the ',
      name: 'TERMS_1',
      desc: '',
      args: [],
    );
  }

  /// `Terms of Use`
  String get TERMS_OF_USE {
    return Intl.message(
      'Terms of Use',
      name: 'TERMS_OF_USE',
      desc: '',
      args: [],
    );
  }

  /// ` and `
  String get TERMS_2 {
    return Intl.message(
      ' and ',
      name: 'TERMS_2',
      desc: '',
      args: [],
    );
  }

  /// `Privacy Policy`
  String get PRIVACY_POLICY {
    return Intl.message(
      'Privacy Policy',
      name: 'PRIVACY_POLICY',
      desc: '',
      args: [],
    );
  }

  /// `.`
  String get TERMS_3 {
    return Intl.message(
      '.',
      name: 'TERMS_3',
      desc: '',
      args: [],
    );
  }

  /// `Monthly`
  String get HOME_MONTHLY {
    return Intl.message(
      'Monthly',
      name: 'HOME_MONTHLY',
      desc: '',
      args: [],
    );
  }

  /// `List`
  String get HOME_LIST {
    return Intl.message(
      'List',
      name: 'HOME_LIST',
      desc: '',
      args: [],
    );
  }

  /// `Statistic`
  String get HOME_STATISTIC {
    return Intl.message(
      'Statistic',
      name: 'HOME_STATISTIC',
      desc: '',
      args: [],
    );
  }

  /// `Setting`
  String get HOME_SETTING {
    return Intl.message(
      'Setting',
      name: 'HOME_SETTING',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get EMAIL {
    return Intl.message(
      'Email',
      name: 'EMAIL',
      desc: '',
      args: [],
    );
  }

  /// `Please write email address`
  String get EMAIL_HINT {
    return Intl.message(
      'Please write email address',
      name: 'EMAIL_HINT',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get PASSWORD {
    return Intl.message(
      'Password',
      name: 'PASSWORD',
      desc: '',
      args: [],
    );
  }

  /// `Please write your password`
  String get PASSWORD_HINT {
    return Intl.message(
      'Please write your password',
      name: 'PASSWORD_HINT',
      desc: '',
      args: [],
    );
  }

  /// `Confirm password`
  String get PASSWORD_CONFIRM {
    return Intl.message(
      'Confirm password',
      name: 'PASSWORD_CONFIRM',
      desc: '',
      args: [],
    );
  }

  /// `Please confirm password`
  String get PASSWORD_CONFIRM_HINT {
    return Intl.message(
      'Please confirm password',
      name: 'PASSWORD_CONFIRM_HINT',
      desc: '',
      args: [],
    );
  }

  /// `Display name`
  String get DISPLAY_NAME {
    return Intl.message(
      'Display name',
      name: 'DISPLAY_NAME',
      desc: '',
      args: [],
    );
  }

  /// `Please write your display name (min 3 letters)`
  String get DISPLAY_NAME_HINT {
    return Intl.message(
      'Please write your display name (min 3 letters)',
      name: 'DISPLAY_NAME_HINT',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get NAME {
    return Intl.message(
      'Name',
      name: 'NAME',
      desc: '',
      args: [],
    );
  }

  /// `Please write your name (min 3 letters)`
  String get NAME_HINT {
    return Intl.message(
      'Please write your name (min 3 letters)',
      name: 'NAME_HINT',
      desc: '',
      args: [],
    );
  }

  /// `Did you forgot password`
  String get DID_YOU_FORGOT_PASSWORD {
    return Intl.message(
      'Did you forgot password',
      name: 'DID_YOU_FORGOT_PASSWORD',
      desc: '',
      args: [],
    );
  }

  /// `Find password`
  String get FIND_PASSWORD {
    return Intl.message(
      'Find password',
      name: 'FIND_PASSWORD',
      desc: '',
      args: [],
    );
  }

  /// `Send email`
  String get SEND_EMAIL {
    return Intl.message(
      'Send email',
      name: 'SEND_EMAIL',
      desc: '',
      args: [],
    );
  }

  /// `Error`
  String get ERROR {
    return Intl.message(
      'Error',
      name: 'ERROR',
      desc: '',
      args: [],
    );
  }

  /// `Not a valid email address`
  String get NO_VALID_EMAIL {
    return Intl.message(
      'Not a valid email address',
      name: 'NO_VALID_EMAIL',
      desc: '',
      args: [],
    );
  }

  /// `Password should be alphanumeric with more than 5 letters`
  String get NO_VALID_PASSWORD {
    return Intl.message(
      'Password should be alphanumeric with more than 5 letters',
      name: 'NO_VALID_PASSWORD',
      desc: '',
      args: [],
    );
  }

  /// `Ok`
  String get OK {
    return Intl.message(
      'Ok',
      name: 'OK',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get CANCEL {
    return Intl.message(
      'Cancel',
      name: 'CANCEL',
      desc: '',
      args: [],
    );
  }

  /// `Create App!`
  String get INTRO {
    return Intl.message(
      'Create App!',
      name: 'INTRO',
      desc: '',
      args: [],
    );
  }

  /// `Person`
  String get PERSON {
    return Intl.message(
      'Person',
      name: 'PERSON',
      desc: '',
      args: [],
    );
  }

  /// `People`
  String get PEOPLE {
    return Intl.message(
      'People',
      name: 'PEOPLE',
      desc: '',
      args: [],
    );
  }

  /// `more`
  String get MORE {
    return Intl.message(
      'more',
      name: 'MORE',
      desc: '',
      args: [],
    );
  }

  /// `Add Ledger`
  String get ADD_LEDGER {
    return Intl.message(
      'Add Ledger',
      name: 'ADD_LEDGER',
      desc: '',
      args: [],
    );
  }

  /// `Setting`
  String get SETTING {
    return Intl.message(
      'Setting',
      name: 'SETTING',
      desc: '',
      args: [],
    );
  }

  /// `Back`
  String get BACK {
    return Intl.message(
      'Back',
      name: 'BACK',
      desc: '',
      args: [],
    );
  }

  /// `Please write name of your ledger`
  String get LEDGER_NAME_HINT {
    return Intl.message(
      'Please write name of your ledger',
      name: 'LEDGER_NAME_HINT',
      desc: '',
      args: [],
    );
  }

  /// `Please write description of ledger`
  String get LEDGER_DESCRIPTION_HINT {
    return Intl.message(
      'Please write description of ledger',
      name: 'LEDGER_DESCRIPTION_HINT',
      desc: '',
      args: [],
    );
  }

  /// `Color`
  String get COLOR {
    return Intl.message(
      'Color',
      name: 'COLOR',
      desc: '',
      args: [],
    );
  }

  /// `Currency`
  String get CURRENCY {
    return Intl.message(
      'Currency',
      name: 'CURRENCY',
      desc: '',
      args: [],
    );
  }

  /// `Done`
  String get DONE {
    return Intl.message(
      'Done',
      name: 'DONE',
      desc: '',
      args: [],
    );
  }

  /// `Update`
  String get UPDATE {
    return Intl.message(
      'Update',
      name: 'UPDATE',
      desc: '',
      args: [],
    );
  }

  /// `Nickname`
  String get NICKNAME {
    return Intl.message(
      'Nickname',
      name: 'NICKNAME',
      desc: '',
      args: [],
    );
  }

  /// `Phone number`
  String get PHONE {
    return Intl.message(
      'Phone number',
      name: 'PHONE',
      desc: '',
      args: [],
    );
  }

  /// `Status message`
  String get STATUS_MESSAGE {
    return Intl.message(
      'Status message',
      name: 'STATUS_MESSAGE',
      desc: '',
      args: [],
    );
  }

  /// `Please write your status message.`
  String get STATUS_MESSAGE_HINT {
    return Intl.message(
      'Please write your status message.',
      name: 'STATUS_MESSAGE_HINT',
      desc: '',
      args: [],
    );
  }

  /// `Announcement`
  String get ANNOUNCEMENT {
    return Intl.message(
      'Announcement',
      name: 'ANNOUNCEMENT',
      desc: '',
      args: [],
    );
  }

  /// `Share opinion`
  String get SHARE_OPINION {
    return Intl.message(
      'Share opinion',
      name: 'SHARE_OPINION',
      desc: '',
      args: [],
    );
  }

  /// `Please send us your comments about Wecount.`
  String get SHARE_OPINION_HINT {
    return Intl.message(
      'Please send us your comments about Wecount.',
      name: 'SHARE_OPINION_HINT',
      desc: '',
      args: [],
    );
  }

  /// `FAQ`
  String get FAQ {
    return Intl.message(
      'FAQ',
      name: 'FAQ',
      desc: '',
      args: [],
    );
  }

  /// `Notification`
  String get NOTIFICATION {
    return Intl.message(
      'Notification',
      name: 'NOTIFICATION',
      desc: '',
      args: [],
    );
  }

  /// `Lock`
  String get LOCK {
    return Intl.message(
      'Lock',
      name: 'LOCK',
      desc: '',
      args: [],
    );
  }

  /// `Log out`
  String get LOGOUT {
    return Intl.message(
      'Log out',
      name: 'LOGOUT',
      desc: '',
      args: [],
    );
  }

  /// `Version`
  String get VERSION {
    return Intl.message(
      'Version',
      name: 'VERSION',
      desc: '',
      args: [],
    );
  }

  /// `Wecount Promises`
  String get ANNOUNCEMENT_1 {
    return Intl.message(
      'Wecount Promises',
      name: 'ANNOUNCEMENT_1',
      desc: '',
      args: [],
    );
  }

  /// `We will always update our app to support better experience to users. We will listen to you as much as we can.\n`
  String get ANNOUNCEMENT_TXT_1 {
    return Intl.message(
      'We will always update our app to support better experience to users. We will listen to you as much as we can.\n',
      name: 'ANNOUNCEMENT_TXT_1',
      desc: '',
      args: [],
    );
  }

  /// `Release note`
  String get ANNOUNCEMENT_2 {
    return Intl.message(
      'Release note',
      name: 'ANNOUNCEMENT_2',
      desc: '',
      args: [],
    );
  }

  /// `Wecount is released on apple app store and android playstore. Thank you for all your supports.\n`
  String get ANNOUNCEMENT_TXT_2 {
    return Intl.message(
      'Wecount is released on apple app store and android playstore. Thank you for all your supports.\n',
      name: 'ANNOUNCEMENT_TXT_2',
      desc: '',
      args: [],
    );
  }

  /// `How do I withdraw from Wecount?`
  String get FAQ_1 {
    return Intl.message(
      'How do I withdraw from Wecount?',
      name: 'FAQ_1',
      desc: '',
      args: [],
    );
  }

  /// `Since we can have some information that may be sensitive to users, we decided to confirm the withdrawal before it is actually done. Send us an email which is dooboolab@gmail.com. We will throughly review your withdrawals and send you email back when it is done.\n`
  String get FAQ_TXT_1 {
    return Intl.message(
      'Since we can have some information that may be sensitive to users, we decided to confirm the withdrawal before it is actually done. Send us an email which is dooboolab@gmail.com. We will throughly review your withdrawals and send you email back when it is done.\n',
      name: 'FAQ_TXT_1',
      desc: '',
      args: [],
    );
  }

  /// `How do I create ledger?`
  String get FAQ_2 {
    return Intl.message(
      'How do I create ledger?',
      name: 'FAQ_2',
      desc: '',
      args: [],
    );
  }

  /// `First, click on the hamburger button which is placed at the top left corner of Main page and open the dashboard. Then click on Add Ledger at the bottom of the dashboard. Then write the title and description and choose the color. Finally click on [Done] button to actually create one.\n`
  String get FAQ_TXT_2 {
    return Intl.message(
      'First, click on the hamburger button which is placed at the top left corner of Main page and open the dashboard. Then click on Add Ledger at the bottom of the dashboard. Then write the title and description and choose the color. Finally click on [Done] button to actually create one.\n',
      name: 'FAQ_TXT_2',
      desc: '',
      args: [],
    );
  }

  /// `What do Wecount earn?`
  String get FAQ_3 {
    return Intl.message(
      'What do Wecount earn?',
      name: 'FAQ_3',
      desc: '',
      args: [],
    );
  }

  /// `We earn your love. We will be fast growing as much as we get more attraction from you.\n`
  String get FAQ_TXT_3 {
    return Intl.message(
      'We earn your love. We will be fast growing as much as we get more attraction from you.\n',
      name: 'FAQ_TXT_3',
      desc: '',
      args: [],
    );
  }

  /// `What is different from ledger and ledger item?`
  String get FAQ_4 {
    return Intl.message(
      'What is different from ledger and ledger item?',
      name: 'FAQ_4',
      desc: '',
      args: [],
    );
  }

  /// `Ledger is just an account book which contains all the ledger items. We named it this way not to confuse ourselves during developing our app.\n`
  String get FAQ_TXT_4 {
    return Intl.message(
      'Ledger is just an account book which contains all the ledger items. We named it this way not to confuse ourselves during developing our app.\n',
      name: 'FAQ_TXT_4',
      desc: '',
      args: [],
    );
  }

  /// `How do I create ledger item?`
  String get FAQ_5 {
    return Intl.message(
      'How do I create ledger item?',
      name: 'FAQ_5',
      desc: '',
      args: [],
    );
  }

  /// `First you need to have your ledger created or you should be invited to another ledger. Then in main page, click on [+] button at the top right corner. You will see left and right screen. Left one is adding consume item and right one is adding income item. Which one you prefer, just select category and fill out amount input box which is minimum information you need to add the item. Finally click on [Done] button to finish adding.\n`
  String get FAQ_TXT_5 {
    return Intl.message(
      'First you need to have your ledger created or you should be invited to another ledger. Then in main page, click on [+] button at the top right corner. You will see left and right screen. Left one is adding consume item and right one is adding income item. Which one you prefer, just select category and fill out amount input box which is minimum information you need to add the item. Finally click on [Done] button to finish adding.\n',
      name: 'FAQ_TXT_5',
      desc: '',
      args: [],
    );
  }

  /// `How can I invite member to my ledger?`
  String get FAQ_6 {
    return Intl.message(
      'How can I invite member to my ledger?',
      name: 'FAQ_6',
      desc: '',
      args: [],
    );
  }

  /// `Ask email address to member whom you want to invite. Then in dashboard, click on [more] button and move to ledger detail page. Click on [+] button placed right of your profile which is placed at the bottom. Write an email address. You can also write multiple addresses by adding spaces.\n`
  String get FAQ_TXT_6 {
    return Intl.message(
      'Ask email address to member whom you want to invite. Then in dashboard, click on [more] button and move to ledger detail page. Click on [+] button placed right of your profile which is placed at the bottom. Write an email address. You can also write multiple addresses by adding spaces.\n',
      name: 'FAQ_TXT_6',
      desc: '',
      args: [],
    );
  }

  /// `Can owner of ledger only invite member?`
  String get FAQ_7 {
    return Intl.message(
      'Can owner of ledger only invite member?',
      name: 'FAQ_7',
      desc: '',
      args: [],
    );
  }

  /// `Yes. Since ledger can have some sensitive information (personally). Only owner can invite members.\n`
  String get FAQ_TXT_7 {
    return Intl.message(
      'Yes. Since ledger can have some sensitive information (personally). Only owner can invite members.\n',
      name: 'FAQ_TXT_7',
      desc: '',
      args: [],
    );
  }

  /// `Where can I send my upgrade request for Wecount?`
  String get FAQ_8 {
    return Intl.message(
      'Where can I send my upgrade request for Wecount?',
      name: 'FAQ_8',
      desc: '',
      args: [],
    );
  }

  /// `If you want to send us any opinion, go to [Share Opinion] in setting page. Then write us any opinion you want to send us.\n`
  String get FAQ_TXT_8 {
    return Intl.message(
      'If you want to send us any opinion, go to [Share Opinion] in setting page. Then write us any opinion you want to send us.\n',
      name: 'FAQ_TXT_8',
      desc: '',
      args: [],
    );
  }

  /// `Can I use this app in other devices?`
  String get FAQ_9 {
    return Intl.message(
      'Can I use this app in other devices?',
      name: 'FAQ_9',
      desc: '',
      args: [],
    );
  }

  /// `Yes. Since our service is based on sns, you can use our app in different phone.\n`
  String get FAQ_TXT_9 {
    return Intl.message(
      'Yes. Since our service is based on sns, you can use our app in different phone.\n',
      name: 'FAQ_TXT_9',
      desc: '',
      args: [],
    );
  }

  /// `How is Wecount different from other ledger app?`
  String get FAQ_10 {
    return Intl.message(
      'How is Wecount different from other ledger app?',
      name: 'FAQ_10',
      desc: '',
      args: [],
    );
  }

  /// `Basically, Wecount is a social ledger service which you can share it with other members. Right now, there is many personal ledger app but there is no social ledger service yet. You can manage your own ledger with Wecount but also with other people. You can only manage your own ledger yourself but also multiple ledgers by creating new ones or get invited.\n`
  String get FAQ_TXT_10 {
    return Intl.message(
      'Basically, Wecount is a social ledger service which you can share it with other members. Right now, there is many personal ledger app but there is no social ledger service yet. You can manage your own ledger with Wecount but also with other people. You can only manage your own ledger yourself but also multiple ledgers by creating new ones or get invited.\n',
      name: 'FAQ_TXT_10',
      desc: '',
      args: [],
    );
  }

  /// `Why did you think you need to make Wecount?`
  String get FAQ_11 {
    return Intl.message(
      'Why did you think you need to make Wecount?',
      name: 'FAQ_11',
      desc: '',
      args: [],
    );
  }

  /// `Firstly, we found out that there are many troubles when someone manage other people"s money like membership fee. When we were university students, there were also trouble since manager did not manage ledger transparently. Actually, Wecount is more needed for people to whom wants to be shared more than those who wants to share. We really needed this service personally so we created one. We will keep working on it for your better experience. Be with us!\n`
  String get FAQ_TXT_11 {
    return Intl.message(
      'Firstly, we found out that there are many troubles when someone manage other people"s money like membership fee. When we were university students, there were also trouble since manager did not manage ledger transparently. Actually, Wecount is more needed for people to whom wants to be shared more than those who wants to share. We really needed this service personally so we created one. We will keep working on it for your better experience. Be with us!\n',
      name: 'FAQ_TXT_11',
      desc: '',
      args: [],
    );
  }

  /// `Send`
  String get SEND {
    return Intl.message(
      'Send',
      name: 'SEND',
      desc: '',
      args: [],
    );
  }

  /// `Adding ledger item`
  String get ADDING_LEDGER_ITEM {
    return Intl.message(
      'Adding ledger item',
      name: 'ADDING_LEDGER_ITEM',
      desc: '',
      args: [],
    );
  }

  /// `Updating ledger item`
  String get UPDATING_LEDGER_ITEM {
    return Intl.message(
      'Updating ledger item',
      name: 'UPDATING_LEDGER_ITEM',
      desc: '',
      args: [],
    );
  }

  /// `Record it`
  String get RECORD_IT {
    return Intl.message(
      'Record it',
      name: 'RECORD_IT',
      desc: '',
      args: [],
    );
  }

  /// `Record income and\nexpenses conveniently.`
  String get TUTORIAL_1_DETAIL {
    return Intl.message(
      'Record income and\nexpenses conveniently.',
      name: 'TUTORIAL_1_DETAIL',
      desc: '',
      args: [],
    );
  }

  /// `Share it`
  String get SHARE_IT {
    return Intl.message(
      'Share it',
      name: 'SHARE_IT',
      desc: '',
      args: [],
    );
  }

  /// `Able to manage and\nshare ledger with friends`
  String get TUTORIAL_2_DETAIL {
    return Intl.message(
      'Able to manage and\nshare ledger with friends',
      name: 'TUTORIAL_2_DETAIL',
      desc: '',
      args: [],
    );
  }

  /// `Take care`
  String get TAKE_CARE {
    return Intl.message(
      'Take care',
      name: 'TAKE_CARE',
      desc: '',
      args: [],
    );
  }

  /// `Analyze graph at a glance.\nYou can manage your income and expenses.`
  String get TUTORIAL_3_DETAIL {
    return Intl.message(
      'Analyze graph at a glance.\nYou can manage your income and expenses.',
      name: 'TUTORIAL_3_DETAIL',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get NEXT {
    return Intl.message(
      'Next',
      name: 'NEXT',
      desc: '',
      args: [],
    );
  }

  /// `Cafe`
  String get CAFE {
    return Intl.message(
      'Cafe',
      name: 'CAFE',
      desc: '',
      args: [],
    );
  }

  /// `Drink`
  String get DRINK {
    return Intl.message(
      'Drink',
      name: 'DRINK',
      desc: '',
      args: [],
    );
  }

  /// `Snack`
  String get SNACK {
    return Intl.message(
      'Snack',
      name: 'SNACK',
      desc: '',
      args: [],
    );
  }

  /// `Meal`
  String get MEAL {
    return Intl.message(
      'Meal',
      name: 'MEAL',
      desc: '',
      args: [],
    );
  }

  /// `Dating`
  String get DATING {
    return Intl.message(
      'Dating',
      name: 'DATING',
      desc: '',
      args: [],
    );
  }

  /// `Movie`
  String get MOVIE {
    return Intl.message(
      'Movie',
      name: 'MOVIE',
      desc: '',
      args: [],
    );
  }

  /// `Pet`
  String get PET {
    return Intl.message(
      'Pet',
      name: 'PET',
      desc: '',
      args: [],
    );
  }

  /// `Transport`
  String get TRANSPORT {
    return Intl.message(
      'Transport',
      name: 'TRANSPORT',
      desc: '',
      args: [],
    );
  }

  /// `Exercise`
  String get EXERCISE {
    return Intl.message(
      'Exercise',
      name: 'EXERCISE',
      desc: '',
      args: [],
    );
  }

  /// `Wear`
  String get WEAR {
    return Intl.message(
      'Wear',
      name: 'WEAR',
      desc: '',
      args: [],
    );
  }

  /// `Sleep`
  String get SLEEP {
    return Intl.message(
      'Sleep',
      name: 'SLEEP',
      desc: '',
      args: [],
    );
  }

  /// `Baby`
  String get BABY {
    return Intl.message(
      'Baby',
      name: 'BABY',
      desc: '',
      args: [],
    );
  }

  /// `Gift`
  String get GIFT {
    return Intl.message(
      'Gift',
      name: 'GIFT',
      desc: '',
      args: [],
    );
  }

  /// `Electronic`
  String get ELECTRONIC {
    return Intl.message(
      'Electronic',
      name: 'ELECTRONIC',
      desc: '',
      args: [],
    );
  }

  /// `Furniture`
  String get FURNITURE {
    return Intl.message(
      'Furniture',
      name: 'FURNITURE',
      desc: '',
      args: [],
    );
  }

  /// `Travel`
  String get TRAVEL {
    return Intl.message(
      'Travel',
      name: 'TRAVEL',
      desc: '',
      args: [],
    );
  }

  /// `Hospital`
  String get HOSPITAL {
    return Intl.message(
      'Hospital',
      name: 'HOSPITAL',
      desc: '',
      args: [],
    );
  }

  /// `Mobile`
  String get MOBILE_FEE {
    return Intl.message(
      'Mobile',
      name: 'MOBILE_FEE',
      desc: '',
      args: [],
    );
  }

  /// `Car`
  String get CAR {
    return Intl.message(
      'Car',
      name: 'CAR',
      desc: '',
      args: [],
    );
  }

  /// `Culture`
  String get CULTURE {
    return Intl.message(
      'Culture',
      name: 'CULTURE',
      desc: '',
      args: [],
    );
  }

  /// `Education`
  String get EDUCATION {
    return Intl.message(
      'Education',
      name: 'EDUCATION',
      desc: '',
      args: [],
    );
  }

  /// `Electric`
  String get ELECTRIC {
    return Intl.message(
      'Electric',
      name: 'ELECTRIC',
      desc: '',
      args: [],
    );
  }

  /// `Insurance`
  String get INSURANCE {
    return Intl.message(
      'Insurance',
      name: 'INSURANCE',
      desc: '',
      args: [],
    );
  }

  /// `Maintenance`
  String get MAINTENANCE {
    return Intl.message(
      'Maintenance',
      name: 'MAINTENANCE',
      desc: '',
      args: [],
    );
  }

  /// `Membership`
  String get MEMBERSHIP {
    return Intl.message(
      'Membership',
      name: 'MEMBERSHIP',
      desc: '',
      args: [],
    );
  }

  /// `Stuffs`
  String get STUFFS {
    return Intl.message(
      'Stuffs',
      name: 'STUFFS',
      desc: '',
      args: [],
    );
  }

  /// `Tax`
  String get TAX {
    return Intl.message(
      'Tax',
      name: 'TAX',
      desc: '',
      args: [],
    );
  }

  /// `You do not have an account book.\nPlease add your household account book.`
  String get NO_LEDGER_DESCRIPTION {
    return Intl.message(
      'You do not have an account book.\nPlease add your household account book.',
      name: 'NO_LEDGER_DESCRIPTION',
      desc: '',
      args: [],
    );
  }

  /// `Price`
  String get PRICE {
    return Intl.message(
      'Price',
      name: 'PRICE',
      desc: '',
      args: [],
    );
  }

  /// `Category`
  String get CATEGORY {
    return Intl.message(
      'Category',
      name: 'CATEGORY',
      desc: '',
      args: [],
    );
  }

  /// `Date`
  String get DATE {
    return Intl.message(
      'Date',
      name: 'DATE',
      desc: '',
      args: [],
    );
  }

  /// `Location`
  String get LOCATION {
    return Intl.message(
      'Location',
      name: 'LOCATION',
      desc: '',
      args: [],
    );
  }

  /// `Picture`
  String get PICTURE {
    return Intl.message(
      'Picture',
      name: 'PICTURE',
      desc: '',
      args: [],
    );
  }

  /// `Consume`
  String get CONSUME {
    return Intl.message(
      'Consume',
      name: 'CONSUME',
      desc: '',
      args: [],
    );
  }

  /// `Income`
  String get INCOME {
    return Intl.message(
      'Income',
      name: 'INCOME',
      desc: '',
      args: [],
    );
  }

  /// `Show All`
  String get SHOW_ALL {
    return Intl.message(
      'Show All',
      name: 'SHOW_ALL',
      desc: '',
      args: [],
    );
  }

  /// `Camera`
  String get CAMERA {
    return Intl.message(
      'Camera',
      name: 'CAMERA',
      desc: '',
      args: [],
    );
  }

  /// `Gallery`
  String get GALLERY {
    return Intl.message(
      'Gallery',
      name: 'GALLERY',
      desc: '',
      args: [],
    );
  }

  /// `Wallet`
  String get WALLET_MONEY {
    return Intl.message(
      'Wallet',
      name: 'WALLET_MONEY',
      desc: '',
      args: [],
    );
  }

  /// `Salary`
  String get SALARY {
    return Intl.message(
      'Salary',
      name: 'SALARY',
      desc: '',
      args: [],
    );
  }

  /// `Bonus`
  String get BONUS {
    return Intl.message(
      'Bonus',
      name: 'BONUS',
      desc: '',
      args: [],
    );
  }

  /// `Sale of goods`
  String get SELL_PRODUCT {
    return Intl.message(
      'Sale of goods',
      name: 'SELL_PRODUCT',
      desc: '',
      args: [],
    );
  }

  /// `Award`
  String get AWARD {
    return Intl.message(
      'Award',
      name: 'AWARD',
      desc: '',
      args: [],
    );
  }

  /// `Present`
  String get PRESENT {
    return Intl.message(
      'Present',
      name: 'PRESENT',
      desc: '',
      args: [],
    );
  }

  /// `Extra`
  String get EXTRA {
    return Intl.message(
      'Extra',
      name: 'EXTRA',
      desc: '',
      args: [],
    );
  }

  /// `Add category`
  String get CATEGORY_ADD {
    return Intl.message(
      'Add category',
      name: 'CATEGORY_ADD',
      desc: '',
      args: [],
    );
  }

  /// `Please write category name.`
  String get CATEGORY_ADD_HINT {
    return Intl.message(
      'Please write category name.',
      name: 'CATEGORY_ADD_HINT',
      desc: '',
      args: [],
    );
  }

  /// `Select icon`
  String get ICON_SELECT {
    return Intl.message(
      'Select icon',
      name: 'ICON_SELECT',
      desc: '',
      args: [],
    );
  }

  /// `Successfully added category.`
  String get CATEGORY_ADDED {
    return Intl.message(
      'Successfully added category.',
      name: 'CATEGORY_ADDED',
      desc: '',
      args: [],
    );
  }

  /// `There was an error while adding category. Please try again.`
  String get CATEGORY_ADD_ERROR {
    return Intl.message(
      'There was an error while adding category. Please try again.',
      name: 'CATEGORY_ADD_ERROR',
      desc: '',
      args: [],
    );
  }

  /// `Successfully deleted category.`
  String get CATEGORY_DELETED {
    return Intl.message(
      'Successfully deleted category.',
      name: 'CATEGORY_DELETED',
      desc: '',
      args: [],
    );
  }

  /// `There was an error while deleting category. Please try again.`
  String get CATEGORY_DELETE_ERROR {
    return Intl.message(
      'There was an error while deleting category. Please try again.',
      name: 'CATEGORY_DELETE_ERROR',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get DELETE {
    return Intl.message(
      'Delete',
      name: 'DELETE',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete?`
  String get DELETE_ASK {
    return Intl.message(
      'Are you sure you want to delete?',
      name: 'DELETE_ASK',
      desc: '',
      args: [],
    );
  }

  /// `Please write category name.`
  String get ERROR_CATEGORY_NAME {
    return Intl.message(
      'Please write category name.',
      name: 'ERROR_CATEGORY_NAME',
      desc: '',
      args: [],
    );
  }

  /// `Please select icon.`
  String get ERROR_CATEGORY_ICON {
    return Intl.message(
      'Please select icon.',
      name: 'ERROR_CATEGORY_ICON',
      desc: '',
      args: [],
    );
  }

  /// `Export`
  String get EXPORT_EXCEL {
    return Intl.message(
      'Export',
      name: 'EXPORT_EXCEL',
      desc: '',
      args: [],
    );
  }

  /// `Member`
  String get MEMBER {
    return Intl.message(
      'Member',
      name: 'MEMBER',
      desc: '',
      args: [],
    );
  }

  /// `See all`
  String get SEE_ALL {
    return Intl.message(
      'See all',
      name: 'SEE_ALL',
      desc: '',
      args: [],
    );
  }

  /// `Please Enter PIN code.`
  String get LOCK_HINT {
    return Intl.message(
      'Please Enter PIN code.',
      name: 'LOCK_HINT',
      desc: '',
      args: [],
    );
  }

  /// `Unlock with Fingerprint`
  String get FINGERPRINT_LOGIN {
    return Intl.message(
      'Unlock with Fingerprint',
      name: 'FINGERPRINT_LOGIN',
      desc: '',
      args: [],
    );
  }

  /// `FingerPrint Setup`
  String get FINGERPRINT_SET {
    return Intl.message(
      'FingerPrint Setup',
      name: 'FINGERPRINT_SET',
      desc: '',
      args: [],
    );
  }

  /// `PIN code mismatch`
  String get PIN_MISMATCH {
    return Intl.message(
      'PIN code mismatch',
      name: 'PIN_MISMATCH',
      desc: '',
      args: [],
    );
  }

  /// `Change membership`
  String get MEMBERSHIP_CHANGE {
    return Intl.message(
      'Change membership',
      name: 'MEMBERSHIP_CHANGE',
      desc: '',
      args: [],
    );
  }

  /// `Owner`
  String get MEMBER_OWNER {
    return Intl.message(
      'Owner',
      name: 'MEMBER_OWNER',
      desc: '',
      args: [],
    );
  }

  /// `Admin`
  String get MEMBER_ADMIN {
    return Intl.message(
      'Admin',
      name: 'MEMBER_ADMIN',
      desc: '',
      args: [],
    );
  }

  /// `Guest`
  String get MEMBER_GUEST {
    return Intl.message(
      'Guest',
      name: 'MEMBER_GUEST',
      desc: '',
      args: [],
    );
  }

  /// `Search user...`
  String get SEARCH_USER_HINT {
    return Intl.message(
      'Search user...',
      name: 'SEARCH_USER_HINT',
      desc: '',
      args: [],
    );
  }

  /// `Please search...`
  String get PLZ_SEARCH {
    return Intl.message(
      'Please search...',
      name: 'PLZ_SEARCH',
      desc: '',
      args: [],
    );
  }

  /// `No data exists.`
  String get NO_DATA {
    return Intl.message(
      'No data exists.',
      name: 'NO_DATA',
      desc: '',
      args: [],
    );
  }

  /// `Leave`
  String get LEAVE {
    return Intl.message(
      'Leave',
      name: 'LEAVE',
      desc: '',
      args: [],
    );
  }

  /// `You should transfer ownership before leaving your ledger.`
  String get SHOULD_TRANSFER_OWNERSHIP {
    return Intl.message(
      'You should transfer ownership before leaving your ledger.',
      name: 'SHOULD_TRANSFER_OWNERSHIP',
      desc: '',
      args: [],
    );
  }

  /// `Isn't the member you're looking for a Wecount user?`
  String get NO_WECOUNT_USER {
    return Intl.message(
      'Isn\'t the member you\'re looking for a Wecount user?',
      name: 'NO_WECOUNT_USER',
      desc: '',
      args: [],
    );
  }

  /// `Invite`
  String get INVITE {
    return Intl.message(
      'Invite',
      name: 'INVITE',
      desc: '',
      args: [],
    );
  }

  /// `This member has already been added.`
  String get ALREADY_MEMBER_WARNING {
    return Intl.message(
      'This member has already been added.',
      name: 'ALREADY_MEMBER_WARNING',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ko'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
