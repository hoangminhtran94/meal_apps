import 'package:flutter/material.dart';
import 'package:meal_apps/widgets/meal_item.dart';

import '../models/meal.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({super.key, required this.title, required this.meals});
  final String title;
  final List<Meal> meals;

  @override
  Widget build(BuildContext context) {
    Widget body = Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Uh oh, ... nothing here!",
            style: Theme.of(context)
                .textTheme
                .headlineLarge!
                .copyWith(color: Theme.of(context).colorScheme.onBackground),
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            "Try select a different category!",
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: Theme.of(context).colorScheme.onBackground),
          ),
        ],
      ),
    );

    if (meals.isNotEmpty) {
      body = ListView.builder(
          itemCount: meals.length,
          itemBuilder: (ctx, index) => MealItem(meal: meals[index]));
    }
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: body);
  }
}
