//
//  NSErrorExtensionTest.m
//  CiderTest
//
//  Created by Katsuyoshi Ito on 09/08/01.
//  Copyright 2009 ITO SOFT DESIGN Inc. All rights reserved.
//

#import "NSErrorCoreDataExtensionTest.h"
#import "CiderCoreData.h"


@implementation NSErrorCoreDataExtensionTest

- (void)setUp
{
    [super setUp];
    
    NSMutableDictionary *userInfo  = [NSDictionary dictionaryWithObject:@"MyDomain domain error." forKey:NSLocalizedDescriptionKey];
    myDomainError = [[NSError errorWithDomain:@"MyDomain" code:1 userInfo:userInfo] retain];
    
    userInfo  = [NSMutableDictionary dictionaryWithObject:@"Cocoa domain error." forKey:NSLocalizedDescriptionKey];
    [userInfo setValue:[NSArray arrayWithObject:myDomainError] forKey:NSDetailedErrorsKey];
    error = [[NSError errorWithDomain:@"Coccoa" code:10000 userInfo:userInfo] retain];
	
    userInfo  = [NSMutableDictionary dictionaryWithObject:@"Cocoa domain error." forKey:NSLocalizedDescriptionKey];
    [userInfo setValue:[NSArray arrayWithObject:error] forKey:NSDetailedErrorsKey];
    deepError = [[NSError errorWithDomain:@"Coccoa" code:10000 userInfo:userInfo] retain];
}

- (NSNumber *)willTearDown
{
    [alertView dismissWithClickedButtonIndex:1 animated:NO];
    [alertView release];
    alertView = nil;
    return [NSNumber numberWithDouble:0.1];
}

- (void)tearDown
{
    [myDomainError release];
    [error release];
	[deepError release];
    [super tearDown];
}

- (void)dealloc
{
    [super dealloc];
}


#pragma mark -
#pragma mark Helpers


#pragma mark -
#pragma mark Tests

- (void)testErrorForDomain
{
    ASSERT_EQUAL(myDomainError, [error errorForDomain:@"MyDomain"]);
    ASSERT_EQUAL(myDomainError, [myDomainError errorForDomain:@"MyDomain"]);
    ASSERT_EQUAL(myDomainError, [deepError errorForDomain:@"MyDomain"]);
    
    ASSERT_NIL([error errorForDomain:@"OtherDomain"]);
    ASSERT_NIL([myDomainError errorForDomain:@"OtherDomain"]);
    ASSERT_NIL([deepError errorForDomain:@"OtherDomain"]);
}

- (void)testShowError
{
    alertView = [[error showError] retain];
    ASSERT_EQUAL_LOCALIZED_STRING_FROM_TABLE(@"Error!", @"cider", alertView.title);
    ASSERT_EQUAL(@"Cocoa domain error.", alertView.message);
}

- (void)testShowErrorForDomain
{
    alertView = [[error showErrorForDomain:@"MyDomain"] retain];
    ASSERT_EQUAL_LOCALIZED_STRING_FROM_TABLE(@"Error!", @"cider", alertView.title);
    ASSERT_EQUAL(@"MyDomain domain error.", alertView.message);
}

- (void)testShowErrorForDomainWithOtherDomain
{
    alertView = [[error showErrorForDomain:@"OtherDomain"] retain];
    ASSERT_EQUAL_LOCALIZED_STRING_FROM_TABLE(@"Error!", @"cider", alertView.title);
    ASSERT_EQUAL(@"Cocoa domain error.", alertView.message);
}

#pragma mark -
#pragma mark Option

// Uncomment it, if you want to test this class except other passed test classes.
//#define TESTS_ALWAYS
#ifdef TESTS_ALWAYS
- (void)testThisClassAlways { ASSERT_FAIL(@"fail always"); }
+ (BOOL)forceTestsAnyway { return YES; }
#endif

@end
