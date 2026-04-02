#import <UIKit/UIKit.h>

// تعريف الخلايا للأزرار الجديدة
@interface AhmedFeatureCell : UITableViewCell
@end
@implementation AhmedFeatureCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
    if (self) {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.detailTextLabel.textColor = [UIColor grayColor];
    }
    return self;
}
@end

%hook IGSettingsViewController

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tv {
    return %orig + 2; // قسم للمطور وقسم للميزات
}

- (NSInteger)tableView:(UITableView *)tv numberOfRowsInSection:(NSInteger)s {
    if (s == 0) return 1; // خلية المطور أحمد
    if (s == 1) return 4; // الأزرار: وضع الشبح، التحميل، الخ..
    return %orig(s - 2);
}

- (UITableViewCell *)tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)ip {
    if (ip.section == 0) {
        // خلية المطور اللي سويناها قبل
        return [self AhmedDevCell]; 
    }
    
    if (ip.section == 1) {
        AhmedFeatureCell *cell = [tv dequeueReusableCellWithIdentifier:@"FeatureCell"];
        if (!cell) cell = [[AhmedFeatureCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"FeatureCell"];
        
        if (ip.row == 0) {
            cell.textLabel.text = @"وضع الشبح";
            cell.detailTextLabel.text = @"مشاهدة الرسائل والقصص بشكل مخفي";
            cell.imageView.image = [UIImage systemImageNamed:@"ghost"];
        } else if (ip.row == 1) {
            cell.textLabel.text = @"التحميل";
            cell.detailTextLabel.text = @"تحميل الريلز والمنشورات والقصص";
            cell.imageView.image = [UIImage systemImageNamed:@"arrow.down.circle"];
        }
        return cell;
    }
    return %orig(tv, [NSIndexPath indexPathForRow:ip.row inSection:ip.section - 2]);
}

// عنوان الأقسام
- (NSString *)tableView:(UITableView *)tv titleForHeaderInSection:(NSInteger)s {
    if (s == 1) return @"إعدادات Ahmed-Gram";
    return %orig(s - 2);
}
%end
