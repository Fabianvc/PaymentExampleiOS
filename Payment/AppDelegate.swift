import UIKit
import SwiftyBeaver

let log = SwiftyBeaver.self

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?
    ) -> Bool {
        configureLogs()

        window = UIWindow(frame: UIScreen.main.bounds)

        let nav = UINavigationController()
        nav.pushViewController(HomeViewController(), animated: false)

        window?.rootViewController = nav
        window?.makeKeyAndVisible()

        return true
    }

    // MARK: - Logs
    func configureLogs() {
        let console = ConsoleDestination() // log to Xcode Console
        console.format = "$C $L: $M $c"
        console.levelColor.error = "❌"
        console.levelColor.warning = "‼️"
        console.levelColor.info = "⚠️"
        console.levelColor.debug = "⚙️"
        console.levelColor.verbose = "🌐"
        log.addDestination(console)
    }
}
