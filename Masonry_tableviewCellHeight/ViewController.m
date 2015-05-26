//
//  ViewController.m
//  Masonry_tableviewCellHeight
//
//  Created by wendongsheng on 15/5/26.
//  Copyright (c) 2015年 etiantian. All rights reserved.
//

#import "ViewController.h"
#import "CustomCell.h"
#import <Masonry.h>

static NSString *cellIdentifier = @"cell";

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ViewController

#pragma mark - cycle life -
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self setupSubViews];
    [self layoutViews];
}

- (void)setupSubViews{
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _tableView.estimatedRowHeight = UITableViewAutomaticDimension;
    [self.view addSubview:_tableView];
    
    //注册cell
    [_tableView registerClass:[CustomCell class] forCellReuseIdentifier:cellIdentifier];
}

- (void)layoutViews{
    
    __weak typeof(self) weakSelf = self;
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(weakSelf.view).insets(UIEdgeInsetsMake(20, 0, 0, 0));
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate && UITableViewDataSource -
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CustomCell *cell = [CustomCell new];
    
    cell.bounds = CGRectMake(0, 0, CGRectGetWidth(tableView.bounds), CGRectGetHeight(cell.bounds));
    
    [cell configLabelText:self.dataArray[indexPath.row]];
    
    [cell setNeedsLayout];
    [cell layoutIfNeeded];
    
    CGFloat height = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    height += 1;
    
    return height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    [cell configLabelText:self.dataArray[indexPath.row]];
    
    return cell;
}

#pragma mark - getter -
- (NSArray *)dataArray{
    if (_dataArray == nil) {
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"dataSource" ofType:@"txt"];
        _dataArray = [[NSString stringWithContentsOfFile:filePath usedEncoding:nil error:nil] componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    }
    return _dataArray;
}

@end
