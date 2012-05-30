//
//  SMXObject.h
//  SMXObject
//
//  Created by Simon Maddox on 29/05/2012.
//  Copyright (c) 2012 The Lab, Telefonica UK Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SMXObject : NSObject <NSCoding>

+ (id) objectFromArchive:(NSData *)archive;
- (NSData *) archivedObject;

@end