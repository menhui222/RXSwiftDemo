//
//  LoginViewController.swift
//  RxSwiftDemo
//
//  Created by 孟辉 on 16/6/20.
//  Copyright © 2016年 孟辉. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SwiftyJSON

class LoginViewController: UIViewController {
    @IBOutlet weak var usernameTF: UITextField!
    @IBOutlet weak var usernameLB: UILabel!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var passwordLB: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    var disposeBag = DisposeBag()
    
    @IBOutlet weak var firstView: UIView!
    @IBOutlet weak var secondView: UIView!
    @IBOutlet weak var thirdView: UIView!
    
    var  label : UILabel?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
     
        let qq_rx_tap = firstView.addImageTextView("QQ登录", serImage: UIImage(imageLiteral: "qq"))
        let webo_rx_tap = secondView.addImageTextView("微博登录", serImage: UIImage(imageLiteral: "webo"))
        let wechat_rx_tap = thirdView.addImageTextView("微信登录", serImage: UIImage(imageLiteral: "wechat"))
        let loginViewModel  = LoginViewModel(input:
            (
                self,
                usernameTF.rx_text.asObservable(),
                passwordTF.rx_text.asObservable(),
                loginButton.rx_tap.asObservable(),
                qq_rx_tap.asObservable(),
                webo_rx_tap.asObservable(),
                wechat_rx_tap.asObservable()
        ))
        
        
        loginViewModel.userNameValid.bindTo(usernameLB.rx_hidden).addDisposableTo(self.disposeBag)
        
        
        loginViewModel.passwordValid.bindTo(passwordLB.rx_hidden).addDisposableTo(self.disposeBag)
        
        
        loginViewModel.loginEnable.subscribeNext { [weak self](enable) in
            self?.loginButton.enabled = enable
            self?.loginButton.alpha  = enable ? 1:0.5;
            print(enable)
            }.addDisposableTo(self.disposeBag)
        
        loginViewModel.loginIn.subscribeNext { (login) in
            print("222\(login)")
            }.addDisposableTo(self.disposeBag);
        //
        loginViewModel.sinaLogin.subscribeNext { (login) in
            print("222\(login)")
        }.addDisposableTo(self.disposeBag);
        
        loginViewModel.sinaAction.subscribeNext { (result) in
            
            switch result{
            case Result.Success :
                appDelegate.window?.rootViewController = HomePageViewController()
               break
            case  Result.Failure(let errorType):
                //
                guard  let error = errorType as? FailureType else{
                    return;
                }
            
                MBProgressHUD.showError(error.message)
               break
                
                
            }
        
            
        }.addDisposableTo(self.disposeBag)

        loginViewModel.qqlogin.subscribeNext { (login) in
            print("222\(login)")
            }.addDisposableTo(self.disposeBag);
        loginViewModel.weChatlogin.subscribeNext { (login) in
            print("222\(login)")
            //UIApplication.sharedApplication().openURL(NSURL(string:"https://www.baidu.com/")!)
            }.addDisposableTo(self.disposeBag);
     
        // Do any additional setup after loading the view.
    }

   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}


extension UIView{

    func addImageTextView(title:String,serImage image:UIImage) -> (ControlEvent<Void>) {
        let view = ImageTextView(frame: self.bounds, setTitle: title, iconImage: image)
        
        self.addSubview(view)
        return view.eventControl.rx_controlEvent(UIControlEvents.TouchUpInside)
    }

}
