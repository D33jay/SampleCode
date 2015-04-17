//
//  MCBlockAlert.h
//  iOSStdLibrary
//
//  Created by David Joerg on 09.04.15.
//  Copyright (c) 2015 Mobile City GmbH. All rights reserved.
//


//This is a Wrapper Class for UIAlertController and UIAlertView. It uses blocks for UIAlertView to make it easier
//handling button touches. This class is used for applications which are developed for iOS 8 and less. It desides
//if a UIALertController or a UIAlertView is diesplayed to the user. This is important for applications which should
//run on iOS 8.0 and less, because for using UIAlertController you need iOS 8.0 or higher. 

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class MCBlockAlert;

typedef void(^MCBlockAlertCompletionBlock)(MCBlockAlert *alert, NSInteger buttonIndex);


@interface MCBlockAlert : NSObject

/**
 *  Creates and returns an MCBlockAlert instance
 *
 *  @param viewController         The viewcontroller to present the alert
 *  @param title                  The title of the alert.
 *  @param message                The message of the alert.
 *  @param cancelButtonTitle      The title of the cancel button. Normally you would put in something like "Ok".
 *  @param destructiveButtonTitle The title of the destructive button. This button is displayed with red text font.
 *  @param otherButtonTitles      The other button titles. For each button title in theses NSArray, the alert creates a new button
 *  @param tapBlock               The tapblock which is called for every button touch of the alert. To find out which button was touched, just use the buttonIndex parameter which is passed to the block.
 *
 *  @return returns an instance of MCBlockAlert
 */
+ (instancetype)alertInViewController:(UIViewController *)viewController
							withTitle:(NSString *)title
							  message:(NSString *)message
					cancelButtonTitle:(NSString *)cancelButtonTitle
			   destructiveButtonTitle:(NSString *)destructiveButtonTitle
					otherButtonTitles:(NSArray *)otherButtonTitles
							 tapBlock:(MCBlockAlertCompletionBlock)tapBlock;

/**
 *  Creates an MCBlockAlert instance and shows it immediately in the passed viewController
 *
 *  @param viewController    The viewcontroller to present the alert
 *  @param title             The title of the alert.
 *  @param message           The message of the alert.
 *  @param cancelButtonTitle The title of the cancel button. Normally you would put in something like "Ok".
 *
 *  @return returns an instance of MCBlockAlert
 */
+ (instancetype)showAlertInViewController:(UIViewController *)viewController
								withTitle:(NSString *)title
								  message:(NSString *)message
						cancelButtonTitle:(NSString *)cancelButtonTitle;


/**
 *  Creates an MCBlockAlert instance and shows it immediately in the passed viewController
 *
 *  @param viewController         The viewcontroller to present the alert
 *  @param title                  The title of the alert.
 *  @param message                The message of the alert.
 *  @param cancelButtonTitle      The title of the cancel button. Normally you would put in something like "Ok".
 *  @param destructiveButtonTitle The title of the destructive button. This button is displayed with red text font.
 *  @param otherButtonTitles      The other button titles. For each button title in theses NSArray, the alert creates a new button
 *  @param tapBlock               The tapblock which is called for every button touch of the alert. To find out which button was touched, just use the buttonIndex parameter which is passed to the block.
 *
 *  @return returns an instance of MCBlockAlert
 */
+ (instancetype)showAlertInViewController:(UIViewController *)viewController
								withTitle:(NSString *)title
								  message:(NSString *)message
						cancelButtonTitle:(NSString *)cancelButtonTitle
				   destructiveButtonTitle:(NSString *)destructiveButtonTitle
						otherButtonTitles:(NSArray *)otherButtonTitles
								 tapBlock:(MCBlockAlertCompletionBlock)tapBlock;


/**
 *  shows an MCBLockalert in the passed viewController
 *
 *  @param viewController The viewController which should present the MCBlockalert
 */
-(void)showInViewController:(UIViewController *)viewController;

@end
