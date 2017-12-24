//
//  playSoundViewController.swift
//  FirstProject(PitchPerfect)
//
//  Created by Mgdolen Zabad on 8/21/17.
//  Copyright © 2017 Udacity1stproject. All rights reserved.
//

import UIKit
import AVFoundation

class playSoundViewController: UIViewController {
    
    
    @IBOutlet weak var fastButton: UIButton!
    @IBOutlet weak var slowButton: UIButton!
    @IBOutlet weak var echoButton: UIButton!
    @IBOutlet weak var reverbButton: UIButton!
    @IBOutlet weak var darthvaderButton: UIButton!
    @IBOutlet weak var chipmunkButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    
    
    var recordedAudioUrl : URL!
    var audioFile: AVAudioFile!
    var audioEngine: AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!
    
    enum ButtonType: Int {
        case slow = 0, fast, darthvader, chipmunk, echo, reverb
    }
    
    
    @IBAction func playSoundForButton(_ sender: UIButton) {
        print("Play Sound Button Pressed")
        
        switch(ButtonType(rawValue: sender.tag)!) {
        case .slow:
            playSound(rate: 0.5)
        case .fast:
            playSound(rate: 1.5)
        case .chipmunk:
            playSound(pitch: 1000)
        case .darthvader:
            playSound(pitch: -1000)
        case .echo:
            playSound(echo: true)
        case .reverb:
            playSound(reverb: true)
        }
        
        configureUI(.playing)
        
    }
    
    @IBAction func stopButtonPressed(_ sender: AnyObject) {
        print("Stop Audio Button Pressed")
        stopAudio()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAudio()
        fastButton.imageView?.contentMode = .scaleAspectFit
        slowButton.imageView?.contentMode = .scaleAspectFit
        echoButton.imageView?.contentMode = .scaleAspectFit
        reverbButton.imageView?.contentMode = .scaleAspectFit
        darthvaderButton.imageView?.contentMode = .scaleAspectFit
        chipmunkButton.imageView?.contentMode = .scaleAspectFit
        stopButton.imageView?.contentMode = .scaleAspectFit
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureUI(.notPlaying)
        
    }
    
}
