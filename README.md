Latest runs:

```console
$ MIX_ENV=bench mix run bench/bind_all.exs
Operating System: macOS
CPU Information: Apple M2
Number of Available Cores: 8
Available memory: 8 GB
Elixir 1.17.1
Erlang 27.0
JIT enabled: true

Benchmark suite executing with the following configuration:
warmup: 2 s
time: 3 s
memory time: 0 ns
reduction time: 0 ns
parallel: 1
inputs: none specified
Estimated total run time: 10 s

Benchmarking exqlite ...
Benchmarking xqlite ...
Calculating statistics...
Formatting results...

Name              ips        average  deviation         median         99th %
xqlite         9.00 M       0.111 μs ±28533.35%      0.0830 μs       0.125 μs
exqlite        0.86 M        1.17 μs   ±766.35%        1.13 μs        1.38 μs

Comparison:
xqlite         9.00 M
exqlite        0.86 M - 10.50x slower +1.05 μs
```

```console
$ MIX_ENV=bench mix run bench/fetch_all.exs
Operating System: macOS
CPU Information: Apple M2
Number of Available Cores: 8
Available memory: 8 GB
Elixir 1.17.1
Erlang 27.0
JIT enabled: true

Benchmark suite executing with the following configuration:
warmup: 2 s
time: 5 s
memory time: 0 ns
reduction time: 0 ns
parallel: 1
inputs: 10 rows, 100 rows, 1000 rows, 10000 rows
Estimated total run time: 56 s

Benchmarking exqlite with input 10 rows ...
Benchmarking exqlite with input 100 rows ...
Benchmarking exqlite with input 1000 rows ...
Benchmarking exqlite with input 10000 rows ...
Benchmarking xqlite with input 10 rows ...
Benchmarking xqlite with input 100 rows ...
Benchmarking xqlite with input 1000 rows ...
Benchmarking xqlite with input 10000 rows ...
Calculating statistics...
Formatting results...

##### With input 10 rows #####
Name              ips        average  deviation         median         99th %
xqlite       229.59 K        4.36 μs   ±161.01%        4.25 μs        5.96 μs
exqlite      134.31 K        7.45 μs   ±167.30%        6.58 μs       22.96 μs

Comparison:
xqlite       229.59 K
exqlite      134.31 K - 1.71x slower +3.09 μs

##### With input 100 rows #####
Name              ips        average  deviation         median         99th %
xqlite        28.56 K       35.01 μs    ±10.36%       34.67 μs       45.96 μs
exqlite       11.74 K       85.20 μs    ±26.00%       74.63 μs      148.74 μs

Comparison:
xqlite        28.56 K
exqlite       11.74 K - 2.43x slower +50.19 μs

##### With input 1000 rows #####
Name              ips        average  deviation         median         99th %
xqlite         4.00 K      249.89 μs     ±7.24%      245.83 μs      295.31 μs
exqlite        1.25 K      802.02 μs    ±16.42%      870.83 μs      969.03 μs

Comparison:
xqlite         4.00 K
exqlite        1.25 K - 3.21x slower +552.13 μs

##### With input 10000 rows #####
Name              ips        average  deviation         median         99th %
xqlite         428.95        2.33 ms     ±7.04%        2.23 ms        2.63 ms
exqlite        140.09        7.14 ms     ±9.71%        7.15 ms        8.50 ms

Comparison:
xqlite         428.95
exqlite        140.09 - 3.06x slower +4.81 ms
```

`insert_all` [benchmark](https://github.com/ruslandoga/xqlite/blob/master/bench/insert_all.exs) is unfair to Exqlite since XQLite uses a different approach so it's omitted.
