// %%raw(`import { getRedirectUrl } from 'expo-auth-session';`)

let useProxy: AuthSession.useProxy = {
  switch Constants.platform {
  | IOS => true
  | Android => true
  | Web => false
  }
}
// let redirectUri:string = getRedirectUri
open AuthSession
let redirectUri:string = getRedirectUri
Js.log2("getRedirectUri: ",redirectUri)
let auth0ClientId = "GDuiq4x1reJXs8a6yDXgqJcNAc8QBOjX"
let authorizationEndpoint = "https://klik.eu.auth0.com/authorize"
export scopes = Some([Scopes.openId, Scopes.profile])
export responseType = Some(ResponseType.idToken)
export extraParams = Some({
  // ideally, this will be a random value
  nonce: "nonce",
})
export authRequestConfig: authRequestConfig = {
  redirectUri,
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
