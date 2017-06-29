//
//  CC_NSStringHandle.h
//  MoscoperV2
//
//  Created by mac on 15/7/21.
//  Copyright (c) 2015年 moscoper. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CC_NSStringHandle : NSObject

/**
 *  获取字符串宽高
 *
 *  @param string 字符串
 *  @param font   字体大小
 *  @param startSize 设定初始宽高 获取以此为模板
 *
 *  @return 宽高
 */
+(CGSize)getSizeWithString:(NSString*)string andFont:(CGFloat)font andSetStartSize:(CGSize)startSize;
/**
 *  用颜色创建image
 *
 *  @param color 颜色
 *
 *  @return image
 */
+ (UIImage*) createImageWithColor: (UIColor*) color;
/**
 *  判断一个view是否在某个区域
 *
 *  @param inView view
 *  @param rect   坐标范围
 *
 *  @return bool
 */
+ (BOOL)isInScreenView:(UIView *)inView withRect:(CGRect)rect;
/**
 *  判断一个x，y是否在某个区域
 *
 *  @param screenRect 某个坐标
 *  @param rect       坐标区域
 *
 *  @return bool
 */
+ (BOOL)isInScreenRect:(CGRect)screenRect withRect:(CGRect)rect;

/**
 *  判断字符串中是否包含表情
 *
 *  @param string 被判断的字符串
 *
 *  @return 返回nil 传过来的是无表情string   返回不为nil 是过滤后的string
 */
+ (NSString*)stringContainsEmoji:(NSString *)string;

/**
 *  获取匹配度
 *
 *  @param matchPercent 匹配数
 *
 *  @return 匹配度字符串
 */
+(NSString*)getMatchPercentWith:(CGFloat)matchPercent;

/**
 *  去除空格
 *
 *  @param originalStr 字符串
 *
 *  @return 过滤后str
 */
+(NSString*)filteringTheBlankSpaceWith:(NSString*)originalStr;

/**
 *  判断电话号码
 *
 *  @param phone 电话字符
 *
 *  @return 是否是正确电话
 */
+(BOOL)phoneNumberJudgeWith:(NSString*)phone;

/**
 *  获取字符串行数
 *
 *  @param string 字符串
 *  @param font   字体大小
 *  @param startSize 设定初始宽高 获取以此为模板
 *
 *  @return 行数
 */
+(NSInteger)getNumberOfString:(NSString*)string andFont:(CGFloat)font andSetStartSize:(CGSize)startSize;

/**
 获得年龄

 @param birth birth description
 @return return value description
 */
+(NSString*)getAgeWith:(NSString*)birth;

/**
 去掉html 字符串中的 标签

 @param html html description
 @return return value description
 */
+ (NSString *)flattenHTML:(NSString *)html;

/**
 *  将string分割成数组
 *
 *  @param listString 要被分割的字符串
 *  @param SepStr     分割用的字符串
 *
 *  @return 分割完得到的数组
 */
+(NSArray*)getListWith:(NSString*)listString andSeparateStr:(NSString*)SepStr;

@end
