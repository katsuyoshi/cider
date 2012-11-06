//
//  NSErrorCoreDataExtension.m
//  CiderTest
//
//  Created by Katsuyoshi Ito on 09/08/01.
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

#import "NSErrorCoreDataExtension.h"
#import "NSErrorExtension.h"


NSString *const CiderErrorDomain = @"CiderErrorDomain";


@implementation NSError(ISCoreDataExtension)

+ (id)errorWithDomain:(NSString *)domain code:(NSInteger)code description:(NSString *)description
{
    NSDictionary *userInfo = [NSDictionary dictionaryWithObject:description forKey:NSLocalizedDescriptionKey];
    return [NSError errorWithDomain:domain code:code userInfo:userInfo];
}

- (NSError *)errorForDomain:(NSString *)domain
{
    if ([[self domain] isEqualToString:domain]) {
        return self;
    }
    for (NSError *anError in [[self userInfo] valueForKey:NSDetailedErrorsKey]) {
        if ([[anError domain] isEqualToString:domain]) {
            return anError;
        } else {
            NSError *anError2 = [anError errorForDomain:domain];
            if (anError2) {
                return anError2;
            }
        }
    }
    return nil;
}

- (NSError *)errorForDomains:(NSArray *)domains
{
    for (NSString *domain in domains) {
        NSError *error = [self errorForDomain:domain];
        if (error) {
            return error;
        }
    }
    return nil;
}

- (NSError *)errorForUserDomains
{
    if ([[self domain] isEqualToString:NSCocoaErrorDomain] == NO) {
        return self;
    }
    for (NSError *anError in [[self userInfo] valueForKey:NSDetailedErrorsKey]) {
        if ([[anError domain] isEqualToString:NSCocoaErrorDomain] == NO) {
            return anError;
        } else {
            NSError *anError2 = [anError errorForUserDomains];
            if (anError2) {
                return anError2;
            }
        }
    }
    return nil;
}


#if TARGET_OS_IPHONE
- (UIAlertView *)showErrorForDomain:(NSString *)domain;
{
    NSError *error = [self errorForDomain:domain];
    if (error) {
        return [error showError];
    } else {
        return [self showError];
    }
}

- (UIAlertView *)showErrorForDomains:(NSArray *)domains
{
    for (NSString *domain in domains) {
        NSError *error = [self errorForDomain:domain];
        if (error) {
            return [error showError];
        }
    }
    return [self showError];
}

- (UIAlertView *)showErrorForUserDomains
{
    NSError *error = [self errorForUserDomains];
    if (error) {
        return [error showError];
    } else {
        return [self showError];
    }
}
#endif

@end
