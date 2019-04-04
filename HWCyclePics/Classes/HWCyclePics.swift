//
//  HWCyclePics.swift
//  HWCyclePics_Example
//
//  Created by 袁海文 on 2019/3/29.
//  Copyright © 2019年 CocoaPods. All rights reserved.
//

import UIKit

public typealias BannerClick = (Int)->()
public typealias LoadImageBlock = (UIImageView, String)->()


/// PageControl的位置：默认在中间
public enum PageControlPosition {
    case left
    case center
    case right
}

public class HWCyclePics: UIView {

    var scrollView: UIScrollView!
    
    var pageControl: UIPageControl!
    
    /// 轮播图的方向,默认水平方向
    public var isDirectionPortrait: Bool = false
    
    /// banner的循环间隔:默认5秒
    public var kInterval: Double = 5.0
    
    /// 小圆点的位置：默认在中间
    public var pageControlPosition: PageControlPosition = PageControlPosition.center
    
    /// 数据源数组，保存图片的名字或者url字符串
    public var bannerList: [String]?{
        didSet{
            
            self.layoutIfNeeded()
            pageControl.numberOfPages =  bannerList?.count ?? 0
            pageControl.currentPage = 0
            self.updateImgView()
            self.stopTimer()
            self.startTimer()
            
        }
    }
    
    /// 自动轮播定时器
    
    lazy var timer: DispatchSourceTimer = {
        let aTimer = DispatchSource.makeTimerSource(queue:DispatchQueue.global())
        
        let deadline = DispatchTime.now() + kInterval
        aTimer.schedule(deadline: deadline, repeating: kInterval)
        
        // 设定时间源的触发事件
        aTimer.setEventHandler(handler: {
            // 返回主线程处理一些事件，更新UI等等
            DispatchQueue.main.async {
                self.nextStep()
            }
        })
        aTimer.resume()
        return aTimer
    }()
    
    /// 图片的加载事件
    public var loadBlock: LoadImageBlock?
    
    /// 图片的点击事件
    public var block: BannerClick?
    
    /// pageControl小圆点默认颜色
    public var pageControlIndicatorColor = UIColor.white
    /// pageControl小圆点当前颜色
    public var pageControlCurrentColor = UIColor.red
    
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupUI()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        self.setupUI()
        
    }
    
     public override func layoutSubviews() {
        super.layoutSubviews()
        
        scrollView.frame = self.bounds
        
        let width = self.bounds.size.width
        let height = self.bounds.size.height
        
        if isDirectionPortrait == true {
            scrollView.contentSize = CGSize(width: 0, height: 3 * height)
        }else{
            scrollView.contentSize = CGSize(width: 3 * width, height: 0)
        }
        
        for i in 0...(scrollView.subviews.count - 1) {
            let imageView = scrollView.subviews[i]
            if isDirectionPortrait == true {
                imageView.frame = CGRect(x: 0, y: CGFloat(i) * height, width: width, height: height)
            }else{
                imageView.frame = CGRect(x: CGFloat(i) * width, y: 0, width: width, height: height)
            }
        }
        
        let widthPageControl: CGFloat = 80.0
        let heightPageControl: CGFloat = 20.0
        
        if (pageControlPosition == PageControlPosition.left) {
            pageControl.frame = CGRect(x: 0, y: height - heightPageControl, width: widthPageControl, height: heightPageControl)
        }else if (pageControlPosition == PageControlPosition.center){
            pageControl.frame = CGRect(x: (width - widthPageControl) / 2, y: height - heightPageControl, width: widthPageControl, height: heightPageControl);
        }else if (pageControlPosition == PageControlPosition.right) {
            pageControl.frame = CGRect(x: width - widthPageControl, y: height - heightPageControl, width: widthPageControl, height: heightPageControl);
        }
        
    }
    
}
extension HWCyclePics{
    func setupUI(){
        
        scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.isPagingEnabled = true
        scrollView.bounces = false
        scrollView.delegate = self as UIScrollViewDelegate
        self.addSubview(scrollView)
        
        for i in 0...2 {
            let imageView = UIImageView()
            if i == 1 {
                let tap = UITapGestureRecognizer.init(target: self, action: #selector(tap(tap:)))
                imageView.isUserInteractionEnabled = true
                imageView.addGestureRecognizer(tap)
            }
            scrollView.addSubview(imageView)
        }
        pageControl = UIPageControl()
        
        pageControl.currentPageIndicatorTintColor = pageControlCurrentColor
        pageControl.pageIndicatorTintColor = pageControlIndicatorColor
        
        self.addSubview(pageControl)
        
    }
    
    @objc func tap(tap: UITapGestureRecognizer) {
        if let imgClick = block {
            imgClick((tap.view?.tag)!)
        }
    }
    func updateImgView(){
        for i in 0...(scrollView.subviews.count - 1) {
            let imageView = scrollView.subviews[i] as! UIImageView
            var index = pageControl.currentPage
            if i == 0 {
                index -= 1
            }else if i == 2{
                index += 1
            }
            
            if index < 0 {
                index = (bannerList?.count ?? 0) - 1
            }else if index >= (bannerList?.count ?? 0) {
                index = 0
            }
            
            guard let arr = bannerList, (bannerList?.count ?? 0) > 0 else{
                return
            }
            
            imageView.tag = index
            
            let imgName = arr[index]
            
            if let loadImg = loadBlock {
                loadImg(imageView, imgName)
            }
            
        }
        
        if isDirectionPortrait == true {
            
            scrollView.setContentOffset(CGPoint(x: 0, y: self.bounds.size.height), animated: false)
        } else {
            
            scrollView.setContentOffset(CGPoint(x: self.bounds.size.width, y: 0), animated: false)
        }
    }
    
    func startTimer() {
        timer.resume()
    }
    func stopTimer() {
        timer.suspend()
    }
    
    func nextStep(){
        
        if isDirectionPortrait == true {
            scrollView.setContentOffset(CGPoint(x: 0, y: 2 * self.bounds.size.height), animated: true)
        } else {
            
            scrollView.setContentOffset(CGPoint(x: 2 * self.bounds.size.width, y: 0), animated: true)
        }
    }
    
    func verifyURL(url: String) -> Bool{
        
        let pattern = "((http|ftp|https)://)(([a-zA-Z0-9\\._-]+\\.[a-zA-Z]{2,6})|([0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}))(:[0-9]{1,4})*(/[a-zA-Z0-9\\&%_\\./-~-]*)?"
        let pred = NSPredicate(format: "SELF MATCHES %@", pattern)
        return pred.evaluate(with: url)
    }
    
}
// MARK: - UIScrollViewDelegate
extension HWCyclePics: UIScrollViewDelegate{
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        var page = 0
        var minDistance = CGFloat(MAXFLOAT)
        for i in 0...(scrollView.subviews.count - 1) {
            var distance: CGFloat = 0
            let imageView = scrollView.subviews[i]
            if isDirectionPortrait == true {
                distance = abs(imageView.frame.origin.y - scrollView.contentOffset.y)
            }else{
                distance = abs(imageView.frame.origin.x - scrollView.contentOffset.x)
            }
            if distance < minDistance{
                minDistance = distance
                page = imageView.tag
            }
        }
        pageControl.currentPage = page
    }
    
    public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        self.stopTimer()
    }
    
    public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        self.startTimer()
    }
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        self.updateImgView()
    }
    
    public func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        
        self.updateImgView()
    }
    
}
