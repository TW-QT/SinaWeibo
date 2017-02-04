//
//  TFPicCollectionView.swift
//  SinaWeibo
//
//  Created by Donkey-Tao on 2016/10/4.
//  Copyright © 2016年 http://taofei.me All rights reserved.
//

import UIKit

class TFPicCollectionView: UICollectionView {
    
    
    //MARK:- 定义属性
    var picURLs : [URL] = [URL](){//微博配图的URL
        didSet{
            self.reloadData()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        dataSource = self
    }

}


//MARK:- 数据源方法
extension TFPicCollectionView : UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return picURLs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //1.获取cell
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: "PicCell", for: indexPath) as! TFPicCollectionViewCell
        
        
        
        //2.给cell设置数值
        cell.backgroundColor = UIColor.purple
        cell.picURL = picURLs[indexPath.item]
        
        //3.返回cell
        return cell
    }
}


//MARK:- 自定义cell
class TFPicCollectionViewCell: UICollectionViewCell {
    //MARK:- 定义模型属性
    var picURL : URL?{
        didSet{
            guard let picURL = picURL  else {
                return
            }
            iconView.sd_setImage(with: picURL, placeholderImage: UIImage(named : "empty_picture"))
        }
    }
    //MARK:- 控件的属性
    @IBOutlet weak var iconView: UIImageView!
}
