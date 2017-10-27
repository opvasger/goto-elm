module Counter exposing (main)

import Html
import Html.Events as Events


{-
   A simple counter application.
-}


type Message
    = Increment
    | Decrement


update message model =
    case message of
        Increment ->
            model + 1

        Decrement ->
            model - 1


model =
    0


view model =
    Html.div
        []
        [ Html.button [ Events.onClick Increment ] [ Html.text "+" ]
        , Html.div [] [ Html.text (toString model) ]
        , Html.button [ Events.onClick Decrement ] [ Html.text "-" ]
        ]


main =
    Html.beginnerProgram
        { model = model
        , update = update
        , view = view
        }
