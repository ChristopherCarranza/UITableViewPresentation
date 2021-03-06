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
        let rowsSectionOne = [
            AccountPresenter(account: Account(id: 123456, isActive: true, name: "Youtube"), actionDelegate: delegate),
            AccountPresenter(account: Account(id: 234567, isActive: true, name: "Twitch"), actionDelegate: delegate),
            AccountPresenter(account: Account(id: 345678, isActive: false, name: "Vimeo"), actionDelegate: delegate)
        ]
        
        let rowsSectionTwo  = [
            AccountPresenter(account: Account(id: 98765, isActive: true, name: "Apple Music"), actionDelegate: delegate),
            AccountPresenter(account: Account(id: 87654, isActive: true, name: "Spotify"), actionDelegate: delegate),
            AccountPresenter(account: Account(id: 76543, isActive: true, name: "SoundCloud"), actionDelegate: delegate),
            AccountPresenter(account: Account(id: 65432, isActive: true, name: "Pandora"), actionDelegate: delegate)
        ]
        
        return [
            UITableViewSection(id: "SectionOne", rows: rowsSectionOne, header: .presentable(AnyUITableViewHeaderFooterPresentable(AccountsSectionHeaderPresenter(title: "Video Accounts")))),
            UITableViewSection(id: "SectionTwo", rows: rowsSectionTwo, header: .title("Music Accounts"))
        ]
    }
    
    class func testModelTwo(delegate: ExampleActionDelegate) -> UITableViewModel {
        let rowsSectionOne = [
            AccountPresenter(account: Account(id: 123456, isActive: true, name: "Youtube"), actionDelegate: delegate),
            AccountPresenter(account: Account(id: 234567, isActive: true, name: "Twitch"), actionDelegate: delegate),
            AccountPresenter(account: Account(id: 345678, isActive: true, name: "Vimeo"), actionDelegate: delegate)
        ]
        
        let rowsSectionTwo  = [
            AccountPresenter(account: Account(id: 98765, isActive: false, name: "Apple Music"), actionDelegate: delegate),
            AccountPresenter(account: Account(id: 87654, isActive: true, name: "Spotify"), actionDelegate: delegate),
        ]
        
        let rowsSectionThree  = [
            AccountPresenter(account: Account(id: 192837, isActive: true, name: "Github"), actionDelegate: delegate),
            AccountPresenter(account: Account(id: 564912, isActive: true, name: "Bitbucket"), actionDelegate: delegate),
        ]
        
        return [
            UITableViewSection(id: "SectionOne", rows: rowsSectionOne, header: .presentable(AnyUITableViewHeaderFooterPresentable(AccountsSectionHeaderPresenter(title: "Video Accounts")))),
            UITableViewSection(id: "SectionTwo", rows: rowsSectionTwo, header: .title("Music Accounts")),
            UITableViewSection(id: "SectionThree", rows: rowsSectionThree, header: .title("Git Accounts"))
        ]
    }
}
