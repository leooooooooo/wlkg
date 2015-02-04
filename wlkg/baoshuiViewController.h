//
//  baoshuiViewController.h
//  wlkg
//
//  Created by leo on 14/11/18.
//  Copyright (c) 2014年 leo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KeychainItemWrapper.h"

@interface baoshuiViewController : UIViewController
{
        KeychainItemWrapper *status;
}
- (IBAction)returnlogin:(id)sender;

@end
