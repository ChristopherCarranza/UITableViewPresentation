//
//  ModelHelper.swift
//  UITableViewPresentation
//
//  Created by Christopher Carranza on 7/14/17.
//  Copyright © 2019 Christopher Carranza. All rights reserved.
//
//

import Foundation
import UITableViewPresentation

final class ModelHelper {
    class func testModelOne(delegate: ExampleActionDelegate) -> UITableViewModel {
        let sectionOne = UITableViewSectionBuilder()
            .withId("SectionOne")
            .withHeaderPresentable(AccountsSectionHeaderPresenter(title: "Video Accounts"))
            .addRows([
                AccountPresenter(account: Account(id: 123456, isActive: true, name: "Youtube"), actionDelegate: delegate),
                AccountPresenter(account: Account(id: 234567, isActive: true, name: "Twitch"), actionDelegate: delegate),
                AccountPresenter(account: Account(id: 345678, isActive: false, name: "Vimeo"), actionDelegate: delegate)
            ])
        
        let sectionTwo = UITableViewSectionBuilder()
            .withId("SectionTwo")
            .withHeader(.title("Music Accounts"))
            .withRows([
                AccountPresenter(account: Account(id: 98765, isActive: true, name: "Apple Music"), actionDelegate: delegate),
                AccountPresenter(account: Account(id: 87654, isActive: true, name: "Spotify"), actionDelegate: delegate),
                AccountPresenter(account: Account(id: 76543, isActive: true, name: "SoundCloud"), actionDelegate: delegate),
                AccountPresenter(account: Account(id: 65432, isActive: true, name: "Pandora"), actionDelegate: delegate)
            ])
        
        return [
            sectionOne.build(),
            sectionTwo.build()
        ]
    }
    
    class func testModelTwo(delegate: ExampleActionDelegate) -> UITableViewModel {
        let sectionOne = UITableViewSectionBuilder()
            .withId("SectionOne")
            .withHeaderPresentable(AccountsSectionHeaderPresenter(title: "Video Accounts"))
            .addRows([
                AccountPresenter(account: Account(id: 123456, isActive: true, name: "Youtube"), actionDelegate: delegate),
                AccountPresenter(account: Account(id: 234567, isActive: true, name: "Twitch"), actionDelegate: delegate),
                AccountPresenter(account: Account(id: 345678, isActive: true, name: "Vimeo"), actionDelegate: delegate)
            ])
        
        let sectionTwo = UITableViewSectionBuilder()
            .withId("SectionTwo")
            .withHeader(.title("Music Accounts"))
            .addRows([
                AccountPresenter(account: Account(id: 98765, isActive: false, name: "Apple Music"), actionDelegate: delegate),
                AccountPresenter(account: Account(id: 87654, isActive: true, name: "Spotify"), actionDelegate: delegate),
                AccountPresenter(account: Account(id: 87254, isActive: true, name: "Tidal"), actionDelegate: delegate),
                AccountPresenter(account: Account(id: 87554, isActive: true, name: "Amazon Music"), actionDelegate: delegate),
                AccountPresenter(account: Account(id: 81554, isActive: true, name: "Youtube Music"), actionDelegate: delegate),
                AccountPresenter(account: Account(id: 81551, isActive: true, name: "Pandora"), actionDelegate: delegate)
            ])
        
        let sectionThree = UITableViewSectionBuilder()
            .withId("SectionThree")
            .withHeader(.title("Git Accounts"))
            .addRows([
                AccountPresenter(account: Account(id: 192837, isActive: true, name: "Github"), actionDelegate: delegate),
                AccountPresenter(account: Account(id: 564912, isActive: true, name: "Bitbucket"), actionDelegate: delegate),
                AccountPresenter(account: Account(id: 192827, isActive: true, name: "Gitlab"), actionDelegate: delegate),
                AccountPresenter(account: Account(id: 564942, isActive: true, name: "My Favorite Git Service"), actionDelegate: delegate)
            ])
        
        return [
            sectionOne.build(),
            sectionTwo.build(),
            sectionThree.build()
        ]
    }
}
