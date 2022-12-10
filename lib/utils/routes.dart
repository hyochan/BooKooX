import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wecount/navigations/auth_switch.dart';
import 'package:wecount/navigations/home_tab.dart';
import 'package:wecount/screens/find_pw.dart';
import 'package:wecount/screens/intro.dart';
import 'package:wecount/screens/ledger_edit.dart';
import 'package:wecount/screens/ledger_item_edit.dart';
import 'package:wecount/screens/ledger_view.dart';
import 'package:wecount/screens/ledgers.dart';
import 'package:wecount/screens/line_graph.dart';
import 'package:wecount/screens/location_view.dart';
import 'package:wecount/screens/lock_auth.dart';
import 'package:wecount/screens/lock_register.dart';
import 'package:wecount/screens/main_empty.dart';
import 'package:wecount/screens/members.dart';
import 'package:wecount/screens/photo_detail.dart';
import 'package:wecount/screens/profile_my.dart';
import 'package:wecount/screens/profile_peer.dart';
import 'package:wecount/screens/setting.dart';
import 'package:wecount/screens/setting_announcement.dart';
import 'package:wecount/screens/setting_currency.dart';
import 'package:wecount/screens/setting_excel.dart';
import 'package:wecount/screens/setting_faq.dart';
import 'package:wecount/screens/setting_notification.dart';
import 'package:wecount/screens/setting_opinion.dart';
import 'package:wecount/screens/sign_in.dart';
import 'package:wecount/screens/sign_up.dart';
import 'package:wecount/screens/splash.dart';
import 'package:wecount/screens/terms.dart';
import 'package:wecount/screens/tutorial.dart';

enum AppRoute {
  authSwitch,
  splash,
  tutorial,
  intro,
  signIn,
  signUp,
  findPw,
  mainEmpty,
  homeTab,
  ledgers,
  terms,
  profileMy,
  setting,
  settingAnnouncement,
  settingOpinion,
  settingFAQ,
  settingNotification,
  ledgerItemEdit,
  settingExcel,
  lockRegister,
  lockAuth,
  locationView,
  photoDetail,
  lineGraph,
  members,
  settingCurrency,
  profilePeer,
  ledgerView,
  ledgerEdit,
}

extension RouteName on AppRoute {
  String get name => describeEnum(this);

  bool get isRoot => this == AppRoute.authSwitch;

  /// Convert to `lower-snake-case` format.
  String get path {
    if (isRoot) return '';

    RegExp exp = RegExp(r'(?<=[a-z])[A-Z]');
    String result = name
        .replaceAllMapped(exp, (Match m) => ('-${m.group(0)}'))
        .toLowerCase();
    return result;
  }

  /// Convert to `lower-snake-case` format with `/`.
  String get fullPath {
    if (isRoot) return '/';

    RegExp exp = RegExp(r'(?<=[a-z])[A-Z]');
    String result = name
        .replaceAllMapped(exp, (Match m) => ('-${m.group(0)}'))
        .toLowerCase();
    return '/$result';
  }
}

final routes = {
  AppRoute.authSwitch.fullPath: (context) => const AuthSwitch(),
  AppRoute.splash.fullPath: (context) => const Splash(),
  AppRoute.tutorial.fullPath: (context) => const Tutorial(),
  AppRoute.intro.fullPath: (context) => const Intro(),
  AppRoute.signIn.fullPath: (context) => const SignIn(),
  AppRoute.signUp.fullPath: (context) => const SignUp(),
  AppRoute.findPw.fullPath: (context) => const FindPw(),
  AppRoute.mainEmpty.fullPath: (context) => const MainEmpty(),
  AppRoute.homeTab.fullPath: (context) => const HomeTab(),
  AppRoute.ledgers.fullPath: (context) => const Ledgers(),
  AppRoute.terms.fullPath: (context) => const Terms(),
  AppRoute.profileMy.fullPath: (context) => const ProfileMy(),
  AppRoute.setting.fullPath: (context) => const Setting(),
  AppRoute.settingAnnouncement.fullPath: (context) =>
      const SettingAnnouncement(),
  AppRoute.settingOpinion.fullPath: (context) => const SettingOpinion(),
  AppRoute.settingFAQ.fullPath: (context) => const SettingFAQ(),
  AppRoute.settingNotification.fullPath: (context) =>
      const SettingNotification(),
  AppRoute.ledgerItemEdit.fullPath: (context) => const LedgerItemEdit(),
  AppRoute.settingExcel.fullPath: (context) => const SettingExcel(),
  AppRoute.lockRegister.fullPath: (context) => const LockRegister(),
  AppRoute.lockAuth.fullPath: (context) => const LockAuth(),
  AppRoute.locationView.fullPath: (context) => const LocationView(),
  AppRoute.ledgerEdit.fullPath: (context) => const LedgerEdit(),
  AppRoute.settingCurrency.fullPath: (context) => const SettingCurrency()
};

MaterialPageRoute onGenerateRoute(RouteSettings settings) {
  // If you push the PassArguments route
  if (settings.name == AppRoute.photoDetail.fullPath) {
    final PhotoDetailArguments args =
        settings.arguments as PhotoDetailArguments;

    return MaterialPageRoute(builder: (context) {
      return PhotoDetail(
        canShare: args.canShare,
        onPressDelete: args.onPressDelete,
        onPressDownload: args.onPressDownload,
        onPressShare: args.onPressShare,
        photo: args.photo,
        photoUrl: args.photoUrl,
      );
    });
  }

  if (settings.name == AppRoute.lineGraph.fullPath) {
    final LineGraphArguments args = settings.arguments as LineGraphArguments;

    return MaterialPageRoute(builder: (context) {
      return LineGraph(
        title: args.title,
        year: args.year,
        price: args.price!,
      );
    });
  }

  if (settings.name == AppRoute.members.fullPath) {
    final MembersArguments args = settings.arguments as MembersArguments;

    return MaterialPageRoute(builder: (context) {
      return Members(
        ledger: args.ledger,
      );
    });
  }

  if (settings.name == AppRoute.settingCurrency.fullPath) {
    final SettingCurrencyArguments args =
        settings.arguments as SettingCurrencyArguments;

    return MaterialPageRoute(builder: (context) {
      return SettingCurrency(
        selectedCurrency: args.selectedCurrency,
        title: args.title,
      );
    });
  }

  if (settings.name == AppRoute.profilePeer.fullPath) {
    final ProfilePeerArguments args =
        settings.arguments as ProfilePeerArguments;

    return MaterialPageRoute(builder: (context) {
      return ProfilePeer(
        user: args.user,
      );
    });
  }

  if (settings.name == AppRoute.ledgerView.fullPath) {
    final LedgerViewArguments args = settings.arguments as LedgerViewArguments;

    return MaterialPageRoute(builder: (context) {
      return LedgerView(
        ledger: args.ledger,
      );
    });
  }

  if (settings.name == AppRoute.ledgerEdit.fullPath) {
    final LedgerEditArguments args = settings.arguments as LedgerEditArguments;

    return MaterialPageRoute(builder: (context) {
      return LedgerEdit(
        ledger: args.ledger,
        mode: args.mode,
      );
    });
  }

  throw 'Route not found: ${settings.name}';
}
