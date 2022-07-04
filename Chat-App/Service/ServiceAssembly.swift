//
//  ServiceAssembly.swift
//  Chat-App
//
//  Created by Станислав on 03.07.2022.
//

class ServiceAssembly {
    
    static var coreDataService: CoreDataService {
        CoreDataServiceImplementation()
    }
    
    static var channelFirebaseService: ChannelFirebaseService {
        ChannelFirebaseServiceImplementation()
    }
    
    static var messageFirebaseService: MessageFirebaseService {
        MessageFirebaseServiceImplementation()
    }
    
    static var profileDataService: ProfileDataService {
        ProfileDataServiceImplementation()
    }
    
    static var gcdService: MultithreadingService {
        GCDService()
    }
    
    static var operationService: MultithreadingService {
        OperationService()
    }
    
    static var fetchControllerService: FetchControllerService {
        FetchControllerServiceImplementation()
    }
    
    static var themeService: ThemeService {
        ThemeServiceImplementation()
    }
    
    static var conversationsListDisplayDataService: ConversationsListDisplayDataService {
        ConversationsListDisplayDataServiceImplementation()
    }
    
    static var conversationDisplayDataService: ConversationDisplayDataService {
        ConversationDisplayDataServiceImplementation()
    }
}
