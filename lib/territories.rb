class World
    module TerritoryDefs
        NA = [
            [ "Alaska", :kamchatka, :northwestterritory, :alberta ],
            [ "Alberta", :alaska, :northwestterritory, :ontario, :westernus ],
            [ "CentralAmerica", :westernus, :easternus, :venezuela ],
            [ "EasternUS", :westernus, :quebec, :ontario, :centralamerica ],
            [ "Greenland", :northwestterritory, :quebec, :ontario, :iceland ],
            [ "NorthwestTerritory", :alberta, :alaska, :ontario, :greenland ],
            [ "Ontario", :alberta, :quebec, :greenland, :northwestterritory, :westernus, :easternus ],
            [ "Quebec", :greenland, :ontario, :easternus ],
            [ "WesternUS", :alberta, :easternus, :centralamerica, :ontario ]
        ]
        SA = [
            [ "Argentina", :peru, :brazil ],
            [ "Brazil", :argentina, :venezuela, :peru, :northafrica ],
            [ "Peru", :argentina, :brazil, :venezuela ],
            [ "Venezuela", :centralamerica, :peru, :brazil ]
        ]
        EU = [
            [ "GreatBritain", :iceland, :scandinavia, :northerneu, :westerneu ],
            [ "Iceland", :greenland, :scandinavia, :greatbritain ],
            [ "NorthernEU", :westerneu, :ukraine, :southerneu, :scandinavia, :greatbritain ],
            [ "Scandinavia", :ukraine, :iceland, :greatbritain, :northerneu ],
            [ "SouthernEU", :middleeast, :ukraine, :westerneu, :northerneu, :egypt, :northafrica ],
            [ "Ukraine", :scandinavia, :northerneu, :southerneu, :ural, :afghanistan, :middleeast],
            [ "WesternEU", :northafrica, :greatbritain, :northerneu, :southerneu ]
        ]
        Africa = [
            [ "Congo", :northafrica, :eastafrica, :southafrica ],
            [ "EastAfrica", :madagascar, :southafrica, :congo, :egypt, :northafrica, :middleeast ],
            [ "Egypt", :southerneu, :middleeast, :northafrica, :eastafrica ],
            [ "Madagascar", :eastafrica, :southafrica ],
            [ "NorthAfrica", :brazil, :westerneu, :egypt, :congo, :eastafrica, :southerneu ],
            [ "SouthAfrica", :madagascar, :congo, :eastafrica ]
        ]
        Asia = [
            [ "Afghanistan", :ukraine, :ural, :china, :india, :middleeast ],
            [ "China", :afghanistan, :ural, :siberia, :mongolia, :siam, :india ],
            [ "India", :middleeast, :afghanistan, :china, :siam ],
            [ "Irkutsk", :siberia, :yakustk, :kamchatka, :mongolia ],
            [ "Japan", :kamchatka, :mongolia ],
            [ "Kamchatka", :alaska, :yakustk, :irkutsk, :japan ],
            [ "MiddleEast", :southerneu, :ukraine, :afghanistan, :india, :egypt, :eastafrica ],
            [ "Mongolia", :siberia, :irkutsk, :japan, :china ],
            [ "Siam", :india, :china, :indonesia ],
            [ "Siberia", :ural, :yakustk, :irkutsk, :china, :mongolia ],
            [ "Ural", :ukraine, :siberia, :china, :afghanistan ],
            [ "Yakustk", :siberia, :irkutsk, :kamchatka ]
        ]
        Australia = [
            [ "EasternAustralia", :westernaustralia, :newguinea ],
            [ "Indonesia", :westernaustralia, :siam, :newguinea ],
            [ "NewGuinea", :easternaustralia, :indonesia, :westernaustralia ],
            [ "WesternAustralia", :easternaustralia, :indonesia, :newguinea ]
        ]
    end
end
