//
//  CC_NSStringHandle.m
//  MoscoperV2
//
//  Created by mac on 15/7/21.
//  Copyright (c) 2015年 moscoper. All rights reserved.
//

#import "CC_NSStringHandle.h"

@implementation CC_NSStringHandle

/****************************************************************************************/

/**
 *  将string分割成数组
 *
 *  @param listString 要被分割的字符串
 *  @param SepStr     分割用的字符串
 *
 *  @return 分割完得到的数组
 */
+(NSArray*)getListWith:(NSString*)listString andSeparateStr:(NSString*)SepStr{
    return [listString componentsSeparatedByString:SepStr];
}

+(NSString*)getAgeWith:(NSString*)birth{
//    NSDate *now = [NSDate date];
    
//    NSCalendar *calendar = [NSCalendar currentCalendar];
//    NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
//    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
    
//    NSInteger year = [dateComponent year];
//    NSInteger month = [dateComponent month];
//    NSInteger day = [dateComponent day];
//    NSInteger hour = [dateComponent hour];
//    NSInteger minute = [dateComponent minute];
//    NSInteger second = [dateComponent second];
    
//    计算年龄
//    第一种仅仅得出年份差的年龄
    //计算年龄
//    NSString *birth = @"1993-10-30";
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    //生日
    NSDate *birthDay = [dateFormatter dateFromString:birth];
    //当前时间
    NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate date]];
    NSDate *currentDate = [dateFormatter dateFromString:currentDateStr];
//    MOSLog(@"currentDate %@ birthDay %@",currentDateStr,birth);
    NSTimeInterval time=[currentDate timeIntervalSinceDate:birthDay];
    int age = ((int)time)/(3600*24*365);
//    MOSLog(@"year %d",age);
    /*
//    另外一种得出详细到天的年龄
    NSCalendar *calendar = [NSCalendar currentCalendar];//定义一个NSCalendar对象
    
    NSDate *nowDate = [NSDate date];
    
    NSString *birth = @"1900-10-30";
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    //生日
    NSDate *birthDay = [dateFormatter dateFromString:birth];
    
    //用来得到详细的时差
    unsigned int unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *date = [calendar components:unitFlags fromDate:birthDay toDate:nowDate options:0];
    
    if([date year] >0)
    {
        MOSLog(@"%@",[NSString stringWithFormat:(@"%ld岁%ld月%ld天"),(long)[date year],(long)[date month],(long)[date day]]) ;
    }
    else if([date month] >0)
    {
        MOSLog(@"%@",[NSString stringWithFormat:(@"%ld月%ld天"),(long)[date month],(long)[date day]]);
    }
    else if([date day]>0){
        MOSLog(@"%@",[NSString stringWithFormat:(@"%ld天"),(long)[date day]]);
    }
    else {
        MOSLog(@"0天");
    }*/
    return [NSString stringWithFormat:@"%d岁",age];
}


/**
 *  获取字符串宽高
 *
 *  @param string 字符串
 *  @param font   字体大小
 *  @param startSize 设定初始宽高 获取以此为模板
 *
 *  @return 宽高
 */
+(CGSize)getSizeWithString:(NSString*)string andFont:(CGFloat)font andSetStartSize:(CGSize)startSize{
    
    CGSize size = [string boundingRectWithSize:startSize options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil].size;
    return size;
}


+(NSInteger)getNumberOfString:(NSString*)string andFont:(CGFloat)font andSetStartSize:(CGSize)startSize{
    
    CGSize size = [string boundingRectWithSize:startSize options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil].size;
    
     CGSize sizeTmp = [@"我" boundingRectWithSize:startSize options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil].size;
    
    int a = size.height;
    int b = sizeTmp.height;
    
    if (a%b==0) {
        return a/b;
    }else{
        if ((a%b)>=(b/2.0)) {
            return  a/b+1;
        }
        return a/b;
    }
}

+ (UIImage*) createImageWithColor: (UIColor*) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 0.5f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

#pragma mark - 返回一个View所在的位置x,y，是否在rect坐标里面
+ (BOOL)isInScreenView:(UIView *)inView withRect:(CGRect)rect{
    return CGRectIntersectsRect(inView.frame, rect);
}
#pragma mark - 返回判断screenRect所在的位置x,y，是否在rect坐标里面
+ (BOOL)isInScreenRect:(CGRect)screenRect withRect:(CGRect)rect{
    return CGRectIntersectsRect(screenRect, rect);
}

+ (NSString *)flattenHTML:(NSString *)html {
    
    NSScanner *theScanner;
    NSString *text = nil;
    
    theScanner = [NSScanner scannerWithString:html];
    
    while ([theScanner isAtEnd] == NO) {
        // find start of tag
        [theScanner scanUpToString:@"<" intoString:NULL] ;
        // find end of tag
        [theScanner scanUpToString:@">" intoString:&text] ;
        // replace the found tag with a space
        //(you can filter multi-spaces out later if you wish)
        html = [html stringByReplacingOccurrencesOfString:
                [NSString stringWithFormat:@"%@>", text]
                                               withString:@""];
    } // while //
    return html;
}

