
import Foundation

protocol CallBack_GameTimer{
    func changeImages()
    func closeImages()
    func updateResult()
}

class GameTimer{
    var cb: CallBack_GameTimer?
    var flag = 1
    var timer:Timer?
    var currentStep:Int=0
    
    init(cb: CallBack_GameTimer? = nil) {
        self.cb = cb
    }
    func startTimer(){
        currentStep = 0
        schedulerTimer(interval: 1.0)
    }
    private func schedulerTimer(interval: TimeInterval){
        timer = Timer.scheduledTimer(timeInterval: interval, target: self, selector: #selector(timerFired), userInfo: nil, repeats: false)
    }
    @objc private func timerFired(){
        switch currentStep{
        case 0 :
            cb?.closeImages()
            schedulerTimer(interval: 2.0)
            currentStep = 1
        case 1:
            cb?.changeImages()
            schedulerTimer(interval: 2.0)
            currentStep = 2
        case 2:
            cb?.closeImages()
            cb?.updateResult()
            startTimer()
        default:
            break
        }
    }
    func stop(){
        flag = 0
    }

    
}
