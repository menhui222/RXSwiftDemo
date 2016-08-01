//
//  ImageTextView.swift
//  RxSwiftDemo
//
//  Created by 孟辉 on 16/7/19.
//  Copyright © 2016年 孟辉. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import RxBlocking

class ImageTextView: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    var iconView = UIImageView()
    var textLabel = UILabel()
    var eventControl = UIControl()
    typealias SelectBlcok = () ->()
    var disposebag = DisposeBag()
    var buttonSelectEvent:SelectBlcok?
    override init(frame: CGRect) {
       super.init(frame: frame)
        //self.backgroundColor = UIColor.redColor()
        self.addSubview(iconView)
        let spaceH = self.frame.height*1/20
        let iconViewH = (self.frame.width - self.frame.height*2/3 < spaceH) ? self.frame.width:self.frame.height*2/3
        let textLabelH = self.frame.height*1/3.0
        iconView.snp_makeConstraints { [weak self](make) in
            make.centerX.equalTo(self!)
            make.width.height.equalTo(iconViewH - spaceH)
            make.top.equalTo(self!).offset(spaceH)
        }
        
        textLabel.textAlignment = .Center
        textLabel.textColor = UIColor.grayColor()
        textLabel.font = UIFont.systemFontOfSize(15.0)
        self.addSubview(textLabel)
        textLabel.snp_makeConstraints { [weak self](make) in
            make.centerX.equalTo(self!)
            make.width.equalTo(self!).offset(spaceH)
            make.height.equalTo(textLabelH - spaceH)
            make.top.equalTo(self!.iconView.snp_bottom).offset(spaceH/2)
        }
        self.addSubview(eventControl)
        eventControl.snp_makeConstraints { (make) in
            make.edges.equalTo(self).offset(0)
        }
        eventControl.rx_controlEvent(UIControlEvents.TouchUpInside).subscribeNext { (_) in
            
            guard let event = self.buttonSelectEvent  else{return}
            event()
            
        }.addDisposableTo(self.disposebag)
        
    }
    convenience init(frame: CGRect,setTitle title:String,iconImage image:UIImage,buttonSelectEvent buttonEvent:SelectBlcok? = nil) {
        self.init(frame: frame)
        self.iconView.image = image
        self.textLabel.text = title;
        
        self.buttonSelectEvent = buttonEvent ;
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
