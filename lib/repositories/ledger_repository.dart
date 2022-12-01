import 'package:wecount/models/ledger_item.dart';
import 'package:wecount/models/user_model.dart';

abstract class ILedgerRepository {
  Future<List<LedgerItem>> getMany({
    double? price,
    Category? category,
    String? memo,
    UserModel? writer,
    DateTime? selectedDate,
    List<Photo>? picture,
    String? latlng,
    String? address,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
  });
}

class LedgerRepository implements ILedgerRepository {
  static final LedgerRepository instance = LedgerRepository();

  @override
  Future<List<LedgerItem>> getMany({
    double? price,
    Category? category,
    String? memo,
    UserModel? writer,
    DateTime? selectedDate,
    List<Photo>? picture,
    String? latlng,
    String? address,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
  }) async {
    return Future.delayed(Duration.zero);
  }
}
