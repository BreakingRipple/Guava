//
//  NoteDetailVC-Config.swift
//  Guava
//
//  Created by Savage on 22/9/21.
//

import Foundation

extension NoteDetailVC{
    func config(){
        imageSlideshow.zoomEnabled = true
        imageSlideshow.circular = false
        imageSlideshow.contentScaleMode = .scaleAspectFill
        
        let pageControl = UIPageControl()
        pageControl.pageIndicatorTintColor = .systemGray
        pageControl.currentPageIndicatorTintColor = mainColor
        
        imageSlideshow.pageIndicator = pageControl
    }
}
