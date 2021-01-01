// https://github.com/foretold-app/foretold/blob/6b7588553d0cfa40f42682e6c816eb0f40e8fc50/packages/client/src/contexts/Auth0Tokens.re
open Rationale.Function.Infix
module JsDate = {
  let fromString = Js.Date.fromString;
  let now = Js.Date.now;
  let make = Js.Date.make;
  let valueOf = Js.Date.valueOf;
};
type access_token = string
type id_token = string
type expires_at = string

type t = {
  access_token: access_token,
  id_token: id_token,
  expires_at: expires_at,
}

let jwt = (t: t) => Jwt.make(t.id_token)
let auth0Id = (t: t) => t |> jwt |> Rationale.Option.bind(_, Jwt.get_attribute("sub"))

let set = (t: t) => {
  open Dom.Storage
  localStorage |> setItem("access_token", t.access_token)
  localStorage |> setItem("id_token", t.id_token)
  localStorage |> setItem("expires_at", t.expires_at)
  ()
}

let destroy = () => {
  open Dom.Storage
  localStorage |> removeItem("access_token")
  localStorage |> removeItem("id_token")
  localStorage |> removeItem("expires_at")
  ()
}

let exists = (t: option<t>) => Rationale.Option.isSome(t)

let isObsolete = (t: t) => {
  let exp = t.expires_at
  let isExpired = \"||>"(\"||>"(Int64.of_string, Int64.to_float), e =>
    e < JsDate.now()
  )
  exp |> isExpired
}

let make_from_storage = () => {
  open Dom.Storage
  let get = e => localStorage |> getItem(e)
  switch (get("access_token"), get("id_token"), get("expires_at")) {
  | (Some(a), Some(b), Some(c)) =>
    Some({access_token: a, id_token: b, expires_at: c})
  | _ => None
  }
}

let make = (access_token, id_token, expires_at) => {
  access_token: access_token,
  id_token: id_token,
  expires_at: expires_at,
}
