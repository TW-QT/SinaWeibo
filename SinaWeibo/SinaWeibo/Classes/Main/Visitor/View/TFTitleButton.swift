//
//  TFTitleButton.swift
//  SinaWeibo
//
//  Created by Donkey-Tao on 2017/1/29.
//  Copyright © 2017年 taofei.me. All rights reserved.
//

import UIKit

class TFTitleButton: UIButton {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    

    override init(frame: CGRect) {
        //要先调用super
        super.init(frame: frame)
        setImage(UIImage(named : "navigationbar_arrow_down"), for: .normal)
        setImage(UIImage(named : "navigationbar_arrow_up"), for: .selected)
        setTitleColor(UIColor.darkGray, for: .normal)
        sizeToFit()
    }
    
    
    //swift中规定：重写了init(frame: frame)或者init方法，必须重写init?(coder aDecoder: NSCoder)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //swift中可以直接修改对象、结构体中的成员变量的属性的
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel!.frame.origin.x = 0
        imageView!.frame.origin.x = titleLabel!.frame.size.width + 10 
    }
    

}
