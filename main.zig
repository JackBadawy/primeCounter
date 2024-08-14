const std = @import("std");

const Error = error{
    SmallNumberError,
};

pub fn isPrime(numToCheck: i32) bool {
    var i: i32 = 2;
    var flNum: f64 = @floatFromInt(numToCheck);
    if (numToCheck <= 1) return false;
    const sqrtNum: i32 = @intFromFloat(@sqrt(flNum));
    while (i <= sqrtNum) : (i += 1) {
        if (@mod(numToCheck, i) == 0) return false;
    }
    return true;
}

pub fn countPrimes(upTo: i32) !i32 {
    var count: i32 = 0;
    var i: i32 = 2;
    if (upTo < 2) {
        return Error.SmallNumberError;
    }
    while (i <= upTo) : (i += 1) {
        if (isPrime(i)) count += 1;
    }
    return count;
}

pub fn main() void {
    const countOfPrimes: i32 = countPrimes(1000000) catch |err| {
        std.debug.print("Error: {}\nNumber input must be larger than 1\n", .{err});
        return;
    };

    std.debug.print("Count of primes: {}\n", .{countOfPrimes});
}
