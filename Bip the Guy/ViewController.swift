//
//  ViewController.swift
//  Bip the Guy
//
//  Created by Andrew Boucher on 9/16/19.
//  Copyright © 2019 Andres de la Cruz. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageToPunch: UIImageView!
    
    var audioPlayer = AVAudioPlayer()
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    //functions
    
    func playSound(soundName:String, audioPlayer: inout AVAudioPlayer) {
        
        if let sound = NSDataAsset(name: soundName) {
            do{
                try audioPlayer = AVAudioPlayer(data: sound.data)
                audioPlayer.play()
            } catch {
                print("ERROR: file \(soundName) couldn't be played as a sound")
            }
        }else{
            print("ERROR: file \(soundName) didn't load ")
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        
        imageToPunch.image = selectedImage
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func  animateImage () {
     let bounds = self.imageToPunch.bounds
     let shrinkValue: CGFloat = 60
        self.imageToPunch.bounds = CGRect(x:  self.imageToPunch.bounds.origin.x + shrinkValue, y: self.imageToPunch.bounds.origin.y + shrinkValue, width: self.imageToPunch.bounds.size.width - shrinkValue, height: self.imageToPunch.bounds.size.height - shrinkValue)
    
        UIView.animate(withDuration: 0.25, delay: 0.0, usingSpringWithDamping: 0.2, initialSpringVelocity: 10.0, options: [], animations: {self.imageToPunch.bounds = bounds}, completion: nil)
    }
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alertController.addAction(defaultAction)
        present(alertController, animated: true, completion: nil)
        
    }
    
    // actions
    @IBAction func libraryPressed(_ sender: UIButton) {
        
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func takeAPhotoPressed(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
        imagePicker.sourceType = .camera
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
        }else{
            showAlert(title: "Camera not Available", message: "There is no camera available on this device.")
        }
    }
    
    @IBAction func imageTapped(_ sender: UITapGestureRecognizer) {
        print("Hey! You Just Pressed the Image!")
        animateImage()
        playSound(soundName: "Punch", audioPlayer: &audioPlayer)
    }
}

