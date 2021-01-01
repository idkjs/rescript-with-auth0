// open ReactNative
// let styles = {
//   open Style
//   StyleSheet.create({
//     "container": style(
//       ~flex=1.,
//       ~backgroundColor="#fff",
//       ~alignItems=#center,
//       ~justifyContent=#center,
//       (),
//     ),
//     "title": style(~fontSize=20., ~textAlign=#center, ~marginTop=40.->dp, ()),
//   })
// }

// type request
// type response
// @bs.new external makeXMLHttpRequest: unit => request = "XMLHttpRequest"
// @bs.send
// external addEventListener: (request, string, unit => unit) => unit = "addEventListener"
// @bs.get external response: request => response = "response"
// @bs.send external open_: (request, string, string) => unit = "open"
// @bs.send external send: request => unit = "send"
// @bs.send external abort: request => unit = "abort"

// @bs.scope("JSON") @bs.val
// // external parseResponse: response => {"message": AuthSession.authSessionResult} = "parse"
// external parseResponse: response => {"message": array<string>} = "parse"
// type state =
//   | LoadingAuthRequest
//   | ErrorFetching
//   | LoadedAuthRequest(AuthSession.authSessionResult)
// @react.component
// let make = () => {
//   let (name, setName) = React.useState(_ => None)
//   let (state, setState) = React.useState(() => LoadingAuthRequest)

//   //   let (_promptAsync, setPromptTrue) = React.useState(_ => false)
//   let (loading, setLoading) = React.useState(_ => true)
//   let authorizationEndpoint = "https://klik.eu.auth0.com/authorize"
//   let useProxy: bool = {
//     switch Constants.platform {
//     | IOS => true
//     | Android => true
//     | Web => false
//     }
//   }
let auth0ClientId = "GDuiq4x1reJXs8a6yDXgqJcNAc8QBOjX"

//   //   open AuthSession
let redirectUri: string = AuthSession.getRedirectUrl()

let authRequestConfig: AuthSession.authRequestConfig = {
  redirectUri: redirectUri,
  clientId: auth0ClientId,
  // id_token will return a JWT token
  responseType: Some(AuthSession.ResponseType.idToken),
  // retrieve the user's profile
  scopes: Some([AuthSession.Scopes.openId, AuthSession.Scopes.profile]),
  extraParams: Some({
    // ideally, this will be a random value
    nonce: "nonce",
  }),
}

//   //   let {request, result, promptAsync} = AuthSession.useAuthRequest({
//   //   let authRequest = AuthSession.useAuthRequest({
//   //     request: authRequestConfig,
//   //     authorizationEndpoint: authorizationEndpoint,
//   //   })
//   //   let authRequest = AuthSession.useAuthRequest({
//   //     request: authRequestConfig,
//   //     authorizationEndpoint: authorizationEndpoint,
//   //   })
//   //   let (request, result, promptAsync) = AuthSession.useAuthRequest({
//   //     request: authRequestConfig,
//   //     authorizationEndpoint: authorizationEndpoint,
//   //   })
//   let authRequest = AuthSession.useAuthRequest({
//     request: authRequestConfig,
//     authorizationEndpoint: authorizationEndpoint,
//   })

//   //   let {request, result, promptAsync} = authRequest
//   //   let request = authRequest["request"]
//   //   let result = authRequest["result"]
//   //   let handePromptAsync = () => {
//   //     promptAsync(useProxy) |> Js.Promise.then_(result => {
//   //         switch (result) {
//   //         | None =>{
//   //           setValue(_ => None)
//   //           Js.Promise.resolve()}
//   //         | Some(newValue) =>{
//   //           setValue(_ => newValue)
//   //            Js.Promise.resolve()
//   //            }
//   //         }
//   //     //   Js.log(result)->ignore
//   //     //   Js.Promise.resolve()
//   //    } )->ignore
//   //   }
//   //   let handePromptAsync2 = () => {
//   //     Js.log("handePromptAsync: ")
//   //     authRequest.promptAsync(.
//   //       ~options=promptAsyncOptions(. ~options=authRequestPromptOptions(~useProxy, ()), ()),
//   //       (),
//   //     )
//   //     |> Js.Promise.then_(result => Js.log(result) |> Js.Promise.resolve)
//   //     |> ignore
//   //   }
//   Js.log("Redirect URL: " ++ redirectUri)
//   let (_, _, promptAsync) = authRequest
// //   let (request, _, _) = authRequest
//   //   let (_, result, _) = authRequest
//   React.useEffect0(() => {
//     let request = makeXMLHttpRequest()
//     request->addEventListener("load", () =>
//       setState(_previousState => LoadedAuthRequest((request->response->parseResponse)["message"]))
//     )
//     request->addEventListener("error", () => setState(_previousState => ErrorFetching))
//     request->open_("GET", authorizationEndpoint)
//     request->send

