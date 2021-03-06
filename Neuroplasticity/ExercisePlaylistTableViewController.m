//
//  ExercisePlaylistTableViewController.m
//  Neuroplasticity
//
//  Created by David Monson on 4/10/15.
//  Copyright (c) 2015 David Monson. All rights reserved.
//

#import "ExercisePlaylistTableViewController.h"
#import "PlaylistsTableViewController.h"
#import "ExercisePresetsTableViewController.h"
#import "PlaylistsController.h"
#import "PursuitsViewController.h"
#import "OPKViewController.h"
#import "HemistimViewController.h"
#import "CartesianCrossViewController.h"
#import <Parse/Parse.h>

@interface ExercisePlaylistTableViewController ()

@end

@implementation ExercisePlaylistTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.titleLabel;
    
    self.tableView.allowsMultipleSelectionDuringEditing = NO;
    
    [PlaylistsController sharedInstance].object = self.selectedPlaylistObject;

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)viewDidAppear:(BOOL)animated {
    [[PlaylistsController sharedInstance]queryForExercisesWithID:self.selectedPlaylistObject WithCompletion:^(BOOL completion) {
        [self.tableView reloadData];
    }];
}

//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
//    // Return YES if you want the specified item to be editable.
//    return YES;
//}
//
//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        //add code here for when you hit delete
//        [_chats removeObjectAtIndex:indexPath.row];
//        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
//    }
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.selectedPlaylistObject[@"playlistArray"] count];;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    NSString *exerciseName = self.selectedPlaylistObject[@"playlistArray"][indexPath.row][@"identifier"];
    cell.textLabel.text = [NSString stringWithFormat:@"%@",exerciseName];
    
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.backgroundColor = [UIColor colorWithRed:(143.0/255.0) green:(116.0/255.0) blue:(248.0/255.0) alpha:1];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:self.view.frame.size.height / 30];
    float imageSize = cell.contentView.frame.size.height *.9;
    
    UIImageView *cellPlayImage = [[UIImageView alloc] initWithFrame:CGRectMake(cell.contentView.frame.size.width - imageSize - 20, cell.contentView.frame.size.height / 2 - imageSize / 2, imageSize, imageSize)];

    cellPlayImage.image = [UIImage imageNamed:@"play"];
    [cell.contentView addSubview:cellPlayImage];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //play animation and continue to play each animation after each one finishes.
    
    if ([self.selectedPlaylistObject[@"playlistArray"][indexPath.row][@"exercise"]  isEqual: @"pursuits"]) {
        PursuitsViewController *pursuitsViewController = [PursuitsViewController new];
        pursuitsViewController.activity = self.selectedPlaylistObject[@"playlistArray"][indexPath.row];
        [self.navigationController pushViewController:pursuitsViewController animated:NO];
    } else if ([self.selectedPlaylistObject[@"playlistArray"][indexPath.row][@"exercise"] isEqual: @"OPK"]) {
        OPKViewController *opkViewController = [OPKViewController new];
        opkViewController.activity = self.selectedPlaylistObject[@"playlistArray"][indexPath.row];
        [self.navigationController pushViewController:opkViewController animated:NO];
    } else if ([self.selectedPlaylistObject[@"playlistArray"][indexPath.row][@"exercise"] isEqual: @"hemistim"]) {
        HemistimViewController *hemistimViewController = [HemistimViewController new];
        hemistimViewController.activity = self.selectedPlaylistObject[@"playlistArray"][indexPath.row];
        [self.navigationController pushViewController:hemistimViewController animated:NO];
    } else if ([self.selectedPlaylistObject[@"playlistArray"][indexPath.row][@"exercise"] isEqual: @"cartesianCross"]) {
        CartesianCrossViewController *cartesianCrossViewController = [CartesianCrossViewController new];
        cartesianCrossViewController.activity = self.selectedPlaylistObject[@"playlistArray"][indexPath.row];
        [self.navigationController pushViewController:cartesianCrossViewController animated:NO];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.view.frame.size.height / 10;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    ExercisePresetsTableViewController *tableViewController = [segue destinationViewController];
     tableViewController.selectedPlaylistObject = self.selectedPlaylistObject;
    
}


@end
