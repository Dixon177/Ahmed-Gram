#import <UIKit/UIKit.h>

// --- واجهة المطور ---
@interface AhmedDevCell : UITableViewCell
@end
@implementation AhmedDevCell
- (instancetype)initWithStyle:(UITableViewCellStyle)s reuseIdentifier:(NSString *)r {
    self = [super initWithStyle:s reuseIdentifier:r];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        UIImageView *pic = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 60, 60)];
        pic.layer.cornerRadius = 30;
        pic.layer.masksToBounds = YES;
        pic.contentMode = UIViewContentModeScaleAspectFill;
        pic.image = [UIImage imageWithContentsOfFile:@"/Library/Application Support/AhmedGram/IMG_1099.png"];
        [self.contentView addSubview:pic];

        UILabel *role = [[UILabel alloc] initWithFrame:CGRectMake(90, 15, 100, 20)];
        role.text = @"المطور";
        role.textColor = [UIColor redColor];
        role.font = [UIFont boldSystemFontOfSize:14];
        [self.contentView addSubview:role];

        UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(90, 35, 200, 30)];
        name.text = @"أحمد - @7btl0";
        name.textColor = [UIColor whiteColor];
        name.font = [UIFont boldSystemFontOfSize:18];
        [self.contentView addSubview:name];
    }
    return self;
}
@end

// --- 1. كود وضع الشبح (Ghost Mode) ---
%hook IGDirectMutationNetworker
- (id)executeMutation:(id)arg1 {
    if ([NSStringFromClass([arg1 class]) containsString:@"ReadReceipt"]) return nil; // إخفاء السين
    return %orig;
}
%end

%hook IGStoryViewerViewController
- (void)markStoryAsSeen:(id)arg1 {
    // إخفاء مشاهدة الستوري
    return; 
}
%end

// --- 2. كود تحميل الوسائط (Media Downloader) ---
%hook IGFeedItemVideoView
- (void)didLongPress {
    %orig;
    // هنا نضيف كود إظهار قائمة التحميل عند الضغط المطول
    UIAlertController *downloadAlert = [UIAlertController alertControllerWithTitle:@"Ahmed-Gram" message:@"هل تريد تحميل الفيديو؟" preferredStyle:UIAlertControllerStyleActionSheet];
    [downloadAlert addAction:[UIAlertAction actionWithTitle:@"تحميل الآن" style:UIAlertActionStyleDefault handler:nil]];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:downloadAlert animated:YES completion:nil];
}
%end

// --- 3. كود الرسائل (استعادة المحذوف) ---
%hook IGDirectMessage
- (bool)isExpired {
    return NO; // يمنع اختفاء رسائل الـ View Once
}
%end

// --- ترتيب الواجهة ---
%hook IGSettingsViewController
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tv { return %orig + 2; }
- (NSInteger)tableView:(UITableView *)tv numberOfRowsInSection:(NSInteger)s {
    if (s == 0) return 1;
    if (s == 1) return 4;
    return %orig(s - 2);
}
- (UITableViewCell *)tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)ip {
    if (ip.section == 0) return [[AhmedDevCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"AhDev"];
    if (ip.section == 1) {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Feat"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        if (ip.row == 0) { cell.textLabel.text = @"وضع الشبح"; cell.detailTextLabel.text = @"مفعل تلقائياً ✅"; }
        else if (ip.row == 1) { cell.textLabel.text = @"التحميل"; cell.detailTextLabel.text = @"اضغط مطولاً على الفيديو للتحميل"; }
        else if (ip.row == 2) { cell.textLabel.text = @"الرسائل"; cell.detailTextLabel.text = @"حفظ رسائل الـ View Once"; }
        else if (ip.row == 3) { cell.textLabel.text = @"تغيير الصوت"; cell.detailTextLabel.text = @"قريباً في التحديث القادم"; }
        return cell;
    }
    return %orig(tv, [NSIndexPath indexPathForRow:ip.row inSection:ip.section - 2]);
}
- (CGFloat)tableView:(UITableView *)tv heightForRowAtIndexPath:(NSIndexPath *)ip {
    return (ip.section == 0) ? 85 : 65;
}
%end
