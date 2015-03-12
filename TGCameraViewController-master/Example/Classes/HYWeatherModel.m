//
//  HYWeatherModel.m
//  Weather
//
//  Created by 张昊 on 14-5-29.
//  Copyright (c) 2014年 HaoYa. All rights reserved.
//

#import "HYWeatherModel.h"

@implementation HYWeatherModel


-(HYWeatherModel *)initWithDataDic:(NSDictionary *)data{
    
  
    
    self.TodayDate=[self GetDate:0 withDate:data];
    
    self.TodayMin=[NSString stringWithFormat:@"Min：%ld°C",
                    (long)[[ NSString stringWithFormat:@"%@" ,
                      data[@"list"][0][@"temp"][@"min"]]integerValue]];
    self.TodayMax=[NSString stringWithFormat:@"Max：%ld°C",
                   (long)[[ NSString stringWithFormat:@"%@" ,
                     data[@"list"][0][@"temp"][@"max"]]integerValue]];
    self.TodayImage= [NSString stringWithFormat:@"%@.png" ,
                      data[@"list"][0][@"weather"][0][@"icon"]];
    
    
    self.TomorrowDate=[self GetDate:1 withDate:data];
    
    self.TomorrowMin=[NSString stringWithFormat:@"Min：%ld°C",
                      (long)[[ NSString stringWithFormat:@"%@" ,
                        data[@"list"][1][@"temp"][@"min"]]integerValue]];
    self.TomorrowMax=[NSString stringWithFormat:@"Max：%ld°C",
                      (long)[[ NSString stringWithFormat:@"%@" ,
                        data[@"list"][1][@"temp"][@"max"]]integerValue]];
    self.TomorrowImage=[NSString stringWithFormat:@"%@.png" ,
                        data[@"list"][1][@"weather"][0][@"icon"]];
    
    
    self.AfterTomorrowDate=[self GetDate:2 withDate:data];
    
    self.AfterTomorrowMin=[NSString stringWithFormat:@"Min：%ld°C",
                           (long)[[ NSString stringWithFormat:@"%@" ,
                             data[@"list"][2][@"temp"][@"min"]]integerValue]];
    self.AfterTomorrowMax=[NSString stringWithFormat:@"Max：%ld°C",
                           (long)[[ NSString stringWithFormat:@"%@" ,
                             data[@"list"][2][@"temp"][@"max"]]integerValue]];
    self.AfterTomorrowImage=[NSString stringWithFormat:@"%@.png" ,
                             data[@"list"][2][@"weather"][0][@"icon"]];
    
   
    return self;
}

-(NSString *)GetDate:(int)render withDate:(NSDictionary *)data{
    
    NSLocale *locael=[[NSLocale alloc]initWithLocaleIdentifier:@"fr_FR"];
    NSDate * dt = [NSDate dateWithTimeIntervalSince1970:[data[@"list"][render][@"dt"] floatValue]];
    NSDateFormatter * df = [[NSDateFormatter alloc] init];
    [df setLocale:locael];
    [df setDateFormat:@" dd MM yyyy "];
    [df setDateStyle:NSDateFormatterFullStyle];
    NSString *regStr = [df stringFromDate:dt];
    return regStr;

}





@end
