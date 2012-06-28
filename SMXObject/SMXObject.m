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

- (void) encodeWithCoder:(NSCoder *)aCoder
{
    unsigned int countOfProperties;
    objc_property_t *properties = class_copyPropertyList(self.class, &countOfProperties);
    if (!properties) return;
    
    for (unsigned int i = 0; i < countOfProperties; i++) {
        objc_property_t property = properties[i];
        NSString *propertyName = [NSString stringWithUTF8String:property_getName(property)];
        
        id value = [self valueForKey:propertyName];
        
		if ([self respondsToSelector:@selector(encodeValue:forProperty:)]){
			value = [self encodeValue:value forProperty:propertyName];
		} else if ([value conformsToProtocol:@protocol(NSCoding)]){
			value = [self valueForKey:propertyName];
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
        
		if ([aDecoder containsValueForKey:propertyName]){
			id value = [aDecoder decodeObjectForKey:propertyName];
			
			if ([object respondsToSelector:@selector(decodeValue:forProperty:)]){
				value = [self decodeValue:value forProperty:propertyName];
			}
			
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
