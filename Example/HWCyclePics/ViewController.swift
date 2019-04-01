//
//  ViewController.swift
//  HWCyclePics
//
//  Created by wozaizhelishua on 03/29/2019.
//  Copyright (c) 2019 wozaizhelishua. All rights reserved.
//

import UIKit
import HWCyclePics

class ViewController: UIViewController {
    
    @IBOutlet weak var banner: HWCyclePics!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        banner.bannerList = ["abc","def","ghi","ojk"]
        banner.bannerList = ["http://images.drztc.com/upload/banner/2019/03/21/2a86d6f9d8e43888fe13a90d5d4deedc.jpg","http://images.drztc.com/upload/banner/2019/03/25/e01ba649170f70b833af37708aaf8b53.jpg","http://images.drztc.com/upload/banner/2018/11/07/c3be84a6f19d56934a773c5225ddaac2.jpg","http://images.drztc.com/upload/banner/2018/05/23/58de5f57f239588284c42931dc53e93f.jpg"]
        banner.block = {
            (tag: Int) -> Void in
            print(tag)
        }
        
        
//        let banner = HWCyclePics.init(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 180))
////        banner.bannerList = ["abc","def","ghi","ojk"]
//        banner.bannerList = ["http://images.drztc.com/upload/banner/2019/03/21/2a86d6f9d8e43888fe13a90d5d4deedc.jpg","http://images.drztc.com/upload/banner/2019/03/25/e01ba649170f70b833af37708aaf8b53.jpg","http://images.drztc.com/upload/banner/2018/11/07/c3be84a6f19d56934a773c5225ddaac2.jpg","http://images.drztc.com/upload/banner/2018/05/23/58de5f57f239588284c42931dc53e93f.jpg"]
//
//        banner.block = {
//            (tag: Int) -> Void in
//            print(tag)
//        }
//        self.view.addSubview(banner)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

