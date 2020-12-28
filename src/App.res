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
  let (value, setValue) = React.useState(_ => None)
  let authorizationEndpoint = "https://klik.eu.auth0.com/authorize"
  let useProxy: AuthSession.useProxy = {
    switch Constants.platform {
    | IOS => {"useProxy": true}
    | Android => {"useProxy": true}
    | Web => {"useProxy": false}
    }
  }
  let auth0ClientId = "GDuiq4x1reJXs8a6yDXgqJcNAc8QBOjX"

  open AuthSession
  let redirectUri: string = getRedirectUri

  let authRequestConfig: authRequestConfig = {
    redirectUri: redirectUri,
    clientId: auth0ClientId,
    // id_token will return a JWT token
    responseType: Some(ResponseType.idToken),
    // retrieve the user's profile
    scopes: Some([Scopes.openId, Scopes.profile]),
    extraParams: Some({
      // ideally, this will be a random value
      nonce: "nonce",
    }),
  }

  let {request, result, promptAsync} = AuthSession.useAuthRequest({
    request: authRequestConfig,
    authorizationEndpoint: authorizationEndpoint,
  })
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
  let handePromptAsync2 = () => {
    Js.log("handePromptAsync: ")
    promptAsync({useProxy})
    |> Js.Promise.then_(result => Js.log(result) |> Js.Promise.resolve)
    |> ignore
  }
  Js.log("Redirect URL: " ++ redirectUri)

  React.useEffect1(() => {
    Js.log2("state_name: ", name)
    Js.log2("result: ", result)

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
  }, [result])

  //   return (
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
      disabled={switch request {
      | Some(_request) => true
      | None => false
      }}
      title="Log in with Auth0"
      onPress={_e => handePromptAsync2()->ignore}
    />
  </View>
}

let default = make
