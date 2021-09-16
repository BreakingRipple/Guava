//
//  Constants.swift
//  Guava
//
//  Created by Savage on 21/8/21.
//

import UIKit

// MARK: StoryboardID
let kFollowVCID = "FollowVCID"
let kNearByVCID = "NearByVCID"
let kDiscoveryVCID = "DiscoveryVCID"
let kWaterfallVCID = "WaterfallVCID"
let kNoteEditVCID = "NoteEditVCID"
let kChannelTableVCID = "ChannelTableVCID"
let kLoginNavID = "LoginNavID"
let kLoginVCID = "loginVCID"
let kMeVCID = "meVCID"


//MARK: CellID
let kWaterfallCellID = "WaterfallCellID"
let kPhotoCellID = "PhotoCellID"
let kPhotoFooterID = "PhotoFooterID"
let kSubChannelCellID = "SubChannelCellID"
let kPOICellID = "POICellID"
let kDraftNoteWaterfallCellID = "DraftNoteWaterfallCellID"

//MARK: resource file related
let mainColor = UIColor(named: "main")!
let mainLightColor = UIColor(named: "main-light")
let blueColor = UIColor(named: "blue")!
let imagePH = UIImage(named: "imagePH")!

//MARK: UserDefaults's key
let kNameFromAppleID = "nameFromAppleID"
let kEmailFromAppleID = "emailFromAppleID"

//MARK: CoreData
let appDelegate = UIApplication.shared.delegate as! AppDelegate
let persistentContainer = appDelegate.persistentContainer
let context = persistentContainer.viewContext //running on main queue
let backgroundContext = persistentContainer.newBackgroundContext() // running on background queue

//MARK: UI layout
let screenRect = UIScreen.main.bounds

// MARK: waterfall
let kWaterfallPadding: CGFloat = 4
let kDraftNoteWaterfallCellBottomViewH: CGFloat = 56
let kChannels = ["For you", "Video", "Live", "Gaming", "Travel", "Fashion", "Vlog", "Photography"]

//YPImagePicker
let kMaxPhotoCount = 9
let kMaxCameraZoomFactor: CGFloat = 5
let kSpacingBetweenItems: CGFloat = 2

//Note
let kMaxNoteTitleCount = 20
let kMaxNoteTextCount = 1000

//Topic
let kAllSubChannels = [
    ["穿神马是神马", "就快瘦到50斤啦", "花5个小时修的靓图", "网红店入坑记"],
    ["魔都名媛会会长", "爬行西藏", "无边泳池只要9块9"],
    ["小鲜肉的魔幻剧", "国产动画雄起"],
    ["练舞20年", "还在玩小提琴吗,我已经尤克里里了哦", "巴西柔术", "听说拳击能减肥", "乖乖交智商税吧"],
    ["粉底没有最厚,只有更厚", "最近很火的法属xx岛的面霜"],
    ["我是白富美你是吗", "康一康瞧一瞧啦"],
    ["装x西餐厅", "网红店打卡"],
    ["我的猫儿子", "我的猫女儿", "我的兔兔"]
]

//GaoDe
let kAMapAPIKey = "c837c7357b4fab67947e024fa95dc8ab"
let kNoPOIPH = "unknown spot"
let kPOITypes = "汽车服务|汽车销售|汽车维修|摩托车服务|餐饮服务|购物服务|生活服务|体育休闲服务|医疗保健服务|住宿服务|风景名胜|商务住宅|政府机构及社会团体|科教文化服务|交通设施服务|金融保险服务|公司企业|道路附属设施|地名地址信息|公共设施"
let kPOIsInitArr = [["don't show position", ""]]
let kPOIsOffset = 20

//JiGuang
let kJAppKey = "716938b4d7f8b61b1f61a9ba"
let kPrivateKey = "MIICeAIBADANBgkqhkiG9w0BAQEFAASCAmIwggJeAgEAAoGBANCero+LQbDl4Nq8YKqUjbZg+5jtdtmNrIWgtA2QkjH2g24DtDPGx7MLhe39ZTR4RzMZ98La4c2XfZTtaJLSm6LtRl0uDx4HzNYxeOyGyCM87kFzfuGxYtqcWaWNls8+wql7D556kIh1SbDH2/vgQWL8IHR3Wr2JGk+hmyVc8J5dAgMBAAECgYEAt4x1r0vpnzeSL0GAl3SefnEzzChZ4i15NhTfdfPV/OmUV24g1VE2kLw5uNuyeIi+tCJLz//+nYGE90wuLsfoL8hq8ozpdJqm1to27CPxjlB2uQ6ZTmqWcBCvL/Kg8hqBlDLnLTHNCFY0aD9hCUroNLW8kovQMEQtt/5WRZ5H5a0CQQD4v1Iez2zp87gIX1AX+UgU1kOgoS3IAzjOVcMUxSuDQ8lKQpF7axlDlYNLIJ+2ZYEqR81WrmvaW7uPrbIpavX3AkEA1rPYQ905luDCxKkmm2t/eK3n7g2rcOkh5lARXYYaXWEAhMkyVuWQSFItX2yC+v2joMgNJ9gwFLv51414yvopSwJBAMWB/C2Um7FDoFudepYejDpnSvlPIW/QBxnmhOiICh3HBBwfsS5jAoNkQwSzGb2U6TNuIb/y7JZMAih6TZ2PXU8CQCVXJfe3k/p/oKAfYw2IxqSwajPmwLhkc3bg2gRP/GndIv/1FgIy7sMFN8ruzmDkl/6wjEkvuj0A7FTmz+lNVL0CQQCtpOaXKbZPuikcAgZ8Py7lVNDOZTBONRa5NEf5cGtewDGyJEv/lx7Krl6lyQzSot9iPZuE+NAQIkNCI2AhhMBJ"
let kPublicKey = "MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDQnq6Pi0Gw5eDavGCqlI22YPuY7XbZjayFoLQNkJIx9oNuA7QzxsezC4Xt/WU0eEczGffC2uHNl32U7WiS0pui7UZdLg8eB8zWMXjshsgjPO5Bc37hsWLanFmljZbPPsKpew+eepCIdUmwx9v74EFi/CB0d1q9iRpPoZslXPCeXQIDAQAB"

