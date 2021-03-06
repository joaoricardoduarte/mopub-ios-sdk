//
//  FakeGSFullScreenAd.m
//  MoPub
//
//  Copyright (c) 2013 MoPub. All rights reserved.
//

#import "FakeIMAdInterstitial.h"

@implementation FakeIMAdInterstitial

- (void)dealloc
{
    self.fakeNetworkExtras = nil;

    [super dealloc];
}

- (UIViewController *)presentingViewController
{
    return nil;
}

- (void)presentInterstitialAnimated:(BOOL)_animated
{
    if (self.willPresentSuccessfully) {
        self.didPresent = YES;
        [self.delegate interstitialWillPresentScreen:self];
    } else {
        [self.delegate interstitial:self didFailToPresentScreenWithError:nil];
    }
}

- (void)addAdNetworkExtras:(NSObject<IMNetworkExtras> *)networkExtras
{
    [super addAdNetworkExtras:networkExtras];

    self.fakeNetworkExtras = (IMInMobiNetworkExtras *)networkExtras;
}

- (void)simulateLoadingAd
{
    [self.delegate interstitialDidReceiveAd:self];
}

- (void)simulateFailingToLoad
{
    [self.delegate interstitial:self didFailToReceiveAdWithError:nil];
}

- (void)simulateUserTap
{
    [self.delegate interstitialDidInteract:self withParams:nil];
    [self.delegate interstitialWillLeaveApplication:self];
}

- (void)simulateUserDismissingAd
{
    self.didPresent = NO;
    [self.delegate interstitialWillDismissScreen:self];
}

- (void)simulateInterstitialFinishedDisappearing
{
    [self.delegate interstitialDidDismissScreen:self];
}

@end