/**
 *  判断字符串中是否包含表情
 *
 *  @param string 被判断的字符串
 *
 *  @return 返回nil 传过来的是无表情string   返回不为nil 是过滤后的string
 */
+ (NSString*)stringContainsEmoji:(NSString *)string
{
    __block BOOL returnValue = NO;
    __block NSString *str = nil;
    
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length])
                               options:NSStringEnumerationByComposedCharacterSequences
                            usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                const unichar hs = [substring characterAtIndex:0];
                                if (0xd800 <= hs && hs <= 0xdbff) {
                                    if (substring.length > 1) {
                                        const unichar ls = [substring characterAtIndex:1];
                                        const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                                        if (0x1d000 <= uc && uc <= 0x1f77f) {
                                            returnValue = YES;
                                        }
                                    }
                                } else if (substring.length > 1) {
                                    const unichar ls = [substring characterAtIndex:1];
                                    if (ls == 0x20e3) {
                                        returnValue = YES;
                                        
                                    }
                                } else {
                                    if (0x2100 <= hs && hs <= 0x27ff) {
                                        returnValue = YES;

                                    } else if (0x2B05 <= hs && hs <= 0x2b07) {
                                        returnValue = YES;
                                        
                                    } else if (0x2934 <= hs && hs <= 0x2935) {
                                        returnValue = YES;
                                        
                                    } else if (0x3297 <= hs && hs <= 0x3299) {
                                        returnValue = YES;
                                        
                                    } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                                        returnValue = YES;
                                        
                                    }
                                }
                                
                                if (returnValue) {
                                    str = [string stringByReplacingOccurrencesOfString:substring withString:@""];

                                }else{
                                    str = nil;
                                }
                            }];
//    MOSLog(@"过滤完---%d",returnValue);
    return str;
}

+(NSString *)getMatchPercentWith:(CGFloat)matchPercent{
    NSString *matchPercentStr = nil;
    
    matchPercentStr = [NSString stringWithFormat:@"%d％",(int)(matchPercent*100)];
    
    return matchPercentStr;
}

+(NSString*)filteringTheBlankSpaceWith:(NSString *)originalStr{
    if (originalStr==nil) {
        return @"";
    }
    NSArray *strs = [originalStr componentsSeparatedByString:@" "];
    
    return [strs componentsJoinedByString:@""];
}

+(BOOL)phoneNumberJudgeWith:(NSString *)phone{
    
    if ([phone length] == 0) {
        return NO;
    }
    //1[0-9]{10}
    
    //^((13[0-9])|(15[^4,\\D])|(18[0,5-9]))\\d{8}$
    
    //    NSString *regex = @"[0-9]{11}";
    
    NSString *regex = @"^1+[3578]+\\d{9}";//@"^((13[0-9])|(147)|(15[^4,\\D])|(18[0,5-9]))\\d{8}$";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    BOOL isMatch = [pred evaluateWithObject:phone];
    
    if (!isMatch) {
        
        return NO;
        
    }
    return YES;
}


#pragma 正则匹配手机号
+ (BOOL)checkTelNumber:(NSString *) telNumber
{
    NSString *pattern = @"^1+[3578]+\\d{9}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:telNumber];
    return isMatch;
}


#pragma 正则匹配用户密码6-18位数字和字母组合
+ (BOOL)checkPassword:(NSString *) password
{
    NSString *pattern = @"^(?![0-9]+$)(?![a-zA-Z]+$)[a-zA-Z0-9]{6,18}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:password];
    return isMatch;
    
}

#pragma 正则匹配用户姓名,20位的中文或英文
+ (BOOL)checkUserName : (NSString *) userName
{
    NSString *pattern = @"^[a-zA-Z一-龥]{1,20}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:userName];
    return isMatch;
    
}


#pragma 正则匹配用户身份证号15或18位
+ (BOOL)checkUserIdCard: (NSString *) idCard
{
    NSString *pattern = @"(^[0-9]{15}$)|([0-9]{17}([0-9]|X)$)";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:idCard];
    return isMatch;
}

#pragma 正则匹员工号,12位的数字
+ (BOOL)checkEmployeeNumber : (NSString *) number
{
    NSString *pattern = @"^[0-9]{12}";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:number];
    return isMatch;
    
}

#pragma 正则匹配URL
+ (BOOL)checkURL : (NSString *) url
{
    NSString *pattern = @"^[0-9A-Za-z]{1,50}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:url];
    return isMatch;
    
}

@end
