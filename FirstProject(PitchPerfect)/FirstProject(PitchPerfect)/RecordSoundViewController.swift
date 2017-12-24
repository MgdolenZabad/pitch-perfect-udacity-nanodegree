//
//  ViewController.swift
//  FirstProject(PitchPerfect)
//
//  Created by Mgdolen Zabad on 8/19/17.
//  Copyright © 2017 Udacity1stproject. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundViewController: UIViewController, AVAudioRecorderDelegate {

    @IBOutlet weak var tapToRecord: UILabel!
    @IBOutlet weak var stopRecordButton: UIButton!
    @IBOutlet weak var recordButton: UIButton!
    
    var audioRecorder : AVAudioRecorder!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stopRecordButton.isEnabled = false
    }

    

    @IBAction func recordingButton(_ sender: Any) {
        
        switchLabelsAndButtons(isRecording: true)
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord, with:AVAudioSessionCategoryOptions.defaultToSpeaker)
        
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }

    @IBAction func stoppingtheRecordButton(_ sender: Any) {
        switchLabelsAndButtons(isRecording: false)
        
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
        
    }
    //"Tap To Record"
    //"Recording In Progress"
    func switchLabelsAndButtons(isRecording:Bool){
        tapToRecord.text = isRecording ? "Recording In Progress" : "Tap To Record"
        stopRecordButton.isEnabled = isRecording
        recordButton.isEnabled = !isRecording
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
            performSegue(withIdentifier: "StopRecording", sender: audioRecorder.url)
        } else {
            let alert = UIAlertController(title: "My Alert", message: "This Audio didn't recorded successfully", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .`default`, handler: { _ in
                NSLog("The \"OK\" alert occured.")
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "StopRecording" {
        let playSoundsVC = segue.destination as! playSoundViewController
        let recordedAudioURL = sender as! URL
        playSoundsVC.recordedAudioUrl = recordedAudioURL
        
        }
    }
    
}

