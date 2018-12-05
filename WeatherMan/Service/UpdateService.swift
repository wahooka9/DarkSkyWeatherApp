//
//  UpdateService.swift
//  WeatherMan
//
//  Created by Andrew Riznyk on 12/4/18.
//  Copyright © 2018 Andrew Riznyk. All rights reserved.
//

import UIKit

class UpdateService {
    private let fireTimeInterval : Int!
    var timer : Timer!
    let timeClosure : ((Timer)->Void)!
    
    init(time:Int, closure:@escaping ()->()){
        fireTimeInterval = time
        timeClosure = { timeCallback  in
            closure()
        }
        timer = Timer.scheduledTimer(withTimeInterval: TimeInterval(time), repeats: true, block: timeClosure)
        timer.fire()
        
        NotificationCenter.default.addObserver(self, selector: #selector(UpdateService.backgrounded), name: UIApplication.willResignActiveNotification, object: nil)
    }
    
    deinit {
        backgrounded()
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc private func backgrounded() {
        if let time = timer {
            time.invalidate()
        }
    }
    
    func restart(){
        timer = Timer.init(timeInterval: timer.timeInterval, repeats: true, block: timeClosure)
    }
    
}
