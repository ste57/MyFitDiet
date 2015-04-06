//
//  Constants.h
//  My Fit Diet
//
//  Created by Stephen Sowole on 30/03/2015.
//  Copyright (c) 2015 Stephen Sowole. All rights reserved.
//

// Main

#define MAIN_FONT @"Primer"
#define MAIN_BACKGROUND_COLOUR [UIColor colorWithRed:39.0f/255.0f green:44.0f/255.0f blue:50.0f/255.0f alpha:1.0]

// Meal Occasions

#define BREAKFAST @"Breakfast"
#define LUNCH @"Lunch"
#define DINNER @"Dinner"
#define SNACK @"Snack"

// Menu Menu Stats Progress

#define STATS_ANIMATE_TIME 0.5
#define STATS_DELAY_ANIMATION_TIME 0.45

#define MENU_DATE_FORMAT @"EEE | dd MMMM yyyy"
#define DIARY_DATE_FORMAT @"EEEE dd MMMM yyyy"

#define TRACK_COLOUR [UIColor colorWithRed:61.0f/255.0f green:66.0f/255.0f blue:72.0f/255.0f alpha:1.0]

#define KCAL_BAR_COLOUR [UIColor colorWithRed:0.52 green:0.84 blue:0.57 alpha:1.0]
#define KCAL_TRACK_WIDTH 5.0f
#define KCAL_BAR_RADIUS 180.0f

#define FOOD_NUTRIENTS_PROGRESS_BAR_RADIUS 50.0f
#define FOOD_NUTRIENTS_TRACK_WIDTH 3.0f
#define FOOD_NUTRIENTS_HEIGHT_DIVIDE 1.52f

#define CARBS_COLOUR [UIColor colorWithRed:0.75 green:0.53 blue:0.84 alpha:1.0]
#define S_FATS_COLOUR [UIColor colorWithRed:0.49 green:0.73 blue:0.95 alpha:1.0]
#define FATS_COLOUR [UIColor colorWithRed:0.94 green:0.74 blue:0.45 alpha:1.0]
#define PROTEIN_COLOUR [UIColor colorWithRed:0.94 green:0.95 blue:0.49 alpha:1.0]

#define EXCEEDED_LIMIT_COLOUR [UIColor colorWithRed:0.99 green:0.61 blue:0.61 alpha:1.0]

// MenuStatsCollectionView

#define OPTIONS_VIEW_HEIGHT_DIVISION_FACTOR 2.8f
#define OPTIONS_BUTTON_WIDTH 50.0f
#define OPTIONS_BUTTON_HEIGHT 55.0f
#define OPTIONS_BUTTONS_SEPERATION_VALUE 4.2f

// Diary

#define CELL_PADDING 15.0

// NSUserDefaults

#define USER_OBJECT @"UserObject"

// NSNotifications

#define DIARY_BUTTON_NOTIFICATION @"DiaryNS"
#define PROFILE_BUTTON_NOTIFICATION @"ProfileNS"
#define PLAN_MEAL_BUTTON_NOTIFICATION @"PlanMealNS"
#define DISPLAY_FOOD_DETAILS @"DisplayDetailsNS"
#define DIARY_RELOAD_STATS @"DiaryReloadNS"
