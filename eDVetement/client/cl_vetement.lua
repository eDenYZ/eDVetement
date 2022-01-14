ESX = nil Citizen.CreateThread(function() while ESX == nil do TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)  Citizen.Wait(0) end end)

local open = false
local Main = RageUI.CreateMenu(Config.NomDesMenu.Menu, "Catégories")
local dressing = RageUI.CreateSubMenu(Main,"ClotheShop", "Dressing")
local dressing = RageUI.CreateSubMenu(Main,"ClotheShop", "Dressing")
local eregister = RageUI.CreateSubMenu(Main, "ClotheShop", "Lunette")
local tshirt = RageUI.CreateSubMenu(Main, "ClotheShop", "Tshirt")
local torse = RageUI.CreateSubMenu(Main, "ClotheShop", "Torse")
local pantalon = RageUI.CreateSubMenu(Main, "ClotheShop", "Pantalon")
local chaussure = RageUI.CreateSubMenu(Main, "ClotheShop", "Chaussure")
local bras = RageUI.CreateSubMenu(Main, "ClotheShop", "Bras")
local chapeau = RageUI.CreateSubMenu(Main, "ClotheShop", "Chapeau")
local chaine = RageUI.CreateSubMenu(Main, "ClotheShop", "Chaine")
local lunette = RageUI.CreateSubMenu(Main, "ClotheShop", "Lunette")
local sac = RageUI.CreateSubMenu(Main,"ClotheShop", "Sac")
lunette.EnableMouse = true
chaine.EnableMouse = true
chapeau.EnableMouse = true
bras.EnableMouse = true
chaussure.EnableMouse = true
pantalon.EnableMouse = true
tshirt.EnableMouse = true
torse.EnableMouse = true
sac.EnableMouse = true
Main.Closed = function()
    RageUI.Visible(Main, false)
    open = false
    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
        TriggerEvent('skinchanger:loadSkin', skin)
    end)
end


local Vetement = {
SliderPannelTorso = {
  Minimum = 0,
  Index = 0,
  },
SliderPannelTshirt = {
  Minimum = 0,
  Index = 0,
   },
SliderPannelPatanlon = {
  Minimum = 0,
  Index = 0,
  },
SliderPannelChaussure = {
  Minimum = 0,
  Index = 0,
},
SliderPannelChapeau = {
  Minimum = 0,
  Index = 0,
},
SliderPannelChaine = {
  Minimum = 0,
  Index = 0,
},
SliderPannelLunette = {
  Minimum = 0,
  Index = 0,
},
SliderPannelSac = {
  Minimum = 0,
  Index = 0,
},
dressing = {
  DressingList = {'Equiper', 'Renommer', 'Supprimer'},
	DressingIndex = 1,
  liste = {},
	tenue = {};
},
}

local SliderProgressTorse = 0
local SliderProgressTshirt = 0
local SliderProgressPatanlon = 0
local SliderProgressChaussure = 0
local SliderProgressBras = 0
local SliderProgressChapeau = 0
local SliderProgressChaine = 0
local SliderProgressLunette = 0
local SliderProgressSac = 0

