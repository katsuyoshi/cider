//
//  ISEnvironment.h
//  irPanel
//
//  Created by Katsuyoshi Ito on 11/03/19.
//
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

#import <Foundation/Foundation.h>


@interface ISEnvironment : NSObject {
    
    BOOL ipod, iphone, ipad;

}

+ (ISEnvironment *)sharedEnvironment;

// hardware
@property (getter = isIPod, readonly) BOOL ipod;
@property (getter = isIPad, readonly) BOOL ipad;
@property (getter = isIPhone, readonly) BOOL iphone;


// OS
@property (readonly) BOOL isIOS3;
@property (readonly) BOOL isIOS4;
@property (readonly) BOOL isIOS5;

// application
@property (assign, readonly) NSString *bundleIdentifier;
@property (assign, readonly) NSString *bundleVersion;

- (BOOL)isVersion:(NSString *)version lessThan:(NSString *)baseVersion;
- (BOOL)isBundleVersionLessThan:(NSString *)version;


/**
 * Get current language which was set by Settings app.
 * @return language i.e) @"ja", @"en", ...
 */
@property (assign, readonly) NSString *currentLanguage;

@end
