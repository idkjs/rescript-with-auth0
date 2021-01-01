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
    "button": style(
      ~backgroundColor="#fb7c85",
      ~padding=10.->dp,
      ~width=200.->pct,
      ~color="white",
      ~borderRadius=10.,
      ~fontSize=20.,
      ~textAlign=#center,
      ~marginTop=40.->dp,
      (),
    ),
  })
}
// module Payload = {
//   type t = {auth0: string}

//   let decode = (json: Js.Json.t): Js.Promise.t<t> =>
//     Js.Promise.make((~resolve, ~reject) =>
//       switch {
//         open Json.Decode
//         {auth0: json |> field("github_token", string)}
//       } {
//       | payload => resolve(. payload)
//       | exception e => reject(. e)
//       }
//     )
// }
type response = {
  _type: [#error | #success],
  error_description: option<string>,
  id_token: string,
}
let auth0ClientId = "GDuiq4x1reJXs8a6yDXgqJcNAc8QBOjX"
let auth0Domain = "https://klik.eu.auth0.com/authorize"
//   //   open AuthSession
let redirectUri: string = AuthSession.getRedirectUrl()
// type queryParams
type queryParams = {
  @bs.as("response_type")
  responseType: option<AuthSession.ResponseType.t>,
  clientId: string,
  redirectUri: string,
  scopes: option<array<AuthSession.Scopes.t>>,
  //   clientSecret: option<string>,
  //   codeChallengeMethod: option<CodeChallengeMethod.t>,
  //   codeChallenge: Js.Nullable.t<string>,
  //   prompt: option<Prompt.t>,
  //   state: option<string>,
  nonce: string,
  //   usePKCE: option<bool>,
}

let stringifyParams = (search: queryParams) => {
  open BsQueryString.Stringify
  toQs([
    ("responseType", optional(search.responseType, string)),
    ("clientId", item(search.clientId, string)),
    ("redirectUri", item(search.redirectUri, string)),
    ("scopes", optional(search.scopes, array)),
    ("nonce", item(search.nonce, string)),
  ])
}
@bs.obj
external queryParams: (
  ~client_id: string=?,
  ~redirect_uri: string=?,
  ~response_type: string=?,
  ~scope: string=?,
  ~nonce: string=?,
  unit,
) => queryParams = ""
// type state = {name:string}
@react.component
let make = () => {
  let (name, setState) = React.useState(() => None)
  let handleResponse: response => Js.Promise.t<unit> = response => {
    switch response._type {
    | #error =>{
      Alert.alert(
        ~title="Authentication error",
        ~message=response.error_description->Belt.Option.getWithDefault("something went wrong"),
        (),

      )
      Js.Promise.resolve()}
   | #success =>
      let jwtToken = response.id_token |> Auth0Tokens.make
      Js.log2("Authentication response", jwtToken)
      let name = jwtToken
      Js.log2("Name", name)
      setState(_ => name->Obj.magic)
      Js.Promise.resolve()
    //   JwtDecode.jwtDecode(jwtToken) |> Js.Promise.then_(decoded => {
    //     Js.log2("Authentication response", decoded)
    //     let name = jwtToken
    //     Js.log2("Name", name)
    //     setState(_ => name) |> Js.Promise.resolve|>ignore
    //   })
    }
  }
  let login: unit => Js.Promise.t<unit> = () => {
    let redirectUrl = AuthSession.getRedirectUrl()
    Js.log(`Redirect URL: ${redirectUrl}`)

    // let queryParams = {
    //   "client_id": auth0ClientId,
    //   "redirect_uri": redirectUrl,
    //   "response_type": Some(AuthSession.ResponseType.idToken),
    //   // retrieve the user's profile
    //   "scope": Some([AuthSession.Scopes.openId, AuthSession.Scopes.profile]),
    //   "nonce": "nonce",
    // }
    let queryParams = queryParams(
      ~client_id=auth0ClientId,
      ~redirect_uri=redirectUrl,
      ~response_type=AuthSession.ResponseType.idToken,
      // retrieve the user's profile
      ~scope="openid profile",
      ~nonce="nonce",
      (),
    )
    let authUrl = auth0Domain ++ "/" ++ "authorize" ++ queryParams->stringifyParams

    AuthSession.startAsync(AuthSession.options(~authUrl, ())) |> Js.Promise.then_(response => {
      Js.log2("Authentication response", response)
      handleResponse(response)|>ignore
     Js.Promise.resolve()
      //   response |> handleResponse(response)|>Js.Promise.resolve
      //   Js.Promise.resolve|>ignore
      //   response |> handleResponse |> ignore;
      //   Js.Promise.resolve(response |> handleResponse)->ignore
    })
  }
  <View style={styles["container"]}>
    {switch name {
    | Some(name) =>
      <Text style={styles["title"]}> {("You are logged in, " ++ name ++ " !")->React.string} </Text>
    | None =>
      <TouchableOpacity onPress={_ => login()->ignore}>
        <Text style={styles["button"]}> {"Login"->React.string} </Text>
      </TouchableOpacity>
    }}
  </View>
}
