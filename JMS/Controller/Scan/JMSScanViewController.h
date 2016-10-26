//
//  JMSScanViewController.h
//  JSM
//
//  Created by 黄沐 on 2016/10/19.
//  Copyright © 2016年 Jiumeisheng. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <AVFoundation/AVFoundation.h>
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>

@protocol UIViewPassValueDelegate <NSObject>

-(void)passValue:(NSString *)stringValue;


@end



@interface JMSScanViewController : UIViewController<AVCaptureMetadataOutputObjectsDelegate,ABNewPersonViewControllerDelegate,ABPeoplePickerNavigationControllerDelegate,UINavigationControllerDelegate,UIViewPassValueDelegate>
{
    int num;
    BOOL upOrdown;
    NSTimer * timer;
}
@property (strong,nonatomic)AVCaptureDevice * device;
@property (strong,nonatomic)AVCaptureDeviceInput * input;
@property (strong,nonatomic)AVCaptureMetadataOutput * output;
@property (strong,nonatomic)AVCaptureSession * session;
@property (strong,nonatomic)AVCaptureVideoPreviewLayer * preview;
@property (strong,nonatomic) UIImageView * line;
@property (strong,nonatomic)NSString *stringValue;

@property (nonatomic) ABRecordRef  addPeople;
@end
