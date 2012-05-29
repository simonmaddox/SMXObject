//
//  MyObject.h
//  SMXObject
//
//  Created by Simon Maddox on 29/05/2012.
//  Copyright (c) 2012 The Lab, Telefonica UK Ltd. All rights reserved.
//

#import "SMXObject.h"

@interface MyObject : SMXObject

@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) NSDictionary *dictionary;
@property (nonatomic, strong) NSArray *array;
@property (nonatomic, strong) NSNumber *number;
@property (nonatomic, strong) UIImage *image;

@end
