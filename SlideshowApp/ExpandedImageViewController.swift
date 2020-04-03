//
//  ExpandedImageViewController.swift
//  SlideshowApp
//
//  Created by 福田 桃太 on 2020/04/02.
//  Copyright © 2020 momota-fukuda. All rights reserved.
//

import UIKit

class ExpandedImageViewController: UIViewController {

    private var _imageIndex = 0
    private var image: UIImage? = nil
    @IBOutlet weak var expandedImageView: UIImageView!
    
    var imageIndex: Int{
        get {
            return self._imageIndex
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.expandedImageView.image = self.image
    }
    
    func setImageInfo(image :UIImage, imageIndex :Int){
        self.image = image
        self._imageIndex = imageIndex
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
