//
//  ViewController.swift
//  Bip the Guy
//
//  Created by Andrew Boucher on 9/16/19.
//  Copyright © 2019 Andres de la Cruz. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var imageToPunch: UIImageView!
    
    var audioPlayer = AVAudioPlayer()
    
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
    
    func  animateImage () {
     let bounds = self.imageToPunch.bounds
     let shrinkValue: CGFloat = 60
        self.imageToPunch.bounds = CGRect(x:  self.imageToPunch.bounds.origin.x + shrinkValue, y: self.imageToPunch.bounds.origin.y + shrinkValue, width: self.imageToPunch.bounds.size.width - shrinkValue, height: self.imageToPunch.bounds.size.height - shrinkValue)
    
        UIView.animate(withDuration: 0.25, delay: 0.0, usingSpringWithDamping: 0.2, initialSpringVelocity: 10.0, options: [], animations: {self.imageToPunch.bounds = bounds}, completion: nil)
    }
    
    
    // actions
    @IBAction func libraryPressed(_ sender: UIButton) {
    }
    
    @IBAction func takeAPhotoPressed(_ sender: Any) {
    }
    
    @IBAction func imageTapped(_ sender: UITapGestureRecognizer) {
        print("Hey! You Just Pressed the Image!")
        animateImage()
        playSound(soundName: "Punch", audioPlayer: &audioPlayer)
    }
}

