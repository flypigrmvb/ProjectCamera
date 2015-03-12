//
//  FKViewController.m
//  AFNetworkingTest
//
//  Created by yeeku on 13-9-30.
//  Copyright (c) 2013年 crazyit.org. All rights reserved.
//

#import "FKAuthorsController.h"
#import "FKBooksController.h"
#import "FKAppDelegate.h"

@interface FKAuthorsController ()
{
	NSArray* authors;
	FKAppDelegate* appDelegate;
}
@end
@implementation FKAuthorsController
- (void)viewDidLoad
{
	[super viewDidLoad];
	appDelegate = [UIApplication sharedApplication].delegate;
	NSString* url = @"http://192.168.1.88:8888/AFNetworkingServer/authors.json";
	// 使用AFHTTPRequestOperationManager发送GET请求
	[appDelegate.manager GET:url parameters:nil
		// 获取服务器响应成功时激发的代码块
		success:^(AFHTTPRequestOperation *operation, id responseObject)
		{
			// 将服务器响应的JSON数据转换为Objective-C对象，赋值给authors属性
			authors = responseObject;
			// 重新加载表格数据
			[self.tableView reloadData];
		}
		// 获取服务器响应失败时激发的代码块
		failure:^(AFHTTPRequestOperation *operation, NSError *error)
		{
			NSLog(@"获取作者信息出现错误: %@", error);
		}];
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	UITableViewCell* cell = (UITableViewCell*)sender;
	// 获取激发跳转的单元格所在的NSIndexPath
	NSIndexPath* indexPath = [self.tableView indexPathForCell:cell];
	// 获取即将跳转到的目标视图控制器
	FKBooksController* booksController = (FKBooksController*)
		segue.destinationViewController;
	// 将用户选中的单元格的作者信息传给目标视图控制器
	booksController.selectedAuthor = [authors objectAtIndex:indexPath.row];
}
// --------下面两个方法根据authors集合的元素来显示表格数据---------
- (NSInteger)tableView:(UITableView *)tableView
 	numberOfRowsInSection:(NSInteger)section
{
	return authors.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView
	cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:
		@"authorCell" forIndexPath:indexPath];
	NSDictionary* dict = [authors objectAtIndex:indexPath.row];
	cell.textLabel.text = [dict objectForKey:@"name"];
	cell.detailTextLabel.text = [dict objectForKey:@"desc"];
	return cell;
}
@end
