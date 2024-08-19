const std = @import("std");

const Error = error{
    SmallNumberError,
};

// pub fn isPrime(numToCheck: i32) bool {
//     var i: i32 = 2;
//     var flNum: f64 = @floatFromInt(numToCheck);
//     if (numToCheck <= 1) return false;
//     const sqrtNum: i32 = @intFromFloat(@sqrt(flNum));
//     while (i <= sqrtNum) : (i += 1) {
//         if (@mod(numToCheck, i) == 0) return false;
//     }
//     return true;
// }

pub fn isPrime(numToCheck: i32) bool {
    if (numToCheck <= 1) return false;
    if (numToCheck <= 3) return true;
    if (@mod(numToCheck, 2) == 0) return false;
    if (@mod(numToCheck, 3) == 0) return false;

    var i: i32 = 5;
    while (i * i <= numToCheck) : (i += 6) {
        if (@mod(numToCheck, i) == 0) return false;
        if (@mod(numToCheck, i + 2) == 0) return false;
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

fn read_num(stdin: *const std.fs.File) i32 {
    var buffer: [20]u8 = undefined;
    const len = stdin.*.read(&buffer) catch |err| {
        std.debug.print("Error while reading number: {}\n", .{err});
        std.os.exit(1);
    };

    if (len == buffer.len) {
        std.debug.print("Input is too big!\n", .{});
        std.os.exit(1);
    }

    const line = std.mem.trimRight(u8, buffer[0..len], "\r\n");
    const val = std.fmt.parseInt(i32, line, 10) catch |err| {
        std.debug.print("Error while reading number: {}\n", .{err});
        std.os.exit(1);
    };

    return val;
}

pub fn main() void {
    const stdin = std.io.getStdIn();

    std.debug.print("Enter a number to find the count of primes up to that number: ", .{});
    var userInput: i32 = read_num(&stdin);

    const start_time = std.time.milliTimestamp();
    const countOfPrimes: i32 = countPrimes(userInput) catch |err| {
        std.debug.print("Error: {}\nNumber input must be larger than 1\n", .{err});
        return;
    };
    const end_time = std.time.milliTimestamp();
    const elapsed_time = end_time - start_time;

    std.debug.print("Count of primes: {}\n", .{countOfPrimes});
    std.debug.print("Execution time: {} ms\n", .{elapsed_time});

    std.debug.print("Press Enter to exit...\n", .{});
    _ = read_num(&stdin);
}
