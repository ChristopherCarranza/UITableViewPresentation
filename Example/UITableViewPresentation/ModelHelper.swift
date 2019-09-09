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
            AnyUITableViewPresentable(AccountPresenter(account: Account(id: 123456, isActive: true, name: "Youtube"), actionDelegate: delegate)),
            AnyUITableViewPresentable(AccountPresenter(account: Account(id: 234567, isActive: true, name: "Twitch"), actionDelegate: delegate)),
            AnyUITableViewPresentable(AccountPresenter(account: Account(id: 345678, isActive: false, name: "Vimeo"), actionDelegate: delegate))
        ]
        
        let rowsSectionTwo  = [
            AnyUITableViewPresentable(AccountPresenter(account: Account(id: 98765, isActive: true, name: "Apple Music"), actionDelegate: delegate)),
            AnyUITableViewPresentable(AccountPresenter(account: Account(id: 87654, isActive: true, name: "Spotify"), actionDelegate: delegate)),
            AnyUITableViewPresentable(AccountPresenter(account: Account(id: 76543, isActive: true, name: "SoundCloud"), actionDelegate: delegate)),
            AnyUITableViewPresentable(AccountPresenter(account: Account(id: 65432, isActive: true, name: "Pandora"), actionDelegate: delegate))
        ]
        
        return [
            UITableViewSection(rows: rowsSectionOne, header: .presentable(AnyUITableViewHeaderFooterPresentable(AccountsSectionHeaderPresenter(title: "Video Accounts")))),
            UITableViewSection(rows: rowsSectionTwo, header: .title("Music Accounts"))
        ]
    }
    
    class func testModelTwo(delegate: ExampleActionDelegate) -> UITableViewModel {
        let rowsSectionOne = [
            AnyUITableViewPresentable(AccountPresenter(account: Account(id: 123456, isActive: true, name: "Youtube"), actionDelegate: delegate)),
            AnyUITableViewPresentable(AccountPresenter(account: Account(id: 234567, isActive: true, name: "Twitch"), actionDelegate: delegate)),
            AnyUITableViewPresentable(AccountPresenter(account: Account(id: 345678, isActive: true, name: "Vimeo"), actionDelegate: delegate))
        ]
        
        let rowsSectionTwo  = [
            AnyUITableViewPresentable(AccountPresenter(account: Account(id: 98765, isActive: false, name: "Apple Music"), actionDelegate: delegate)),
            AnyUITableViewPresentable(AccountPresenter(account: Account(id: 87654, isActive: true, name: "Spotify"), actionDelegate: delegate)),
        ]
        
        let rowsSectionThree  = [
            AnyUITableViewPresentable(AccountPresenter(account: Account(id: 192837, isActive: true, name: "Github"), actionDelegate: delegate)),
            AnyUITableViewPresentable(AccountPresenter(account: Account(id: 564912, isActive: true, name: "Bitbucket"), actionDelegate: delegate)),
        ]
        
        return [
            UITableViewSection(rows: rowsSectionOne, header: .presentable(AnyUITableViewHeaderFooterPresentable(AccountsSectionHeaderPresenter(title: "Video Accounts")))),
            UITableViewSection(rows: rowsSectionTwo, header: .title("Music Accounts")),
            UITableViewSection(rows: rowsSectionThree, header: .title("Git Accounts"))
        ]
    }
}
