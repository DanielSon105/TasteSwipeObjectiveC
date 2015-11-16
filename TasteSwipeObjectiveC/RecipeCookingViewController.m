//
//  RecipeCookingViewController.m
//  TasteSwipeObjectiveC
//
//  Created by Michelle Burke on 11/16/15.
//  Copyright © 2015 Daniel Barrido. All rights reserved.
//

#import "RecipeCookingViewController.h"
#import "EntryViewController.h"
#import "Recipe.h"
#import "RecipeStep.h"

@interface RecipeCookingViewController () <UIPageViewControllerDataSource>

@property UIPageViewController *recipeBook;
@property NSDictionary *fakeRecipeID1;
@property NSString *fakeRecipeOrder1;
@property NSString *fakeRecipeDescription1;
@property NSDictionary *fakeRecipeID2;
@property NSString *fakeRecipeOrder2;
@property NSString *fakeRecipeDescription2;
@property NSMutableArray *arrayOfRecipeSteps;

@end

@implementation RecipeCookingViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.fakeRecipeOrder1 = @"1";
    self.fakeRecipeOrder2 = @"2";
    self.fakeRecipeDescription1 = @"prepare ingredients";
    self.fakeRecipeDescription2 = @"cook ingredients";
    self.fakeRecipeID1 = [[NSDictionary alloc] initWithObjectsAndKeys:self.fakeRecipeOrder1, @"order", self.fakeRecipeDescription1, @"description", nil];
    self.fakeRecipeID2 = [[NSDictionary alloc] initWithObjectsAndKeys:self.fakeRecipeOrder2, @"order", self.fakeRecipeDescription2, @"description", nil];
    self.recipeSteps = [NSArray arrayWithObjects:self.fakeRecipeID1, self.fakeRecipeID2, nil];

    self.arrayOfRecipeSteps = [NSMutableArray new];
    for (NSDictionary *dict in self.recipeSteps) {
        RecipeStep *step = [[RecipeStep alloc] initWithContentsOfDictionary:dict];
        [self.arrayOfRecipeSteps addObject:step];
    }

    self.recipeBook = [UIPageViewController new];

    self.recipeBook.view.frame = self.view.frame;
    self.recipeBook.dataSource = self;
    [self addChildViewController:self.recipeBook];
    [self.view addSubview:self.recipeBook.view];

    [self didMoveToParentViewController:self];

    [self.recipeBook setViewControllers:@[[self getEntryController:0]] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
}

-(UIViewController *)getEntryController:(NSInteger)index{
    if (index >= 0) {
        EntryViewController *entryVC = [self.storyboard instantiateViewControllerWithIdentifier:@"RecipeSteps"];
        entryVC.step = self.arrayOfRecipeSteps[index];
        entryVC.page = index;
        return entryVC;
    }
    return nil;
}

-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    NSInteger index = ((EntryViewController *) viewController).page + 1;
    if (((EntryViewController *) viewController).page == NSNotFound || index == self.arrayOfRecipeSteps.count) {
        return nil;
    }
    return [self getEntryController:index];
}

-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
    NSInteger index = ((EntryViewController *)viewController).page - 1;
    if (((EntryViewController *) viewController).page == NSNotFound || index < 0) {
        return nil;
    }
    return [self getEntryController:index];
}

-(NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController{
    return self.arrayOfRecipeSteps.count;
}

-(NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController{
    return 0;
}

@end