//
//  MasterViewController.h
//  ToDoList
//
//  Created by Kushan Shah on 1/27/14.
//  Copyright (c) 2014 Kushan Shah. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MasterViewController : UITableViewController <UITextViewDelegate>
@property (strong, nonatomic) NSMutableArray *todoList;
@end
