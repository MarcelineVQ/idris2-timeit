TimeIt
=====

Plain simple timing for HasIO actions

```
Main> :module TimeIt
Main> :module System
Main> :exec timeIt "Woof" $ traverse (\n => sleep n <* printLn n) [3,1,2]
```
```
3
1
2
Woof: 6.000343895
```
