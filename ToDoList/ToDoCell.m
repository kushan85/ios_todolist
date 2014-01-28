//
//  ToDoCell.m
//  ToDoList
//
//  Created by Kushan Shah on 1/27/14.
//  Copyright (c) 2014 Kushan Shah. All rights reserved.
//

#import "ToDoCell.h"

@implementation ToDoCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.accessoryView = self.todoTextView;
        self.editingAccessoryView = self.todoTextView;
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
