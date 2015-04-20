//
//  FSServing.m
//  Tracker
//
//  Created by Parker Wightman on 11/27/12.
//  Copyright (c) 2012 Mysterious Trousers. All rights reserved.
//

#import "FSServing.h"
#import "NSString+Camelize.h"

@implementation FSServing

- (id) initWithJSON:(NSDictionary *)json {
    self = [super init];

    if (self) {
        for (NSString *key in json) {
            id value = [json objectForKey:key];
            [self setValue:value forKey:[key camelize]];
        }
    }

    return self;
}

+ (id) servingWithJSON:(NSDictionary *)json {
    return [[self alloc] initWithJSON:json];
}

- (float) numberOfUnitsValue {
    return [_numberOfUnits floatValue];
}
- (float) metricServingAmountValue {
    return [_metricServingAmount floatValue];
}
- (NSInteger) servingIdValue {
    return [_servingId integerValue];
}



// Nutrient Info - Floats
- (float) caloriesValue {
    return [_calories floatValue];
}
- (float) carbohydrateValue {
    return [_carbohydrate floatValue];
}
- (float) proteinValue {
    return [_protein floatValue];
}
- (float) fatValue {
    return [_fat floatValue];
}
- (float) saturatedFatValue {
    return [_saturatedFat floatValue];
}
- (float) polyunsaturatedFatValue {
    return [_polyunsaturatedFat floatValue];
}
- (float) monounsaturatedFatValue {
    return [_monounsaturatedFat floatValue];
}
- (float) transFatValue {
    return [_transFat floatValue];
}
- (float) cholesterolValue {
    return [_cholesterol floatValue];
}
- (float) sodiumValue {
    return [_sodium floatValue];
}
- (float) potassiumValue {
    return [_potassium floatValue];
}
- (float) fiberValue {
    return [_fiber floatValue];
}
- (float) sugarValue {
    return [_sugar floatValue];
}



// Nutrient Info - Ints
- (NSInteger) vitaminCValue {
    return [_vitaminC integerValue];
}
- (NSInteger) vitaminAValue {
    return [_vitaminA integerValue];
}
- (NSInteger) calciumValue {
    return [_calcium integerValue];
}
- (NSInteger) ironValue {
    return [_iron integerValue];
}

@end
