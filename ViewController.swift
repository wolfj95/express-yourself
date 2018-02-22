//
//  ViewController.swift
//  express yourself
//
//  Created by Jacob Wolf on 2/20/18.
//  Copyright © 2018 Jacob Wolf. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {
    
    let motion = CMMotionManager()
    
    //MARK:Properties
    @IBOutlet var background: UIView!
    @IBOutlet weak var alphaSlider: UISlider!
    
    //color variables
    var red: CGFloat = 0.0
    var blue: CGFloat = 0.0
    var green: CGFloat = 0.0
    var alpha: CGFloat = 0.5
    
    //timer
    var timer: Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        startDeviceMotion()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: Actions
    
    func startDeviceMotion() {
        if motion.isDeviceMotionAvailable {
            self.motion.deviceMotionUpdateInterval = 1.0 / 60.0
            self.motion.showsDeviceMovementDisplay = true
            self.motion.startDeviceMotionUpdates(using: .xMagneticNorthZVertical)
 
             //Configure a timer to fetch the motion data.
            timer = Timer(fire: Date(), interval: (1.0/60.0), repeats: true,
                               block: { (timer) in
                                if let data = self.motion.deviceMotion {
                                    // Get the attitude relative to the magnetic north reference frame.
                                    let x = data.attitude.pitch
                                    let z = data.attitude.yaw
                                    if x < -0 {
                                        self.chooseRandomColor()
                                    }
                                    self.alpha = CGFloat(((z * -1) + 3)/3.3)
                                    print("alpha: " + String(describing: self.alpha))
                                    self.view.backgroundColor = UIColor.init(red: self.red, green: self.green, blue: self.blue, alpha: self.alpha)
                                }
            })
    
            // Add the timer to the current run loop.
            RunLoop.current.add(timer!, forMode: .defaultRunLoopMode)
        }
    }
    
    @IBAction func colorChange(_ sender: Any) {
        chooseRandomColor()
        self.view.backgroundColor = UIColor.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    func chooseRandomColor() {
        red = CGFloat(drand48())
        blue = CGFloat(drand48())
        green = CGFloat(drand48())
    }
    
}

