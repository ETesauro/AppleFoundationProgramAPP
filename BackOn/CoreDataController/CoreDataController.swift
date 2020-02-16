//
//  CoreDataController.swift
//  BackOn
//
//  Created by Emmanuel Tesauro on 15/02/2020.
//  Copyright © 2020 Emmanuel Tesauro. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class CoreDataController {
    static let shared = CoreDataController()
    private var context: NSManagedObjectContext
    
    
    init() {
        let application = UIApplication.shared.delegate as! AppDelegate
        self.context = application.persistentContainer.viewContext
    }
    
    func addUser(user: UserInfo) {
        let entity = NSEntityDescription.entity(forEntityName: "PUser", in: self.context)
        
        let newUser = PUser(entity: entity!, insertInto: self.context)
        newUser.name = user.name
        newUser.surname = user.surname
        newUser.userID = user.userID
        
        
        do {
            try self.context.save()
        } catch let errore {
            print("[CDC] Problema salvataggio Libro: \(newUser.name!) in memoria")
            print("  Stampo l'errore: \n \(errore) \n")
        }
        print("\(newUser.name!) salvato in memoria.")
        
    }
    
    
    func checkUser() -> Bool{
        print("[CDC] Recupero l'utente dal context ")
        
        let fetchRequest: NSFetchRequest<PUser> = PUser.fetchRequest()
        
        do {
            let array = try self.context.fetch(fetchRequest)
            
            guard array.count > 0 else {
                print("[CDC] Non ci sono utenti")
                return false
            }
            
            for x in array {
                let user = x
                print("[CDC] Utente \(user.name!), \(user.userID!)")
            }
            
            return true
            
        } catch let errore {
            print("[CDC] Problema esecuzione FetchRequest")
            print("  Stampo l'errore: \n \(errore) \n")
            return false
        }
    }
    
    
    func getLoggedUser() -> (String, UserInfo){
        print("[CDC] Recupero l'utente dal context ")
        
        let fetchRequest: NSFetchRequest<PUser> = PUser.fetchRequest()
        
        do {
            let array = try self.context.fetch(fetchRequest)
            
            guard array.count > 0 else {
                print("[CDC] Non ci sono utenti")
                return ("Nil", UserInfo(photo: "", name: "", surname: ""))
            }
            
            for x in array {
                let user = x
                print("[CDC] Utente \(user.name!), \(user.userID!)")
            }
            
            //            photo = "" va cambiato
            let myUser = UserInfo(photo: "", name: array[0].name!, surname: array[0].surname!)
            
            return ("OK", myUser)
            
        } catch let errore {
            print("[CDC] Problema esecuzione FetchRequest")
            print("  Stampo l'errore: \n \(errore) \n")
            return ("Nil", UserInfo(photo: "", name: "", surname: ""))
        }
    }
    
}
