//
//  DataManager.m
//  HW_TableImages
//
//  Created by Alexander on 19.04.14.
//  Copyright (c) 2014 Alexander. All rights reserved.
//

#import "DataManager.h"

#define ARC4RANDOM_MAX      0x100000000

@implementation DataManager

+ (instancetype)sharedInstance
{
    static id _singleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _singleton = [[self alloc] init];
    });
    return _singleton;
}

- (void)asyncListOfFruits:(void(^)(NSArray* arr))completion
{
    float delay = 0.5 + 1.5 * ((double)arc4random() / ARC4RANDOM_MAX);
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^
    {
        NSArray *result = @[@{@"title" : @"Абрикос круче чем кокос", @"thumb_img" : @"Apricot_tb.png"},
                            @{@"title" : @"", @"thumb_img" : @"Apple_tb.png"},
                            @{@"title" : @"Банана", @"thumb_img" : @"Banana_tb.png"},
                            @{@"title" : @"Ананас", @"thumb_img" : @"Ananas_tb.png"}];
        result = [result arrayByAddingObjectsFromArray:result];
        result = [result arrayByAddingObjectsFromArray:result];
        completion(result);
    });
}

- (void)asyncGetImage:(NSString*)imgName complection:(void(^)(UIImage* img))completion
{
    float delay = 0.5 + 1.5 * ((double)arc4random() / ARC4RANDOM_MAX);
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^
    {
        UIImage *img = [UIImage imageNamed:imgName];
        completion(img);
    });
}

@end
