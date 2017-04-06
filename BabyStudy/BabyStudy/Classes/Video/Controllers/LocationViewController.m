//
//  LocationViewController.m
//  BabyStudy
//
//  Created by Cyrill on 2017/3/30.
//  Copyright © 2017年 cyrill. All rights reserved.
//

#import "LocationViewController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface LocationViewController () <MKMapViewDelegate, CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;

@end

@implementation LocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"位置";
    
    //获取用户授权
    [self.locationManager requestAlwaysAuthorization];
    
    //获取当前授权状态
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    if (status == kCLAuthorizationStatusAuthorizedAlways || status == kCLAuthorizationStatusAuthorizedWhenInUse)
    {
        NSLog(@"授权通过");
    }
    else
    {
        NSLog(@"授权不通过");
    }
    //设置代理
    self.locationManager.delegate = self;
    //设置经度
    self.locationManager.desiredAccuracy =kCLLocationAccuracyBest;
    //开始定位
    [self.locationManager startUpdatingLocation];
    
     // stopUpdatingLocation
    
    
    MKMapView *mapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
    mapView.delegate = self;
    mapView.showsUserLocation = YES;
    [self.view addSubview:mapView];
}

- (void)mapViewWillStartLoadingMap:(MKMapView *)mapView {
    
}

- (void)mapViewDidFinishLoadingMap:(MKMapView *)mapView {
    
}

- (void)mapViewDidStopLocatingUser:(MKMapView *)mapView {
    NSLog(@"");
}

- (void)mapViewWillStartLocatingUser:(MKMapView *)mapView {
    NSLog(@"");
}

- (void)mapViewWillStartRenderingMap:(MKMapView *)mapView {
    NSLog(@"");
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
    NSLog(@"");
    
//    CLLocationCoordinate2D loc = [userLocation coordinate];
//    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(loc, 250, 250);
//    mapView.region = region;
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    NSLog(@"");
    
    // NSLog(@"%@",locations);
    //取出位置信息
    CLLocation *location = [locations lastObject];
    
    //创建地理信息编解码对象
    CLGeocoder *geoCoder = [[CLGeocoder alloc]init];
    
    //转换位置信息
    [geoCoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        //        NSLog(@"%@",placemarks[0]);
        CLPlacemark *placeMark = placemarks[0];
        NSLog(@"%@%@",placeMark.country,placeMark.locality);
    }];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"%@",error);
}

- (void)locationManagerDidPauseLocationUpdates:(CLLocationManager *)manager {
    
}

- (void)locationManager:(CLLocationManager *)manager didVisit:(CLVisit *)visit {
    
}

- (void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region {
    
}

- (CLLocationManager *)locationManager
{
    if (!_locationManager) {
        _locationManager = [[CLLocationManager alloc] init];
    }
    return _locationManager;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
