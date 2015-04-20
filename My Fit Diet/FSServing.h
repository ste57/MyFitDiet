//
//  FSServing.h
//  Tracker
//
//  Created by Parker Wightman on 11/27/12.
//  Copyright (c) 2012 Mysterious Trousers. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FSServing : NSObject

- (id) initWithJSON:(NSDictionary *)json;
+ (id) servingWithJSON:(NSDictionary *)json;

@property (nonatomic, strong, readonly) NSString *servingDescription;
@property (nonatomic, strong, readonly) NSString *servingUrl;
@property (nonatomic, strong, readonly) NSString *metricServingUnit;
@property (nonatomic, strong, readonly) NSString *measurementDescription;
@property (nonatomic, strong, readonly) NSNumber *numberOfUnits;
@property (nonatomic, strong, readonly) NSNumber *metricServingAmount;
@property (nonatomic, strong, readonly) NSNumber *servingId;

// Decimals
@property (nonatomic, strong, readonly) NSNumber *calories;
@property (nonatomic, strong, readonly) NSNumber *carbohydrate;
@property (nonatomic, strong, readonly) NSNumber *protein;
@property (nonatomic, strong, readonly) NSNumber *fat;
@property (nonatomic, strong, readonly) NSNumber *saturatedFat;
@property (nonatomic, strong, readonly) NSNumber *polyunsaturatedFat;
@property (nonatomic, strong, readonly) NSNumber *monounsaturatedFat;
@property (nonatomic, strong, readonly) NSNumber *transFat;
@property (nonatomic, strong, readonly) NSNumber *cholesterol;
@property (nonatomic, strong, readonly) NSNumber *sodium;
@property (nonatomic, strong, readonly) NSNumber *potassium;
@property (nonatomic, strong, readonly) NSNumber *fiber;
@property (nonatomic, strong, readonly) NSNumber *sugar;

// Ints
@property (nonatomic, strong, readonly) NSNumber *vitaminC;
@property (nonatomic, strong, readonly) NSNumber *vitaminA;
@property (nonatomic, strong, readonly) NSNumber *calcium;
@property (nonatomic, strong, readonly) NSNumber *iron;

- (float) numberOfUnitsValue;
- (float) metricServingAmountValue;
- (NSInteger) servingIdValue;

// Nutrient Info
- (float) caloriesValue;
- (float) carbohydrateValue;
- (float) proteinValue;
- (float) fatValue;
- (float) saturatedFatValue;
- (float) polyunsaturatedFatValue;
- (float) monounsaturatedFatValue;
- (float) transFatValue;
- (float) cholesterolValue;
- (float) sodiumValue;
- (float) potassiumValue;
- (float) fiberValue;
- (float) sugarValue;
- (NSInteger) vitaminCValue;
- (NSInteger) vitaminAValue;
- (NSInteger) calciumValue;
- (NSInteger) ironValue;

@end
