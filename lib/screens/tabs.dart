import 'package:flutter/material.dart';
import 'package:meal_apps/screens/categories.dart';
import 'package:meal_apps/screens/meals.dart';

import '../models/meal.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;
  final List<Meal> _favoriteMeals = [];
  var _activePageTitle = "Categories";

  void _showInfoMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  void _toggleMealFavoriteStatus(Meal meal) {
    final isExisting = _favoriteMeals.contains(meal);
    if (isExisting) {
      setState(() {
        _favoriteMeals.remove(meal);
      });
      _showInfoMessage("Meal is no longer a favorite");
    } else {
      setState(() {
        _favoriteMeals.add(meal);
      });
      _showInfoMessage("Marked as a favorite");
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
    Widget activePage = CategoriesScreen(
      onToggleFavorite: _toggleMealFavoriteStatus,
    );
    if (_selectedPageIndex == 1) {
      activePage = MealsScreen(
        meals: _favoriteMeals,
        onToggleFavorite: _toggleMealFavoriteStatus,
      );
    }
    return Scaffold(
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
