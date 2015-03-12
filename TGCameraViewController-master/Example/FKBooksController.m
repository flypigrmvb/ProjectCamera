//
//  FKBooksController.m
//  AFNetworkingTest
//
//  Created by yeeku on 13-10-3.
//  Copyright (c) 2013年 crazyit.org. All rights reserved.
//

#import "FKBooksController.h"
#import "FKAppDelegate.h"

@interface FKBooksController ()
{
	NSArray* books;
	FKAppDelegate* appDelegate;
}
@end
@implementation FKBooksController
- (void)viewDidLoad
{
    [super viewDidLoad];
	appDelegate = [UIApplication sharedApplication].delegate;	
	NSString* url = @"http://192.168.1.88:8888/AFNetworkingServer/books.json";
	self.navigationItem.title = [NSString stringWithFormat:@"%@的图书"
		, [self.selectedAuthor objectForKey:@"name"]];
	// 使用NSDictionary封装请求参数
	NSDictionary *parameters = @{@"authorId":
		[self.selectedAuthor objectForKey:@"id"]};
	// 使用AFHTTPRequestOperationManager发送GET请求
	[appDelegate.manager POST:url parameters:parameters
		// 获取服务器响应成功时激发的代码块
		success:^(AFHTTPRequestOperation *operation, id responseObject)
		{
			// 将服务器响应的JSON数据转换为Objective-C对象，赋值给books属性
			books = responseObject;
			// 重新加载表格数据
			[self.tableView reloadData];
	 	}
		// 获取服务器响应失败时激发的代码块
		failure:^(AFHTTPRequestOperation *operation, NSError *error)
		{
			NSLog(@"获取图书信息出现错误: %@", error);
		}];
}
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
	return books.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView
		 cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	// 根据动态单元格原型的ID来获取可重用单元格
	UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:
							 @"bookCell" forIndexPath:indexPath];
	// 获取当前行号在books中对应的数据
	NSDictionary* book = [books objectAtIndex:indexPath.row];
	// 获取单元格中3个控件，并为3个控件设置显示文本
	UILabel* titleLable = (UILabel*)[cell viewWithTag:1];
	titleLable.text = [book objectForKey:@"title"];
	UILabel* authorLable = (UILabel*)[cell viewWithTag:2];
	authorLable.text = [book objectForKey:@"author"];
	UILabel* remarkLabel = (UILabel*)[cell viewWithTag:3];
	remarkLabel.text = [book objectForKey:@"remark"];
	return cell;
}
@end