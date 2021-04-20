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
        self.card = card
        if card.isMatched == true {
            backImageView.alpha = 0
            frontImageView.alpha = 0
            textView.alpha = 0
        } else if card.text == 0 {
            ImageController.getImage(for: card.imageName ?? "", completion: { image in
                self.frontImageView.image = image
            })
            backImageView.alpha = 1
            frontImageView.alpha = 1
            textView.alpha = 0
        } else {
            backImageView.alpha = 1
            frontImageView.alpha = 0
            textView.alpha = 1
            textView.text = card.country
        }
        if card.isFlipped == false && card.text == 0{
            UIView.transition(from: frontImageView, to: backImageView, duration: 0.5, options: [.transitionFlipFromLeft, .showHideTransitionViews], completion: nil)
        } else if card.isFlipped == true && card.text == 0{
            UIView.transition(from: backImageView, to: frontImageView, duration: 0.5, options: [.transitionFlipFromLeft, .showHideTransitionViews], completion: nil)
        } else if card.isFlipped == false && card.text == 1{
            UIView.transition(from: textView, to: backImageView, duration: 0.5, options: [.transitionFlipFromLeft, .showHideTransitionViews], completion: nil)
        } else if card.isFlipped == true && card.text == 1{
            UIView.transition(from: backImageView, to: textView, duration: 0.5, options: [.transitionFlipFromLeft, .showHideTransitionViews], completion: nil)
        }
        
        
    }
    func flip(_ card: Card) {
        self.card = card
        if card.text == 0 {
            UIView.transition(from: backImageView, to: frontImageView, duration: 0.5, options: [.transitionFlipFromLeft, .showHideTransitionViews], completion: nil)
        } else {
            UIView.transition(from: backImageView, to: textView, duration: 0.5, options: [.transitionFlipFromLeft, .showHideTransitionViews], completion: nil)
        }
       
    }
    
    func flipBack(_ card: Card) {
        self.card = card
        if card.text == 0 {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                UIView.transition(from: self.frontImageView, to: self.backImageView, duration: 0.5, options: [.transitionFlipFromLeft, .showHideTransitionViews], completion: nil)
            }
        } else {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                UIView.transition(from: self.textView, to: self.backImageView, duration: 0.5, options: [.transitionFlipFromLeft, .showHideTransitionViews], completion: nil)
            }
        }
    }
    
    func remove() {
        backImageView.alpha = 0
        UIView.animate(withDuration: 0.5, delay: 1, options: .curveEaseOut, animations: {
            self.frontImageView.alpha = 0
            self.textView.alpha = 0
        }, completion: nil)
        
    }
    
}
