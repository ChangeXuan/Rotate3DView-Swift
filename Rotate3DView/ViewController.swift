//
//  ViewController.swift
//  Rotate3DView
//
//  Created by 覃子轩 on 2017/7/4.
//  Copyright © 2017年 覃子轩. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var angle = CGPoint.init(x: 0, y: 0)
    
    let diceView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addDice()
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(viewTransform))
        diceView.addGestureRecognizer(panGesture)
    }
    
    func addDice() {
        
        let viewFrame = UIScreen.main.bounds
        
        var diceTransform = CATransform3DIdentity
        
        // 骰子的控制view
        diceView.frame = CGRect(x: 0, y: viewFrame.maxY / 2 - 50, width: viewFrame.width, height: 100)
        
        // 坐标系是按照当前view的朝向来重新判断的
        //1
        let view1 = UIImageView.init(image: UIImage(named: "one"))
        view1.frame = CGRect(x: viewFrame.maxX / 2 - 50, y: 0, width: 100, height: 100)
        // 向”前“走50
        diceTransform = CATransform3DTranslate(diceTransform, 0, 0, 50)
        view1.layer.transform = diceTransform
        
        //6
        let view6 = UIImageView.init(image: UIImage(named: "two"))
        view6.frame = CGRect(x: viewFrame.maxX / 2 - 50, y: 0, width: 100, height: 100)
        // 向“后”走50
        diceTransform = CATransform3DTranslate(CATransform3DIdentity, 0, 0, -50)
        view6.layer.transform = diceTransform
        
        //2
        let view2 = UIImageView.init(image: UIImage(named: "three"))
        view2.frame = CGRect(x: viewFrame.maxX / 2 - 50, y: 0, width: 100, height: 100)
        // 沿着y轴逆时针旋转90度
        diceTransform = CATransform3DRotate(CATransform3DIdentity, (CGFloat.pi / 2), 0, 1, 0)
        diceTransform = CATransform3DTranslate(diceTransform, 0, 0, 50)
        view2.layer.transform = diceTransform
        
        //5
        let view5 = UIImageView.init(image: UIImage(named: "four"))
        view5.frame = CGRect(x: viewFrame.maxX / 2 - 50, y: 0, width: 100, height: 100)
        // 沿着y轴顺时针旋转90度
        diceTransform = CATransform3DRotate(CATransform3DIdentity, (-CGFloat.pi / 2), 0, 1, 0)
        diceTransform = CATransform3DTranslate(diceTransform, 0, 0, 50)
        view5.layer.transform = diceTransform
        
        //3
        let view3 = UIImageView.init(image: UIImage(named: "five"))
        view3.frame = CGRect(x: viewFrame.maxX / 2 - 50, y: 0, width: 100, height: 100)
        // 沿着x轴顺时针旋转90度
        diceTransform = CATransform3DRotate(CATransform3DIdentity, (-CGFloat.pi / 2), 1, 0, 0)
        diceTransform = CATransform3DTranslate(diceTransform, 0, 0, 50)
        view3.layer.transform = diceTransform
        
        //4
        let view4 = UIImageView.init(image: UIImage(named: "six"))
        view4.frame = CGRect(x: viewFrame.maxX / 2 - 50, y: 0, width: 100, height: 100)
        // 沿着x轴逆时针旋转90度
        diceTransform = CATransform3DRotate(CATransform3DIdentity, (CGFloat.pi / 2), 1, 0, 0)
        diceTransform = CATransform3DTranslate(diceTransform, 0, 0, 50)
        view4.layer.transform = diceTransform
        
        
        diceView.addSubview(view1)
        diceView.addSubview(view2)
        diceView.addSubview(view3)
        diceView.addSubview(view4)
        diceView.addSubview(view5)
        diceView.addSubview(view6)
        
        view.addSubview(diceView)
    }
    
    /// 手势响应函数
    ///
    /// - parameter sender:
    func viewTransform(sender: UIPanGestureRecognizer) {
        
        let point = sender.translation(in: self.view)
        // let point = sender.translation(in: self.diceView)
        let angleX = angle.x + (point.x/30)
        let angleY = angle.y - (point.y/30)
        
        var transform = CATransform3DIdentity
        // m34用语按比例缩放x和y的值来呈现物体的远近
        // -1.0 / d 来让影像有远近的 3D 效果，d 代表了想象中视角与屏幕的距离，这个距离只需要大概估算，不需要很精准的计算
        transform.m34 = -1 / 500
        transform = CATransform3DRotate(transform, angleX, 0, 1, 0)
        transform = CATransform3DRotate(transform, angleY, 1, 0, 0)
        // 使用sublayer来旋转，否则转动得很乱
        diceView.layer.sublayerTransform = transform
        
        if sender.state == .ended {
            angle.x = angleX
            angle.y = angleY
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