//Alipay
let kAliPayAppID = "2021002179620483"
let kAliPayPID = "2088212904324795"
let kAliPayPrivateKey = "MIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDyDxvBx3VajnvxFCkbvmwh4b81RE6x2qwRfuVCSdlNAPuXbkXPEriKOh1XnWKjFDp/5MYomycbLL30j8OiFH4nNGhCkgKwDxOcDC3po2SNCQrtmukgyC7PEVGkfMN1mnCt/3a8IkS14H60dL3MpkWrTPFBbJDi2TGon54lJUTPGHdVEquthZ4/8Owh5twWBNeNgW95r+B5mbkVfRIETmyqwe73d+vu6/A0hXs+uHWldQt++DoCO6ZfN6715HriQGaCnY4bhJUzAB1KN0xNGe9QDC5pEVHP4J9hCVtIqPAYK5vzWqw9isSdhyJIn/B3A66zmI1jHRb/TxvdjhHCp96hAgMBAAECggEADsrXkmcDB+6vKlNmE7j2WLe3/KRY/stzOnp7vipPKkKGHYHyqC3nsyLMCj+m+HpS/N/ZMEATCrkYPqrOdMg10WWFfZP4sBOryhyAbce7bFcCIPUXjBZPrf3L9HZfZ39xpWB4PBUIB+lZNOPxeWEr3sUL9UiSLhrByyE+A90cMF+a9Qzwwr6h8j3WCI+bacUwTLIcwDzatLyTT/JuLdR1J8bUuf6XaI7mmRBYEIgKeC93AsqSPef2tlFfB78Sruyc4IZugoIvbJAk18nvDok8U6kboHvg+KC8pqbbKdFVJIm4O6OVMzm4xXnVTDS3mHT3VyaFprLXUXkdCCVb8h3aZQKBgQD9sFV+d3OZdK7YWQsP9l2L0Jjs6QF3g8bVJ+9wLiRzfHOUfftgXHzsqVcgl8VaSKOwoNvbAFTJWr7drKlt/UwuGGY3YyuTbKjRePuvVNLCFJeuoBRqvm6PFpbUZLR0v8/Pu35QETTrxWxbdbW2QwFDAdWd6QnhGFkJPll7fRI00wKBgQD0Q6af98l9OjzBHEwbS+ligDjD3n9N8rzVtEwbI+n9gzFdjcrzDJCwk+C/NNhzv+Xst4egfrmBJXMK3txr0N04yiP3/o0rh9rRWcfMwIVhNLc2n2hSvbqYWhNMO47Jl3TeefdH291r+cB41r/MDsWlR2g+2fzWYq7VXq9fJGxGOwKBgBgI2cC2jnQuctY6cWrcu3YgmCxx0trA2FifhPbK2Fc8pjKeUO+LM6a0UHXdCyyHj0KPquSvvlipSUX1MsQh6FLBqwV6VsmL1N6rqKSu05zhmJFJx0Vpr03NJRMQS2x4M7cJm2j4iFwCA0cS+tk+teLkTJm+V1pFFUJj7tRdQBlTAoGAZhX4B5dJsHqsdZDcBfR9/9rS3pmY3vz6Ct6liBpEat1vvkfKcDXqKsJDBeaSKB4le/9gQaV05hK+t+ZYfP731go1aioK2gyXWTOKm3pCxFOB1uRcd2gwGghbVFr33CzefTTAMlojekMRO++UjTYHSIJFgS8dyoPHygkehkb0sY0CgYEApOMlYE8CdnXAZlqaSCuOJN/HMOdpm96zqyyFt6EC6W3VOkNSjjL14YCIBxSHZyd9Lb4Nnz7rct7C0DqBUzQMVFfZqTjMAqLHpo677QSwKCv4QrIZlYPlpIOl5zRVVTX8bLbOkcrgitlnJx0+LAv7attactpFd9aKZN2/dzb3RKU="
let kAppScheme = "Guava"

// regualr expression
let kChinaPhoneRegEx = "^1\\d{10}$"
let kAuthCodeRegEx = "^\\d{6}$"

//MARK: LeanCloud
//Settings
let kLCAppID = "XSCCpvw8BKsgs0EhzsAVwnoM-gzGzoHsz"
let kLCAppKey = "GOTGo06DMTXgjK7o1YhhYJCH"
let kLCServerURL = "https://xsccpvw8.lc-cn-n1-shared.com"
//User table
let kNickNameCol = "nickName"
let kAvatarCol = "avatar"
let kGenderCol = "gender"
let kIntroCol = "intro"


let test = ""
let testagain = ""
