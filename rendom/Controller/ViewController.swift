//
//  ViewController.swift
//  rendom
//
//  Created by Ghada Al on 14/05/1440 AH.
//  Copyright © 1440 ghadaalone. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var breeds: [String] = []

    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.delegate = self
        pickerView.dataSource = self
         dogAPI.requestListBreeds(completionHandler: handleBreedsListResponse(breeds:error:))
        
        //dogAPI.requestRandomImage(completionHandler: handleRandomImageResponse(imageData:error:))
      
            
    }
       
    func handleBreedsListResponse (breeds: [String], error: Error?) {
        self.breeds = breeds
    }
    
    func handleRandomImageResponse(imageData: dogImage?, error: Error?) {
        guard let imageURL = URL(string: imageData?.message ?? "") else {
            return
        }
        dogAPI.requestImageFile(url: imageURL, completionHandler: self.handleImageFileResponse(image:error:))
        DispatchQueue.main.async {
            self.pickerView.reloadAllComponents()
        }
        
        }

        
    
    func handleImageFileResponse(image: UIImage?, error: Error?) {
        DispatchQueue.main.async {
            self.imageView.image = image
        }
    }
    
    
    
  

}
extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return breeds.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return breeds[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        dogAPI.requestRandomImage(breed: breeds[row], completionHandler: handleRandomImageResponse(imageData:error:))
    }
    
}
