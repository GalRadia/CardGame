
import Foundation

protocol CallBack_GameTimer{
    func changeImages()
    func closeImages()
    func updateResult()
}

class GameTimer{
    var cb: CallBack_GameTimer?
    var flag = 1
    
    init(cb: CallBack_GameTimer? = nil) {
        self.cb = cb
    }
    func startTimer(){
        if(flag==1){
            return
        }
        flag = 1
        repeat{
            cb?.changeImages()
            sleep(3)
            cb?.updateResult()
            cb?.closeImages()
            sleep(2)
        }while(flag==1)
    }
    func stop(){
        flag = 0
    }

    
}
