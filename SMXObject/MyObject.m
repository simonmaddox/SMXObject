//
//  MyObject.m
//  SMXObject
//
//  Created by Simon Maddox on 29/05/2012.
//  Copyright (c) 2012 The Lab, Telefonica UK Ltd. All rights reserved.
//

#import "MyObject.h"

@implementation MyObject

@synthesize message, dictionary, array, number, image;

- (id) plistCompatibleObjectForKey:(NSString *)key
{
    if ([key isEqualToString:@"image"]){
        return UIImagePNGRepresentation(self.image);
    }
    
    return nil;
}

+ (id) objectForPlistCompatibleKey:(NSString *)key value:(id)value
{   
    if ([key isEqualToString:@"image"]){
        return [UIImage imageWithData:value];
    }
    
    return nil;
}

@end
