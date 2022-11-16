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

final routes = {
  AuthSwitch.name: (context) => AuthSwitch(),
  Splash.name: (context) => Splash(),
  Tutorial.name: (context) => Tutorial(),
  Intro.name: (context) => Intro(),
  SignIn.name: (context) => SignIn(),
  SignUp.name: (context) => SignUp(),
  FindPw.name: (context) => FindPw(),
  MainEmpty.name: (context) => MainEmpty(),
  HomeTab.name: (context) => HomeTab(),
  Ledgers.name: (context) => Ledgers(),
  Terms.name: (context) => Terms(),
  ProfileMy.name: (context) => ProfileMy(),
  Setting.name: (context) => Setting(),
  SettingAnnouncement.name: (context) => SettingAnnouncement(),
  SettingOpinion.name: (context) => SettingOpinion(),
  SettingFAQ.name: (context) => SettingFAQ(),
  SettingNotification.name: (context) => SettingNotification(),
  LedgerItemEdit.name: (context) => LedgerItemEdit(),
  SettingExcel.name: (context) => SettingExcel(),
  LockRegister.name: (context) => LockRegister(),
  LockAuth.name: (context) => LockAuth(),
  LocationView.name: (context) => LocationView()
};

MaterialPageRoute onGenerateRoute(RouteSettings settings) {
  // If you push the PassArguments route
  if (settings.name == PhotoDetail.name) {
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

  if (settings.name == LineGraph.name) {
    final LineGraphArguments args = settings.arguments as LineGraphArguments;

    return MaterialPageRoute(builder: (context) {
      return LineGraph(
        title: args.title,
        year: args.year,
        price: args.price!,
      );
    });
  }

  if (settings.name == Members.name) {
    final MembersArguments args = settings.arguments as MembersArguments;

    return MaterialPageRoute(builder: (context) {
      return Members(
        ledger: args.ledger,
      );
    });
  }

  if (settings.name == SettingCurrency.name) {
    final SettingCurrencyArguments args =
        settings.arguments as SettingCurrencyArguments;

    return MaterialPageRoute(builder: (context) {
      return SettingCurrency(
        selectedCurrency: args.selectedCurrency,
        title: args.title,
      );
    });
  }

  if (settings.name == ProfilePeer.name) {
    final ProfilePeerArguments args =
        settings.arguments as ProfilePeerArguments;

    return MaterialPageRoute(builder: (context) {
      return ProfilePeer(
        user: args.user,
      );
    });
  }

  if (settings.name == LedgerView.name) {
    final LedgerViewArguments args = settings.arguments as LedgerViewArguments;

    return MaterialPageRoute(builder: (context) {
      return LedgerView(
        ledger: args.ledger,
      );
    });
  }

  if (settings.name == LedgerEdit.name) {
    if (settings.arguments == null) {
      return MaterialPageRoute(builder: (context) {
        return LedgerEdit();
      });
    } else {
      final LedgerEditArguments args =
          settings.arguments as LedgerEditArguments;

      return MaterialPageRoute(builder: (context) {
        return LedgerEdit(
          ledger: args.ledger,
          mode: args.mode,
        );
      });
    }
  }

  throw 'Route not found: ${settings.name}';
}
