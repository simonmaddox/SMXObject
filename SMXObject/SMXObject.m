//
//  SMXObject.m
//  SMXObject
//
//  Created by Simon Maddox on 29/05/2012.
//  Copyright (c) 2012 The Lab, Telefonica UK Ltd. All rights reserved.
//

#import "SMXObject.h"
#import <objc/runtime.h>

static NSArray *_smxObjectAllowedTypes;

@implementation SMXObject

+ (void) initialize
{
    _smxObjectAllowedTypes = [NSArray arrayWithObjects:@"NSString", 
                              @"NSDictionary",
                              @"NSArray",
                              @"NSData",
                              @"NSDate",
                              @"NSNumber",
                              nil];
    
    [super initialize];
}

- (void) encodeWithCoder:(NSCoder *)aCoder
{
    unsigned int countOfProperties;
    objc_property_t *properties = class_copyPropertyList(self.class, &countOfProperties);
    if (!properties) return;
    
    for (unsigned int i = 0; i < countOfProperties; i++) {
        objc_property_t property = properties[i];
        NSString *propertyName = [NSString stringWithUTF8String:property_getName(property)];
                
        NSString *attributes = [NSString stringWithUTF8String:property_getAttributes(property)];
        
        id value = nil;
        for (NSString *type in _smxObjectAllowedTypes){
            if ([attributes rangeOfString:type].length > 0){
                value = [self valueForKey:propertyName];
                break;
            }
        }
        
        if (!value){
            value = [self plistCompatibleObjectForKey:propertyName];
        }
        
        if (value){
            [aCoder encodeObject:value forKey:propertyName];
        }
    }
    
    free(properties);
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    id object = [[[self class] alloc] init];
    
    unsigned int countOfProperties;
    objc_property_t *properties = class_copyPropertyList(self.class, &countOfProperties);
    if (!properties) return object;
    
    for (unsigned int i = 0; i < countOfProperties; i++) {
        objc_property_t property = properties[i];
        NSString *propertyName = [NSString stringWithUTF8String:property_getName(property)];
        
        NSString *attributes = [NSString stringWithUTF8String:property_getAttributes(property)];
        id value = nil;
        
        for (NSString *type in _smxObjectAllowedTypes){
            if ([attributes rangeOfString:type].length > 0){
                value = [aDecoder decodeObjectForKey:propertyName];
                break;
            }
        }
        
        if (!value){
            value = [self.class objectForPlistCompatibleKey:propertyName value:[aDecoder decodeObjectForKey:propertyName]];
        }
        
        if (value){
            [object setValue:value forKey:propertyName];
        }
    }
    
    free(properties);
    
    
    return object;
}

+ (id) objectFromArchive:(NSData *)archive
{
    return [NSKeyedUnarchiver unarchiveObjectWithData:archive];
}

- (NSData *) archivedObject
{
    return [NSKeyedArchiver archivedDataWithRootObject:self];
}

@end
