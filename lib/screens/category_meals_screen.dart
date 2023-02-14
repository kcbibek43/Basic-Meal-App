import 'package:flutter/material.dart';

import '../widgets/meal_item.dart';
import '../models/meal.dart';

class CategoryMealsScreen extends StatelessWidget {
//  final String categoryId;
//  final String categoryTitle;
//  CategoryMealsScreen(this.categoryId,this.categoryTitle);
final List<Meal> availableMeals;
   CategoryMealsScreen(this.availableMeals);
  static const routeName = '/category-meal';
  @override
  Widget build(BuildContext context) {
    final routeArg = ModalRoute.of(context)!.settings.arguments as Map<String,String>;
    final categoryTitle = routeArg['title'];
        final categoryId = routeArg['id'];
    final categoryMeals = availableMeals.where((meal) => (meal.categories.contains(categoryId))).toList();
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle!),
      ),
body: ListView.builder(itemBuilder: (ctx,index){
return MealItem(
  id: categoryMeals[index].id,
  title: categoryMeals[index].title,
  imageUrl: categoryMeals[index].imageUrl,
  duration: categoryMeals[index].duration,
  affordability: categoryMeals[index].affordability,
  complexity: categoryMeals[index].complexity,
  );
},
itemCount: categoryMeals.length,),
    );
  }
}