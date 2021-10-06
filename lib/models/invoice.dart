import 'package:hive/hive.dart';
part 'invoice.g.dart';

@HiveType(typeId: 1)
class Invoice extends HiveObject {
  @HiveField(0)
  late String username;
  @HiveField(1)
  late String dateTime;
  @HiveField(2)
  late String productName;
  @HiveField(3)
  late int quantity;
  @HiveField(4)
  late double profit;
}
