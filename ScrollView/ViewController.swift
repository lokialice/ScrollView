//
//  ViewController.swift
//  ScrollView
//
//  Created by Macbook Pro MD102 on 5/27/15.
//  Copyright (c) 2015 Macbook Pro MD102. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIScrollViewDelegate {
    
    @IBOutlet var scrollViewA:UIScrollView!

    var imageView:UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //1
        let image = UIImage(named: "photo1.png")!
        imageView = UIImageView(image: image)
        imageView.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: image.size)
        scrollViewA.addSubview(imageView)
        
        //2
        scrollViewA.contentSize = image.size
        //3
        var doubletapRecognizer = UITapGestureRecognizer(target: self, action: "scrollViewDoubleTapped:")
        doubletapRecognizer.numberOfTapsRequired = 2
        doubletapRecognizer.numberOfTouchesRequired = 1
        scrollViewA.addGestureRecognizer(doubletapRecognizer)
        
        //4
        let scrollViewFrame = scrollViewA.frame
        let scaleWidth = scrollViewFrame.size.width / scrollViewA.contentSize.width
        let scaleHeight =  scrollViewFrame.size.height / scrollViewA.contentSize.height
        let minScale = min(scaleWidth,scaleHeight)
        scrollViewA.minimumZoomScale = minScale
        
        //5
        scrollViewA.maximumZoomScale = 1
        scrollViewA.zoomScale = minScale
        
        //6
        centerScrollViewContents()
    }

    func centerScrollViewContents() {
        let boundSize = scrollViewA.bounds.size
        var  contentFrame = imageView.frame
        
        if contentFrame.size.width < boundSize.width {
            contentFrame.origin.x = (boundSize.width -  contentFrame.size.width) / 2.0
        }else{
            contentFrame.origin.x = 0.0
        }
        
        if contentFrame.size.height < boundSize.height {
            contentFrame.origin.y = (boundSize.height - contentFrame.size.height) / 2.0
        }else{
            contentFrame.origin.y = 0.0
        }
        imageView.frame = contentFrame
    }
    func scrollViewDoubleTapped(recognizer:UIGestureRecognizer){
        //1
        let pointInView = recognizer.locationInView(imageView)
        //2
        var newZoomScale = scrollViewA.zoomScale * 1.5
        newZoomScale = min(newZoomScale,scrollViewA.maximumZoomScale)
        
        //3
        let scrollViewSize = scrollViewA.bounds.size
        let w = scrollViewSize.width / newZoomScale
        let h = scrollViewSize.height / newZoomScale
        let x = pointInView.x - (w/2.0)
        let y = pointInView.y - (h/2.0)
        
        let rectToZoomTo =  CGRectMake(x, y, w, h)
        
        //4
        scrollViewA.zoomToRect(rectToZoomTo, animated: true)
    }
    func viewForZoomingInScrollView(scrollView: UIScrollView!) -> UIView! {
        return imageView
    }
    func scrollViewDidZoom(scrollView: UIScrollView!) {
        centerScrollViewContents()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

