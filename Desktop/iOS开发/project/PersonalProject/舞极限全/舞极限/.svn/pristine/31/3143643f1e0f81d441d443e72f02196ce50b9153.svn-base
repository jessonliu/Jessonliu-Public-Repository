//
//  NSDate+TodayWeek.m
//  DancingDemol
//
//  Created by laouhn on 15/10/7.
//  Copyright (c) 2015年 JHH. All rights reserved.
//

#import "NSDate+TodayWeek.h"

@implementation NSDate (TodayWeek)


+ (NSString *)TodayForWeek {
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter new] autorelease];
    [formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:8*3600]];
    [formatter setDateFormat:@"E"];
    NSString *weekDay = [formatter stringFromDate:date];
    return [weekDay stringByReplacingOccurrencesOfString:@"周" withString:@"星期"];
}

@end
