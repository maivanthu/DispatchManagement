//
//  ListDSCVViewController.swift
//  MasterDocs
//
//  Created by VanThu on 03/03/2017.
//  Copyright © 2017 VanThu. All rights reserved.
//

import UIKit

class ListDSCVViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var slidescrollView: UIScrollView!
    @IBOutlet weak var pageControll: UIPageControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        slidescrollView.delegate = self
        let slides:[Slide] = createSlides()
        setupSlideScrollView(slides: slides)
        pageControll.numberOfPages = slides.count
        pageControll.currentPage = 0
        view.bringSubview(toFront: pageControll)
        
    }
    
    func createSlides() -> [Slide] {
        let slide1:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide1.label.text = "Slide1"
        
        let slide2:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide2.label.text = "Slide2"
        
        let slide3:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide3.label.text = "Slide3"
        
        return [slide1, slide2, slide3]
    }
    
    func setupSlideScrollView(slides: [Slide]) {
        
        slidescrollView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        
        slidescrollView.contentSize = CGSize(width: view.frame.width * CGFloat(slides.count), height: view.frame.height)
        slidescrollView.isPagingEnabled = true
        
        for i in 0 ..< slides.count{
            slides[i].frame = CGRect(x: view.frame.width * CGFloat(i), y: 0, width: view.frame.width, height: view.frame.height)
            slidescrollView.addSubview(slides[i])
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x/view.frame.width)
        pageControll.currentPage = Int(pageIndex)
    }
    

}
