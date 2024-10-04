Latest runs on my laptop:

```console
$ MIX_ENV=bench mix run bench/bind_all.exs

Name              ips        average  deviation         median         99th %
xqlite         9.00 M       0.111 μs ±28533.35%      0.0830 μs       0.125 μs
exqlite        0.86 M        1.17 μs   ±766.35%        1.13 μs        1.38 μs

Comparison:
xqlite         9.00 M
exqlite        0.86 M - 10.50x slower +1.05 μs
```

```console
$ MIX_ENV=bench mix run bench/fetch_all.exs

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

```console
$ MIX_ENV=bench mix run bench/insert_all.exs

##### With input 1 row #####
Name              ips        average  deviation         median         99th %
xqlite       242.33 K        4.13 μs    ±50.77%        4.04 μs        5.42 μs
exqlite      154.18 K        6.49 μs    ±66.23%        6.21 μs       11.29 μs

Comparison:
xqlite       242.33 K
exqlite      154.18 K - 1.57x slower +2.36 μs

##### With input 10 rows #####
Name              ips        average  deviation         median         99th %
xqlite       142.92 K        7.00 μs    ±53.32%        6.58 μs       17.92 μs
exqlite       80.40 K       12.44 μs    ±40.34%       11.54 μs          29 μs

Comparison:
xqlite       142.92 K
exqlite       80.40 K - 1.78x slower +5.44 μs

##### With input 100 rows #####
Name              ips        average  deviation         median         99th %
xqlite        21.44 K       46.65 μs    ±13.97%       45.50 μs       71.16 μs
exqlite       11.65 K       85.84 μs    ±13.21%       84.58 μs      117.83 μs

Comparison:
xqlite        21.44 K
exqlite       11.65 K - 1.84x slower +39.20 μs

##### With input 1000 rows #####
Name              ips        average  deviation         median         99th %
xqlite         3.40 K      294.37 μs     ±3.89%      291.58 μs      327.92 μs
exqlite        1.33 K      749.33 μs     ±2.29%      746.25 μs      790.57 μs

Comparison:
xqlite         3.40 K
exqlite        1.33 K - 2.55x slower +454.97 μs
```
