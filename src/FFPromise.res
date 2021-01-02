// https://gist.github.com/jfrolich/38da5a25361bbfed2226d6bc13b408d9
// https://discord.com/channels/235176658175262720/235199190781788160/791541316042620928
type t<'a> = Js.Promise.t<'a>
type error

@bs.new
external make: ((@bs.uncurry ~resolve: (. 'a) => unit, ~reject: (. exn) => unit) => unit) => t<'a> =
  "Promise"
@bs.val @bs.scope("Promise") external resolve: 'a => t<'a> = "resolve"
@bs.val @bs.scope("Promise") external reject: exn => t<'a> = "reject"
@bs.val @bs.scope("Promise")
external all: array<t<'a>> => t<array<'a>> = "all"
@bs.val @bs.scope("Promise")
external all2: ((t<'a0>, t<'a1>)) => t<('a0, 'a1)> = "all"
@bs.val @bs.scope("Promise")
external all3: ((t<'a0>, t<'a1>, t<'a2>)) => t<('a0, 'a1, 'a2)> = "all"
@bs.val @bs.scope("Promise")
external all4: ((t<'a0>, t<'a1>, t<'a2>, t<'a3>)) => t<('a0, 'a1, 'a2, 'a3)> = "all"
@bs.val @bs.scope("Promise")
external all5: ((t<'a0>, t<'a1>, t<'a2>, t<'a3>, t<'a4>)) => t<('a0, 'a1, 'a2, 'a3, 'a4)> = "all"
@bs.val @bs.scope("Promise")
external all6: ((t<'a0>, t<'a1>, t<'a2>, t<'a3>, t<'a4>, t<'a5>)) => t<(
  'a0,
  'a1,
  'a2,
  'a3,
  'a4,
  'a5,
)> = "all"

@bs.val @bs.scope("Promise")
external race: array<t<'a>> => t<'a> = "race"

@bs.send
external then_: (t<'a>, @bs.uncurry ('a => t<'b>)) => t<'b> = "then"

@bs.send
external catch: (t<'a>, @bs.uncurry (error => t<'a>)) => t<'a> = "catch"
/* [ p|> catch handler]
      Note in JS the returned promise type is actually runtime dependent,
      if promise is rejected, it will pick the [handler] otherwise the original promise,
      to make it strict we enforce reject handler
      https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise/catch
 */
