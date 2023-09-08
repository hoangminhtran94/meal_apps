import 'package:flutter/material.dart';
import 'package:meal_apps/providers/favorites_provider.dart';
import 'package:meal_apps/screens/categories.dart';
import 'package:meal_apps/screens/filters.dart';
import 'package:meal_apps/widgets/main_drawer.dart';
import "package:meal_apps/providers/meals_provider.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import '../providers/filters_provider.dart';
import 'meals.dart';

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedPageIndex = 0;
  var _activePageTitle = "Categories";

  void _setScreen(String identifier) {
    Navigator.of(context).pop();
    if (identifier == "filters") {
      Navigator.of(context).push<Map<Filter, bool>>(
          MaterialPageRoute(builder: (ctx) => const FiltersScreen()));
    }
  }

  void _selectPage(int index) {
    var currentPage = index == 1 ? "Your Favorites" : "All Categories";
    setState(() {
      _selectedPageIndex = index;
      _activePageTitle = currentPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    final meals = ref.watch(mealsProvider);
    final favoriteMeals = ref.watch(favoriteMealsProvider);
    final selectedFilters = ref.watch(filterProvider);
    final availableMeals = meals.where((meal) {
      if (selectedFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
        return false;
      }
      if (selectedFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
        return false;
      }
      if (selectedFilters[Filter.vegeterian]! && !meal.isVegetarian) {
        return false;
      }
      if (selectedFilters[Filter.vegan]! && !meal.isVegan) {
        return false;
      }
      return true;
    }).toList();
    Widget activePage = CategoriesScreen(
      availableMeals: availableMeals,
    );
    if (_selectedPageIndex == 1) {
      activePage = MealsScreen(
        meals: favoriteMeals,
      );
    }
    return Scaffold(
      drawer: MainDrawer(
        onSelectScreen: _setScreen,
      ),
      appBar: AppBar(
        title: Text(_activePageTitle),
      ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPageIndex,
        onTap: (index) {
          _selectPage(index);
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.set_meal), label: "Category"),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: "Favorite")
        ],
      ),
    );
  }
}