OpenVetement = function()
     if main then 
      main = false
         RageUI.Visible(Main, false)
         return
     else
      main = true 
         RageUI.Visible(Main, true)
         Citizen.CreateThread(function()
         while main do 
             RageUI.IsVisible(Main,function()

              RageUI.Button("Mon Dressing",nil,{RightBadge = RageUI.BadgeStyle.Clothes },true,{
                onSelected = function()
                end
              },dressing)

              RageUI.Button("Catégories Tshirt",nil,{RightLabel = "→"},true,{
              onSelected = function()
              end
            },tshirt)

            RageUI.Button("Catégories Sac",nil,{RightLabel = "→"},true,{
              onSelected = function()
              end
            },sac)

            RageUI.Button("Catégories Torse",nil,{RightLabel = "→"},true,{
              onSelected = function()
              end
            },torse)

            RageUI.Button("Catégories Pantalon",nil,{RightLabel = "→"},true,{
              onSelected = function()
              end
            },pantalon)

            RageUI.Button("Catégories Chaussure",nil,{RightLabel = "→"},true,{
              onSelected = function()
              end
            },chaussure)

            RageUI.Button("Catégories Bras",nil,{RightLabel = "→"},true,{
              onSelected = function()
              end
            },bras)

            RageUI.Button("Catégories Chapeau",nil,{RightLabel = "→"},true,{
              onSelected = function()
              end
            },chapeau)

            RageUI.Button("Catégories Chaine",nil,{RightLabel = "→"},true,{
              onSelected = function()
              end
            },chaine)


            RageUI.Button("Catégories Lunette",nil,{RightLabel = "→"},true,{
              onSelected = function()
              end
            },lunette)


            RageUI.Button("Valider et payer : ~g~75$" , "Prix du Shopping : ~g~75$", { Color = { BackgroundColor = { 0, 140, 0, 160 } } }, true, {
              onSelected = function()
                    end
                },eregister)

          end)

      RageUI.IsVisible(dressing, function()
        ESX.TriggerServerCallback('Vetement:clothe_load', function(tenue)
          Vetement.dressing.liste = tenue
      end)
      for i = 1, #Vetement.dressing.liste, 1 do
      RageUI.List(Vetement.dressing.liste[i].nom, Vetement.dressing.DressingList, Vetement.dressing.DressingIndex, nil, {}, true, {
        onListChange = function(Index)
          Vetement.dressing.DressingIndex = Index
        end,
        onSelected = function(Index)
          tenuchoisi = Vetement.dressing.liste[i] 
            if Index == 1 then
              TriggerEvent('skinchanger:getSkin', function(skin)
                TriggerEvent('skinchanger:loadClothes', skin, json.decode(tenuchoisi.contenu))
                    TriggerEvent('skinchanger:getSkin', function(skin)
                    TriggerServerEvent('esx_skin:save', skin)
                    end)
                  end)
            elseif Index == 2 then
              local newname = gettxt2("Choisir un nom pour la tenue ", "", 15)
              TriggerServerEvent('Vetement:clothe_rename', newname, tenuchoisi.id)
                RageUI.GoBack()
                ESX.TriggerServerCallback('Vetement:clothe_load', function(tenue)
                  Vetement.dressing.liste = tenue
                end)
          elseif Index == 3 then
            TriggerServerEvent('Vetement:clothe_del_tenue', tenuchoisi.id)
            RageUI.GoBack()
              ESX.TriggerServerCallback('Vetement:clothe_load', function(tenue)
                dressing.liste = tenue
              end)
            end
        end
    })





end
      end)

      RageUI.IsVisible(eregister, function()

        RageUI.Separator("↓ ~h~~o~Eregister Votre tenue~s~ ↓")

          
        RageUI.Button("Non" , nil, { Color = { BackgroundColor = { 183, 28, 28, 160 } } }, true, {
          onSelected = function()
            TriggerServerEvent("Vetement:SaveSkin")
                    RageUI.CloseAll()
                end
            })

        RageUI.Button("Oui" , nil, { Color = { BackgroundColor = { 0, 140, 0, 160 } } }, true, {
          onSelected = function()
            TriggerServerEvent("Vetement:SaveSkin")
                  Wait(180)
                  local nom = gettxt2("Choisir un nom pour la tenue ", "", 15)
                  TriggerEvent('skinchanger:getSkin', function(skin)
                  TriggerServerEvent('Vetement:clothe_save', nom, skin)
                  ESX.ShowNotification("~g~Tenue enregistrée !")
                  RageUI.CloseAll()
                end)
                end
            })




  end)


          RageUI.IsVisible(tshirt,function()
            
            RageUI.SliderProgress('List des Tshirt : '..SliderProgressTshirt..'', SliderProgressTshirt, 124, false, {
              ProgressBackgroundColor = { R = 255, G = 255, B = 255, A = 255 },
              ProgressColor = { R = 3, G = 169, B = 96, A = 244 },
          }, true, {
              onSliderChange = function(Index)
              SliderProgressTshirt = Index
              TriggerEvent("skinchanger:change", "tshirt_1", SliderProgressTshirt)

              end
          })
  
          RageUI.SliderPanel(Vetement.SliderPannelTshirt.Index, 0, "Variations Couleur : "..Vetement.SliderPannelTshirt.Index.."", 15, {  
                    onSliderChange = function(Index)
                      Vetement.SliderPannelTshirt.Index = Index
                      TriggerEvent("skinchanger:change", "tshirt_2", Vetement.SliderPannelTshirt.Index)
                  end
              }, 1)
          end)
        

            RageUI.IsVisible(torse,function()

          RageUI.SliderProgress('List des Torse : '..SliderProgressTorse..'', SliderProgressTorse, 289, false, {
            ProgressBackgroundColor = { R = 255, G = 255, B = 255, A = 255 },
            ProgressColor = { R = 3, G = 169, B = 96, A = 244 },
        }, true, {
            onSliderChange = function(Index)
                SliderProgressTorse = Index
                TriggerEvent("skinchanger:change", "torso_1", SliderProgressTorse)
            end
        })

        RageUI.SliderPanel(Vetement.SliderPannelTorso.Index, 0, "Variations Couleur : "..Vetement.SliderPannelTorso.Index.."", 15, {  
                  onSliderChange = function(Index)
                    Vetement.SliderPannelTorso.Index = Index
                    TriggerEvent("skinchanger:change", "torso_2", Vetement.SliderPannelTorso.Index)
                end
            }, 1)



          end)

          RageUI.IsVisible(pantalon,function()

            RageUI.SliderProgress('List des Patanlon : '..SliderProgressPatanlon..'', SliderProgressPatanlon, 114, false, {
              ProgressBackgroundColor = { R = 255, G = 255, B = 255, A = 255 },
              ProgressColor = { R = 3, G = 169, B = 96, A = 244 },
          }, true, {
              onSliderChange = function(Index)
                SliderProgressPatanlon = Index
                  TriggerEvent("skinchanger:change", "pants_1", SliderProgressPatanlon)
              end
          })
  
          RageUI.SliderPanel(Vetement.SliderPannelPatanlon.Index, 0, "Variations Couleur : "..Vetement.SliderPannelPatanlon.Index.."", 15, {  
                    onSliderChange = function(Index)
                      Vetement.SliderPannelPatanlon.Index = Index
                      TriggerEvent("skinchanger:change", "pants_2", Vetement.SliderPannelPatanlon.Index)
                  end
              }, 1)
  

          end)

          RageUI.IsVisible(chaussure,function()
          RageUI.SliderProgress('List des Chaussure : '..SliderProgressChaussure..'', SliderProgressChaussure, 90, false, {
            ProgressBackgroundColor = { R = 255, G = 255, B = 255, A = 255 },
            ProgressColor = { R = 3, G = 169, B = 96, A = 244 },
          }, true, {
              onSliderChange = function(Index)
                SliderProgressChaussure = Index
                  TriggerEvent("skinchanger:change", "shoes_1", SliderProgressChaussure)
                end
          })
  

          RageUI.SliderPanel(Vetement.SliderPannelChaussure.Index, 0, "Variations Couleur : "..Vetement.SliderPannelChaussure.Index.."", 15, {  
                    onSliderChange = function(Index)
                      Vetement.SliderPannelChaussure.Index = Index
                      TriggerEvent("skinchanger:change", "shoes_2", Vetement.SliderPannelChaussure.Index)
                  end
              }, 1)

          end)

          RageUI.IsVisible(bras,function()

            RageUI.SliderProgress('List des Bras : '..SliderProgressBras..'', SliderProgressBras, 90, false, {
              ProgressBackgroundColor = { R = 255, G = 255, B = 255, A = 255 },
              ProgressColor = { R = 3, G = 169, B = 96, A = 244 },
          }, true, {
              onSliderChange = function(Index)
                SliderProgressBras = Index
                  TriggerEvent("skinchanger:change", "arms", SliderProgressBras)
              end
          })
  
          end)

          RageUI.IsVisible(chapeau,function()

            RageUI.SliderProgress('List des Chapeau : '..SliderProgressChapeau..'', SliderProgressChapeau, 90, false, {
              ProgressBackgroundColor = { R = 255, G = 255, B = 255, A = 255 },
              ProgressColor = { R = 3, G = 169, B = 96, A = 244 },
          }, true, {
              onSliderChange = function(Index)
                SliderProgressChapeau = Index
                  TriggerEvent("skinchanger:change", "helmet_1", SliderProgressChapeau)
              end
          })
  
          RageUI.SliderPanel(Vetement.SliderPannelChapeau.Index, 0, "Variations Couleur : "..Vetement.SliderPannelChapeau.Index.."", 10, {  
                    onSliderChange = function(Index)
                      Vetement.SliderPannelChapeau.Index = Index
                      TriggerEvent("skinchanger:change", "helmet_2", Vetement.SliderPannelChapeau.Index)
                  end
              }, 1)

          end)

          RageUI.IsVisible(chaine,function()

            RageUI.SliderProgress('List des Chaine : '..SliderProgressChaine..'', SliderProgressChaine, 50, false, {
              ProgressBackgroundColor = { R = 255, G = 255, B = 255, A = 255 },
              ProgressColor = { R = 3, G = 169, B = 96, A = 244 },
          }, true, {
              onSliderChange = function(Index)
                SliderProgressChaine = Index
                  TriggerEvent("skinchanger:change", "chain_1", SliderProgressChaine)
              end
          })
  
          RageUI.SliderPanel(Vetement.SliderPannelChaine.Index, 0, "Variations Couleur : "..Vetement.SliderPannelChaine.Index.."", 5, {  
                    onSliderChange = function(Index)
                      Vetement.SliderPannelChaine.Index = Index
                      TriggerEvent("skinchanger:change", "chain_2", Vetement.SliderPannelChaine.Index)
                  end
              }, 1)
          end)

          RageUI.IsVisible(lunette,function()

            RageUI.SliderProgress('List des Lunette : '..SliderProgressLunette..'', SliderProgressLunette, 26, false, {
              ProgressBackgroundColor = { R = 255, G = 255, B = 255, A = 255 },
              ProgressColor = { R = 3, G = 169, B = 96, A = 244 },
          }, true, {
              onSliderChange = function(Index)
                SliderProgressLunette = Index
                  TriggerEvent("skinchanger:change", "glasses_1", SliderProgressLunette)
              end
          })
  
          RageUI.SliderPanel(Vetement.SliderPannelLunette.Index, 0, "Variations Couleur : "..Vetement.SliderPannelLunette.Index.."", 5, {  
                    onSliderChange = function(Index)
                      Vetement.SliderPannelLunette.Index = Index
                      TriggerEvent("skinchanger:change", "glasses_2", Vetement.SliderPannelLunette.Index)
                  end
              }, 1)

            end)
            RageUI.IsVisible(sac,function()

              RageUI.SliderProgress('List des Sac : '..SliderProgressSac..'', SliderProgressSac, 50, false, {
                ProgressBackgroundColor = { R = 255, G = 255, B = 255, A = 255 },
                ProgressColor = { R = 3, G = 169, B = 96, A = 244 },
            }, true, {
                onSliderChange = function(Index)
                  SliderProgressSac = Index
                    TriggerEvent("skinchanger:change", "bags_1", SliderProgressSac)
                end
            })
    
            RageUI.SliderPanel(Vetement.SliderPannelSac.Index, 0, "Variations Couleur : "..Vetement.SliderPannelSac.Index.."", 5, {  
                      onSliderChange = function(Index)
                        Vetement.SliderPannelSac.Index = Index
                        TriggerEvent("skinchanger:change", "bags_2", Vetement.SliderPannelSac.Index)
                    end
                }, 1)




          end)
        Wait(0)
      end
    end)
  end
end      

