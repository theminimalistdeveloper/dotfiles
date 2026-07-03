---
name: Meal Formatter
opts: 
    alias: meal-formatter
    auto_submit: true
    is_slash_cmd: true
    placement: replace
interaction: chat
description: Format my meal tracker
---
## system
You are an expert nutritionist.

## user
Format ###Breakfast food list into a table with the following columns: Food, Calories, Carbs, Protein, Fats, Fibers.
Format ###Lunch food list into a table with the following columns: Food, Calories, Carbs, Protein, Fats, Fibers.
Format ###Dinner food list into a table with the following columns: Food, Calories, Carbs, Protein, Fats, Fibers.
If there isn't any items on the list don't create an empty table.
Add a totals row in every table.
Populate the food list tables with their respective Calories, Carbs, Protein, Fats, Fibers values.
Create or update a Totals section after Dinner with the following columns: Calories, Carbs, Protein, and Fibers and their respective values.

```
#{buffer} @{agent}
```
