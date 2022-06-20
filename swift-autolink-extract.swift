import Foundation

let task = Process()
task.launchPath = "/usr/bin/xcrun"
task.arguments = ["swift-frontend", "--driver-mode=swift-autolink-extract"] + Array(ProcessInfo.processInfo.arguments.dropFirst())
task.launch()
task.waitUntilExit()
exit(task.terminationStatus)
