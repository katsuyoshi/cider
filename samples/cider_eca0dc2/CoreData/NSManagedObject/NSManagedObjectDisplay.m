//
//  NSManagedObjectDisplay.m
//  CiderTest
//
//  Created by Katsuyoshi Ito on 09/09/24.
//

/* 

  Copyright 2009 ITO SOFT DESIGN Inc. All rights reserved.

  Redistribution and use in source and binary forms, with or without modification,
  are permitted provided that the following conditions are met:
  
      * Redistributions of source code must retain the above copyright notice,
        this list of conditions and the following disclaimer.
 
      * Redistributions in binary form must reproduce the above copyright notice,
        this list of conditions and the following disclaimer in the documentation
        and/or other materials provided with the distribution.
 
      * Neither the name of ITO SOFT DESIGN Inc. nor the names of its
        contributors may be used to endorse or promote products derived from this
        software without specific prior written permission.
 
  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
  DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR
  ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
  ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

*/

#import "NSManagedObjectDisplay.h"
#import "NSDateFormatterPatches.h"


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
                NSDateFormatter *formatter = [NSDateFormatter dateFormatterWithCurrentLocale];
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
