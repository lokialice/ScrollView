//
//  CustomScrollViewController.swift
//  ScrollView
//
//  Created by Macbook Pro MD102 on 5/27/15.
//  Copyright (c) 2015 Macbook Pro MD102. All rights reserved.
//

import UIKit

class CustomScrollViewController: UIViewController,UIScrollViewDelegate {

    @IBOutlet var scrollViewB:UIScrollView!
    var containerView:UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        //Set up the container view to hold your custom view hierarchy
        let containerSize =  CGSize(width: 640, height: 640)
        containerView =  UIView(frame: CGRect(origin:CGPoint(x: 0, y: 0), size:containerSize))
        scrollViewB.addSubview(containerView)
        
        //Set up your custom view hierarchy
        let redView = UIView(frame: CGRect( x: 0, y: 0,width: 640, height:80))
        redView.backgroundColor = UIColor.redColor()
        containerView.addSubview(redView)
        
        let blueView = UIView(frame: CGRect(x: 0, y: 560, width: 640, height: 80))
        blueView.backgroundColor =  UIColor.blueColor()
        containerView.addSubview(blueView)
        
        let greenView = UIView(frame: CGRect(x: 160, y: 160, width: 320, height: 320))
        greenView.backgroundColor = UIColor.greenColor()
        containerView.addSubview(greenView)
        
        let imageView = UIImageView(image: UIImage(named: "slow.png"))
        imageView.center = CGPoint(x: 320, y: 320)
        containerView.addSubview(imageView)
        
        //Tell the scroll view the  size of the contents
        scrollViewB.contentSize = containerSize
        
        //set up the minimum and maximum zoom scales
        let scrollViewFrame = scrollViewB.frame
        let scaleWidth = scrollViewFrame.size.width / scrollViewB.contentSize.width
        let scaleHeight = scrollViewFrame.size.height / scrollViewB.contentSize.height
        let minscale = min(scaleWidth,scaleHeight)
        
        scrollViewB.minimumZoomScale = minscale
        scrollViewB.maximumZoomScale = 1.0
        scrollViewB.zoomScale = 1.0
        centerScrollViewContents()
    }

    func centerScrollViewContents(){
        let boundSize = scrollViewB.bounds.size
        var contentFrame = containerView.frame
        
        if contentFrame.size.width < boundSize.width {
            contentFrame.origin.x = (boundSize.width - contentFrame.size.width) / 2.0
        }else{
            contentFrame.origin.x = 0.0
        }
        if contentFrame.size.height < boundSize.height {
            contentFrame.origin.y = (boundSize.height - contentFrame.size.height) / 2.0
        }else{
            contentFrame.origin.y = 0.0
        }
        containerView.frame = contentFrame
    }
    func viewForZoomingInScrollView(scrollView: UIScrollView!) -> UIView! {
        return containerView
    }
    func scrollViewDidZoom(scrollView: UIScrollView!) {
        centerScrollViewContents()
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
