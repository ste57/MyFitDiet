//
//  NutritionObject.h
//  My Fit Diet
//
//  Created by Stephen Sowole on 21/04/2015.
//  Copyright (c) 2015 Stephen Sowole. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FXForms.h"

@interface NutritionObject : NSObject <FXForm>

// Data Used For Statistics
@property float calories;
@property float totalFats;
@property float saturatedFats;
@property float totalCarbohydrates;
@property float protein;

@property int activityLevel;

@end
