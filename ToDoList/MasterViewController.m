//
//  MasterViewController.m
//  ToDoList
//
//  Created by Kushan Shah on 1/27/14.
//  Copyright (c) 2014 Kushan Shah. All rights reserved.
//

#import "MasterViewController.h"
#import "ToDoNote.h"
#import "ToDoCell.h"
#import <Parse/Parse.h>

@interface MasterViewController ()

- (IBAction)onAddNote:(id)sender;
@property (strong, nonatomic) PFObject *parseObject;

@end

@implementation MasterViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.navigationItem.title = @"TODO LIST";
        NSMutableArray *loadedArray = [[NSUserDefaults standardUserDefaults] mutableArrayValueForKey:@"todolist"];
        if(!loadedArray) {
            self.todoList = [[NSMutableArray alloc] init];
        } else {
            
            self.todoList = [[NSMutableArray alloc] init];
            for(NSString *str in loadedArray) {
                ToDoNote *note = [[ToDoNote alloc] init];
                note.todoData = str;
                [self.todoList addObject:note];
            }
        };
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.todoList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ToDoCell *cell = (ToDoCell *)[tableView dequeueReusableCellWithIdentifier:@"ToDoCell"];
    
    ToDoNote *note = (ToDoNote *)[self.todoList objectAtIndex:indexPath.row];
    cell.todoTextView.text = note.todoData;
    cell.todoTextView.delegate = self;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
}



- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(hideKeyboard)];
    
    CGPoint pnt = [self.tableView convertPoint:textView.bounds.origin fromView:textView];
    NSIndexPath* path = [self.tableView indexPathForRowAtPoint:pnt];
    [self.tableView selectRowAtIndexPath:path animated:YES scrollPosition:UITableViewScrollPositionTop];
    [self.tableView scrollToRowAtIndexPath:path atScrollPosition:UITableViewScrollPositionTop animated:YES];
    return YES;
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat height = 70;
    //calculate height for each cell
    
    return height;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [self.todoList removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}

// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    NSString *stringToMove = [self.todoList objectAtIndex:fromIndexPath.row];
    [self.todoList removeObjectAtIndex:fromIndexPath.row];
    [self.todoList insertObject:stringToMove atIndex:toIndexPath.row];
}

// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    NSString *tempString = [textView.text stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    tempString = [tempString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    tempString = [tempString stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSLog(@"%@", tempString);
    NSLog(@"%d", tempString.length);
    
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    NSLog(@"%d", indexPath.row);
    
    if(tempString.length == 0) {
        [self.todoList removeObjectAtIndex:indexPath.row];
        [self.tableView reloadData];
    }
    
//    PFQuery *query = [PFQuery queryWithClassName:@"ToDoNote"];
//    // Retrieve the object by id
//    [query getObjectInBackgroundWithId:@"GMXvlQ0ESe" block:^(PFObject *parseObject, NSError *error) {
//        
//        self.parseObject = parseObject;
//        self.parseObject[@"todoData"] = textView.text;
//        [self.parseObject saveInBackground];
//        
//    }];
    ToDoNote *note = [self.todoList objectAtIndex:indexPath.row];
    note.todoData = textView.text;
    
    NSMutableArray *save = [[NSMutableArray alloc] init];
    for(ToDoNote *noteText in self.todoList) {
        [save addObject:noteText.todoData];
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:save forKey:@"todolist"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */


- (void)hideKeyboard{
    [self.view endEditing:YES];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(onAddNote:)];
}


- (IBAction)onAddNote:(id)sender {
    ToDoNote *note = [[ToDoNote alloc] init];
    note.todoData = @"";
    [self.todoList addObject:note];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.todoList.count-1 inSection:0];
    NSArray *indexPaths = [NSArray arrayWithObject:indexPath];
    
    [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:YES];
    
    ToDoCell *firstResponder = (ToDoCell *)[self.tableView cellForRowAtIndexPath:indexPath];
    [firstResponder.todoTextView becomeFirstResponder];
    [self.tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionTop];
    
}
@end
