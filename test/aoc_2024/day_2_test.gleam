import gleeunit/should
import aoc_2024/day_2 as sut

const input =
    [[7, 6, 4, 2, 1],
     [1, 2, 7, 8, 9],
     [9, 7, 6, 2, 1],
     [1, 3, 2, 4, 5],
     [8, 6, 4, 4, 1],
     [1, 3, 6, 7, 9]]

pub fn pt_1_test() {
  input |> sut.pt_1() |> should.equal(2)
}

pub fn pt_2_test() {
  input |> sut.pt_2() |> should.equal(4)
}