//     // the return value is called by React's useEffect when the component unmounts
//     Some(() => request->abort)
//   })
//   //   React.useEffect1(() => {
//   //     loading
//   //       ? {
//   //           Js.log2("LOADING_TRUE: ", loading)
//   //           Js.log2("state_name: ", name)
//   //           Js.log2("authRequest: ", authRequest)
//   //           let (request, _, _) = authRequest
//   //           let (_, result, _) = authRequest
//   //           let (_, _, promptAsync) = authRequest
//   //           Js.log2("authRequest.request: ", request)
//   //           Js.log2("authRequest.result: ", result)
//   //           Js.log2("authRequest.promptAsync: ", promptAsync)
//   //         }
//   //       : {
//   //           Js.log2("LOADING_FALSE: ", loading)
//   //           Js.log2("state_name: ", name)
//   //           Js.log2("authRequest: ", authRequest)
//   //           let (request, _, _) = authRequest
//   //           let (_, result, _) = authRequest
//   //           let (_, _, promptAsync) = authRequest
//   //           Js.log2("authRequest.request: ", request)
//   //           Js.log2("authRequest.result: ", result)
//   //           Js.log2("authRequest.promptAsync: ", promptAsync)
//   //         }

//   //     // Js.log2("_promptAsync: ", _promptAsync)
//   //     // if _promptAsync {
//   //     // //   handePromptAsync2()->ignore
//   //     //   Js.log2("_promptAsync: ", _promptAsync)
//   //     // }

//   //     // switch result {
//   //     // | Some(result) =>
//   //     // switch result {
//   //     // | Some(error) => {
//   //     //     Js.log("result.error: " ++ result.error)
//   //     //     Alert.alert(~title="Authentication error", ~message="something went wrong")
//   //     //   }
//   //     // | None =>
//   //     //   if result.type_ == success {
//   //     //     // Retrieve the JWT token and decode it
//   //     //     let jwtToken = result.params.id_token
//   //     //     Js.log("jwtToken: " ++ jwtToken)
//   //     //     let decoded = JwtDecode.jwtDecode(jwtToken)
//   //     //     Js.log("jwtToken_decoded: " ++ decoded)
//   //     //     let {name} = decoded
//   //     //     Js.log("name_decoded: " ++ name)
//   //     //     setName(name)
//   //     //   }

//   //     // | None => ()
//   //     // }
//   //     None
//   //   }, [loading])

//   //   let handleSuggestion = suggestion =>
//   //   getDetails(suggestion)->Promise.Js.get(d => {
//   //     Js.log(d)
//   //     onSelect(d)
//   //   })
//   switch state {
//   | ErrorFetching => <Text style={styles["title"]}> {"An error occurred!"->React.string} </Text>
//   | LoadingAuthRequest => <Text style={styles["title"]}> {"Loading..."->React.string} </Text>
//   | LoadedAuthRequest(authRequest) => {
//       Js.log2("authRequest", authRequest)
//       <View style={styles["container"]}>
//         {switch name {
//         | Some(name) => <>
//             <Text style={styles["title"]}>
//               {("You are logged in, " ++ name ++ "!")->React.string}
//             </Text>
//             <Button title="Log out" onPress={_ => setName(_ => None)} />
//           </>
//         | None => React.null
//         }}
//         <Button
//         // disabled={!request}
//           title="Log in with Auth0"
//           onPress={_e => {
//             // open AuthSession
//             Js.log("handePromptAsync: ")
//             let options = AuthSession.promptAsyncOptions(
//               ~options=AuthSession.promptOptions(~useProxy, ()),
//               (),
//             )
//             promptAsync(. ~options, ())->Js.Promise.then_(result => {
//               Js.log(result)
//               setLoading(_ => false)
//               Js.Promise.resolve(result)
//             }, _)
//               |> // promptAsync(. ~options, ())->Promise.Js.get(result => {
//               //   Js.log(result)
//               //   setLoading(_=>false)
//               // //   Js.Promise.resolve(result)
//               // })
//               ignore
//           }}
//         />
//       </View>
//     }
//   }
// }

