// Copyright 2016 The Tulsi Authors. All rights reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import Cocoa
import TulsiGenerator

/// Defines an object that holds an array of UIMessages.
protocol MessageLogProtocol: class {
  var messages: [UIMessage] { get }
}


/// Models a single user-facing message.
final class UIMessage: NSObject, NSPasteboardWriting {
  dynamic let text: String
  dynamic let messagePriority: TulsiGenerator.LogMessagePriority
  let timestamp = Date()

  init(text: String, type: TulsiGenerator.LogMessagePriority) {
    self.text = text
    self.messagePriority = type
  }

  // MARK: - NSPasteboardWriting

  func writableTypes(for pasteboard: NSPasteboard) -> [String] {
    return [NSPasteboardTypeString]
  }

  func pasteboardPropertyList(forType type: String) -> Any? {
    if type == NSPasteboardTypeString {
      let timeString = DateFormatter.localizedString(from: timestamp,
                                                               dateStyle: .none,
                                                               timeStyle: .medium)
      return "[\(timeString)](\(messagePriority.rawValue)): \(text)"
    }
    return nil
  }
}
