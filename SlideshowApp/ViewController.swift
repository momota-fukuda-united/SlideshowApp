//
//  ViewController.swift
//  SlideshowApp
//
//  Created by 福田 桃太 on 2020/04/02.
//  Copyright © 2020 momota-fukuda. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let imagePathBase = "image"
    var nowIndex = 0
    let imageNum = 5
    
    var images: [UIImage] = []
    
    var timer :Timer? = nil
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet var disableUIsDuringSlideShow: [UIControl] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        for index in 0..<self.imageNum {
            let image = UIImage(named: self.createImagePath(index: index))
            if image == nil {
                continue;
            }
            
            self.images.append(image!)
        }
        
        self.nowIndex = self.images.startIndex
        self.updateImage(index: self.nowIndex)
    }

    func createImagePath(index :Int) -> String {
        return "\(self.imagePathBase)\(index)"
    }
    
    func changeNextImage() {
        self.nowIndex += 1
        if self.nowIndex >= self.images.endIndex {
            self.nowIndex = self.images.startIndex
        }
        
        self.updateImage(index: self.nowIndex)
    }
    
    func changeBeforeImage() {
        self.nowIndex -= 1
        if self.nowIndex < self.images.startIndex {
            self.nowIndex = self.images.endIndex - 1
        }
        
        self.updateImage(index: self.nowIndex)
    }
    
    func updateImage(index :Int) {
        if (self.nowIndex < self.images.startIndex) || (self.images.endIndex <= self.nowIndex) {
            return
        }
        
        self.imageView.image = self.images[self.nowIndex]
    }
    
    @objc func onUpdateTimer(timer :Timer){
        self.changeNextImage()
    }
    
    @IBAction func onTapNextButton(_ sender: UIButton) {
        self.changeNextImage()
    }
    @IBAction func onTapBackButton(_ sender: UIButton) {
        self.changeBeforeImage()
    }
    @IBAction func onTapTogglePlayButton(_ sender: UIButton) {
        if self.timer == nil {
            self.timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(self.onUpdateTimer(timer:)), userInfo: nil, repeats: true)
        } else {
            self.timer?.invalidate()
            self.timer = nil
        }
        
        for ui in self.disableUIsDuringSlideShow {
            // タイマーがある == スライドショー中
            ui.isEnabled = self.timer == nil
        }
    }
}

