//
//  NSNotificationCenterExtension.m
//  Cider
//
//  Created by Katsuyoshi Ito on 09/11/27.

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

#import "NSNotificationCenterExtension.h"


@implementation NSNotificationCenter(ISExtensionOnMainThread)


- (void)IS_postNotificationOnMainThreadArgs:(NSDictionary *)args
{
    NSNotification *notification = [args valueForKey:@"notification"];
    if (notification) {
        [self postNotification:notification];
        return;
    }
    
    NSString *name = [args valueForKey:@"notificationName"];
    NSDictionary *userInfo = [args valueForKey:@"userInfo"];
    id object = [args valueForKey:@"object"];
    [self postNotificationName:name object:object userInfo:userInfo];
}


- (void)postNotificationOnMainThread:(NSNotification *)notification
{
    NSDictionary *args = [NSDictionary dictionaryWithObjectsAndKeys:notification, @"notification", nil];
    [self performSelectorOnMainThread:@selector(IS_postNotificationOnMainThreadArgs:) withObject:args waitUntilDone:YES];
}

- (void)postNotificationNameOnMainThread:(NSString *)notificationName object:(id)notificationSender
{
    NSDictionary *args = [NSDictionary dictionaryWithObjectsAndKeys:notificationName, @"notificationName", notificationSender, @"object", nil];
    [self performSelectorOnMainThread:@selector(IS_postNotificationOnMainThreadArgs:) withObject:args waitUntilDone:YES];
}

- (void)postNotificationNameOnMainThread:(NSString *)notificationName object:(id)notificationSender userInfo:(NSDictionary *)userInfo
{
    NSDictionary *args = [NSDictionary dictionaryWithObjectsAndKeys:notificationName, @"notificationName", notificationSender, @"object", userInfo, @"userInfo", nil];
    [self performSelectorOnMainThread:@selector(IS_postNotificationOnMainThreadArgs:) withObject:args waitUntilDone:YES];
}


@end
