//
//  KAutoSlider
//
//  Copyright © 2017 Kenan Atmaca. All rights reserved.
//  kenanatmaca.com
//
//

import UIKit

enum Style {
    case scale
    case alpha
    case translation
}

class KAutoSlider {
    
   private var rootView:UIView!
    
   private var contentView:UIView = {
        let bgView = UIView()
        bgView.backgroundColor = UIColor.black
        bgView.translatesAutoresizingMaskIntoConstraints = false
        return bgView
    }()
    
   private var imageView:UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFill
        imgView.autoresizingMask = [.flexibleWidth, .flexibleHeight, .flexibleBottomMargin, .flexibleRightMargin, .flexibleLeftMargin, .flexibleTopMargin]
        imgView.layer.cornerRadius = 0
        imgView.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.clipsToBounds = true
        return imgView
    }()
    
   private var pageContoller:UIPageControl = {
        let pgControl = UIPageControl()
        pgControl.currentPageIndicatorTintColor = UIColor.white
        pgControl.pageIndicatorTintColor = UIColor.lightGray
        pgControl.backgroundColor = UIColor.black.withAlphaComponent(0.1)
        pgControl.translatesAutoresizingMaskIntoConstraints = false
        return pgControl
    }()
    
    private var imageTimer:Timer!
    private var imgCounter:Int = 0
    
    var images:[UIImage] = []
    var animationType:Style = .alpha

    
    init(to controller:UIViewController) {
        self.rootView = controller.view
        addViews()
        setupConstraints()
    }
    
    private func addViews() {
        rootView.addSubview(contentView)
        rootView.addSubview(imageView)
        rootView.addSubview(pageContoller)
    }
    
    private func setupConstraints() {
        
        contentView.widthAnchor.constraint(equalToConstant: rootView.bounds.width).isActive = true
        contentView.heightAnchor.constraint(equalToConstant: rootView.bounds.height).isActive = true
        contentView.topAnchor.constraint(equalTo: rootView.topAnchor).isActive = true
        contentView.rightAnchor.constraint(equalTo: rootView.rightAnchor).isActive = true
        contentView.leftAnchor.constraint(equalTo: rootView.leftAnchor).isActive = true
        
        imageView.widthAnchor.constraint(equalToConstant: rootView.bounds.width).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: rootView.bounds.height).isActive = true
        imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive = true
        imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 0).isActive = true
        
        pageContoller.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0).isActive = true
        pageContoller.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 0).isActive = true
        pageContoller.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: 0).isActive = true
    }
    
    func start() {
        
        if images.count > 0 {
            imageView.image = images.first
            pageContoller.numberOfPages = images.count
            
            imageTimer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(changeImg), userInfo: nil, repeats: true)
        }
    }
    
    func stop() {
        imageTimer.invalidate()
        imgCounter = 0
    }
    
    func remove() {
        stop()
        contentView.removeFromSuperview()
        imageView.removeFromSuperview()
        pageContoller.removeFromSuperview()
    }
    
    @objc func changeImg() {
         imgCounter += 1
         animationSetup()
        if imgCounter == images.count {imgCounter = 0}
    }
    
    private func animationSetup() {
        
        switch(animationType) {
        case .scale:
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
                self.imageView.transform = CGAffineTransform.init(scaleX: 0.7, y: 0.7)
            }) { (_) in
                UIView.animate(withDuration: 0.3, animations: {
                    self.imageView.transform = CGAffineTransform.identity
                }, completion: { (_) in
                    self.pageContoller.currentPage = self.imgCounter
                    self.imageView.image = self.images[self.imgCounter]
                })
            }
        case .alpha:
            UIView.animate(withDuration: 0.5, animations: {
                self.imageView.alpha = 0
            }, completion: { (_) in
                UIView.animate(withDuration: 0.5, animations: {
                    self.imageView.alpha = 1
                    self.pageContoller.currentPage = self.imgCounter
                    self.imageView.image = self.images[self.imgCounter]
                })
            })
        case .translation:
            UIView.animate(withDuration: 0.5, animations: {
                self.imageView.transform = CGAffineTransform.init(translationX: -400, y: 0)
            }, completion: { (_) in
                UIView.animate(withDuration: 0.5, animations: {
                    self.imageView.transform = CGAffineTransform.identity
                    self.pageContoller.currentPage = self.imgCounter
                    self.imageView.image = self.images[self.imgCounter]
                })
            })
        }
    }

}//