// let default = make
open ReactNative
module ImageBackgroundFromUri = {
  @react.component
  let make = (~uri, ~resizeMode=?, ~style=?, ~children, ()) => {
    // let uri = Image.uriSource(~uri)
    <ImageBackground
      ?resizeMode ?style source={Image.Source.fromUriSource(Image.uriSource(~uri, ()))}>
      children
    </ImageBackground>
  }
}
let styles = {
  open Style
  StyleSheet.create({
    "container": style(
      ~flex=1.,
      ~backgroundColor="#fff",
      ~alignItems=#center,
      ~justifyContent=#center,
      ~height=120.->dp,
      (),
    ),
    "title": style(~fontSize=20., ~textAlign=#center, ~marginTop=40.->dp, ()),
  })
}
let imageStyle = (i, dogs) => {
  open Style
  StyleSheet.create({
    "imageStyle": style(
      ~height=120.->dp,
      ~width=100.->pct,
      ~marginRight=i === Js.Array.length(dogs) - 1 ? 0.->dp : 8.->dp,
      ~borderRadius=8.,
      //   ~boxShadow="0px 4px 16px rgb(200, 200, 200)",
      //   ~resizeMode=#cover,
      // ~imageBackground=j`url($dog)`,
      // ~backgroundPosition=#center,
      (),
    ),
  })
}

type request
type response
@bs.new external makeXMLHttpRequest: unit => request = "XMLHttpRequest"
// @bs.send
// external addEventListener: (request, string, unit => unit) => unit = "addEventListener"
@bs.get external response: request => response = "response"
@bs.send external open_: (request, string, string) => unit = "open"
@bs.send external send: request => unit = "send"
@bs.send external abort: request => unit = "abort"

@bs.scope("JSON") @bs.val
external parseResponse: response => {"message": array<string>} = "parse"
@bs.val
external addEventListener: (string, unit => unit) => unit = "addEventListener"
@bs.val
external removeEventListener: (string, unit => unit) => unit = "removeEventListener"
module AppState = {
  type t = string

  @bs.inline
  let active = "active"

  @bs.inline
  let background = "background"

  @bs.inline
  let inactive = "inactive"

  @bs.scope("AppState") @bs.module("react-native")
  external currentState: t = "currentState"

  @bs.scope("AppState") @bs.module("react-native")
  external addEventListener: @bs.string
  [
    | #change(t => unit)
    | #focus(unit => unit)
    | #blur(unit => unit)
    | #memoryWarning(unit => unit)
  ] => unit = "addEventListener"

  @bs.scope("AppState") @bs.module("react-native")
  external removeEventListener: @bs.string
  [
    | #change(t => unit)
    | #focus(unit => unit)
    | #blur(unit => unit)
    | #memoryWarning(unit => unit)
  ] => unit = "removeEventListener"
}
type state =
  | LoadingDogs
  | ErrorFetchingDogs
  | LoadedDogs(array<string>)
export useAppState = () => {
  let (state, setState) = React.useState(() => AppState.active)
  React.useEffect0(() => {
    let handler = #change(state => setState(_ => state))
    AppState.addEventListener(handler)

    Some(() => AppState.removeEventListener(handler))
  })
  state
}
@react.component
let make = () => {
  let (state, setState) = React.useState(() => LoadingDogs)
  let (isAuthenticated, setIsAuthenticated) = React.useState(_ => false)
  let (user, setUser) = React.useState(_ => None)
  let (auth0Client, setAuth0) = React.useState(_ => None)
  let (loading, setLoading) = React.useState(_ => true)
  let (popupOpen, setPopupOpen) = React.useState(_ => false)
  let (idToken, setIdToken) = React.useState(_ => "")
  let authorizationEndpoint = "https://klik.eu.auth0.com/authorize"
  let options = AuthSession.options(
    ~authUrl=authorizationEndpoint,
    ~returnUrl=AuthSession.getRedirectUrl(),
    (),
  )
  let auth0FromHook = AuthSession.useAuthRequest(options)
  // Notice that instead of `useEffect`, we have `useEffect0`. See
  // reasonml.github.io/reason-react/docs/en/components#hooks for more info
  React.useEffect1(() => {
    let handler = () => setAuth0(_ => Some(auth0FromHook))
    addEventListener("load", handler)
    setAuth0(_ => Some(auth0FromHook))
    Some(() => removeEventListener("load", handler))
  }, [auth0FromHook])

  React.useEffect1(() => {
    // ReasonReactRouter.addEventListener(location,"load",)
    // let auth0FromHook = Auth0SpaClient.createAuth0Client(options);
    // // Js.Promise.resolve();
    // setAuth0(_ => Some(auth0FromHook));
    // Js.Promise.resolve();
    switch auth0Client {
    | Some(auth0Client) =>
      // let checkAuthenticated = auth0Client.isAuthenticated();
      Js.log2("auth0Client:", auth0Client) |> ignore
      setIsAuthenticated(_ => false)
    | None => ()
    }
    None
  }, [auth0Client])
  //   React.useEffect0(() => {
  //     let request = makeXMLHttpRequest()
  //     // request->addEventListener("load", () =>
  //     //   setState(_previousState => LoadedDogs((request->response->parseResponse)["message"]))
  //     // )
  //     request->addEventListener("load", () => {
  //       Js.log2("(request->response->parseResponse))", (request->response->parseResponse)["message"])
  //       setState(_previousState => LoadedDogs((request->response->parseResponse)["message"]))
  //     })
  //     request->addEventListener("error", () => setState(_previousState => ErrorFetchingDogs))
  //     request->open_("GET", authorizationEndpoint)
  //     request->send

  //     // the return value is called by React's useEffect when the component unmounts
  //     Some(() => request->abort)
  //   })

  <View style={styles["container"]}>
    {switch state {
    | ErrorFetchingDogs =>
      <Text style={styles["title"]}> {"An error occurred!"->React.string} </Text>
    | LoadingDogs => <Text style={styles["title"]}> {"Loading..."->React.string} </Text>
    | LoadedDogs(dogs) =>
      dogs
      ->Belt.Array.mapWithIndex((i, dog) => {
        <ImageBackgroundFromUri
          uri=j`url($dog)` resizeMode=#cover style={imageStyle(i, dogs)["imageStyle"]}>
          <Text style={styles["title"]}> {"Inside"->React.string} </Text>
        </ImageBackgroundFromUri>
      })
      ->React.array
    }}
  </View>
}

let default = make
