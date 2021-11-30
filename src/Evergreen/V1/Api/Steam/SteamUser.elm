module Evergreen.V1.Api.Steam.SteamUser exposing (..)

import Evergreen.V1.Api.Steam


type alias PlayerSummary =
    { steamId : Evergreen.V1.Api.Steam.SteamId
    , personaName : String
    , avatar : String
    , avatarMedium : String
    , avatarFull : String
    }
