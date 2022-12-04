import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wecount/models/user_model.dart';
import 'package:wecount/utils/firebase_config.dart';
import 'package:wecount/utils/general.dart';
import 'package:wecount/utils/logger.dart';

abstract class IUserRepository {
  Future<UserModel?> getMe();
  Future<UserModel?> getOne(String uid);
  Future<List<UserModel?>> getMany(String ledgerId);
}

class UserRepository implements IUserRepository {
  static final UserRepository instance = UserRepository();
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  @override
  Future<UserModel?> getMe() async {
    var user = General.instance.checkAuth();

    var snap = await FirestoreConfig.userColRef.doc(user.uid).get();

    if (!snap.exists) return null;
    return UserModel.fromJson(snap.data() ?? {});
  }

  @override
  Future<UserModel?> getOne(String uid) async {
    DocumentReference<UserModel> doc =
        FirestoreConfig.userColRef.doc(uid).withConverter<UserModel>(
              fromFirestore: (snapshot, _) =>
                  UserModel.fromJson(snapshot.data() ?? {}),
              toFirestore: (company, _) => company.toJson(),
            );

    var snap = await doc.get();

    if (!snap.exists) null;
    return snap.data();
  }

  @override
  Future<List<UserModel?>> getMany(String ledgerId) async {
    var snap = await FirestoreConfig.ledgerColRef.doc(ledgerId).get();
    List<dynamic> members = snap.data()!['members'];
    List<dynamic> users = [];

    return Future.wait(
      members.map(
        (e) async {
          var query =
              FirestoreConfig.userColRef.doc(e).withConverter<UserModel>(
                    fromFirestore: (snapshot, _) =>
                        UserModel.fromJson(snapshot.data() ?? {}),
                    toFirestore: (user, _) => user.toJson(),
                  );
          var userSnap = await query.get();
          return userSnap.data();
        },
      ),
    );
  }
}
