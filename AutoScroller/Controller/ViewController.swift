//
//  ViewController.swift
//  AutoScroller
//
//  Created by Aria Bisma Wahyutama on 23/06/19.
//  Copyright © 2019 ARIA BISMA WAHYUTAMA. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var sliderCollectionView: UICollectionView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageView: UIPageControl!
    @IBOutlet weak var topCollection: UICollectionView!
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var midLabel: UILabel!
    @IBOutlet weak var midCollection: UICollectionView!
    
    var imgArr = [  UIImage(named:"image1"),
                    UIImage(named:"image2"),
                    UIImage(named:"image3")
    ]
    
    var timer = Timer()
    var counter = 0, tag = 0
    var labelText = "", labelDetail = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pageView.numberOfPages = imgArr.count
        pageView.currentPage = 0
        DispatchQueue.main.async {
            self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.changeImage), userInfo: nil, repeats: true)
        }
        sliderCollectionView.delegate = self
        topCollection.delegate = self
        midCollection.delegate = self
        midCollection.dataSource = self
        sliderCollectionView.dataSource = self
        topCollection.dataSource = self
        
        
        
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height+100)
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailApp" {
            let nextVC = segue.destination as! AppDetailViewController
            nextVC.label = labelDetail
        } else if segue.identifier == "summaryApp" {
            let nextVC = segue.destination as! SummaryAppViewController
            nextVC.label = labelText
        }
    }
    
    @IBAction func topApplication(_ sender: Any) {
        labelText = "Ini aplikasi top"
        performSegue(withIdentifier: "summaryApp", sender: self)
    }
    
    @IBAction func topRated(_ sender: Any) {
        labelText = "Ini aplikasi rating tinggi"
        performSegue(withIdentifier: "summaryApp", sender: self)
    }
    
    @IBAction func topAppDetail(_ sender: Any) {
        labelDetail = "ini top application ke \((sender as AnyObject).tag!)"
        performSegue(withIdentifier: "detailApp", sender: self)
    }
    
    @IBAction func topRatedApp(_ sender: Any) {
        labelDetail = "ini aplikasi rating tinggi ke \((sender as AnyObject).tag!)"
        performSegue(withIdentifier: "detailApp", sender: self)
        
    }
    
    @objc func changeImage() {
        if counter < imgArr.count {
            let index = IndexPath.init(item: counter, section: 0)
            self.sliderCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            pageView.currentPage = counter
            counter += 1
        } else {
            counter = 0
            let index = IndexPath.init(item: counter, section: 0)
            self.sliderCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: false)
            pageView.currentPage = counter
            counter = 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.sliderCollectionView {
            return imgArr.count
        } else if collectionView == self.topCollection {
            return 14
        }
        return 14
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.sliderCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
            if let vc = cell.viewWithTag(111) as? UIImageView {
                vc.image = imgArr[indexPath.row]
            }
            
            func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
                return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            }
            
            func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
                let size = sliderCollectionView.frame.size
                return CGSize(width: size.width, height: size.height)
            }
            
            func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
                return 0.0
            }
            
            func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
                return 0.0
            }
            
            return cell
        } else if collectionView == self.topCollection {
            let cellB = collectionView.dequeueReusableCell(withReuseIdentifier: "topCollection", for: indexPath)
            
            let editButton = UIButton(frame: CGRect(x:0, y:0, width:90,height:90))
           
            editButton.tag = indexPath.row
            editButton.setImage(UIImage(named: "imagetest.png"), for: .normal)
            
            editButton.addTarget(self, action: #selector(topAppDetail), for: UIControl.Event.touchUpInside)
            
            cellB.addSubview(editButton)
            
            func collectionView(_ collectionView: UICollectionView,
                                layout collectionViewLayout: UICollectionViewLayout,
                                sizeForItemAt indexPath: IndexPath) -> CGSize {
                let size = topCollection.frame.size
                return CGSize(width: size.width, height: size.height)
            }
            
            func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
                return 1.0
            }
            
            func collectionView(_ collectionView: UICollectionView, layout
                collectionViewLayout: UICollectionViewLayout,
                                minimumLineSpacingForSectionAt section: Int) -> CGFloat {
                return 1.0
            }
            return cellB
        } else {
            let cellC = collectionView.dequeueReusableCell(withReuseIdentifier: "midCollection", for: indexPath)
            
            let editButton = UIButton(frame: CGRect(x:0, y:0, width:90,height:90))
            
            editButton.tag = indexPath.row
            editButton.setImage(UIImage(named: "imagetest.png"), for: .normal)
            
            editButton.addTarget(self, action: #selector(topRatedApp), for: UIControl.Event.touchUpInside)
            
            cellC.addSubview(editButton)
            
            
            func collectionView(_ collectionView: UICollectionView,
                                layout collectionViewLayout: UICollectionViewLayout,
                                sizeForItemAt indexPath: IndexPath) -> CGSize {
                let size = midCollection.frame.size
                return CGSize(width: size.width, height: size.height)
            }
            
            func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
                return 1.0
            }
            
            func collectionView(_ collectionView: UICollectionView, layout
                collectionViewLayout: UICollectionViewLayout,
                                minimumLineSpacingForSectionAt section: Int) -> CGFloat {
                return 1.0
            }
            return cellC
        }
    }
    
    
    
}
