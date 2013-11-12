//
//  SMXObject.m
//  SMXObject
//
//  Created by Simon Maddox on 29/05/2012.
//  Copyright (c) 2012 The Lab, Telefonica UK Ltd. All rights reserved.
//
//  @iamleeg wrote all of the objc runtime stuff. Thanks, Graham.
//

#import "SMXObject.h"
#import <objc/runtime.h>

@implementation SMXObject

#pragma mark - NSCoding

- (void) encodeWithCoder:(NSCoder *)aCoder
{
    [[self class] SMX_enumeratePropertiesOfObject:self block:^(NSString *propertyName) {
        id value = [self valueForKey:propertyName];
        
		if ([self respondsToSelector:@selector(encodeValue:forProperty:)]){
			value = [self encodeValue:value forProperty:propertyName];
		} else if ([value conformsToProtocol:@protocol(NSCoding)]){
			value = [self valueForKey:propertyName];
		}
		
		if (value){
			[aCoder encodeObject:value forKey:propertyName];
		}
    }];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    id object = [[[self class] alloc] init];
    
    [[object class] SMX_enumeratePropertiesOfObject:object block:^(NSString *propertyName) {
        if ([aDecoder containsValueForKey:propertyName]){
			id value = [aDecoder decodeObjectForKey:propertyName];
			
			if ([object respondsToSelector:@selector(decodeValue:forProperty:)]){
				value = [object decodeValue:value forProperty:propertyName];
			}
			
			[object setValue:value forKey:propertyName];
		}
    }];
    
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

#pragma mark - NSCopying

- (id)copyWithZone:(NSZone *)zone
{
    id copiedObject = [[self class] allocWithZone:zone];
    
    [[copiedObject class] SMX_enumeratePropertiesOfObject:copiedObject block:^(NSString *propertyName) {
        id value = [self valueForKey:propertyName];
        [copiedObject setValue:value forKey:propertyName];
    }];
    
    return copiedObject;
}

#pragma mark -

+ (void) SMX_enumeratePropertiesOfObject:(id)object block:(void (^)(NSString *propertyName))block
{
    unsigned int countOfProperties;
    objc_property_t *properties = class_copyPropertyList([object class], &countOfProperties);
    if (!properties) return;
    
    for (unsigned int i = 0; i < countOfProperties; i++) {
        objc_property_t property = properties[i];
        NSString *propertyName = [NSString stringWithUTF8String:property_getName(property)];
        
        block(propertyName);
    }
    
    free(properties);
}

@end
