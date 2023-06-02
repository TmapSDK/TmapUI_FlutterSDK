import os.log

extension OSLog {
    static let tmapLog: OSLog = OSLog(subsystem: Bundle.main.bundleIdentifier ?? "com.SKTelecom.TMap", category: "tmap")
}
func tmapLog(_ message: @autoclosure () -> Any) {
    #if DEBUG
        os_log(.debug, log: .tmapLog, "%{public}s", "\(message())")
    #endif
}

typealias Debuggable = Logging

protocol Logging {
    var debugEnabled : Bool? { get set }
    
    func log(_ message: String,
             filePath : String,
             funcName : String,
             lineNumber : Int,
             columnNumber : Int)
}

extension Logging {
    
    func log(_ message: String,
             filePath : String = #file,
             funcName : String = #function,
             lineNumber : Int = #line,
             columnNumber : Int = #column) {
        
        if true == debugEnabled! {
            let fileName = (filePath as NSString).lastPathComponent.split(separator: ".")[0]
            print("[\(date())][\(fileName)-\(funcName):\(lineNumber)] - \(message)")
        }
    }
}

func date() -> String {
    let date = Date()
    let formatter = DateFormatter()
    formatter.dateFormat = "HH:mm:ss.SSSS"
    
    return formatter.string(from: date)
}

func Log(_ message: String,
         filePath : String = #file,
         funcName : String = #function,
         lineNumber : Int = #line,
         columnNumber : Int = #column) {
#if DEBUG
    let fileName = (filePath as NSString).lastPathComponent.split(separator: ".")[0]
    print("[\(date())][\(fileName)-\(funcName):\(lineNumber)] - \(message)")
#endif
}
