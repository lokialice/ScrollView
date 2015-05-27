//
//  PageScrollViewController.swift
//  ScrollView
//
//  Created by Macbook Pro MD102 on 5/27/15.
//  Copyright (c) 2015 Macbook Pro MD102. All rights reserved.
//

import UIKit

class PageScrollViewController: UIViewController,UIScrollViewDelegate {

    @IBOutlet var scrollViewC:UIScrollView!
    @IBOutlet var pageControl:UIPageControl!
    var pageImages:[UIImage] = []
    var pageViews:[UIImageView?] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        //1
        pageImages = [UIImage(named: "photo1.png")!,
            UIImage(named: "photo2.png")!,
            UIImage(named: "photo3.png")!,
            UIImage(named: "photo4.png")!,
            UIImage(named: "photo5.png")!]
        
        let pageCount = pageImages.count
        //2
        pageControl.currentPage = 0
        pageControl.numberOfPages = pageCount
        
        //3
        for _ in 0..<pageCount {
            pageViews.append(nil)
        }
        //4
        let pageScrollViewSize = scrollViewC.frame.size
        scrollViewC.contentSize = CGSize(width: pageScrollViewSize.width * CGFloat(pageImages.count), height: pageScrollViewSize.height)
        //5
        loadVisiblePages()
    }
   
    func loadPage(page:Int){
        if page < 0 || page >= pageImages.count {
            //If it's outside the range of what you display, then do nothing
            return
        }
        //1
        if let pageView = pageViews[page]{
            //Do nothing. The view is already loaded
        }else{
            //2
            var frame = scrollViewC.bounds
            frame.origin.x = frame.size.width * CGFloat(page)
            frame.origin.y = 0.0
            
            //3
            let newPageView = UIImageView(image: pageImages[page])
            newPageView.contentMode = .ScaleAspectFit
            newPageView.frame = frame
            scrollViewC.addSubview(newPageView)
            //4 
            pageViews[page] = newPageView
        }
    }
    func purgePage(page:Int){
        if page < 0 || page >= pageImages.count {
            return
        }
        //Remove a page from the scroll view and reset the container array
        if let pageView = pageViews[page]{
            pageView.removeFromSuperview()
            pageViews[page] = nil
        }
    }
    func loadVisiblePages(){
        //First, deteermine which page is currently visible
        let pageWidth = scrollViewC.frame.size.width
        let page = Int(floor((scrollViewC.contentOffset.x * 2.0 + pageWidth) / (pageWidth * 2.0)))
        
        //Update the page control
        pageControl.currentPage = page
        
        //work out which pages you want to load
        let firstPage = page - 1
        let lastPage = page + 1
        
        //Purge anything before the first page 
        for var index = 0;index < firstPage; ++index {
            purgePage(index)
        }
        
        //Load pages in our range
        for index in firstPage...lastPage{
            loadPage(index)
        }
        //pure anthing after the last page
        for var index = lastPage+1;index < pageImages.count;++index {
            purgePage(index)
        }
        
    }
    func scrollViewDidScroll(scrollView: UIScrollView) {
        loadVisiblePages()
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
