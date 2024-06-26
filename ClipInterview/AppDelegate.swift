//
//  AppDelegate.swift
//  ClipInterview
//
//  Created by Sergio Andres Rodriguez Castillo on 27/03/24.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let ejerciciosPracticos = EjerciciosPracticos()
        ejerciciosPracticos.maxAndMinSumForNumberSeries([1,3,5,7,9])
        ejerciciosPracticos.maxAndMinSumForNumberSeries([1,2,3,4,5])
        
        ejerciciosPracticos.maxAndMinSumForNumberSeriesSecondSolution([1,3,5,7,9])
        ejerciciosPracticos.maxAndMinSumForNumberSeriesSecondSolution([1,2,3,4,5])
        
        print(ejerciciosPracticos.validateString("abc"))
        print(ejerciciosPracticos.validateString("abcc"))
        print(ejerciciosPracticos.validateString("abccc"))
        
        window = UIWindow()
        let serviceManager = ServiceManager()
        let viewModel = ListViewModel(serviceManager: serviceManager)
        let viewController = ListViewController(viewModel: viewModel)
        let navigationController = UINavigationController(rootViewController: viewController)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        return true
    }
}

