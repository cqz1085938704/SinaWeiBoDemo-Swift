//
//  UIImageView+Remote.m
//  新浪微博Demo-Swift
//
//  Created by caiyao's Mac on 2017/9/4.
//  Copyright © 2017年 core's Mac. All rights reserved.
//

#import "UIImageView+Remote.h"
#import <objc/runtime.h>

static NSString *const imageFloder = @"QDIINewsIcons";

@interface UIImageView ()

@property (nonatomic, strong)NSURLSession *session;
@property (nonatomic, strong)NSURLSessionDataTask *dataTask;

@end

@implementation UIImageView (Remote)

-(void)setSession:(NSURLSession *)session
{
    objc_setAssociatedObject(self, @selector(session), session, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(void)setDataTask:(NSURLSessionDataTask *)dataTask
{
    objc_setAssociatedObject(self, @selector(dataTask), dataTask, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(NSURLSession *)session
{
    return objc_getAssociatedObject(self, @selector(session));
}

-(NSURLSessionDataTask *)dataTask
{
    return objc_getAssociatedObject(self, @selector(dataTask));
}

-(NSString *)pathOfImage:(NSString *)imageName
{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    path = [path stringByAppendingPathComponent:@"Application Support"];
    path = [path stringByAppendingPathComponent:imageFloder];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:path isDirectory:nil])
    {
        NSError *error = nil;
        [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error];
    }
    return [NSString stringWithFormat:@"%@/%@", path, imageName];
}

-(BOOL)imageExists:(NSString *)imageName
{
    BOOL exists = NO;
    
    NSString *imagePath = [self pathOfImage:imageName];
    if ([[NSFileManager defaultManager] fileExistsAtPath:imagePath])
    {
        exists = YES;
    }
    return exists;
}

-(BOOL)saveImage:(NSData *)imageData ToPath:(NSString *)path
{
    return [[NSFileManager defaultManager] createFileAtPath:path contents:imageData attributes:nil];
}

-(NSString *)generateImageName:(NSString *)urlString
{
    NSArray *components = [urlString componentsSeparatedByString:@"="];
    NSString *imageName = urlString;
    NSString *format = @"jpeg";
    if (components.count == 2)
    {
        imageName = components[0];
        format = components[1];
    }
    
    if ([format isEqualToString:@"jpeg"])
    {
        format = @"jpg";
    }
    imageName = [imageName stringByReplacingOccurrencesOfString:@"/" withString:@""];
    imageName = [imageName stringByAppendingFormat:@".%@", format];
    return imageName;
}

-(void)setImageWithURL:(NSString *)urlString placeHolder:(NSString *)placeHolder completion:(Completion)completion
{
    [self.dataTask cancel];
    [self.session invalidateAndCancel];
    
    NSString *imageName = [self generateImageName:urlString];
    if ([self imageExists:imageName])
    {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            UIImage *cachedImage = [[UIImage alloc] initWithContentsOfFile:[self pathOfImage:imageName]];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.image = cachedImage;
            });
        });
    }
    else
    {
        self.image = [UIImage imageNamed:placeHolder];
    }
    
    __weak typeof(self) weakSelf = self;
    self.session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    self.dataTask = [self.session dataTaskWithURL:[NSURL URLWithString:urlString] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        __weak typeof(self) strongSelf = weakSelf;
        if (!error)
        {
            [strongSelf saveImage:data ToPath:[strongSelf pathOfImage:imageName]];
            UIImage *image = [UIImage imageWithData:data];
            dispatch_async(dispatch_get_main_queue(), ^{
                strongSelf.image = image;
            });
        }
        if (completion)
        {
            completion();
        }
    }];
    [self.dataTask resume];
}
@end
