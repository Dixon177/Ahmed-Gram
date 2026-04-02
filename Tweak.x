#import <UIKit/UIKit.h>

@interface AhmedCell : UITableViewCell
@property (nonatomic, strong) UIImageView *pic;
@property (nonatomic, strong) UILabel *name;
@property (nonatomic, strong) UILabel *role;
@end

@implementation AhmedCell
- (instancetype)initWithStyle:(UITableViewCellStyle)s reuseIdentifier:(NSString *)r {
    self = [super initWithStyle:s reuseIdentifier:r];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.pic = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 60, 60)];
        self.pic.layer.cornerRadius = 30;
        self.pic.layer.masksToBounds = YES;
        self.pic.contentMode = UIViewContentModeScaleAspectFill;
        // هنا الكود راح يندل صورتك بالاسم اللي رفعته إنت
        self.pic.image = [UIImage imageWithContentsOfFile:@"/Library/Application Support/AhmedGram/IMG_1099.png"];
        [self.contentView addSubview:self.pic];

        self.role = [[UILabel alloc] initWithFrame:CGRectMake(90, 15, 100, 20)];
        self.role.text = @"المطور";
        self.role.textColor = [UIColor redColor];
        self.role.font = [UIFont boldSystemFontOfSize:14];
        [self.contentView addSubview:self.role];

        self.name = [[UILabel alloc] initWithFrame:CGRectMake(90, 35, 200, 30)];
        self.name.text = @"أحمد - @7btl0";
        self.name.textColor = [UIColor whiteColor];
        self.name.font = [UIFont boldSystemFontOfSize:18];
        [self.contentView addSubview:self.name];
    }
    return self;
}
@end

%hook IGSettingsViewController
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tv { return %orig + 1; }
- (NSInteger)tableView:(UITableView *)tv numberOfRowsInSection:(NSInteger)s {
    if (s == 0) return 1;
    return %orig(s - 1);
}
- (UITableViewCell *)tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)ip {
    if (ip.section == 0) return [[AhmedCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Ah"];
    return %orig(tv, [NSIndexPath indexPathForRow:ip.row inSection:ip.section - 1]);
}
- (CGFloat)tableView:(UITableView *)tv heightForRowAtIndexPath:(NSIndexPath *)ip {
    if (ip.section == 0) return 85;
    return %orig;
}
%end
