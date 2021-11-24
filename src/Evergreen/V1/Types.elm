module Evergreen.V1.Types exposing (..)

import Browser
import Browser.Navigation
import Dict
import Evergreen.V1.Api.Steam
import Evergreen.V1.Api.Steam.PlayerService
import Evergreen.V1.Api.User
import Evergreen.V1.Bridge
import Evergreen.V1.Gen.Pages
import Evergreen.V1.Shared
import Lamdera
import Time
import Url


type alias FrontendModel =
    { url : Url.Url
    , key : Browser.Navigation.Key
    , shared : Evergreen.V1.Shared.Model
    , page : Evergreen.V1.Gen.Pages.Model
    }


type alias Session =
    { userId : Int
    , expires : Time.Posix
    }


type alias BackendModel =
    { sessions : Dict.Dict Lamdera.SessionId Session
    , users : Dict.Dict Int Evergreen.V1.Api.User.UserFull
    }


type FrontendMsg
    = ChangedUrl Url.Url
    | ClickedLink Browser.UrlRequest
    | Shared Evergreen.V1.Shared.Msg
    | Page Evergreen.V1.Gen.Pages.Msg
    | Noop


type alias ToBackend =
    Evergreen.V1.Bridge.ToBackend


type BackendMsg
    = GotGames_Home Lamdera.ClientId (Result Evergreen.V1.Api.Steam.Error Evergreen.V1.Api.Steam.PlayerService.GameList)
    | CheckSession Lamdera.SessionId Lamdera.ClientId
    | RenewSession Evergreen.V1.Api.User.UserId Lamdera.SessionId Lamdera.ClientId Time.Posix
    | NoOpBackendMsg


type ToFrontend
    = ActiveSession Evergreen.V1.Api.User.User
    | PageMsg Evergreen.V1.Gen.Pages.Msg
    | NoOpToFrontend
