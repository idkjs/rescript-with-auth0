open ReactNative
let styles = {
  open Style
  StyleSheet.create({
    "container": style(
      ~flex=1.,
      ~backgroundColor="#fff",
      ~alignItems=#center,
      ~justifyContent=#center,
      (),
    ),
    "title": style(~fontSize=20., ~textAlign=#center, ~marginTop=40.->dp, ()),
  })
}
@react.component
let make = () => {
  let (name, setName) = React.useState(_ => None)
  //   let (_promptAsync, setPromptTrue) = React.useState(_ => false)
  let (loading, setLoading) = React.useState(_ => true)
  let authorizationEndpoint = "https://klik.eu.auth0.com/authorize"
  let useProxy: bool = {
    switch Constants.platform {
    | IOS => true
    | Android => true
    | Web => false
    }
  }
  let auth0ClientId = "GDuiq4x1reJXs8a6yDXgqJcNAc8QBOjX"

  //   open AuthSession
  let redirectUri: string = AuthSession.getRedirectUri

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

  //   let {request, result, promptAsync} = AuthSession.useAuthRequest({
  //   let authRequest = AuthSession.useAuthRequest({
  //     request: authRequestConfig,
  //     authorizationEndpoint: authorizationEndpoint,
  //   })
  //   let authRequest = AuthSession.useAuthRequest({
  //     request: authRequestConfig,
  //     authorizationEndpoint: authorizationEndpoint,
  //   })
  //   let (request, result, promptAsync) = AuthSession.useAuthRequest({
  //     request: authRequestConfig,
  //     authorizationEndpoint: authorizationEndpoint,
  //   })
  let authRequest = AuthSession.useAuthRequest({
    request: authRequestConfig,
    authorizationEndpoint: authorizationEndpoint,
  })

  //   let {request, result, promptAsync} = authRequest
  //   let request = authRequest["request"]
  //   let result = authRequest["result"]
  //   let handePromptAsync = () => {
  //     promptAsync(useProxy) |> Js.Promise.then_(result => {
  //         switch (result) {
  //         | None =>{
  //           setValue(_ => None)
  //           Js.Promise.resolve()}
  //         | Some(newValue) =>{
  //           setValue(_ => newValue)
  //            Js.Promise.resolve()
  //            }
  //         }
  //     //   Js.log(result)->ignore
  //     //   Js.Promise.resolve()
  //    } )->ignore
  //   }
  //   let handePromptAsync2 = () => {
  //     Js.log("handePromptAsync: ")
  //     authRequest.promptAsync(.
  //       ~options=promptAsyncOptions(. ~options=authRequestPromptOptions(~useProxy, ()), ()),
  //       (),
  //     )
  //     |> Js.Promise.then_(result => Js.log(result) |> Js.Promise.resolve)
  //     |> ignore
  //   }
  Js.log("Redirect URL: " ++ redirectUri)
  let (_, _, promptAsync) = authRequest
  let (request, _, _) = authRequest
//   let (_, result, _) = authRequest
  React.useEffect1(() => {
    loading
      ? {
          Js.log2("LOADING_TRUE: ", loading)
          Js.log2("state_name: ", name)
          Js.log2("authRequest: ", authRequest)
          let (request, _, _) = authRequest
          let (_, result, _) = authRequest
          let (_, _, promptAsync) = authRequest
          Js.log2("authRequest.request: ", request)
          Js.log2("authRequest.result: ", result)
          Js.log2("authRequest.promptAsync: ", promptAsync)
        }
      : {
          Js.log2("LOADING_FALSE: ", loading)
          Js.log2("state_name: ", name)
          Js.log2("authRequest: ", authRequest)
          let (request, _, _) = authRequest
          let (_, result, _) = authRequest
          let (_, _, promptAsync) = authRequest
          Js.log2("authRequest.request: ", request)
          Js.log2("authRequest.result: ", result)
          Js.log2("authRequest.promptAsync: ", promptAsync)
        }

    // Js.log2("_promptAsync: ", _promptAsync)
    // if _promptAsync {
    // //   handePromptAsync2()->ignore
    //   Js.log2("_promptAsync: ", _promptAsync)
    // }

    // switch result {
    // | Some(result) =>
    // switch result {
    // | Some(error) => {
    //     Js.log("result.error: " ++ result.error)
    //     Alert.alert(~title="Authentication error", ~message="something went wrong")
    //   }
    // | None =>
    //   if result.type_ == success {
    //     // Retrieve the JWT token and decode it
    //     let jwtToken = result.params.id_token
    //     Js.log("jwtToken: " ++ jwtToken)
    //     let decoded = JwtDecode.jwtDecode(jwtToken)
    //     Js.log("jwtToken_decoded: " ++ decoded)
    //     let {name} = decoded
    //     Js.log("name_decoded: " ++ name)
    //     setName(name)
    //   }

    // | None => ()
    // }
    None
  }, [loading])

  let request = request->Belt.Option.isSome
//   let handleSuggestion = suggestion =>
//   getDetails(suggestion)->Promise.Js.get(d => {
//     Js.log(d)
//     onSelect(d)
//   })

  <View style={styles["container"]}>
    {switch name {
    | Some(name) => <>
        <Text style={styles["title"]}>
          {("You are logged in, " ++ name ++ "!")->React.string}
        </Text>
        <Button title="Log out" onPress={_ => setName(_ => None)} />
      </>
    | None => React.null
    }}
    <Button
      disabled={!request}
      title="Log in with Auth0"
      onPress={_e => {
        // open AuthSession
        Js.log("handePromptAsync: ")
        let options = AuthSession.promptAsyncOptions(
          ~options=AuthSession.promptOptions(~useProxy, ()),
          (),
        )
        promptAsync(. ~options, ())->Js.Promise.then_(result => {
          Js.log(result)
          setLoading(_=>false)
          Js.Promise.resolve(result)
        },_)
        // promptAsync(. ~options, ())->Promise.Js.get(result => {
        //   Js.log(result)
        //   setLoading(_=>false)
        // //   Js.Promise.resolve(result)
        // })
        |> ignore
      }}
    />
  </View>
}

let default = make
