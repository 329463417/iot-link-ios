//
//  ViewController.m
//  QCFrameworkDemo
//
//

#import "HomeVC.h"
#import "TIoTCoreEquipmentTableViewCell.h"
#import "CMPageTitleContentView.h"
#import "ControlDeviceVC.h"

#import "TIoTCoreFoundation.h"
#import "TRTCCalling.h"
#import "TIoTCoreUtil.h"
#import "TIoTCoreRequestObject.h"
#import "TIoTCoreAppEnvironment.h"

static NSString *cellID = @"DODO";
@interface HomeVC ()<UITableViewDelegate,UITableViewDataSource,CMPageTitleContentViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tab;

@property (nonatomic,strong) NSArray *familyList;
@property (nonatomic,strong) NSArray *roomList;
@property (nonatomic,strong) NSString *currentFamilyId;
@property (nonatomic,strong) NSString *currentRoomId;
@property (nonatomic,strong) NSArray *deviceList;

@property (nonatomic,strong) CMPageTitleContentView *familyTitlesView;
@property (nonatomic,strong) CMPageTitleContentView *roomTitlesView;


@property dispatch_semaphore_t sem;
@property (nonatomic, copy) NSArray *deviceIds;

@end

@implementation HomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [TIoTCoreSocketManager shared].socketedRequestURL = [NSString stringWithFormat:@"%@?uin=%@",[TIoTCoreAppEnvironment shareEnvironment].wsUrl,SDKGlobalDebugUin];

    
    self.title = NSLocalizedString(@"main_tab_1", @"首页");
    [self.tab registerClass:[TIoTCoreEquipmentTableViewCell class] forCellReuseIdentifier:cellID];
    
//    [self getFamilyList];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self getFamilyList];
}

- (void)addViewWithType:(NSUInteger)type names:(NSArray<NSString *> *)names
{
    CMPageTitleConfig *config = [CMPageTitleConfig defaultConfig];
    config.cm_switchMode = CMPageTitleSwitchMode_Scale;
    config.cm_titles = names;
    config.cm_font = [UIFont systemFontOfSize:16];
    config.cm_selectedFont = [UIFont boldSystemFontOfSize:17];
    config.cm_normalColor = kFontColor;
    config.cm_selectedColor = kRGBColor(0, 82, 217);

    CMPageTitleContentView *titView = [[CMPageTitleContentView alloc] initWithConfig:config];
    titView.backgroundColor = [UIColor lightGrayColor];
    titView.cm_delegate = self;
    
    if (1 == type) {
        if (self.familyTitlesView) {
            [self.familyTitlesView removeFromSuperview];
        }
        titView.frame = CGRectMake(60, kNavBarAndStatusBarHeight, kScreenWidth - 60, 44);
        self.familyTitlesView = titView;
        self.familyTitlesView.isGetSelectedView = YES;
    }
    else
    {
        if (self.roomTitlesView) {
            [self.roomTitlesView removeFromSuperview];
        }
        titView.frame = CGRectMake(60, kNavBarAndStatusBarHeight + 44 + 2, kScreenWidth - 60, 44);
        self.roomTitlesView = titView;
        self.roomTitlesView.isGetSelectedView = YES;
    }
    [self.view addSubview:titView];
}



- (void)getFamilyList
{
    [[TIoTCoreFamilySet shared] getFamilyListWithOffset:0 limit:0 success:^(id  _Nonnull responseObject) {
        
        self.familyList = responseObject[@"FamilyList"];
        
        if (self.familyList.count > 0) {
            NSArray *names = [self.familyList valueForKey:@"FamilyName"];
            [self addViewWithType:1 names:names];
            
            self.currentFamilyId = self.familyList[0][@"FamilyId"];
            [TIoTCoreUserManage shared].familyId = self.currentFamilyId;
            [self getRoomList];
            [self getDeviceList];
            
            [[NSUserDefaults standardUserDefaults] setValue:self.familyList[0][@"FamilyId"] forKey:@"firstFamilyId"];
        }
        else
        {
            [self createFamily];
        }
        
        
        
    } failure:^(NSString * _Nullable reason, NSError * _Nullable error,NSDictionary *dic) {
        
    }];
}

- (void)createFamily
{
    [[TIoTCoreFamilySet shared] createFamilyWithName:NSLocalizedString(@"my_family", @"我的家") address:@"兰陵" success:^(id  _Nonnull responseObject) {
        [self getFamilyList];
    } failure:^(NSString * _Nullable reason, NSError * _Nullable error,NSDictionary *dic) {
        
    }];
}

- (void)getRoomList
{
    [[TIoTCoreFamilySet shared] getRoomListWithFamilyId:self.currentFamilyId offset:0 limit:0 success:^(id  _Nonnull responseObject) {
        
        self.roomList = responseObject[@"RoomList"];
        NSMutableArray *names = [NSMutableArray arrayWithObject:@"全部"];
        [names addObjectsFromArray:[self.roomList valueForKey:@"RoomName"]];
        [self addViewWithType:2 names:names];
        
    } failure:^(NSString * _Nullable reason, NSError * _Nullable error,NSDictionary *dic) {
        
    }];
}

- (void)getDeviceList
{
    [[TIoTCoreDeviceSet shared] getDeviceListWithFamilyId:self.currentFamilyId roomId:self.currentRoomId ?: @"" offset:0 limit:0 success:^(id  _Nonnull responseObject) {
        self.deviceList = responseObject;
        
        self.deviceIds = [self.deviceList valueForKey:@"DeviceId"];
        if (self.deviceIds && self.deviceIds.count > 0) {
            [[TIoTCoreDeviceSet shared] activePushWithDeviceIds:self.deviceIds complete:^(BOOL success, id data) {
                
            }];
        }
        
        [self.tab reloadData];
        
        
    } failure:^(NSString * _Nullable reason, NSError * _Nullable error,NSDictionary *dic) {
        
    }];
}





#pragma mark - UITableView

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.deviceList.count;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    TIoTCoreEquipmentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    cell.dataDic = self.deviceList[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ControlDeviceVC *vc = [[ControlDeviceVC alloc] init];
    vc.title = [NSString stringWithFormat:@"%@",self.deviceList[indexPath.row][@"AliasName"]];
    vc.deviceInfo = [self.deviceList[indexPath.row] mutableCopy];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - CMPageTitleContentViewDelegate

- (void)cm_pageTitleContentView:(CMPageTitleContentView *)view clickWithLastIndex:(NSUInteger)LastIndex Index:(NSUInteger)index Repeat:(BOOL)repeat
{
    if (view == self.familyTitlesView) {
        DDLogVerbose(@"家庭==%zi",index);
        
        self.currentFamilyId = self.familyList[index][@"FamilyId"];
        self.currentRoomId = nil;
        [self getRoomList];
        [self getDeviceList];
    }
    else
    {
        DDLogVerbose(@"房间==%zi",index);
        
        if (index > 0) {
            self.currentRoomId = self.roomList[index - 1][@"RoomId"];
        }
        else
        {
            self.currentRoomId = nil;
        }
        
        [self getDeviceList];
    }
}


#pragma mark - setter

- (void)setCurrentFamilyId:(NSString *)currentFamilyId
{
    _currentFamilyId = currentFamilyId;
}

@end
