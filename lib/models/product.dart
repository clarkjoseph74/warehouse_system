import 'package:hive/hive.dart';
part 'product.g.dart';

@HiveType(typeId: 0)
class Product extends HiveObject {
  @HiveField(0)
  late String productName;
  @HiveField(1)
  late int quantity;
  @HiveField(2)
  late double sellPtice;
  @HiveField(3)
  late double buyPrice;
}
