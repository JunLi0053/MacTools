//
//  MTJsonVC.swift
//  MacTools
//
//  Created by Jun on 2020/4/4.
//  Copyright © 2020 Jun. All rights reserved.
//

import Cocoa
import Highlightr

let iOS_String_Property = "@property (nonatomic, copy) NSString *"
let iOS_Array_Property = "@property (nonatomic, copy) NSArray *"
let iOS_Number_Property = "@property (nonatomic, strong) NSNumber *"
let iOS_Class_Interface = "@interface %@ : NSObject"
let iOS_Class_End = "@end"
let iOS_Class_Name = "Name"

class MTJsonVC: NSViewController, NSTextViewDelegate {
    
    @IBOutlet var jsonTextView: NSTextView!
    @IBOutlet var classTextView: NSTextView!
    @IBOutlet weak var handleButton: NSButton!
    var highlightr:Highlightr!
    var jsonDict:[String:Any] = [:]
    var classStr = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        highlightr = Highlightr()
        highlightr.setTheme(to: "solarized-dark")
        handleButton.target = self
        handleButton.action = #selector(jsonToClass)
        jsonTextView.delegate = self
        jsonTextView.isAutomaticQuoteSubstitutionEnabled = false; //禁用引号的智能替换功能
        jsonTextView.textStorage?.font = NSFont.systemFont(ofSize: 20)
    }
    
    @objc func jsonToClass() {
        classStr = ""
        let jsonData:Data = jsonTextView.string.data(using: .utf8)!
        
        do {
            jsonDict = try JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers) as! Dictionary<String, Any>
            handle(className: iOS_Class_Name, dict: jsonDict)
            
            let highlightedCode = highlightr!.highlight(classStr, as: "ObjectiveC")
            classTextView.textStorage?.setAttributedString(highlightedCode!)
            beautifyJson()
        } catch {
            print("Error")
            classTextView.string = "json异常！"
        }
    }
    
    func handle(className:String, dict:Dictionary<String, Any>) {
        var mTmpDict:[String:Any] = [:]
        var classStrArray = [String.init(format: iOS_Class_Interface, className).capitalized]
        for (key,value) in dict {
            var type = ""
            if value is String {
                type = iOS_String_Property
            }
            else if value is Dictionary<String, Any> {
                type = "@property (nonatomic, strong) \(key.capitalized) *"
                mTmpDict.updateValue(value, forKey: key);
            }
            else if value is Array<Any> {
                type = iOS_Array_Property
            }
            else {
                type = iOS_Number_Property
            }
            classStrArray.append(type+key+";")
        }
        classStrArray.append(iOS_Class_End)
        classStr += classStrArray.joined(separator: "\n") + "\n\n"
        for (key,value) in mTmpDict {
            handle(className: key, dict: value as! Dictionary<String, Any>)
        }
    }
    
    func beautifyJson() {
        let showJsonString = highlightr!.highlight(jsonDict.showJsonString, as: "json")
        jsonTextView.textStorage?.setAttributedString(showJsonString!)
    }
}
