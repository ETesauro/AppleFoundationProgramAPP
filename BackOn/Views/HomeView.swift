//
//  HomeView.swift
//  BeMyPal
//
//  Created by Vincenzo Riccio on 12/02/2020.
//  Copyright © 2020 Vincenzo Riccio. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack{

                //      VStack che contiene due bottoni, il primo per chiedere i permessi
                //      di inviare notifiche,
                //      Il secondo attualmente triggera la notifica con il nextCommitment
                        
                            
                            Button("Request Permission") {
                //              HO SCELTO AUTORIZZAZIONE AD ALERT, BADGE E NOTIFICATION SOUND
                                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                                    if success {
                                        print("All set!")
                                    } else if let error = error {
                                        print(error.localizedDescription)
                                    }
                                }
                            }

                            Button("Schedule Notification") {
                                let content = UNMutableNotificationContent()
                                let nextCommitment = self.getNextCommitment(data: commitmentData)
                                
                //                content.title = "Tommy diventa Trusted!"
                                content.title = nextCommitment.title
                                
                //                content.subtitle = "Carica la C.I. con Nome: Tommy Riccio"
                                content.subtitle = nextCommitment.descr
                                
                                content.sound = UNNotificationSound.default

                //              Ciò che fa partire la notifica... Ho messo 5 secondi
                //                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
                                
                //              Imposto il commitment 30 min prima della scadenza
                                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: nextCommitment.timeRemaining() - 30*60, repeats: false)
                                
                //              Identificatore di richiesta, per ora ho messo a caso (?)
                //              Per la presentazione non dovrebbe essere un problema
                                let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

                //              Aggiungiamo la richiesta di notifica al notification center
                //              Mi ricorda una sorta di InvokeLater, ma per le notifiche
                                UNUserNotificationCenter.current().add(request)
                            }
                
                
                CommitmentRow()
                DiscoverRow()
            }
        }
    }
    
        //Questo metodo da un array di commitment restituisce il più imminente
        //ASSUNZIONI:
        //  data HA SOLO commitment futuri (non ancora implementata tale selezione)
        //  data NON E' VUOTO
        //  In futuro avrà i commitment "For you"
        func getNextCommitment(data: [Commitment]) -> Commitment {
            var toReturn = data[0]
            
        //  Scorre data[] e sceglie il commitment più imminente
            for c in data{
                if(toReturn.date.compare(c.date) == ComparisonResult.orderedDescending){
                    toReturn = c
                }
            }
            return toReturn
        }
        
        func getNextFive(dataDictionary: [UUID: Commitment]) -> [Commitment]{
    /*
        Se si passa a strutture dati canoniche:
            Ordinata
            Eseguo la insert e la remove last ogni volta che passo per un elemento
    */
            let data = Array(dataDictionary.values)
            var toReturn: [Commitment] = [data[0]]

    //      Mi serve a sapere se non ho ancora inserito i primi 5 elementi ordinatamente
            var last = 0

            for i in 1...data.count{
                for j in stride(from: last < 5 ? last : 4, through: 0, by: -1){
                    if(toReturn[j].date.compare(data[i].date) == ComparisonResult.orderedDescending){
                        let toShift = toReturn[j]
                        toReturn[j] = data[i]
                        toReturn[j + 1] = toShift
                    }
                    else {
                        if(last < 5){
                           toReturn[last + 1] = data[i]
                        }
                    }
                    last += 1
                }
            }
            return toReturn
        }
    
}

#if DEBUG
struct HomeView_Previews: PreviewProvider {
   static var previews: some View {
      HomeView()
   }
}
#endif
