#import "DashboardTableViewController.h"
#import "DashboardTableViewCell.h"

@interface DashboardTableViewController ()

@end

@implementation DashboardTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    items = [TestUtility getTestTypes];    
    [self.view setBackgroundColor:[UIColor colorWithRGBHexString:color_gray1 alpha:1.0f]];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];    
    UIImageView *navbarImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ooni_logo"]];
    navbarImageView.contentMode = UIViewContentModeScaleAspectFit;
    [navbarImageView.widthAnchor constraintEqualToConstant:135].active = YES;
    [navbarImageView.heightAnchor constraintEqualToConstant:24].active = YES;
    self.navigationController.navigationBar.topItem.titleView = navbarImageView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        return tableView.frame.size.width / 5 * 3;
    }
    return (tableView.frame.size.width / 5 * 3 )/2;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [items count];
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DashboardTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    NSString *testName = [items objectAtIndex:indexPath.row];
    if (cell == nil) {
        cell = [[DashboardTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    [cell setTestName:testName];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(IBAction)run:(id)sender{
    if ([[ReachabilityManager sharedManager].reachability currentReachabilityStatus] != NotReachable)
        [self performSegueWithIdentifier:@"toTestRun" sender:sender];
    else
        [MessageUtility alertWithTitle:@"Modal.Error" message:@"Modal.Error.NoInternet" inView:self];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"toTestSettings"]){
        UITableViewCell* cell = (UITableViewCell*)[[[sender superview] superview] superview];
        NSIndexPath* indexPath = [self.tableView indexPathForCell:cell];
        SettingsTableViewController *vc = (SettingsTableViewController * )segue.destinationViewController;
        NSString *testName = [items objectAtIndex:indexPath.row];
        [vc setTestName:testName];
    }
    else if ([[segue identifier] isEqualToString:@"toTestRun"]){
        UITableViewCell* cell = (UITableViewCell*)[[[sender superview] superview] superview];
        NSIndexPath* indexPath = [self.tableView indexPathForCell:cell];
        TestRunningViewController *vc = (TestRunningViewController * )segue.destinationViewController;
        NSString *testSuiteName = [items objectAtIndex:indexPath.row];
        [vc setTestSuiteName:testSuiteName];
    }
    else if ([[segue identifier] isEqualToString:@"toTestOverview"]){
        NSIndexPath* indexPath = [self.tableView indexPathForSelectedRow];
        TestOverviewViewController *vc = (TestOverviewViewController * )segue.destinationViewController;
        NSString *testName = [items objectAtIndex:indexPath.row];
        [vc setTestName:testName];
    }    
}


@end
