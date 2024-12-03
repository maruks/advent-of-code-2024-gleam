import gleam/string as str
import gleam/int
import gleam/regexp as re
import gleam/list.{map,fold,sort,group} as list
import gleam/dict as dict

fn parse_line(s: String) {
  let assert Ok(spaces) = re.from_string("\\s+")
  let assert [s1, s2] = re.split(spaces,s)
  let assert Ok(n1) = int.parse(s1)
  let assert Ok(n2) = int.parse(s2)
  #(n1, n2)
}

pub fn parse(input: String) {
  input |> str.split("\n") |> map(parse_line)
}

pub fn pt_1(input: List(#(Int, Int))) {
  let list_1 = input |> map(fn(t) {t.0}) |> sort(by: int.compare)
  let list_2 = input |> map(fn(t) {t.1}) |> sort(by: int.compare)
  list.zip(list_1,list_2) |> map(fn(t) {int.absolute_value(t.0 - t.1)}) |> fold(0, fn(acc, x) { acc + x })
}

pub fn pt_2(input: List(#(Int, Int))) {
  let list_1 = input |> map(fn(t) {t.0})
  let grouped = input |> map(fn(t) {t.1}) |> group(fn(i) {i})
  list_1 |> fold(0, fn(acc, x) {acc + x * case dict.get(grouped,x) { Ok(xs) -> list.length(xs)
                                                                     Error(_) -> 0}})
}
