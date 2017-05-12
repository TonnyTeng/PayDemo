//
//  NSDate+XT.h
//  FingerTipEarn
//
//  Created by dengtao on 2017/4/12.
//  Copyright © 2017年 dengtao. All rights reserved.
//

#import <Foundation/Foundation.h>

#define D_MINUTE	60
#define D_HOUR		3600
#define D_DAY		86400
#define D_WEEK		604800
#define D_YEAR		31556926

@interface NSDate (XT)

// Relative dates from the current date
+ (NSDate *) dateTomorrow;
+ (NSDate *) dateYesterday;

+ (NSDate *) dateWithDaysFromNow: (NSInteger) days;
+ (NSDate *) dateWithDaysBeforeNow: (NSInteger) days;
+ (NSDate *) dateWithHoursFromNow: (NSInteger) dHours;
+ (NSDate *) dateWithHoursBeforeNow: (NSInteger) dHours;
+ (NSDate *) dateWithMinutesFromNow: (NSInteger) dMinutes;
+ (NSDate *) dateWithMinutesBeforeNow: (NSInteger) dMinutes;

// Comparing dates
- (BOOL) isEqualToDateIgnoringTime: (NSDate *) aDate;
- (BOOL) isTodayDate:(NSDate *)date;
- (BOOL) isToday;
- (BOOL) isTomorrow;
- (BOOL) isYesterday;
- (BOOL) isYesterdayday:(NSDate *)da;
- (BOOL) isSameWeekAsDate: (NSDate *) aDate;
- (BOOL) isThisWeek;
- (BOOL) isNextWeek;
- (BOOL) isLastWeek;
- (BOOL) isSameYearAsDate: (NSDate *) aDate;
- (BOOL) isThisYear;
- (BOOL) isNextYear;
- (BOOL) isLastYear;
- (BOOL) isEarlierThanDate: (NSDate *) aDate;
- (BOOL) isLaterThanDate: (NSDate *) aDate;

// Adjusting dates
- (NSDate *) dateByAddingDays: (NSInteger) dDays;
- (NSDate *) dateBySubtractingDays: (NSInteger) dDays;
- (NSDate *) dateByAddingHours: (NSInteger) dHours;
- (NSDate *) dateBySubtractingHours: (NSInteger) dHours;
- (NSDate *) dateByAddingMinutes: (NSInteger) dMinutes;
- (NSDate *) dateBySubtractingMinutes: (NSInteger) dMinutes;
- (NSDate *) dateAtStartOfDay;
- (NSDate *) dateAtEndOfDay;
- (NSDate *) dateAtStartOfMonth;

// Retrieving intervals
- (NSInteger) minutesAfterDate: (NSDate *) aDate;
- (NSInteger) minutesBeforeDate: (NSDate *) aDate;
- (NSInteger) hoursAfterDate: (NSDate *) aDate;
- (NSInteger) hoursBeforeDate: (NSDate *) aDate;
- (NSInteger) daysAfterDate: (NSDate *) aDate;
- (NSInteger) daysBeforeDate: (NSDate *) aDate;

// Decomposing dates
@property (readonly) NSInteger nearestHour;
@property (readonly) NSInteger hour;
@property (readonly) NSInteger minute;
@property (readonly) NSInteger seconds;
@property (readonly) NSInteger day;
@property (readonly) NSInteger month;
@property (readonly) NSInteger week;
@property (readonly) NSInteger weekday;
@property (readonly) NSInteger nthWeekday; // e.g. 2nd Tuesday of the month == 2
@property (readonly) NSInteger year;

- (NSString *)stringWithFormate:(NSString *)formate;

//NSDate<==>NSString

+ (NSDate *)dateFromString:(NSString *)dateString;
+ (NSDate *)dateFromPointString:(NSString *)dateString;

+ (NSString *)stringFromDate:(NSDate *)date;
+ (NSString *)stringFromElseDate:(NSDate *)date;
+ (NSString *)stringFromPointDate:(NSDate *)date;


+ (NSString *)stringFromDateHors:(NSDate *)date;
+ (NSString *)stringFromDateCompare:(NSDate *)date;
+ (NSString *)stringFromTime:(NSDate *)date;
/**
 本周第一天
 @return 第一天NSSTRING
 */
+ (NSString *)thisWeekFirstDayString;

/**
 本月第一天
 @return 第一天NSSTRING
 */
+ (NSString *)thisMonthFirstDayString;

/**
 弥补时差
 @param date 传入时间
 @return +8小时后的时间
 */
+ (NSDate *)addEightHoursWithDate:(NSDate *)date;

//标准时间转时间戳
+ (NSString *)standardTimeConversionTimeStamp:(NSString *)time;

//时间戳 转 标准时间
+ (NSString *)timeStampConversionStandardTime:(NSString *)time showDay:(BOOL)showDay showMinutes:(BOOL)showMinutes;

//判断时间为前天
+ (BOOL) isYesterdaydayTwo:(NSDate *)da;


@end
