
type platform =
  | IOS
  | Android
  | Web


let platform = if ReactNative.Platform.os == ReactNative.Platform.ios {
  IOS
} else if ReactNative.Platform.os == ReactNative.Platform.web {
  Web
} else {
  Android
}

