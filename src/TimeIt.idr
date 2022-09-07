module TimeIt

import public System.Clock

{- Deadass IO timing

:exec timeIt "Woof" $ traverse (\n => sleep n <* printLn n) [3,1,2]
3
1
2
Woof: 6.000343895

-}

-- showTime doesn't pad nanoseconds properly
export
showTime' : Clock Duration -> String
showTime' t = show $ (cast {to=Double} (seconds t)) + (cast {to=Double} (nanoseconds t) / 1000000000)

export
timeIt' : HasIO io => String -> io a -> io (Clock Duration,a)
timeIt' str act = do
  now <- liftIO $ clockTime Monotonic
  r <- act
  later <- liftIO $ clockTime Monotonic
  let dif = timeDifference later now
  putStrLn $ str ++ ": " ++ showTime' dif
  pure (dif,r)

-- repeated definition since calling the above and dropping the Clock affects timing somehow!
export
timeIt : HasIO io => String -> io a -> io a
timeIt str act = do
  now <- liftIO $ clockTime Monotonic
  r <- act
  later <- liftIO $ clockTime Monotonic
  let dif = timeDifference later now
  putStrLn $ str ++ ": " ++ showTime' dif
  pure r
