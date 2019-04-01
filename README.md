 <h1> HWCyclePics</h1>轻量级的无限轮播图
 
 ## How To Use
 * 代码加载
 ```
 import HWCyclePics
 ...
 let banner = HWCyclePics.init(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 180))
 //设置图片数据源，本地或者接口返回，本地时为图片的名字，接口返回时为图片的下载地址
 //banner.bannerList = ["abc","def","ghi","ojk"]
 banner.bannerList = ["http://images.drztc.com/upload/banner/2019/03/21/2a86d6f9d8e43888fe13a90d5d4deedc.jpg","http://images.drztc.com/upload/banner/2019/03/25/e01ba649170f70b833af37708aaf8b53.jpg","http://images.drztc.com/upload/banner/2018/11/07/c3be84a6f19d56934a773c5225ddaac2.jpg","http://images.drztc.com/upload/banner/2018/05/23/58de5f57f239588284c42931dc53e93f.jpg"]
 //设置点击事件
 banner.block = {
 (tag: Int) -> Void in
 print(tag)
 }
 self.view.addSubview(banner)
 ```
 * Nib加载
 ```
 import HWCyclePics
 ...
 @IBOutlet weak var banner: HWCyclePics!
 ...
 //设置图片数据源
 banner.bannerList = ["abc","def","ghi","ojk"]
 //设置点击事件
 banner.block = {
 (tag: Int) -> Void in
 print(tag)
 }
 ```
 
 ## Installation
 
 HWCyclePics is available through [CocoaPods](https://cocoapods.org). To install
 it, simply add the following line to your Podfile:
 
 ```ruby
 pod 'HWCyclePics'
 ```
 
 ## Author
 本人小菜鸟一枚，欢迎各位同仁和大神指教，我的联系方式是：
 RedGerrard, 417705652@qq.com
 
 ## Licenses
 
 All source code is licensed under the [MIT License](https://raw.github.com/SDWebImage/SDWebImage/master/LICENSE).
