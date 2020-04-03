//
//  ViewController.swift
//  SlideshowApp
//
//  Created by 福田 桃太 on 2020/04/02.
//  Copyright © 2020 momota-fukuda. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private let playOrPauseButtonTextDic :[Bool: String] = [
        true: "再生",
        false: "停止"
    ]
    
    private let imagePathBase = "image"
    private var nowIndex = 0
    private let imageNum = 5
    
    private var images: [UIImage] = []
    
    private var timer :Timer? = nil
    
    @IBOutlet private weak var slideImageButton: UIButton!
    @IBOutlet private weak var playOrPauseButton: UIButton!
    
    @IBOutlet private var disableUIsDuringSlideShow: [UIControl] = []
    
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
        self.setPlayOrPauseButtonState(isPlayButton: self.timer == nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let expandedImageViewController = segue.destination as? ExpandedImageViewController
        
        expandedImageViewController?.setImageInfo(image: self.images[self.nowIndex], imageIndex: self.nowIndex)
        
        if self.timer != nil {
            self.toggleTimerPlaying()
        }
    }
    
    private  func createImagePath(index :Int) -> String {
        return "\(self.imagePathBase)\(index)"
    }
    
    private func changeNextImage() {
        self.nowIndex += 1
        if self.nowIndex >= self.images.endIndex {
            self.nowIndex = self.images.startIndex
        }
        
        self.updateImage(index: self.nowIndex)
    }
    
    private func changeBeforeImage() {
        self.nowIndex -= 1
        if self.nowIndex < self.images.startIndex {
            self.nowIndex = self.images.endIndex - 1
        }
        
        self.updateImage(index: self.nowIndex)
    }
    
    private func updateImage(index :Int) {
        if (self.nowIndex < self.images.startIndex) || (self.images.endIndex <= self.nowIndex) {
            return
        }
        
        self.slideImageButton.setImage(self.images[self.nowIndex], for: UIControl.State.normal)
        self.slideImageButton.imageView?.contentMode = .scaleAspectFit
    }
    
    private func toggleTimerPlaying(){
        if self.timer == nil {
            self.timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(self.onUpdateTimer(timer:)), userInfo: nil, repeats: true)
        } else {
            self.timer?.invalidate()
            self.timer = nil
        }
        
        self.setPlayOrPauseButtonState(isPlayButton: self.timer == nil)
        
        for ui in self.disableUIsDuringSlideShow {
            // タイマーがある == スライドショー中
            ui.isEnabled = self.timer == nil
        }
    }
    
    private func setPlayOrPauseButtonState(isPlayButton: Bool){
        self.playOrPauseButton.setTitle(self.playOrPauseButtonTextDic[isPlayButton], for: UIControl.State.normal)
    }
    
    @IBAction func unwind(_ unwindSegue: UIStoryboardSegue) {
        let sourceViewController = unwindSegue.source as? ExpandedImageViewController
        // Use data from the view controller which initiated the unwind segue
        
        if sourceViewController == nil {
            return
        }
        
        self.nowIndex = sourceViewController!.imageIndex
    }
    
    @objc private func onUpdateTimer(timer :Timer){
        self.changeNextImage()
    }
    
    @IBAction private  func onTapNextButton(_ sender: UIButton) {
        self.changeNextImage()
    }
    @IBAction private  func onTapBackButton(_ sender: UIButton) {
        self.changeBeforeImage()
    }
    @IBAction private  func onTapTogglePlayButton(_ sender: UIButton) {
        self.toggleTimerPlaying()
    }
}

