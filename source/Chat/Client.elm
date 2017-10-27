module Client exposing (main)

import Html exposing (Html)
import Html.Attributes as Attributes
import Html.Events as Events
import WebSocket


type Msg
    = Input String
    | Send
    | Receive String


type alias Model =
    { messages : List String
    , message : String
    }


url =
    "ws://localhost:3000"


init =
    ( { message = ""
      , messages = []
      }
    , Cmd.none
    )


update msg model =
    case msg of
        Input message ->
            ( { model | message = message }, Cmd.none )

        Send ->
            ( { model | message = "" }, WebSocket.send url model.message )

        Receive message ->
            ( { model | messages = message :: model.messages }, Cmd.none )


subscriptions model =
    WebSocket.listen url Receive


view model =
    Html.div []
        [ Html.input [ Attributes.value model.message, Events.onInput Input ] []
        , Html.button [ Events.onClick Send ] [ Html.text "send" ]
        , Html.div [] (List.map (\message -> Html.div [] [ Html.text message ]) model.messages)
        ]


main =
    Html.program
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }
