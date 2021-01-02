type key = [#response_type | #client_id | #scopes | #redirect_uri]

let encodeValue =Js.Global.encodeURIComponent
let encodeResponseType =(responseType:ResponseType.ResponseType.t)=>encodeValue(responseType :> string)
@bs.val external encodeKey: key => string = "encodeURIComponent"

let auth0ClientId = "GDuiq4x1reJXs8a6yDXgqJcNAc8QBOjX"
let auth0Domain = "https://klik.eu.auth0.com/authorize"
let redirectUrl = AuthSession.getRedirectUrl()
let goToUrl: string => unit = %bs.raw(` function (url) {
        window.location.href = url;
    } `)

let url =
  auth0Domain ++
  "?" ++
  ("response_type=" ++
  (encodeValue(ResponseType.idToken) ++
  "&" ++
  ("client_id=" ++
  (encodeValue(auth0ClientId) ++
  "&" ++
  ("scope=" ++
  (encodeValue(Scopes.make([Scopes.openId, Scopes.profile])) ++
  "&" ++
  ("redirect_uri=" ++
  encodeValue(redirectUrl) ++
  "&nonce=nonce")))))))

let authenticate = () => {
  goToUrl(url)
}
module type Url = {
  type param
  let add: (key, string) => array<param>
  let buildUrl: (string, array<param>) => string
}

module Url = {
  type param = (key, string)

  let add = (key: key, value, params: array<param>) => Belt.Array.concat(params, [(key, value)])

  let encodeParam = ((key: key, value)) => encodeKey(key) ++ ("=" ++ encodeValue(value))

  let buildUrl = (path, params: array<param>) => {
    let params = params->Belt.Array.map(encodeParam) |> Js.Array.joinWith("&")

    switch params {
    | "" => path
    | _ => j`$path?$params`
    }
  }
}
// type keys = [#response_type | #client_id | #scopes | #redirect_uri]
let config = Url.buildUrl(
  auth0Domain,
  [
    (#response_type, ResponseType.idToken),
    (#client_id, auth0ClientId),
    (#scopes, Scopes.make([Scopes.openId, Scopes.profile])),
    (#redirect_uri, redirectUrl),
  ],
)

// type test = {token:ResponseType.t}

// let test:test ={token:ResponseType.ResponseType.idToken}
// Js.log("Test" ++ test.token)
// type test2 = {token:string}
// let test2:test2 ={token:ResponseType.idToken}
