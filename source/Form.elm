module Form exposing (main)

import Html exposing (Html)
import Html.Events as Events
import Html.Attributes as Attributes
import Process
import Task


type alias Model =
    { name : String
    , pass : String
    , loading : Bool
    }


type Msg
    = InputName String
    | InputPass String
    | Submit
    | Reset


init : ( Model, Cmd Msg )
init =
    ( { name = ""
      , pass = ""
      , loading = False
      }
    , Cmd.none
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        InputName text ->
            ( { model | name = text }, Cmd.none )

        InputPass text ->
            ( { model | pass = text }, Cmd.none )

        Submit ->
            ( { model | loading = True }, Task.perform (always Reset) (Process.sleep 2000) )

        Reset ->
            init


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


view : Model -> Html Msg
view model =
    Html.div []
        [ Html.input
            [ Events.onInput InputName
            , Attributes.value model.name
            , Attributes.disabled model.loading
            , Attributes.placeholder "name"
            ]
            []
        , Html.input
            [ Events.onInput InputPass
            , Attributes.value model.pass
            , Attributes.disabled model.loading
            , Attributes.placeholder "pass"
            , Attributes.type_ "password"
            ]
            []
        , Html.button
            [ Events.onClick Submit
            , Attributes.disabled model.loading
            ]
            [ Html.text "submit" ]
        ]


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }
