//
//  NSManagedObjectSerialize.m
//  Cider
//
//  Created by Katsuyoshi Ito on 10/07/21.
//  Copyright 2010 ITO SOFT DESIGN Inc. All rights reserved.
//

/* 

  Copyright 2010 ITO SOFT DESIGN Inc. All rights reserved.

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

#import "NSManagedObjectSerialize.h"
#import "NSManagedObjectList.h"
#import "NSSortDescriptorExtension.h"



@interface NSManagedObject(ISSerialize_private)
- (NSArray *)ISSerialize_serializeKeysWithshallowInfo:(BOOL)shallow;
- (id)ISSerialize_parseObject:(id)object shallowInfo:(BOOL)shallow objectHolder:(NSMutableSet *)objectHolder;
- (NSDictionary *)ISSerialize_serializableDictionaryWithShallowInfo:(BOOL)shallow objectHolder:(NSMutableSet *)objectHolder;
@end


@implementation NSManagedObject(ISSerialize)

#pragma mark -
#pragma mark private

- (NSArray *)ISSerialize_serializeKeysWithshallowInfo:(BOOL)shallow
{
    NSMutableArray *array = [NSMutableArray array];
    NSEntityDescription *entity = [self entity];
    for (NSPropertyDescription *property in entity.properties) {
        if (shallow == NO || [property isKindOfClass:[NSRelationshipDescription class]] == NO) {
            [array addObject:property.name];
        }
    }
    return array;
}

- (id)ISSerialize_parseObject:(id)object shallowInfo:(BOOL)shallow objectHolder:(NSMutableSet *)objectHolder
{
    if ([object isKindOfClass:[NSString class]] ||
        [object isKindOfClass:[NSNumber class]]     ) {
        return object;
    } else
    if ([object isKindOfClass:[NSDate class]]) {
        NSDateFormatter *dateFormatter = [self dateFormatterForSerialization];
        return [dateFormatter stringFromDate:object];
    } else
    if ([object isKindOfClass:[NSMutableSet class]]) {
        NSMutableArray *array = [NSMutableArray array];
        NSArray *objects = [object allObjects];
        for (id object2 in objects) {
            if ([objectHolder containsObject:object2] == NO) {
                [objectHolder addObject:object2];
                id object3 = [object2 ISSerialize_serializableDictionaryWithShallowInfo:shallow objectHolder:objectHolder];
                if (object3) {
                    [array addObject:object3];
                }
            }
        }
        return array;
    } else {
        if ([objectHolder containsObject:object] == NO) {
            if ([object respondsToSelector:@selector(ISSerialize_serializableDictionaryWithShallowInfo:objectHolder:)]) {
                [objectHolder addObject:object];
                return [object ISSerialize_serializableDictionaryWithShallowInfo:shallow objectHolder:objectHolder];
            } else {
                NSLog(@"WARN: %@ does not supprt %@", object, NSStringFromSelector(@selector(serializabeDictionaryWithShallowInfo:)));
            }
        }
    }
    return nil;
}

- (NSDictionary *)ISSerialize_serializableDictionaryWithShallowInfo:(BOOL)shallow objectHolder:(NSMutableSet *)objectHolder
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    if (objectHolder == nil) {
        objectHolder = [NSMutableSet set];
    }
    
    [objectHolder addObject:self];
    for (NSString *key in [self ISSerialize_serializeKeysWithshallowInfo:shallow]) {
        id object = [self ISSerialize_parseObject:[self valueForKey:key] shallowInfo:shallow objectHolder:objectHolder];
        if (object) {
NSLog(@"key = %@; object = %@", key, object);
            [dict setValue:object forKey:key];
        }
    }
    return dict;
}

#pragma mark -
#pragma mark public

- (NSDictionary *)serializableDictionaryWithShallowInfo:(BOOL)shallow
{
    return [self ISSerialize_serializableDictionaryWithShallowInfo:shallow objectHolder:nil];
}

- (NSDictionary *)serializableDictionary
{
    return [self serializableDictionaryWithShallowInfo:YES];
}

+ (NSDateFormatter *)dateFormatterForSerialization
{
    NSDateFormatter *formatter = [[NSDateFormatter new] autorelease];
    [formatter setLocale:[NSLocale currentLocale]];
    [formatter setTimeStyle:NSDateFormatterMediumStyle];
    [formatter setDateStyle:NSDateFormatterMediumStyle];

    return formatter;
}

- (NSDateFormatter *)dateFormatterForSerialization
{
    return [[self class] dateFormatterForSerialization];
}





@end
