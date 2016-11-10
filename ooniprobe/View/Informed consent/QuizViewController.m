// Part of MeasurementKit <https://measurement-kit.github.io/>.
// MeasurementKit is free software. See AUTHORS and LICENSE for more
// information on the copying conditions.

#import "QuizViewController.h"

@interface QuizViewController ()

@end

@implementation QuizViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedString(@"quiz", nil);
    self.titleLabel.text = NSLocalizedString(@"quiz", nil);
    self.subtitleLabel.text = NSLocalizedString(@"quiz_text", nil);

    UIBarButtonItem *next = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"next", nil) style:UIBarButtonItemStylePlain target:self action:@selector(next)];
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:next, nil];

    headers = @[@"header_1", @"header_2"];
    firstQuestion = @[@"answer_1_1", @"answer_1_2", @"answer_1_3"];
    secondQuestion = @[@"answer_2_1",  @"answer_2_2", @"answer_2_3"];
    
    self.tableView.estimatedRowHeight = 80.0;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    if (indexPath.row == 0){
        cell = [tableView dequeueReusableCellWithIdentifier:@"Header" forIndexPath:indexPath];
        cell.textLabel.font = [UIFont boldSystemFontOfSize:17.0];
        cell.textLabel.text = NSLocalizedString([headers objectAtIndex:indexPath.section], nil);
    }
    else {
        cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
        UILabel *title = (UILabel*)[cell viewWithTag:1];
        UIImageView *image = (UIImageView*)[cell viewWithTag:2];
        title.font = [UIFont systemFontOfSize:17.0];
        image.image = [UIImage imageNamed:@"not-selected"];
        if(indexPath.section == 0) {
            title.text = NSLocalizedString([firstQuestion objectAtIndex:indexPath.row-1], nil);
            if (indexPath.row == firstAnswer) image.image = [UIImage imageNamed:@"selected"];
        }
        else if(indexPath.section == 1) {
            title.text = NSLocalizedString([secondQuestion objectAtIndex:indexPath.row-1], nil);
            if (indexPath.row == secondAnswer) image.image = [UIImage imageNamed:@"selected"];
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row != 0){
        if(indexPath.section == 0) firstAnswer = indexPath.row;
        else if(indexPath.section == 1) secondAnswer = indexPath.row;
        [self.tableView reloadData];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)next{
    if ([self checkAnswers]){
        [self performSegueWithIdentifier:@"toConfiguration" sender:self];
    }
    else {
        [self.navigationController popViewControllerAnimated:YES];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"showToastWrong" object:nil];
    }
}

-(BOOL) checkAnswers{
    if (firstAnswer == 1 && secondAnswer == 2) return TRUE;
    return false;
}

@end