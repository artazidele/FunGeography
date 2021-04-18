//
//  CardCollectionViewCell.swift
//  FunGeography
//
//  Created by arta.zidele on 17/04/2021.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var backImageView: UIImageView!
    @IBOutlet weak var frontImageView: UIImageView!
    
    @IBOutlet weak var textView: UITextView!
    var card: Card?
   
    func setCard(_ card: Card){
        if card.text == 0 {
            ImageController.getImage(for: card.imageName ?? "", completion: { image in
                self.frontImageView.image = image
            })
            backImageView.alpha = 0
            frontImageView.alpha = 1
            textView.alpha = 0
        } else {
            backImageView.alpha = 0
            frontImageView.alpha = 0
            textView.alpha = 1
            textView.text = card.country
        }
        
        
    }
    
    func setCard2(_ card: Card) {
        self.card = card
        print(card.country!)
        if card.isMatched == true {
            backImageView.alpha = 0
            frontImageView.alpha = 0
            textView.alpha = 0
            return
        } else {
           /* backImageView.alpha = 1
            frontImageView.alpha = 1
            textView.alpha = 0*/
            backImageView.alpha = 2
            frontImageView.alpha = 0
            textView.alpha = 1
            textView.text = card.country
            
        }
      //  frontImageView.image = UIImage(named: card.country!)
        if card.isFlipped == false {
            print("isFlipped")
            UIView.transition(from: frontImageView, to: backImageView, duration: 0.5, options: [.transitionFlipFromLeft, .showHideTransitionViews], completion: nil)
        } else {
            UIView.transition(from: backImageView, to: frontImageView, duration: 0.5, options: [.transitionFlipFromLeft, .showHideTransitionViews], completion: nil)
        }
    }
    
    
    func flip() {
        UIView.transition(from: backImageView, to: frontImageView, duration: 0.5, options: [.transitionFlipFromLeft, .showHideTransitionViews], completion: nil)
    }
    
    func flipBack() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            UIView.transition(from: self.frontImageView, to: self.backImageView, duration: 0.5, options: [.transitionFlipFromLeft, .showHideTransitionViews], completion: nil)
        }
        
    }
    
    func remove() {
        backImageView.alpha = 0
        UIView.animate(withDuration: 0.5, delay: 1, options: .curveEaseOut, animations: {
            self.frontImageView.alpha = 0
        }, completion: nil)
        
    }
}
