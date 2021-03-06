#import "Settings.h"
#import "ReachabilityManager.h"
#import "SettingsUtility.h"
#import "InCodeMappingProvider.h"

@implementation Settings

- (id)init {
    self = [super init];
    if (self) {
        self.annotations = [[NSMutableDictionary alloc] initWithDictionary:@{@"network_type" : [[ReachabilityManager sharedManager] getStatus]}];
        self.disabled_events = @[@"status.queued", @"status.update.websites", @"failure.report_close"];
        self.log_level = [SettingsUtility getVerbosity];
        self.options = [Options new];
    }
    return self;
}

-(NSDictionary*)getSettingsDictionary{
    ObjectMapper *mapper = [[ObjectMapper alloc] init];
    InCodeMappingProvider *inCodeMappingProvider = [InCodeMappingProvider new];
    [inCodeMappingProvider mapFromPropertyKey:@"ca_bundle_path" toDictionaryKey:@"net/ca_bundle_path" forClass:[Options class]];
    [mapper setMappingProvider:inCodeMappingProvider];
    return [mapper dictionaryFromObject:self];
}

@end
