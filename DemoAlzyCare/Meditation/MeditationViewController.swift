import UIKit
import AVFoundation


class MeditationViewController: UIViewController {
    

    @IBOutlet weak var durationPicker: UIDatePicker!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var progressView: CircularProgressView1!
    @IBOutlet weak var setTimeLabel: UILabel!
    @IBOutlet weak var setMusicLabel: UILabel!
    @IBOutlet var backgroundSoundPicker: UIPickerView!
    
    
    var timer: Timer?
        var meditationSession: MeditationSession?
        var isPaused = false
        var audioPlayer: AVAudioPlayer?
        var backgroundAudioPlayer: AVAudioPlayer?

        var backgroundSounds = ["None", "Ocean Waves", "Valley Sunset", "Rainfall"]
        var selectedBackgroundSound: String?

        override func viewDidLoad() {
            super.viewDidLoad()

            // Configure the duration picker for countdown timer mode
            durationPicker.datePickerMode = .countDownTimer
            durationPicker.countDownDuration = 60

            // Initially, the pause and stop buttons should be disabled
            pauseButton.isEnabled = false
            stopButton.isEnabled = false

            // Set up the picker view for background sound selection
            backgroundSoundPicker.dataSource = self
            backgroundSoundPicker.delegate = self
        }

        @IBAction func startButtonTapped(_ sender: UIButton) {
            let duration = durationPicker.countDownDuration
            meditationSession = MeditationSession(duration: duration)
            meditationSession?.start()

            // Start the timer
            timer?.invalidate()  // Invalidate any existing timer
            timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
                self?.updateTimeLabel()
            }

            // Play background sound
            playBackgroundSound()

            startButton.isEnabled = false
            pauseButton.isEnabled = true
            stopButton.isEnabled = true
            durationPicker.isEnabled = false
            durationPicker.isHidden = true
            setTimeLabel.isHidden = true
            
            setMusicLabel.isHidden = true
            backgroundSoundPicker.isHidden = true // Hide the picker view during the session
        }

        @IBAction func pauseButtonTapped(_ sender: UIButton) {
            if isPaused {
                    // Resume
                    meditationSession?.resume()
                    timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
                        self?.updateTimeLabel()
                    }
                    pauseButton.setTitle("Pause", for: .normal)
                    backgroundAudioPlayer?.play() // Resume background music
                } else {
                    // Pause
                    meditationSession?.pause()
                    timer?.invalidate()
                    pauseButton.setTitle("Resume", for: .normal)
                    backgroundAudioPlayer?.pause() // Pause background music
                }
                isPaused.toggle()

        }

        @IBAction func stopButtonTapped(_ sender: UIButton) {
            timer?.invalidate()
            meditationSession?.end()

            // Stop background sound
            backgroundAudioPlayer?.stop()

            startButton.isEnabled = true
            pauseButton.isEnabled = false
            stopButton.isEnabled = false
            durationPicker.isEnabled = true
            durationPicker.isHidden = false // Show the duration picker
            setTimeLabel.isHidden = false
            setMusicLabel.isHidden = false
            backgroundSoundPicker.isHidden = false // Show the picker view again
            timeLabel.text = "Session Stopped"
            progressView.progress = 0
            pauseButton.setTitle("Pause", for: .normal)
            isPaused = false
        }

        func updateTimeLabel() {
            guard let session = meditationSession else { return }
            let remainingTime = session.remainingTime
            
            if remainingTime > 0 {
                timeLabel.text = formatTime(remainingTime)
                let progress = 1 - CGFloat(remainingTime / session.duration)
                progressView.progress = progress
            } else {
                timeLabel.text = "Session Complete"
                timer?.invalidate()
                startButton.isEnabled = true
                pauseButton.isEnabled = false
                stopButton.isEnabled = false
                durationPicker.isEnabled = true
                progressView.progress = 1
                pauseButton.setTitle("Pause", for: .normal)
                isPaused = false

                // Play completion sound
                playSound()
                
                // Stop background sound
                backgroundAudioPlayer?.stop()
            }
        }

        func formatTime(_ interval: TimeInterval) -> String {
            let minutes = Int(interval) / 60
            let seconds = Int(interval) % 60
            return String(format: "%02d:%02d", minutes, seconds)
        }

        func playSound() {
            guard let url = Bundle.main.url(forResource: "bell_Sound", withExtension: "wav") else { return }
            
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: url)
                audioPlayer?.play()
            } catch {
                print("Error playing sound: \(error.localizedDescription)")
            }
        }

        func playBackgroundSound() {
            guard let soundName = selectedBackgroundSound, soundName != "None" else {
                print("No background sound selected.")
                return
            }
            
            guard let url = Bundle.main.url(forResource: soundName, withExtension: "mp3") else {
                print("Sound file \(soundName).mp3 not found in the bundle.")
                return
            }
            
            do {
                backgroundAudioPlayer = try AVAudioPlayer(contentsOf: url)
                backgroundAudioPlayer?.numberOfLoops = -1 // Loop indefinitely
                backgroundAudioPlayer?.play()
                print("Playing background sound: \(soundName)")
            } catch {
                print("Error playing background sound: \(error.localizedDescription)")
            }
        }
    }

    extension MeditationViewController: UIPickerViewDataSource, UIPickerViewDelegate {
        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 1
        }
        
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return backgroundSounds.count
        }
        
        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return backgroundSounds[row]
        }
        
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            selectedBackgroundSound = backgroundSounds[row]
            print("Selected background sound: \(selectedBackgroundSound ?? "None")")
        }
    }
