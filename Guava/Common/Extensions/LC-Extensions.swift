//
//  LC-Extensions.swift
//  Guava
//
//  Created by Savage on 16/9/21.
//

import LeanCloud

extension LCFile{
    
    func save(to table: LCObject, as record: String, group: DispatchGroup? = nil){
        group?.enter()
        self.save { result in
            switch result {
            case .success:
                if let _ = self.url?.value {
//                    print("文件保存完成。URL: \(value)")
                    do {
                        try table.set(record, value: self)
                        group?.enter()
                        table.save { (result) in
                            switch result {
                            case .success:
//                                print("file has been associated.")
                                break
                            case .failure(error: let error):
                                print("fail to save table: \(error)")
                            }
                            group?.leave()
                            
                        }
                        
                    } catch {
                        print("fail to asign value \(error)")
                    }
                }
            case .failure(error: let error):
                // 保存失败，可能是文件无法被读取，或者上传过程中出现问题
                print("fail to sava file in cloud: \(error)")
            }
            
            group?.leave()
        }
    }
}
