import 'package:wecount/navigations/auth_switch.dart';
import 'package:wecount/navigations/home_tab.dart';
import 'package:wecount/screens/find_pw.dart';
import 'package:wecount/screens/intro.dart';
import 'package:wecount/screens/ledger_edit.dart';
import 'package:wecount/screens/ledger_item_edit.dart';
import 'package:wecount/screens/ledger_view.dart';
import 'package:wecount/screens/ledgers.dart';
import 'package:wecount/screens/line_graph.dart';
import 'package:wecount/screens/lock_auth.dart';
import 'package:wecount/screens/lock_register.dart';
import 'package:wecount/screens/main_empty.dart';
import 'package:wecount/screens/profile_my.dart';
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
  LedgerEdit.name: (context) => LedgerEdit(),
  LedgerView.name: (context) => LedgerView(),
  Terms.name: (context) => Terms(),
  ProfileMy.name: (context) => ProfileMy(),
  Setting.name: (context) => Setting(),
  SettingAnnouncement.name: (context) => SettingAnnouncement(),
  SettingOpinion.name: (context) => SettingOpinion(),
  SettingFAQ.name: (context) => SettingFAQ(),
  SettingNotification.name: (context) => SettingNotification(),
  LedgerItemEdit.name: (context) => LedgerItemEdit(),
  SettingCurrency.name: (context) => SettingCurrency(),
  SettingExcel.name: (context) => SettingExcel(),
  LockRegister.name: (context) => LockRegister(),
  LockAuth.name: (context) => LockAuth(),
  LineGraph.name: (context) => LineGraph(),
};
