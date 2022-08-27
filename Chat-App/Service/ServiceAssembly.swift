//
//  ServiceAssembly.swift
//  Chat-App
//
//  Created by Станислав on 03.07.2022.
//

class ServiceAssembly {
    
    static let coreDataService: CoreDataService = CoreDataServiceImplementation()
    static let channelFirebaseService: ChannelFirebaseService = ChannelFirebaseServiceImplementation()
    static let messageFirebaseService: MessageFirebaseService = MessageFirebaseServiceImplementation()
    static let profileDataService: ProfileDataService = ProfileDataServiceImplementation()
    static let gcdService: MultithreadingService = GCDService()
    static let operationService: MultithreadingService = OperationService()
    static let fetchControllerService: FetchControllerService = FetchControllerServiceImplementation()
    static let themeService: ThemeService = ThemeServiceImplementation()
    static let conversationsListDisplayDataService: ConversationsListDisplayDataService = ConversationsListDisplayDataServiceImplementation()
    static let conversationDisplayDataService: ConversationDisplayDataService = ConversationDisplayDataServiceImplementation()
    static let networkConfigFactory: ConfigFactory = ConfigFactory()
}
