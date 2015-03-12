//
//  HYWeatherModel.h
//  Weather
//
//  Created by 张昊 on 14-5-29.
//  Copyright (c) 2014年 HaoYa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HYWeatherModel : NSObject

@property (nonatomic,copy)NSString          *TodayDate;
@property (nonatomic,copy)NSString          *TodayImage;
@property (nonatomic,copy)NSString          *TodayMin;
@property (nonatomic,copy)NSString          *TodayMax;

@property (nonatomic,copy)NSString          *TomorrowDate;
@property (nonatomic,copy)NSString          *TomorrowImage;
@property (nonatomic,copy)NSString          *TomorrowMin;
@property (nonatomic,copy)NSString          *TomorrowMax;

@property (nonatomic,copy)NSString          *AfterTomorrowDate;
@property (nonatomic,copy)NSString          *AfterTomorrowImage;   
@property (nonatomic,copy)NSString          *AfterTomorrowMin;
@property (nonatomic,copy)NSString          *AfterTomorrowMax;


-(HYWeatherModel *)initWithDataDic:(NSDictionary *)data;
@end
