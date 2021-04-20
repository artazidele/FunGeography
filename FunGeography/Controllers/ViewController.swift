//
//  ViewController.swift
//  FunGeography
//
//  Created by arta.zidele on 17/04/2021.
//


import UIKit
import Foundation

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
   
    var region = ""
    var cardArray = [Card]()
    var firstFlippedCardIndex: IndexPath?
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var someCountryList: [Card] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        getCardData()
        print(cardArray.count)
        collectionView.delegate = self
        collectionView.dataSource = self
        print(region)
     }
    
  
    func getCardData() {
        var countryList: [Country] = []
        let url = URL(string: "http://countryapi.gear.host/v1/Country/getCountries")!
        NetworkController.performRequest(for: url, httpMethod: .get) {(data, err) in
            if let error = err {
                print("Getting err from url \(url.absoluteString), error: \(error.localizedDescription)")
            }
            if let data = data {
                do {
                   
                    let game = try JSONDecoder().decode(Game.self, from: data)
                    countryList = game.response
                    for i in 0..<countryList.count {
                        print(countryList[i].region)
                    }
                    
                    var generatedNumbersArray = [Int]()
                    while generatedNumbersArray.count < 9 {
                        print("IZSAUC \(generatedNumbersArray.count)")
                        let randomNumber = arc4random_uniform(UInt32(countryList.count))
                        if generatedNumbersArray.contains(Int(randomNumber)) == false {
                            generatedNumbersArray.append(Int(randomNumber))
                            let oneCard = Card()
                            oneCard.imageName = "\(countryList[Int(randomNumber)].imageUrl ?? "")"
                            oneCard.country = "\(countryList[Int(randomNumber)].name)"
                            print(oneCard.country!)
                            self.someCountryList.append(oneCard)
                            print(randomNumber)
                            
                            let twoCard = Card()
                            twoCard.text = 1
                            twoCard.imageName = "\(countryList[Int(randomNumber)].imageUrl ?? "")"
                            twoCard.country = "\(countryList[Int(randomNumber)].name)"
                            self.someCountryList.append(twoCard)
                        }
                    }
                    for i in 0..<self.someCountryList.count {
                        let randomNumber = Int(arc4random_uniform(UInt32(generatedNumbersArray.count)))
                        let temporary = self.someCountryList[i]
                        self.someCountryList[i] = self.someCountryList[randomNumber]
                        self.someCountryList[randomNumber] = temporary
                    }
                
                    for i in 0..<18 {
                        print("KARTS \(self.someCountryList[i].country ?? "")")
                    }
                    print("SKAITS SKAITS \(self.someCountryList.count)")
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
                } catch {
                    print("failed to decode data \(error), data: \(data)")
                }
                
            } else {
                print("Data is nil")
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
 
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("izsauc12345!!!!!!!!")
        return someCountryList.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cardCell", for: indexPath) as! CardCollectionViewCell
        let card = someCountryList[indexPath.row]
        cell.setCard(card)
        print("izsauc!!!!!!!!")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! CardCollectionViewCell
        let card = someCountryList[indexPath.row]
        print(card.country!)
        if card.isFlipped == true && card.isMatched == false {
           cell.flipBack()
            card.isFlipped = false
        } else {
            cell.flip()
            card.isFlipped = true
            if firstFlippedCardIndex == nil {
                firstFlippedCardIndex = indexPath
            } else {
                checkForMatches(indexPath)
            }
        }
        print("izsauc!!!!!!!!")
    }
    
    func checkForMatches(_ secondFlippedCardIndex: IndexPath) {
        let cardOneCell = collectionView.cellForItem(at: firstFlippedCardIndex!) as? CardCollectionViewCell
        let cardTwoCell = collectionView.cellForItem(at: secondFlippedCardIndex) as? CardCollectionViewCell
        let cardOne = someCountryList[firstFlippedCardIndex!.row]
        let cardTwo = someCountryList[secondFlippedCardIndex.row]
        if cardOne.imageName == cardTwo.imageName {
            cardOne.isMatched = true
            cardTwo.isMatched = true
            cardOneCell?.remove()
            cardTwoCell?.remove()
            checkGameEnded()
        } else {
            cardOne.isFlipped = false
            cardTwo.isFlipped = false
            cardOneCell?.flipBack()
            cardTwoCell?.flipBack()
        }
        if cardOneCell == nil {
            collectionView.reloadItems(at: [firstFlippedCardIndex!])
        }
        firstFlippedCardIndex = nil
    }
    
    
    func checkGameEnded() {
        /*    var isWon = true
        for card in cardArray {
            if card.isMatched == false {
                isWon = false
                break
            }
        }
        var title = ""
        var message = ""
        if isWon == true {
          if miliseconds > 0 {
                timer?.invalidate()
            }
            title = "Congratulations!"
            message = "You have won"
        } else {
            if miliseconds > 0 {
                return
            }
            title = "Game over"
            message = "You have lost"
        }
        showAlert(title, message)*/
        
    }
    
    func showAlert(_ title: String, _ message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(alertAction)
        present(alert, animated: true, completion: nil)
    }
    
}