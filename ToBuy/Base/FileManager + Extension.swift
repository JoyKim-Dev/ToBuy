//
//  FileManager + Extension.swift
//  ToBuy
//
//  Created by Joy Kim on 7/7/24.
//

import UIKit

extension UIViewController {
    
    func saveImageToDocument(image: UIImage, filename: String) {
          
        // 이미지 저장할 위치 파악.
          guard let documentDirectory = FileManager.default.urls(
              for: .documentDirectory,
              in: .userDomainMask).first else { return }
          
          //이미지를 저장할 경로(파일명) 지정 . 링크값 만들기
          let fileURL = documentDirectory.appendingPathComponent("\(filename).jpg")
          
          //이미지 압축  url 이미지로 받아와서 jpg 형태로 변환 & 압축 (png 옵션도 있음) .
          guard let data = image.jpegData(compressionQuality: 0.5) else { return }
          
          //이미지 파일 저장 .
          do {
              try data.write(to: fileURL)
          } catch {
              print("file save error", error)
          }
      }
    
    func loadImageToDocument(filename: String) -> UIImage? {
           
          guard let documentDirectory = FileManager.default.urls(
              for: .documentDirectory,
              in: .userDomainMask).first else { return nil }
           
        // 파일 이름 활용해서 링크 생성
          let fileURL = documentDirectory.appendingPathComponent("\(filename).jpg")
          
          //이 경로에 실제로 파일이 존재하는 지 확인
          if FileManager.default.fileExists(atPath: fileURL.path()) {
              return UIImage(contentsOfFile: fileURL.path())
          } else {
              return UIImage(systemName: "star.fill")
          }
          
      }
    
    // document에 저장된 사진 파일 삭제처리. 이걸 하지 않으면 앱 내에서 사진 삭제해도 앱 삭제 전까지는 용량 그대로 차지하게 됨.
    func removeImageFromDocument(filename: String) {
        
        // document 위치 조회
          guard let documentDirectory = FileManager.default.urls(
              for: .documentDirectory,
              in: .userDomainMask).first else { return }

          let fileURL = documentDirectory.appendingPathComponent("\(filename).jpg")
          
          if FileManager.default.fileExists(atPath: fileURL.path()) {
              // 삭제 완료 될때까지 다른 동작이 일어나지 않도록 doCatch구문으로 감쌌음.
              
              do {
                  try FileManager.default.removeItem(atPath: fileURL.path())
              } catch {
                  print("file remove error", error)
              }
              
          } else {
              print("file no exist")
          }
          
      }
}
