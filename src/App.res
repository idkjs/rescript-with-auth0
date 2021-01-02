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
type state =
  | LoadingDogs
  | ErrorFetchingDogs
  | LoadedDogs(array<string>)

type authenticationState =
  | Success
  | NotAuthorized
  | NotAvailable
  | InBackground(Js.Date.t)

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
  let appState = Hooks.useAppState()
  let authenticationOptions = AuthSession.options(
    ~authUrl=authorizationEndpoint,
    ~returnUrl=AuthSession.getRedirectUrl(),
    (),
  )
  let (authState, setAuthenticated) = React.useState(() => NotAuthorized)

  //   let authenticate = _ => {
  //       open Js
  //     AuthSession.startAsync(authenticationOptions)
  //     |> Promise.then_(authResult =>
  //          setAuthenticated(_ =>
  //            AuthSession.paramsGet(authResult)
  //              ? Success : NotAuthorized
  //          )
  //          |> Promise.resolve
  //        )
  //     |> Promise.catch(_ =>
  //          setAuthenticated(_ => NotAvailable) |> Promise.resolve
  //        )
  //     |> ignore;
  //   };
  let auth0Client = AuthSession.startAsync(authenticationOptions)
  // Notice that instead of `useEffect`, we have `useEffect0`. See
  // reasonml.github.io/reason-react/docs/en/components#hooks for more info
  //   React.useEffect1(() => {
  //     let handler = () => setAuth0(_ => Some(auth0FromHook))
  //     Hooks.AppState.addEventListener(#change, handler)
  //     setAuth0(_ => Some(auth0FromHook))
  //     Some(() => Hooks.AppState.removeEventListener("load", handler))
  //   }, [auth0FromHook])

  React.useEffect1(() => {
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
