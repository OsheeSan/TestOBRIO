//
//  AppDelegate.swift
//  TestOBRIO
//
//  Created by admin on 30.04.2024.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        return true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute:  {
            print("Active")
        })
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute:  {
            print("Active")
        })  // Приложение снова становится активным после того, как было в фоне
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Data")
        container.loadPersistentStores(completionHandler: {
            description, error in
            guard error == nil else {
                print(error?.localizedDescription)
                return
            }
        })
        return container
    }()
    
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                    fatalError(error.localizedDescription)
            }
        }
    }


}

