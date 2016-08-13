//
//  Constants.h
//  PrimeNumberGenerator
//
//  Created by Joy Tao on 8/11/16.
//  Copyright © 2016 CYT. All rights reserved.
//

#ifndef Constants_h
#define Constants_h

#define iPhoneModel [[[UIDevice currentDevice]model] isEqualToString:@"iPhone"]
#define iPadModel [[[UIDevice currentDevice] model] isEqualToString:@"iPad"]


#define SmallestPrimeNumber 2

#define MinInputValue 1
#define MaxInputValue 1000
#define InputRegex  @"^[+-]{0,1}[0-9]+$"

#define CachedQueries @"CachedQueries"
#define CachedNumber @"CachedNumber"
#define CachedType @"CachedType"

/* Color */
#define ThemeColor [UIColor colorWithRed:246.0f/255.0 green:146.0f/255.0 blue:60.0f/255.0 alpha:1.0]
#define NavigationBarColor [UIColor colorWithRed:60.0f/255.0 green:246.0f/255.0 blue:146.0f/255.0 alpha:1.0]


#define InputFieldNormalColor [UIColor colorWithRed:249.0f/255.0 green:177.0f/255.0 blue:116.0f/255.0 alpha:.7f]
#define InputFieldWarningColor [UIColor colorWithRed:249.0f/255.0 green:125.0f/255.0 blue:125.0f/255.0 alpha:.90]

/* Font */
#define ThemeFont @"Futura-Medium"
#define iPhoneLargeFont 20.0f
#define iPhoneMediumFont 16.0f
#define iPhoneSmallFont 12.0f

#define iPadLargeFont 28.0f
#define iPadMediumFont 18.0f
#define iPadSmallFont 14.0f



#endif /* Constants_h */
