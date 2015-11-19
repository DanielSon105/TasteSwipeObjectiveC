//
//  AppSettingsViewController.m
//  TasteSwipeObjectiveC
//
//  Created by Daniel Barrido on 11/15/15.
//  Copyright © 2015 Daniel Barrido. All rights reserved.
//

#import "AppSettingsViewController.h"
#import "NetworkClient.h"

@interface AppSettingsViewController ()
@property NetworkClient *networkClient;

@end

@implementation AppSettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.networkClient = [NetworkClient new];
    self.networkClient.accessToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"accessToken"];

    NSLog(@"token on logout page --> %@", self.networkClient.accessToken);
    // Do any additional setup after loading the view.
}

- (IBAction)onLogoutButtonTapped:(id)sender {
    [self deleteToken:self.networkClient.accessToken];
    //programmatic segue to Welcomeview Controller or Sign-up View Controller?
    
}


-(void)deleteToken:(NSString *)token
{
    NSLog(@"delete Token ---> %@", token);

    NSURLSessionConfiguration *sessionConfig =
    [NSURLSessionConfiguration defaultSessionConfiguration];

    NSURLSession *session =
    [NSURLSession sessionWithConfiguration:sessionConfig delegate:nil delegateQueue:nil];


    NSURL *url =[NSURL URLWithString:@"http://tasteswipe-int.herokuapp.com/tokens"];

    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];

    request.HTTPMethod = @"DELETE";

    [request setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Accept"];

    [request setValue:[NSString stringWithFormat:@"Token token=\"%@\"; charset=utf-8", token] forHTTPHeaderField:@"Authorization"];

    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{

            if (!error) {
                NSHTTPURLResponse *httpResp = (NSHTTPURLResponse*) response;
                if (httpResp.statusCode == 200) {
                    // 3
                    NSString *text =
                    [[NSString alloc]initWithData:data
                                         encoding:NSUTF8StringEncoding];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"accessToken"];
                        NSLog(@"%@", text);
                        NSLog(@"delete works");

                        [self performSegueWithIdentifier: @"LogOutToSignInSegue" sender:self];

                    });

                } else {
                    NSLog(@"token was not deleted");
                    NSLog(@"%ld", (long)httpResp.statusCode);
                    // HANDLE BAD RESPONSE //
                }
            } else {
                // ALWAYS HANDLE ERRORS :-] //
            }

        });
    }];
    
    [task resume];
    
}

@end
