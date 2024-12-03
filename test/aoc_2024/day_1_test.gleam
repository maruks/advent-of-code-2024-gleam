import gleeunit/should
import aoc_2024/day_1 as sut

pub fn pt_2_test() {
  let input =
     [#(3, 4),
      #(4, 3),
      #(2, 5),
      #(1, 3),
      #(3, 9),
      #(3, 3)]
  input |> sut.pt_2() |> should.equal(31)
}
