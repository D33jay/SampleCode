//
//  MCBlockAlert.m
//  iOSStdLibrary
//
//  Created by David Joerg on 09.04.15.
//  Copyright (c) 2015 Mobile City GmbH. All rights reserved.
//

#import "MCBlockAlert.h"
#import <iOSBlocks/UIKit/UIAlertView+Block.h>

static NSInteger const MCBlockAlertNoButtonExistsIndex = -1;

static NSInteger const MCBlockAlertCancelButtonIndex = 0;
static NSInteger const MCBlockAlertDestructiveButtonIndex = 1;
static NSInteger const MCBlockAlertFirstOtherButtonIndex = 2;

@interface MCBlockAlert ()

@property (nonatomic) UIAlertController *alertController;
@property (nonatomic) UIAlertView *alertView;
@property (nonatomic) UIActionSheet *actionSheet;

@property (nonatomic, assign) BOOL hasCancelButton;
@property (nonatomic, assign) BOOL hasDestructiveButton;
@property (nonatomic, assign) BOOL hasOtherButtons;

@end

@implementation MCBlockAlert

+ (instancetype)alertInViewController:(UIViewController *)viewController
							withTitle:(NSString *)title
							  message:(NSString *)message
					cancelButtonTitle:(NSString *)cancelButtonTitle
			   destructiveButtonTitle:(NSString *)destructiveButtonTitle
					otherButtonTitles:(NSArray *)otherButtonTitles
							 tapBlock:(MCBlockAlertCompletionBlock)tapBlock
{
	
	MCBlockAlert *alert = [[MCBlockAlert alloc] init];
	
	alert.hasCancelButton = cancelButtonTitle != nil;
	alert.hasDestructiveButton = destructiveButtonTitle != nil;
	alert.hasOtherButtons = otherButtonTitles.count > 0;
	
	//if the UIAlertController has been found use this for presenting the alert
	//(iOS 8.0 and higer)
	if ([UIAlertController class])
	{
		alert.alertController = [UIAlertController alertControllerWithTitle:title
																	message:message
															 preferredStyle:UIAlertControllerStyleAlert];
		
		//Add cancel action
		if(cancelButtonTitle)
		{
			UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelButtonTitle
																   style:UIAlertActionStyleCancel
																 handler:^(UIAlertAction* action)
										   {
											   if(tapBlock)
											   {
												   tapBlock(alert, MCBlockAlertCancelButtonIndex);
											   }
										   }];
			
			[alert.alertController addAction:cancelAction];
		}
		
		//Add destructive action
		if(destructiveButtonTitle)
		{
			UIAlertAction *destructiveAction = [UIAlertAction actionWithTitle:destructiveButtonTitle
																		style:UIAlertActionStyleDestructive
																	  handler:^(UIAlertAction* action)
												{
													if(tapBlock)
													{
														tapBlock(alert, MCBlockAlertDestructiveButtonIndex);
													}
												}];
			
			[alert.alertController addAction:destructiveAction];
		}
		
		
		//Add other actions
		for(int i = 0; i < otherButtonTitles.count; i++)
		{
			UIAlertAction *action = [UIAlertAction actionWithTitle:otherButtonTitles[i]
															 style:UIAlertActionStyleDefault
														   handler:^(UIAlertAction* action)
									 {
										 if(tapBlock)
											 tapBlock(alert, MCBlockAlertFirstOtherButtonIndex + i);
									 }];
			
			[alert.alertController addAction:action];
		}
		
	}
	else	//UIAlertController not found, so use UIAlertViews
	{
		alert.alertView = [UIAlertView alertViewWithTitle:title
												  message:message
										cancelButtonTitle:cancelButtonTitle
										otherButtonTitles:otherButtonTitles
												onDismiss:^(NSInteger buttonIndex, NSString *buttonTitle)
						   {
							   if(tapBlock)
								   tapBlock(alert, buttonIndex);
						   }
												 onCancel:^
						   {
							   if(tapBlock)
								   tapBlock(alert, MCBlockAlertCancelButtonIndex);
						   }];
		

	}
	
	return alert;

}

+ (instancetype)showAlertInViewController:(UIViewController *)viewController
								withTitle:(NSString *)title
								  message:(NSString *)message
						cancelButtonTitle:(NSString *)cancelButtonTitle
{
	return [MCBlockAlert showAlertInViewController:viewController
										 withTitle:title
										   message:message
								 cancelButtonTitle:cancelButtonTitle
							destructiveButtonTitle:nil
								 otherButtonTitles:nil
										  tapBlock:nil];
}

+ (instancetype)showAlertInViewController:(UIViewController *)viewController
								withTitle:(NSString *)title
								  message:(NSString *)message
						cancelButtonTitle:(NSString *)cancelButtonTitle
				   destructiveButtonTitle:(NSString *)destructiveButtonTitle
						otherButtonTitles:(NSArray *)otherButtonTitles
								 tapBlock:(MCBlockAlertCompletionBlock)tapBlock
{
	MCBlockAlert *alert = [MCBlockAlert alertInViewController:viewController
													withTitle:title
													  message:message
											cancelButtonTitle:cancelButtonTitle
									   destructiveButtonTitle:destructiveButtonTitle
											otherButtonTitles:otherButtonTitles
													 tapBlock:tapBlock];
	
	[alert showInViewController:viewController];
	
	return alert;
}

-(void)showInViewController:(UIViewController *)viewController
{
	if ([UIAlertController class])
	{
		if(viewController)
			[viewController presentViewController:self.alertController animated:YES completion:nil];
	}
	else
	{
		[self.alertView show];
	}
}

#pragma mark -


- (NSInteger)cancelButtonIndex
{
	if (!self.hasCancelButton) {
		return MCBlockAlertNoButtonExistsIndex;
	}
	
	return MCBlockAlertCancelButtonIndex;
}

- (NSInteger)firstOtherButtonIndex
{
	if (!self.hasOtherButtons) {
		return MCBlockAlertNoButtonExistsIndex;
	}
	
	return MCBlockAlertFirstOtherButtonIndex;
}

- (NSInteger)destructiveButtonIndex
{
	if (!self.hasDestructiveButton) {
		return MCBlockAlertNoButtonExistsIndex;
	}
	
	return MCBlockAlertDestructiveButtonIndex;
}

@end


