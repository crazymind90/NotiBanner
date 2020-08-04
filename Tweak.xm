// By @CrazyMind90



#import "CMManager.h"


@interface UIApplication ()

-(void) launchApplicationWithIdentifier:(NSString*)identifier suspended:(BOOL)suspended;

@end


@interface SBApplication : NSObject

-(void) Open;
-(void) Dismiss;

@end



UIView *View;
UIView *New;
UIWindow *Window;
NSString *Bundle;

%hook SBApplication
-(BOOL)icon:(id)arg1 launchFromLocation:(id)arg2 context:(id)arg3 {

  NSString *bundle = MSHookIvar<NSString*>(self,"_bundleIdentifier");


  if ([bundle isEqual:@"com.apple.Preferences"]) {

  [Window removeFromSuperview];
  [Window setHidden:YES];
  [View setHidden:YES];

  Bundle = bundle;

  [self performSelector:@selector(ShowView)];

  return NO;

}

return %orig;

}

%new
-(void) ShowView {


     // Create UIWindow to make the new view on it
     Window = [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT/5)];


    // New View
    View = [CMManager InitViewWithBGColor:UIColor.clearColor LeftRight:22.7 UpDown:19.5 Width:1.1 Height:9 Blur:YES BackgroundImage:nil InView:New];
    View.layer.cornerRadius = 20;


    // Animation
    [CMManager ViewToBeAnimated:View delegate:New Duration:0.7 StartAnimationFrom:kCATransitionFromRight];



    // set Label
    [CMManager InitLabelInsideViewWithName:@"Open Preferences ?" TextAlignment:NSTextAlignmentCenter TextColor:UIColor.whiteColor LeftRight:0 UpDown:-0.4 Width:1 Height:1.20 InView:View];



    // First button
    UIButton *FirstButton = [CMManager InitButtonInsideViewWithName:@"Dismiss" LeftRight:0.1 UpDown:0.5 Width:0.3 Height:0.4 InView:View Target:self Action:@selector(Dismiss)];

    FirstButton.backgroundColor = UIColorFromHEX(0x303030);
    [FirstButton setTitleColor:UIColorFromHEX(0xFF6557) forState:UIControlStateNormal];
    FirstButton.showsTouchWhenHighlighted = YES;

    if ([CMManager isIPhonexScreen])
    FirstButton.layer.cornerRadius = 20;

    if (![CMManager isIPhonexScreen])
    FirstButton.layer.cornerRadius = 12;




    // Second button
    UIButton *SecondButton =  [CMManager InitButtonInsideViewWithName:@"Open" LeftRight:0.6 UpDown:0.5 Width:0.3 Height:0.4 InView:View Target:self Action:@selector(Open)];

    SecondButton.backgroundColor = UIColorFromHEX(0x303030);
    [SecondButton setTitleColor:UIColorFromHEX(0x3E71D8) forState:UIControlStateNormal];
    SecondButton.showsTouchWhenHighlighted = YES;

    if ([CMManager isIPhonexScreen])
    SecondButton.layer.cornerRadius = 20;

    if (![CMManager isIPhonexScreen])
    SecondButton.layer.cornerRadius = 12;



// Show the new view inside UIWindow
    [Window makeKeyAndVisible];
    [Window addSubview:View];
}


// FirstButton action
%new
-(void) Dismiss {

  [Window removeFromSuperview];
  [Window setHidden:YES];
  [View setHidden:YES];


}


// SecondButton action
%new
-(void) Open {

  [[UIApplication sharedApplication] launchApplicationWithIdentifier:Bundle suspended:NO];

  [Window removeFromSuperview];
  [Window setHidden:YES];
  [View setHidden:YES];


}

%end

























































//
