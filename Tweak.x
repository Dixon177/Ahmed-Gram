#import <UIKit/UIKit.h>

// تعريف الخلية المخصصة للمطور أحمد
@interface AhmedDevCell : UITableViewCell
@property (nonatomic, strong) UIImageView *devImage;
@property (nonatomic, strong) UILabel *devName;
@property (nonatomic, strong) UILabel *devRole;
@end

@implementation AhmedDevCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        // رسم الصورة الشخصية الدائرية
        self.devImage = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 60, 60)];
        self.devImage.layer.cornerRadius = 30;
        self.devImage.layer.masksToBounds = YES;
        self.devImage.contentMode = UIViewContentModeScaleAspectFill;
        // استدعاء صورتك من ملفات النظام
        self.devImage.image = [UIImage imageWithContentsOfFile:@"/Library/PreferenceBundles/AhmedGram.bundle/AhmedProfile.png"];
        [self.contentView addSubview:self.devImage];
        
        // كلمة "المطور" باللون الأحمر
        self.devRole = [[UIHeaderFooterView alloc] initWithFrame:CGRectMake(90, 15, 100, 20)];
        UILabel *roleLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 15, 100, 20)];
        roleLabel.text = @"المطور";
        roleLabel.textColor = [UIColor redColor];
        roleLabel.font = [UIFont boldSystemFontOfSize:14];
        [self.contentView addSubview:roleLabel];
        
        // اسمك ويوزرك
        self.devName = [[UILabel alloc] initWithFrame:CGRectMake(90, 35, 200, 30)];
        self.devName.text = @"أحمد - @7btl0";
        self.devName.textColor = [UIColor whiteColor];
        self.devName.font = [UIFont boldSystemFontOfSize:18];
        [self.contentView addSubview:self.devName];
    }
    return self;
}
@end

// حقن الواجهة داخل إعدادات الانستقرام
%hook IGSettingsViewController
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return %orig + 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) return 1;
    return %orig(section - 1);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        AhmedDevCell *cell = [[AhmedDevCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"AhmedCell"];
        return cell;
    }
    return %orig(tableView, [NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section - 1]);
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) return 85;
    return %orig;
}
%end
