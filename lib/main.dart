import 'package:flutter/material.dart';
import 'package:shopapp/dummy_data.dart';
import 'package:shopapp/screens/categories_screen.dart';
import 'package:shopapp/screens/filters_screen.dart';
import 'package:shopapp/screens/meal_detail_screen.dart';
import 'package:shopapp/screens/tabs_screen.dart';
import 'screens/category_meals_screen.dart';
import './models/meal.dart';
void main () => runApp(MyApp());
class MyApp extends StatefulWidget {

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String,bool> _filters = {
  'gluten': false,
  'lactose': false,
  'vegan': false,
  'vegetarian': false,
  };
  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favoritesMeals = [];
  void _setFilter(Map<String,bool> filterData){
   setState(() {
     _filters = filterData;
     _availableMeals = DUMMY_MEALS.where((meal){
  if(_filters['gluten']! && !meal.isGlutenFree){
    return false;
  }
  if(_filters['lactose']! && !meal.isLactoseFree){
    return false;
  }
  if(_filters['vegetarian']! && !meal.isVegetarian){
    return false;
  }
  if(_filters['vegan']! && !meal.isVegan){
    return false;
  }
  return true;
   }).toList();
  }
   );
  }
  void _toggleFavorite(String mealId){
    final existingIndex = _favoritesMeals.indexWhere((meal) => meal.id == mealId);
    if(existingIndex>=0){
      setState(() {
        _favoritesMeals.removeAt(existingIndex);
      });
    }
    else{
      setState(() {
        _favoritesMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
      });
    }
  }
  bool _isMealFavorites(String id){
    return _favoritesMeals.any((meal) => meal.id == id);
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
       title:  'Daily Meals',
       theme:ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
            bodyText1: TextStyle(
              color: Color.fromRGBO(20, 51, 51, 1),
            ),
            bodyText2: TextStyle(
              color: Color.fromRGBO(20, 51, 51, 1),
            ),
            headline6: TextStyle(
              fontSize: 20,
              fontFamily: 'RobotoCondensed',
              fontWeight: FontWeight.bold,
            )),
      ),
//home: CategoriesScreen(),
     initialRoute: '/', // default is '/'
      routes: {
        '/': (ctx) => TabsScreen(_favoritesMeals),
        CategoryMealsScreen.routeName: (ctx) =>
            CategoryMealsScreen(_availableMeals),
        MealDetailScreen.routeName: (ctx) => MealDetailScreen(_toggleFavorite,_isMealFavorites),
        FiltersScreen.routeName: (ctx) => FiltersScreen(_filters,_setFilter),
      },
      onGenerateRoute: (settings) {
        print(settings.arguments);
        // if (settings.name == '/meal-detail') {
        //   return ...;
        // } else if (settings.name == '/something-else') {
        //   return ...;
        // }
        // return MaterialPageRoute(builder: (ctx) => CategoriesScreen(),);
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (ctx) => CategoriesScreen(),
        );
      },
    );
  }
}
