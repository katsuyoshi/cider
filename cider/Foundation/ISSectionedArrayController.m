//
//  ISSectionedArrayController.m
//  iRubyKaigi
//
//  Created by Katsuyoshi Ito on 10/07/06.
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

#import "ISSectionedArrayController.h"


#pragma mark -
#pragma mark ISSectionHolder


@interface ISSectionHolder : NSObject
{
    id sectionObject;
    NSMutableArray *items;
}

- (id)initWithSectionObject:(id)object;

@property (retain, readonly) id sectionObject;
@property (retain, readonly) NSMutableArray *items;

@end

@implementation ISSectionHolder

@synthesize sectionObject;
@synthesize items;


+ (id)sectionHolderWithSectionObject:(id)object
{
    return [[[self alloc] initWithSectionObject:object] autorelease];
}

- (id)initWithSectionObject:(id)object
{
    self = [super init];
    if (self) {
        sectionObject = [object retain];
        items = [NSMutableArray new];
    }
    return self;
}

- (void)dealloc
{
    [items release];
    [sectionObject release];
    [super dealloc];
}

@end


#pragma mark -
#pragma mark ISSectionedArrayController


@implementation ISSectionedArrayController

@synthesize sectionTitleName;


- (id)initWithArray:(NSArray *)array sectionName:(NSString *)aSectionName sortDescriptors:(NSArray *)aSortDescriptors
{
    self = [super init];
    if (self) {
        sectionName = [aSectionName retain];
        originalDataSource = [array retain];
        sortDescriptors = [aSortDescriptors retain];
        [self reloadData];
    }
    return self;
}

- (id)initWithSet:(NSSet *)set sectionName:(NSString *)aSectionName sortDescriptors:(NSArray *)aSortDescriptors
{
    return [self initWithArray:[set allObjects] sectionName:aSectionName sortDescriptors:aSortDescriptors];
}

- (void)dealloc
{
    [sectionName release];
    [sectionTitleName release];
    [dataSource release];
    [sortDescriptors release];
    [originalDataSource release];
    [super dealloc];
}

- (void)reloadData
{
    NSArray *array = originalDataSource;
    if (sortDescriptors && [sortDescriptors count]) {
        array = [array sortedArrayUsingDescriptors:sortDescriptors];
    }
    
    [dataSource release];
    dataSource = [NSMutableArray new];
    
    
    ISSectionHolder *holder = nil;
    id sectionObject = nil;
    id preSectionObject = nil;
    for (id object in array) {
        sectionObject = [object valueForKey:sectionName];
        if ([preSectionObject isEqual:sectionObject] == NO) {
            preSectionObject = sectionObject;
            holder = [ISSectionHolder sectionHolderWithSectionObject:sectionObject];
            [dataSource addObject:holder];
        }
        [holder.items addObject:object];
    }         
}

#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [dataSource count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    ISSectionHolder *holder = [dataSource objectAtIndex:section];
    return [holder.items count];
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    ISSectionHolder *holder = [dataSource objectAtIndex:section];
    if ([sectionTitleName length]) {
        return [holder.sectionObject valueForKey:sectionTitleName];
    } else {
        return [holder.sectionObject description];
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 
    return nil;
}

- (id)objectAtIndexPath:(NSIndexPath *)indexPath
{
    ISSectionHolder *holder = [dataSource objectAtIndex:indexPath.section];
    return [holder.items objectAtIndex:indexPath.row];
}


@end
