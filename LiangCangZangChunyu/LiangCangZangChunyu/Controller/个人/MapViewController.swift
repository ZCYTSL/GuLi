//
//  MapViewController.swift
//  LiangCangZangChunyu
//
//  Created by qianfeng on 16/9/18.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit
import MapKit



class MapViewController: UIViewController,MAMapViewDelegate,AMapSearchDelegate {
    
    var mapView:MAMapView!
    var searchAPI = AMapSearchAPI()
    var searchTF:UITextField!
    var searchPOI:UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.creatMapView()
        self.mapFoundations()
        self.creatSearchBar()
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = true
    }
    //创建地图
    func creatMapView() {
        AMapServices.sharedServices().apiKey = APIKey
        mapView = MAMapView.init(frame: self.view.bounds)
        mapView.delegate = self
        self.view.addSubview(mapView)
        self.view.sendSubviewToBack(mapView)
    }
    //地图的基本设置
    func mapFoundations() {
        mapView.mapType = MAMapType.Standard
        mapView.showsUserLocation = true
        mapView.showsScale = true
        mapView.showsCompass = true
        mapView.showTraffic = true
    }
    //创建一个搜索框
    func creatSearchBar() {
        searchTF = UITextField.init(frame: CGRectMake(50, 50, 250, 50))
        searchTF.placeholder = "搜索内容"
        searchTF.backgroundColor = UIColor.grayColor()
        self.view.addSubview(searchTF)
        searchPOI = UIButton.init(frame: CGRectMake(310, 50, 50, 50))
        searchPOI.addTarget(self, action: #selector(self.btnClick(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        searchPOI.setTitle("搜索", forState: UIControlState.Normal)
        searchPOI.setTitle("搜索", forState: UIControlState.Selected)
        searchPOI.setTitleColor(UIColor.redColor(), forState: UIControlState.Normal)
        searchPOI.setTitleColor(UIColor.redColor(), forState: UIControlState.Selected)
        self.view.addSubview(searchPOI)
    }
    
    //搜索按钮的方法
    func btnClick(button:UIButton) {
        self.searchTF.resignFirstResponder()
        self.searchAPI.delegate = self
        let request = AMapPOIAroundSearchRequest()
        request.keywords = self.searchTF.text
        request.location = AMapGeoPoint.init()
        request.radius = 5000
        request.sortrule = 0
        request.offset = 50
        searchAPI.AMapPOIAroundSearch(request)
    }
    //搜索成功的回调方法
    func onPOISearchDone(request: AMapPOISearchBaseRequest!, response: AMapPOISearchResponse!) {
        mapView.removeAnnotations(mapView.annotations)
        for poi in response.pois {
            print("名称 地址 电话 距离 纬度 经度",poi.name, poi.address, poi.tel, poi.distance, poi.location.latitude, poi.location.longitude)
            let annotation = MAPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D.init(latitude: Double(poi.location.latitude), longitude: Double(poi.location.longitude))
            annotation.title = poi.name
            annotation.subtitle = poi.tel
            mapView.addAnnotation(annotation)
        }

    }
    
    func AMapSearchRequest(request: AnyObject!, didFailWithError error: NSError!) {
        print("搜索失败:原因",error)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
