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
xqlite         7.02 M       0.142 μs  ±4485.44%       0.125 μs       0.167 μs
exqlite        0.84 M        1.18 μs   ±708.03%        1.17 μs        1.29 μs

Comparison:
xqlite         7.02 M
exqlite        0.84 M - 8.31x slower +1.04 μs
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
xqlite       253.70 K        3.94 μs   ±169.07%        3.88 μs        5.33 μs
exqlite      166.76 K        6.00 μs   ±101.37%        5.75 μs        8.46 μs

Comparison:
xqlite       253.70 K
exqlite      166.76 K - 1.52x slower +2.06 μs

##### With input 100 rows #####
Name              ips        average  deviation         median         99th %
xqlite        36.10 K       27.70 μs    ±16.05%          28 μs       37.38 μs
exqlite       17.87 K       55.97 μs    ±32.22%       49.75 μs      128.92 μs

Comparison:
xqlite        36.10 K
exqlite       17.87 K - 2.02x slower +28.27 μs

##### With input 1000 rows #####
Name              ips        average  deviation         median         99th %
xqlite         4.86 K      205.95 μs     ±5.26%      205.21 μs      236.71 μs
exqlite        1.97 K      507.82 μs    ±13.70%      525.29 μs      615.26 μs

Comparison:
xqlite         4.86 K
exqlite        1.97 K - 2.47x slower +301.87 μs

##### With input 10000 rows #####
Name              ips        average  deviation         median         99th %
xqlite         519.54        1.92 ms     ±4.63%        1.88 ms        2.18 ms
exqlite        210.14        4.76 ms     ±8.38%        4.65 ms        5.68 ms

Comparison:
xqlite         519.54
exqlite        210.14 - 2.47x slower +2.83 ms
```

`insert_all` [benchmark](https://github.com/ruslandoga/xqlite/blob/master/bench/insert_all.exs) is unfair to Exqlite since XQLite uses a different approach so it's omitted.
