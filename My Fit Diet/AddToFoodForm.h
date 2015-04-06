//
//  AddToFoodForm.h
//  My Fit Diet
//
//  Created by Stephen Sowole on 04/04/2015.
//  Copyright (c) 2015 Stephen Sowole. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FXForms.h"

@interface AddToFoodForm : NSObject <FXForm>

// Serving Size
@property float servingSize;
@property bool foodAlreadyAdded;

@end
