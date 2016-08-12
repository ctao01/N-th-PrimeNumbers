//
//  RootViewController.m
//  PrimeNumberGenerator
//
//  Created by Joy Tao on 8/11/16.
//  Copyright © 2016 CYT. All rights reserved.
//

#import "ResultListViewController.h"
#import "Constants.h"

typedef enum {
    CachedTypeNone = 0,
    CachedTypeAll = 1,
    CachedTypePartial = 2
}CachedDataType;


@interface PrimeNumberCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel * numberLabel;
@property (nonatomic, strong) IBOutlet UILabel * indexLabel;

@end

@implementation PrimeNumberCell
@end


@interface ResultListViewController ()
@property (nonatomic , strong) NSArray * primeNumbers;
@end

@implementation ResultListViewController

//static int maxPrimeNumber() {
//    
////    As of January 2016 , the largest known prime number is 2^(74,207,281 − 1), a number with 22,338,618 decimal digits. It was found in 2016 by the Great Internet Mersenne Prime Search (GIMPS). Plot of the number of digits in largest known prime by year, since the electronic computer.
//    
//    double number = pow(2, 74207281) ;  //Inf
//    int maxPrimeNumber = (int) number;
//    return maxPrimeNumber;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.primeNumbers = [[NSArray alloc]init];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Public

- (void) getPrimeNumbersToNthNumber:(int)nth
{
    NSDictionary * isCached = [self isCachedQuery:nth];
    NSInteger cachedType = [[isCached objectForKey:CachedType] integerValue];
    
    if (cachedType == CachedTypeAll) {
        NSString * key = [isCached objectForKey:CachedNumber];
        self.primeNumbers = [[[self totalCachedNumbers] objectForKey:key] subarrayWithRange: NSMakeRange(0, nth)];
    }
    
    else if (cachedType == CachedTypePartial)
    {
        NSString * key = [isCached objectForKey:CachedNumber];
        NSArray * cachedNumbers = [[self totalCachedNumbers ]objectForKey:key];
        
        NSMutableArray * newNumbers = [[NSMutableArray alloc]init];
        
        int count = [key intValue];
        int value = [[cachedNumbers lastObject] intValue];
        
        while (count <= nth ) {
            
            int d = 2;
            bool isPrime = true;
            
            while (d < value) {
                if (value % d == 0)
                {
                    isPrime = false;
                }
                d++;
            }
            if (isPrime) {
                //            NSLog(@"%i - %i", count, value);
                [newNumbers addObject: [NSNumber numberWithInt:value]];
                count ++;
                
            }
            value = value + 1;
        }
        
        NSArray * totals = [newNumbers arrayByAddingObjectsFromArray:cachedNumbers];
        totals = [[[NSSet setWithArray:totals] allObjects] sortedArrayUsingDescriptors:@[[[NSSortDescriptor alloc] initWithKey:@"intValue" ascending: true]]];
        
        NSMutableDictionary * new = [NSMutableDictionary dictionaryWithDictionary:[self totalCachedNumbers]];
        [new setObject:totals forKey:[NSString stringWithFormat:@"%d", nth]];
        [[NSUserDefaults standardUserDefaults]removeObjectForKey: Cached];
        [[NSUserDefaults standardUserDefaults]setObject:new forKey: Cached];
        
        self.primeNumbers = totals;
        
        
    }
    
    else
    {
        NSMutableArray * numbers = [[NSMutableArray alloc]init];
        
        int count = 0;
        int value = 2;
        
        while (count < nth ) {
            
            int d = 2;
            bool isPrime = true;
            
            while (d < value) {
                if (value % d == 0)
                {
                    isPrime = false;
                }
                d++;
            }
            if (isPrime) {
                //            NSLog(@"%i - %i", count, value);
                [numbers addObject: [NSNumber numberWithInt:value]];
                count ++;
                
            }
            value = value + 1;
        }
        NSMutableDictionary * new = [NSMutableDictionary dictionaryWithDictionary:[self totalCachedNumbers]];
        [new setObject:numbers forKey:[NSString stringWithFormat:@"%d",nth]];
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:Cached];
        [[NSUserDefaults standardUserDefaults]setObject:new forKey:Cached];
        
        self.primeNumbers = numbers;
    }
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.primeNumbers count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString * primeCellIdentifer = @"primeNumberCellIdentifer";
    
    PrimeNumberCell * cell = [tableView dequeueReusableCellWithIdentifier:primeCellIdentifer];
    
    cell.numberLabel.text = [NSString stringWithFormat:@"%@",[self.primeNumbers objectAtIndex:indexPath.row]];
    cell.indexLabel.text = [NSString stringWithFormat:@"(%li)", indexPath.row + 1];
    
    return cell;
}


#pragma mark - Private Methods

- (NSDictionary *) totalCachedNumbers
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:Cached];
}

- (NSMutableDictionary*) isCachedQuery:(int)nth
{
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"intValue" ascending:NO];
    NSDictionary * cachedDict = [[NSUserDefaults standardUserDefaults] objectForKey:Cached];
    if (cachedDict == nil) {
        [[NSUserDefaults standardUserDefaults]setObject:[NSMutableDictionary new] forKey:Cached];
    }
    NSArray * keys = [[cachedDict allKeys] sortedArrayUsingDescriptors:@[sortDescriptor]];
    
    __block NSMutableDictionary * isCached = [NSMutableDictionary dictionaryWithObjects:@[[NSNumber numberWithInteger:CachedTypeNone]] forKeys:@[CachedType]];
    if ([keys count] > 0)
    {
        
        [keys enumerateObjectsUsingBlock:^(NSString * obj, NSUInteger idx, BOOL *  stop) {
            
            int oldQueryNumber = [obj intValue];
            if (oldQueryNumber >= nth) {
                [isCached setObject:[NSNumber numberWithInteger:CachedTypeAll] forKey:CachedType];
                [isCached setObject:obj forKey:CachedNumber];
                *stop = true;
            }
            else
            {
                [isCached setObject:[NSNumber numberWithInteger:CachedTypePartial] forKey:CachedType];
                [isCached setObject:obj forKey:CachedNumber];
                *stop = true;
            }
        }];
        
    }
    return isCached;
    
}


@end
