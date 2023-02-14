import 'package:flutter/material.dart';
import 'package:shopapp/widgets/main_drawer.dart';
class FiltersScreen extends StatefulWidget {
 static const routeName = '/filters';
  final Function saveFilters;
  final Map<String , bool> currentFilters;
 FiltersScreen(this.currentFilters,this.saveFilters);
  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _glutenFree = false;
  bool _vegetarian = false;
  bool _vegan = false; 
  bool _lactoseFree = false;
  @override
  initState(){
   _glutenFree = widget.currentFilters['gluten'] ?? false;
    _lactoseFree = widget.currentFilters['lactose'] ?? false;
    _vegetarian = widget.currentFilters['vegetarian'] ?? false;
    _vegan = widget.currentFilters['vegan'] ?? false;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Filters!'),
        actions: [
          IconButton(icon: Icon(Icons.save),
          onPressed: (() {
            final selectedFilters = {
              'gluten': _glutenFree,
              'lactose': _lactoseFree,
              'vegan': _vegan,
              'vegetarian': _vegetarian,
            };
            widget.saveFilters(selectedFilters);
          }
          ),
      )],
      ),
      drawer: MainDrawer(),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Text('Adjust your meal selection.',
            style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Expanded(child: ListView(
            children: [
               SwitchListTile(value: _glutenFree,
              title: Text('Gluten-Free'),
              subtitle: Text('Only include gluten-free Meals'),
               onChanged: (newValue){
              setState(() {
                _glutenFree = newValue;
              },
              );}),
                SwitchListTile(value: _lactoseFree,
              title: Text('Lactose-Free'),
              subtitle: Text('Only include lactose-free Meals'),
               onChanged: (newValue){
              setState(() {
                _lactoseFree = newValue;
              },
              );}),
                SwitchListTile(value: _vegetarian,
              title: Text('vegetarian'),
              subtitle: Text('Only include Veg Meals'),
               onChanged: (newValue){
              setState(() {
                _vegetarian = newValue;
              },
              );}),
                SwitchListTile(value: _vegan,
              title: Text('Vegan'),
              subtitle: Text('Only include Vegan Meals'),
               onChanged: (newValue){
              setState(() {
                _vegan = newValue;
              },
              );}),
            ],
          ))
        ],
      ),
    );
  }
}