import 'package:flutter/material.dart';
import 'package:meal_apps/models/meal.dart';
import 'package:transparent_image/transparent_image.dart';
import "package:meal_apps/widgets/meal_item_trait.dart";

class MealItem extends StatelessWidget {
  const MealItem({super.key, required this.meal, required this.onSelectMeal});
  final void Function() onSelectMeal;
  final Meal meal;
  String get complexityText {
    return meal.complexity.name[0].toUpperCase() +
        meal.complexity.name.substring(1);
  }

  String get affordabilityText {
    return meal.affordability.name[0].toUpperCase() +
        meal.affordability.name.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      clipBehavior: Clip.hardEdge,
      elevation: 2,
      child: InkWell(
        onTap: onSelectMeal,
        child: Stack(
          children: [
            Hero(
              tag: meal.id,
              child: FadeInImage(
                placeholder: MemoryImage(kTransparentImage),
                image: NetworkImage(meal.imageUrl),
                fit: BoxFit.cover,
                width: double.infinity,
                height: 200,
              ),
            ),
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  color: Colors.black54,
                  padding: const EdgeInsets.symmetric(
                    vertical: 6,
                    horizontal: 36,
                  ),
                  child: Column(children: [
                    Text(
                      meal.title,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      children: [
                        MealItemTrait(
                            icon: Icons.schedule,
                            label: '${meal.duration} min'),
                        const SizedBox(
                          width: 12,
                        ),
                        MealItemTrait(
                            icon: Icons.work, label: 'Level: $complexityText'),
                        const SizedBox(
                          width: 12,
                        ),
                        MealItemTrait(
                            icon: Icons.monetization_on,
                            label: ' $affordabilityText')
                      ],
                    ),
                  ]),
                ))
          ],
        ),
      ),
    );
  }
}
