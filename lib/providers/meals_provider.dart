import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:meal_apps/models/category.dart";

final mealsProvider = Provider((ref) {
  return dummyMeals;
});
