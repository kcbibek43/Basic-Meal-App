import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../widgets/meal_item.dart';
import '';
class FavoritesScreen extends StatelessWidget {
  final List<Meal> favoritesMeals;
  FavoritesScreen(this.favoritesMeals);
  @override
  Widget build(BuildContext context) {
  if(favoritesMeals.isEmpty){
    return Center(
     child: Text('You have No favrites yet - Start adding Some !'));
  }
  else{
    return ListView.builder(itemBuilder: (ctx,index){
       return MealItem(
  id: favoritesMeals[index].id,
  title: favoritesMeals[index].title,
  imageUrl: favoritesMeals[index].imageUrl,
  duration: favoritesMeals[index].duration,
  affordability: favoritesMeals[index].affordability,
  complexity: favoritesMeals[index].complexity,
  );
},
itemCount: favoritesMeals.length,);
  }
  }
}