//
//  OnboardingVC.swift
//  Yummie
//
//  Created by Haytham on 31/10/2023.
//

import UIKit

class OnboardingVC: UIViewController {
    
#warning("THE ONBOARDING VIEW DOES NOT NAVIGATE TO THE ITEMS IN HOMEVC")
    
    var pageCounter = 0 {
        
        didSet {
            pageControl.currentPage = pageCounter
            
            if pageCounter == slides.count - 1 {
                nextButton.setTitle("Get Started", for: .normal)
            } else {
                nextButton.setTitle("Next", for: .normal)
            }
        }
    }
    
    let slides: [OnboardingSlide] =  [OnboardingSlide(title: "Delicious Dishes", description: "Experienc a variety of amazing dishes from different cultures around the world", image: UIImage(named: "slide2")!),
                                      OnboardingSlide(title: "World-Class Chefs", description: "Our dishes are prepared by only the best", image: UIImage(named: "slide1")!),
                                      OnboardingSlide(title: "Instant World-Wide Delivery", description: "Your orders will be delivered instantly irrespective of your location around the world", image: UIImage(named: "slide3")!)]
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var nextButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pageControl.numberOfPages = slides.count
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        
        if pageCounter == slides.count - 1 {
            
            guard let vc = storyboard?.instantiateViewController(withIdentifier: "HomeVC") else { return }
            
            vc.modalPresentationStyle = .fullScreen
            vc.modalTransitionStyle = .crossDissolve
            
            present(vc, animated: true)
            
            
        } else {
            pageCounter += 1
            let indexPath = IndexPath(item: pageCounter, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
    
}

extension OnboardingVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCollectionViewCell.identifier, for: indexPath) as! OnboardingCollectionViewCell
        cell.configureCollectionCell(slides[indexPath.row])
        return cell
    }
    
}

extension OnboardingVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        pageCounter = Int(scrollView.contentOffset.x / width)
    }
    
}
