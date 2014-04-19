//
//  DataManager.h
//  HW_TableImages
//
//  Created by Alexander on 19.04.14.
//  Copyright (c) 2014 Alexander. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataManager : NSObject

+ (instancetype)sharedInstance;

- (void)asyncListOfFruits:(void(^)(NSArray* arr))complection;

- (void)asyncGetImage:(NSString*)imgName complection:(void(^)(UIImage* img))complection;

@end
