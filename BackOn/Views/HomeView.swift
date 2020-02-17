//
//  HomeView.swift
//  BeMyPal
//
//  Created by Vincenzo Riccio on 12/02/2020.
//  Copyright © 2020 Vincenzo Riccio. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var shared: Shared
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack{
    //          Bottone per chiedere il permesso alle notifiche
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
    //          Bottone per notificare il prossimo commitment
                Button("Schedule Notification") {
                    let nextCommitment = getNextNotificableCommitment(dataDictionary: self.shared.commitmentSet)
                    if(nextCommitment != nil){
                        let notification = UNMutableNotificationContent()
                        notification.title = nextCommitment!.title
                        notification.subtitle = nextCommitment!.descr
                        notification.sound = UNNotificationSound.default
                        
        //              Imposto la notifica 30 min prima della scadenza
                        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: nextCommitment!.timeRemaining() - 30*60, repeats: false)
        //              let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
                        let request = UNNotificationRequest(identifier: nextCommitment!.ID.uuidString, content: notification, trigger: trigger)
        //              Aggiungo la richiesta di notifica al notification center (sembra una InvokeLater per                le notifiche)
                        UNUserNotificationCenter.current().add(request)
                    }
                }
                CommitmentRow()
                DiscoverRow()
            }
        }
        .background(Color("background"))
        .edgesIgnoringSafeArea(.all)
    }
}

#if DEBUG
struct HomeView_Previews: PreviewProvider {
   static var previews: some View {
      HomeView()
   }
}
#endif
