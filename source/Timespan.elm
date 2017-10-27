module Timespan exposing (Error, Timespan, fromTime, head, isCoinciding, tail, toDuration, toTuple)

import Time exposing (Time)


{-
   A timespan invariably starts before it ends.
   The lone constructor for Timespans is
   unexposed to maintain this guarantee.
-}


type Timespan
    = Private Time Time


type Error
    = BadTime


fromTime : Time -> Time -> Result Error Timespan
fromTime head tail =
    case head < tail of
        True ->
            Ok (Private head tail)

        False ->
            Err BadTime


toTuple : Timespan -> ( Time, Time )
toTuple (Private head tail) =
    ( head, tail )


toDuration : Timespan -> Time
toDuration (Private head tail) =
    tail - head


isCoinciding : Timespan -> Timespan -> Bool
isCoinciding (Private headA tailA) (Private headB tailB) =
    headA < headB && headB < tailA || headB < headA && headA < tailB


head : Timespan -> Time
head (Private head _) =
    head


tail : Timespan -> Time
tail (Private _ tail) =
    tail
