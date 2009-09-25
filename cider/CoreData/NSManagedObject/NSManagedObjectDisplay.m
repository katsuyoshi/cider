//
//  NSManagedObjectDisplay.m
//  tandr
//
//  Created by Katsuyoshi Ito on 09/09/24.
//  Copyright 2009 ITO SOFT DESIGN Inc. All rights reserved.
//

#import "NSManagedObjectDisplay.h"


@implementation NSManagedObject(ISDisplay)

- (NSFormatter *)formatterForAttribute:(NSString *)attributeName
{
    NSAttributeDescription *description = [[[self entity] attributesByName] valueForKey:attributeName];
    if (description) {
        switch ([description attributeType]) {
        case NSInteger16AttributeType:
        case NSInteger32AttributeType:
        case NSInteger64AttributeType:
        case NSDecimalAttributeType:
        case NSDoubleAttributeType:
        case NSFloatAttributeType:
        case NSBooleanAttributeType:
            {
                NSNumberFormatter *formatter = [[NSNumberFormatter new] autorelease];
                [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
                return formatter;
            }
        
        case NSDateAttributeType:
            {
                NSDateFormatter *formatter = [[NSDateFormatter new] autorelease];
                [formatter setTimeStyle:NSDateFormatterMediumStyle];
                [formatter setDateStyle:NSDateFormatterMediumStyle];
                [formatter setLocale:[[[NSLocale alloc] initWithLocaleIdentifier:NSLocalizedString(@"LOCALE", nil)] autorelease]];
                return formatter;
            }
        }
    }
    return nil;
}

- (id)convertFromString:(NSString *)value attribute:(NSString *)attributeName
{
    id formatter = [self formatterForAttribute:attributeName];
    if (formatter) {
        if ([formatter isKindOfClass:[NSNumberFormatter class]]) {
            return [formatter numberFromString:value];
        }
        if ([formatter isKindOfClass:[NSDateFormatter class]]) {
            return [formatter dateFromString:value];
        }
    }
    
    return value;
}


@end
