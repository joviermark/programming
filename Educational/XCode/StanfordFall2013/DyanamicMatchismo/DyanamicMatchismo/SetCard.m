//
//  SetCard.m
//  Matchismo
//
//  Created by Ethan Petuchowski on 12/5/13.
//  Copyright (c) 2013 Ethan Petuchowski. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard

- (int)match:(NSArray *)otherCards
{
    int matchScore = 0;
    NSMutableSet *chosenShapes = [NSMutableSet setWithObject:self.shape];
    NSMutableSet *chosenColors = [NSMutableSet setWithObject:self.color];
    NSMutableSet *chosenFills  = [NSMutableSet setWithObject:self.fillType];
    for (SetCard *otherCard in otherCards) {
        [chosenShapes addObject:otherCard.shape];
        [chosenColors addObject:otherCard.color];
        [chosenFills addObject:otherCard.fillType];
    }
    
    if (([chosenShapes count] == 3 || [chosenShapes count] == 1) &&
        ([chosenColors count] == 3 || [chosenColors count] == 1) &&
        ([chosenFills count]  == 3 || [chosenFills count]  == 1))
    {
        matchScore = 1;
    }
    
    return matchScore;
}


+ (NSDictionary *)colorDict
{
    return @{@"Red": [UIColor redColor],
             @"Purple": [UIColor purpleColor],
             @"Green": [UIColor greenColor]};
}


+ (NSDictionary *)shapesDict
{
    return @{@"Squiggle": @"◼︎",
             @"Diamond": @"▲",
             @"Oval": @"☯"};
}


- (NSAttributedString *)attributedContents
{
    NSMutableDictionary *attributes =
        [@{NSForegroundColorAttributeName:[SetCard colorDict][self.color]} mutableCopy];
    
    if ([self.fillType  isEqualToString: @"Solid"]) {
        [attributes addEntriesFromDictionary:
         @{NSBackgroundColorAttributeName: [UIColor grayColor]}];
        
    } else if ([self.fillType  isEqualToString: @"Striped"]) {
        [attributes addEntriesFromDictionary:
         @{NSBackgroundColorAttributeName: [UIColor yellowColor]}];
    }
    
    return [[NSAttributedString alloc]
            initWithString:[SetCard shapesDict][self.shape] attributes:attributes];
}

- (NSString *)contents
{   // http://stackoverflow.com/questions/510269/how-do-i-concatenate-strings
    NSArray *stringArray = @[[self.color substringToIndex:1],
                             [self.fillType substringToIndex:1],
                             [SetCard shapesDict][self.shape],
                             @","];
    
    return [stringArray componentsJoinedByString:@""];
}

+ (NSArray *)validShapes
{
    return @[@"Oval", @"Diamond", @"Squiggle"];
}

+ (NSArray *)validColors
{
    return @[@"Red", @"Purple", @"Green"];
}

+ (NSArray *)validFillTypes
{
    return @[@"Solid", @"Striped", @"Unfilled"];
}

// must @synthesize properties if we provide both setter AND getter
@synthesize shape = _shape;

- (void)setShape:(NSString *)shape
{
    if ([[SetCard validShapes] containsObject:shape]) {
        _shape = shape;
    }
}

- (NSString *)shape
{
    return _shape ? _shape : @"?";
}

@end