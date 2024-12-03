import gleam/string as str
import gleam/int
import gleam/regexp as re
import gleam/list.{map,all,group,range,length,any} as list
import gleam/dict as dict
import gleam/result

fn signum(i: Int) {
  case i {
    _ if i < 0 -> -1
    _ if i > 0 -> 1
    _ -> 0
    }
}

fn parse_line(s: String) {
  let assert Ok(spaces) = re.from_string("\\s+")
  let assert Ok(res) = re.split(spaces,s) |> map(int.parse) |> result.all
  res
}

pub fn parse(input: String) {
  input |> str.split("\n") |> map(parse_line)
}

pub fn diff_list(xs: List(Int), prev: Int, result: List(Int)) {
  case xs {
    [first, ..rest] -> diff_list(rest, first, [first - prev, ..result])
    [] -> result
  }
}

pub fn is_safe(xs: List(Int)) {
  let assert [first, ..rest] = xs
  let diffs = diff_list(rest, first, [])
  let levels = diffs |> all (fn(i) {let a = int.absolute_value(i)
                                    a > 0 && a < 4})
  let group_size = diffs |> group(signum) |> dict.size
  levels && {group_size == 1}
}

pub fn pt_1(input: List(List(Int))) {
  let grouped = input |> group(is_safe)
  case dict.get(grouped, True) {
    Ok(vals) -> list.length(vals)
    Error(_) -> 0
  }
}

pub fn list_with_elem_removed(xs: List(Int), index: Int) {
  let #(a,b) = list.split(xs, index)
  let assert Ok(tail) = list.rest(b)
  list.flatten([a,tail])
}

pub fn is_safe_with_dampener(xs: List(Int)) {
  is_safe(xs) || range(0,length(xs) - 1) |> any(fn(i) {list_with_elem_removed(xs,i) |> is_safe()})
}

pub fn pt_2(input: List(List(Int))) {
  let grouped = input |> group(is_safe_with_dampener)
  case dict.get(grouped, True) {
    Ok(vals) -> list.length(vals)
    Error(_) -> 0
  }
}
