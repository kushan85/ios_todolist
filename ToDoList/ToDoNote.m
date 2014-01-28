//
//  ToDoNote.m
//  ToDoList
//
//  Created by Kushan Shah on 1/27/14.
//  Copyright (c) 2014 Kushan Shah. All rights reserved.
//

#import "ToDoNote.h"

@implementation ToDoNote
@synthesize todoData;

#pragma mark NSCoding Protocol

- (void)encodeWithCoder:(NSCoder *)encoder;
{
    [encoder encodeObject:[self todoData] forKey:@"todoData"];
}

- (id)initWithCoder:(NSCoder *)decoder;
{
    if ( ![super init] )
        return nil;
    
    [self setTodoData:[decoder decodeObjectForKey:@"todoData"]];
    
    return self;
}

@end
