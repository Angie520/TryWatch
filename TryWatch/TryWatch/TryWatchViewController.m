//
//  TryWatchViewController.m
//  TryWatch
//
//  Created by K.Lam on 2017/4/7.
//  Copyright © 2017年 wbiao. All rights reserved.
//

#import "TryWatchViewController.h"

#define GBWidth [UIScreen mainScreen].bounds.size.width

@interface TryWatchViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic , weak) UIImageView *imageView;

@end

@implementation TryWatchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, GBWidth, GBWidth)];
    [self.view addSubview:imageView];
    imageView.userInteractionEnabled = YES;
    self.imageView = imageView;
    
    
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake((GBWidth - 100) / 2, GBWidth + 104, 100, 40)];
    [btn addTarget:self action:@selector(openCamera) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"打开相机" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:btn];
    
}

- (void)openCamera {
    NSLog(@"打开相机");
    
    NSUInteger sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    sourceType = UIImagePickerControllerSourceTypeCamera;
    // 跳转到相机或相册页面
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
    imagePickerController.allowsEditing = YES;
    imagePickerController.sourceType = sourceType;
    
    [self presentViewController:imagePickerController animated:YES completion:^{
        
    }];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    self.imageView.image = image;
    
    [self addWatchToImageView];
}


- (void)addWatchToImageView {
    UIImageView *watchView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 100, 100)];
    watchView.image = [UIImage imageNamed:@"watch.jpg"];
    watchView.userInteractionEnabled = YES;
    [self.imageView addSubview:watchView];
    
    // 旋转手势
    UIRotationGestureRecognizer *rotationGestureRecognizer = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotateView:)];
    [watchView addGestureRecognizer:rotationGestureRecognizer];
    
    // 缩放手势
    UIPinchGestureRecognizer *pinchGestureRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchView:)];
    [watchView addGestureRecognizer:pinchGestureRecognizer];
    
    // 移动手势
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panView:)];
    [watchView addGestureRecognizer:panGestureRecognizer];
}

// 处理旋转手势
- (void) rotateView:(UIRotationGestureRecognizer *)rotationGestureRecognizer
{
    UIView *view = rotationGestureRecognizer.view;
    if (rotationGestureRecognizer.state == UIGestureRecognizerStateBegan || rotationGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        view.transform = CGAffineTransformRotate(view.transform, rotationGestureRecognizer.rotation);
        [rotationGestureRecognizer setRotation:0];
    }
}

// 处理缩放手势
- (void) pinchView:(UIPinchGestureRecognizer *)pinchGestureRecognizer
{
    UIView *view = pinchGestureRecognizer.view;
    if (pinchGestureRecognizer.state == UIGestureRecognizerStateBegan || pinchGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        view.transform = CGAffineTransformScale(view.transform, pinchGestureRecognizer.scale, pinchGestureRecognizer.scale);
        pinchGestureRecognizer.scale = 1;
    }
}

// 处理拖拉手势
- (void) panView:(UIPanGestureRecognizer *)panGestureRecognizer
{
    UIView *view = panGestureRecognizer.view;
    if (panGestureRecognizer.state == UIGestureRecognizerStateBegan || panGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        CGPoint translation = [panGestureRecognizer translationInView:view.superview];
        [view setCenter:(CGPoint){view.center.x + translation.x, view.center.y + translation.y}];
        [panGestureRecognizer setTranslation:CGPointZero inView:view.superview];
    }
}

@end
