---------------------
--    CO MAVEN     --
-- GITHUB : COKLUK --
-- S 4 L E H#4119  --
---------------------
ESX = nil
FENER = false
local a
local b
local c
local d
local e
local f = {}
Citizen.CreateThread(
    function()
        while ESX == nil do
            TriggerEvent(
                "esx:getSharedObject",
                function(g)
                    ESX = g
                end
            )
            Citizen.Wait(0)
        end
        while ESX.GetPlayerData().job == nil do
            Citizen.Wait(10)
        end
        ESX.PlayerData = ESX.GetPlayerData()
        Wait(200)
        LoadPhone()
        TriggerServerEvent("s4-phone:server:s4share", false)
    end
)
Wifi = false
WifiOpen = function()
    Wifi = not Wifi
    Citizen.CreateThread(
        function()
            while Wifi do
                local h = 2000
                if Config.BlackMarkets then
                    local i, j, k = table.unpack(GetEntityCoords(PlayerPedId()))
                    for l = 1, #Config.BlackMarkets, 1 do
                        local m, n, o = table.unpack(Config.BlackMarkets[l].coords)
                        if GetDistanceBetweenCoords(m, n, o, i, j, k, true) <= Config.BlackMarket_closeness then
                            if not d then
                                SendNUIMessage({action = "bm", state = 1})
                            end
                            d = l
                            h = 5
                        else
                            if not d then
                                SendNUIMessage({action = "bm", state = 0})
                            end
                            Wait(1000)
                            d = nil
                            Wifi = true
                            WifiOpen()
                        end
                    end
                end
                Citizen.Wait(h)
            end
        end
    )
end
Citizen.CreateThread(
    function()
        while true do
            local h = 2000
            if Config.BlackMarkets then
                local i, j, k = table.unpack(GetEntityCoords(PlayerPedId()))
                for l = 1, #Config.BlackMarkets, 1 do
                    local m, n, o = table.unpack(Config.BlackMarkets[l].coords)
                    if GetDistanceBetweenCoords(m, n, o, i, j, k, true) <= Config.BlackMarket_closeness then
                        e = l
                        h = 5
                    else
                        if not e then
                            SendNUIMessage({action = "bm", state = 0})
                        end
                        Wait(1000)
                        e = nil
                    end
                end
            end
            Citizen.Wait(h)
        end
    end
)
local p = {}
phoneProp = 0
local q = "prop_npc_phone_02"
PhoneData = {
    MetaData = {},
    isOpen = false,
    PlayerData = nil,
    Contacts = {},
    Tweets = {},
    currentTab = nil,
    MentionedTweets = {},
    Hashtags = {},
    Chats = {},
    Invoices = {},
    CallData = {},
    RecentCalls = {},
    Garage = {},
    SelfTweets = {},
    Mails = {},
    Adverts = {},
    id = 1,
    GarageVehicles = {},
    AnimationData = {lib = nil, anim = nil},
    SuggestedContacts = {},
    CryptoTransactions = {},
    Sounds = true
}
RegisterNetEvent("s4-phone:client:RaceNotify")
AddEventHandler(
    "s4-phone:client:RaceNotify",
    function(r)
        if PhoneData.isOpen then
            SendNUIMessage(
                {
                    action = "PhoneNotification",
                    PhoneNotify = {
                        title = Lang["RACE_TITLE"],
                        text = r,
                        icon = "fas fa-flag-checkered",
                        color = "#353b48",
                        timeout = 1500
                    }
                }
            )
        else
            SendNUIMessage(
                {
                    action = "Notification",
                    NotifyData = {
                        title = Lang["RACE_TITLE"],
                        content = r,
                        icon = "fas fa-flag-checkered",
                        timeout = 3500,
                        color = "#353b48"
                    }
                }
            )
        end
    end
)
local s = {x = 1694.163, y = 3293.051, z = 40.14209, h = 88.75}
local t = vector3(s.x, s.y, s.z)
Citizen.CreateThread(
    function()
        RequestModel(0x106D9A99)
        while not HasModelLoaded(0x106D9A99) do
            Wait(1)
        end
        npc = CreatePed(1, 0x106D9A99, s.x, s.y, s.z, s.h, false, true)
        SetPedCombatAttributes(npc, 46, true)
        SetPedFleeAttributes(npc, 0, 0)
        SetBlockingOfNonTemporaryEvents(npc, true)
        SetEntityAsMissionEntity(npc, true, true)
        SetEntityInvincible(npc, true)
        FreezeEntityPosition(npc, true)
        if not Config.ek_script_kullanim then
            while true do
                sleepthread = 2000
                local u = PlayerPedId()
                local v = GetEntityCoords(u)
                local w = #(v - t)
                if w <= 5.0 then
                    sleepthread = 1
                    if w <= 1.5 then
                        DrawText3D(t.x, t.y, t.z + 0.9, "[E] - Telefon hackle")
                        if IsControlJustPressed(1, 38) then
                            TriggerEvent("s4-phone:client:ctxmenu")
                            Wait(1000)
                        end
                    end
                end
                Citizen.Wait(sleepthread)
            end
        end
    end
)
local x = {x = 149.5101, y = -232.860, z = 54.424, h = 88.75}
local y = vector3(x.x, x.y, x.z)
Citizen.CreateThread(
    function()
        while true do
            sleepthread = 2000
            local u = PlayerPedId()
            local v = GetEntityCoords(u)
            local w = #(v - y)
            if w <= 5.0 then
                sleepthread = 1
                if w <= 1.5 then
                    DrawText3D(y.x, y.y, y.z + 0.9, "[E] - Telefon Satın al")
                    if IsControlJustPressed(1, 38) then
                        TriggerServerEvent("s4-phone:telver")
                        Wait(1000)
                    end
                end
            end
            Citizen.Wait(sleepthread)
        end
    end
)
function DrawText3D(z, A, B, C)
    SetTextScale(0.30, 0.30)
    SetTextFont(0)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(C)
    SetDrawOrigin(z, A, B, 0)
    DrawText(0.0, 0.0)
    local D = string.len(C) / 250
    DrawRect(0.0, 0.0 + 0.0125, 0.017 + D, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end
RegisterNetEvent("s4-phone:client:ctxmenu")
AddEventHandler(
    "s4-phone:client:ctxmenu",
    function()
        local E = {}
        ESX.TriggerServerCallback(
            "s4-phone:envtelefonlar",
            function(F)
                for l = 1, #F, 1 do
                    if F[l].name == "phone" and F[l].info.durum == "kilitli" then
                        local G = {}
                        if not F[l].info.durum then
                            F[l].info.durum = "kilitli"
                        end
                        G.label = F[l].info.telno .. " Parmak izini sil"
                        G.value = F[l].slot
                        table.insert(E, G)
                    end
                end
                telmenu(E)
            end
        )
    end
)
function telmenu(H)
    ESX.UI.Menu.CloseAll()
    ESX.UI.Menu.Open(
        "default",
        GetCurrentResourceName(),
        "ventacyc",
        {title = "Telefonlar", align = "top-right", elements = H},
        function(I, J)
            for K, L in ipairs(H) do
                if I.current.value == L.value then
                    J.close()
                    local M = PlayerPedId()
                    exports["mythic_progbar"]:Progress(
                        {
                            name = L.label,
                            duration = 3250,
                            label = L.label,
                            useWhileDead = false,
                            canCancel = true,
                            controlDisables = {
                                disableMovement = true,
                                disableCarMovement = true,
                                disableMouse = false,
                                disableCombat = true
                            }
                        },
                        function(N)
                            if not N then
                                TriggerServerEvent("s4-phone:sifrekirtelefon", L.value)
                            end
                        end
                    )
                end
            end
        end,
        function(I, J)
            J.close()
            TriggerEvent("notification", "Almaktan vazgeçtin!", 2, 2000)
        end,
        function(I, J)
        end
    )
end
RegisterNetEvent("s4-phone:client:AddRecentCall")
AddEventHandler(
    "s4-phone:client:AddRecentCall",
    function(I, O, P)
        table.insert(
            PhoneData.RecentCalls,
            {name = IsNumberInContacts(I.number), time = O, type = P, number = I.number, anonymous = I.anonymous}
        )
        TriggerServerEvent("s4-phone:server:SetPhoneAlerts", "phone")
        Config.PhoneApplications["phone"].Alerts = Config.PhoneApplications["phone"].Alerts + 1
        SendNUIMessage({action = "RefreshAppAlerts", AppData = Config.PhoneApplications})
    end
)
RegisterNUICallback(
    "GetCurrentArrests",
    function(I, Q)
        ESX.TriggerServerCallback(
            "s4-phone:server:GetCurrentArrests",
            function(R)
                Q(R)
            end
        )
    end
)
RegisterNUICallback(
    "GETEMS",
    function(I, Q)
        ESX.TriggerServerCallback(
            "s4-phone:server:GETEMS",
            function(z)
                Q(z)
            end
        )
    end
)
RegisterNUICallback(
    "GetBMarket",
    function(I, Q)
        if e then
            Q(Config.BlackMarkets[e].items)
        end
    end
)
wp = false
local S
RegisterNUICallback(
    "buybm",
    function(I, Q)
        S = I.x
        ESX.TriggerServerCallback(
            "s4-phone:server:buybm",
            function(L)
                if L then
                    wp = false
                    WayOpen()
                    SetNewWaypoint(Config.BlackMarket_delivery.x, Config.BlackMarket_delivery.y)
                else
                    wp = true
                    WayOpen()
                end
            end,
            I.price
        )
    end
)
WayOpen = function()
    wp = not wp
    Citizen.CreateThread(
        function()
            while wp do
                sleepthread = 2000
                local u = PlayerPedId()
                local v = GetEntityCoords(u)
                local w = #(v - Config.BlackMarket_delivery)
                if w <= 5.0 then
                    sleepthread = 1
                    if w <= 1.5 then
                        DrawText3D(
                            Config.BlackMarket_delivery.x,
                            Config.BlackMarket_delivery.y,
                            Config.BlackMarket_delivery.z + 0.9,
                            "[E] - Teslim al"
                        )
                        if IsControlJustPressed(1, 38) then
                            TriggerServerEvent("s4-phone:server:givebmitem", S)
                            S = nil
                            WayOpen()
                            Wait(1000)
                        end
                    end
                end
                Citizen.Wait(sleepthread)
            end
        end
    )
end
RegisterNetEvent("s4-phone:client:DosyaAl")
AddEventHandler(
    "s4-phone:client:DosyaAl",
    function(I)
        SendNUIMessage({action = "DosyaAl", veri = I})
        f = I
    end
)
RegisterNUICallback(
    "WifiSifreKontrol",
    function(I, Q)
        if e then
            if I.sifre == Config.BlackMarkets[e].WifiPass then
                Wifi = false
                WifiOpen()
            else
                Wifi = true
                WifiOpen()
            end
        else
            Wifi = true
            WifiOpen()
        end
        Q(Config.BlackMarkets[e].WifiPass)
    end
)
RegisterNUICallback(
    "DosyaKaydet",
    function(I, Q)
        if I.durum == "kaydet" then
            TriggerServerEvent("s4-phone:server:DosyaKaydet", f)
        end
        Wait(200)
        f = {}
    end
)
RegisterNUICallback(
    "DosyaGonder",
    function(I, Q)
        local T = {}
        T = {
            firstname = PhoneData.PlayerData.charinfo.firstname,
            lastname = PhoneData.PlayerData.charinfo.lastname,
            resim_url = I.resim_url,
            src = tonumber(I.src)
        }
        TriggerServerEvent("s4-phone:server:DosyaGonder", T)
    end
)
RegisterNUICallback(
    "GetCurrentWeazel",
    function(I, Q)
    end
)
RegisterNUICallback(
    "GetCurrentFoodCompany",
    function(I, Q)
        Q(Config.FoodCompany)
    end
)
RegisterNUICallback(
    "GetCurrentFoodWorker",
    function(I, Q)
    end
)
RegisterNUICallback(
    "disableControls",
    function(I)
        local U = 0
        repeat
            U = U + 1
            Citizen.Wait(1)
            SetNuiFocusKeepInput(false)
        until U >= 100
        if PhoneData.isOpen then
            SetNuiFocusKeepInput(true)
        end
    end
)
RegisterNetEvent("esx:setJob")
AddEventHandler(
    "esx:setJob",
    function(V)
        if V.name == "police" then
            SendNUIMessage({action = "UpdateApplications", JobData = V, applications = Config.PhoneApplications})
        elseif p.name == "police" and V.name == "unemployed" then
            SendNUIMessage({action = "UpdateApplications", JobData = V, applications = Config.PhoneApplications})
        end
        p = V
    end
)
RegisterNUICallback(
    "UpdateSoundStatus",
    function(I, Q)
        PhoneData.Sounds = I.sound
        Q("ok")
    end
)
RegisterNUICallback(
    "ClearRecentAlerts",
    function(I, Q)
        TriggerServerEvent("s4-phone:server:SetPhoneAlerts", "phone", 0)
        Config.PhoneApplications["phone"].Alerts = 0
        SendNUIMessage({action = "RefreshAppAlerts", AppData = Config.PhoneApplications})
    end
)
RegisterNUICallback(
    "SetBackground",
    function(I)
        local W = I.background
        TriggerServerEvent("s4-phone:server:SaveMetaData", "background", W)
    end
)
RegisterNUICallback(
    "s4share",
    function(I)
        TriggerServerEvent("s4-phone:server:s4share", I.veri)
    end
)
RegisterNUICallback(
    "s4shareGET",
    function(I, Q)
        ESX.TriggerServerCallback(
            "s4-phone:server:GetS4Share",
            function(X)
                Q(X)
            end
        )
    end
)
RegisterNUICallback(
    "UpdateAvailableStatus",
    function(I, Q)
        TriggerServerEvent("s4-phone:UpdateAvailableStatus", I.available)
        Q("ok")
    end
)
RegisterNUICallback(
    "GetMissedCalls",
    function(I, Q)
        Q(PhoneData.RecentCalls)
    end
)
RegisterNUICallback(
    "GetSuggestedContacts",
    function(I, Q)
        Q(PhoneData.SuggestedContacts)
    end
)
function IsNumberInContacts(Y)
    local Z = Y
    for _, L in pairs(PhoneData.Contacts) do
        if Y == L.number then
            Z = L.name
        end
    end
    return Z
end
local a0 = false
Citizen.CreateThread(
    function()
        while true do
            if IsControlJustPressed(0, Config.OpenPhone) then
                if not PhoneData.isOpen then
                    ESX.TriggerServerCallback(
                        "s4-phone:server:GetirVerilecekTelefon",
                        function(a1)
                            print(ESX.DumpTable(a1))
                            TriggerEvent("s4-phone:client:telefon", a1.telno, a1.aitlik, a1.durum)
                        end
                    )
                end
            end
            if PhoneData.isOpen then
                DisableControlAction(0, 24, true)
                DisableControlAction(0, 29, true)
                DisableControlAction(0, 257, true)
                DisableControlAction(0, 25, true)
                DisableControlAction(0, 263, true)
                DisableControlAction(0, 45, true)
                DisableControlAction(0, 21, true)
                DisableControlAction(0, 22, true)
                DisableControlAction(0, 44, true)
                DisableControlAction(0, 37, true)
                DisableControlAction(0, 288, true)
                DisableControlAction(0, 245, true)
                DisableControlAction(0, 289, true)
                DisableControlAction(0, 170, true)
                DisableControlAction(0, 167, true)
                DisableControlAction(0, 244, true)
                DisableControlAction(0, 303, true)
                DisableControlAction(0, 29, true)
                DisableControlAction(0, 81, true)
                DisableControlAction(0, 26, true)
                DisableControlAction(0, 73, true)
                DisableControlAction(2, 199, true)
                DisableControlAction(2, 36, true)
                DisableControlAction(0, 47, true)
                DisableControlAction(0, 264, true)
                DisableControlAction(0, 257, true)
                DisableControlAction(0, 140, true)
                DisableControlAction(0, 141, true)
                DisableControlAction(0, 142, true)
            end
            Citizen.Wait(3)
        end
    end
)
function CalculateTimeToDisplay()
    hour = GetClockHours()
    minute = GetClockMinutes()
    local g = {}
    if minute <= 9 then
        minute = "0" .. minute
    end
    g.hour = hour
    g.minute = minute
    return g
end
Citizen.CreateThread(
    function()
        while true do
            if PhoneData.isOpen then
                SendNUIMessage({action = "UpdateTime", InGameTime = CalculateTimeToDisplay()})
            end
            Citizen.Wait(1000)
        end
    end
)
Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(60000)
            if a0 then
                ESX.TriggerServerCallback(
                    "s4-phone:server:GetPhoneData",
                    function(a2)
                        if a2.PlayerContacts ~= nil and next(a2.PlayerContacts) ~= nil then
                            PhoneData.Contacts = a2.PlayerContacts
                        end
                        SendNUIMessage({action = "RefreshContacts", Contacts = PhoneData.Contacts})
                    end
                )
            end
        end
    end
)
function test()
    for a3 = 1, #PhoneData.Tweets do
        local a4 = PhoneData.Tweets[a3].message
        local a5 = a4:split("@")
        for l = 2, #a5, 1 do
            local a6 = a5[l]:split(" ")[1]
            if a6 ~= nil or a6 ~= "" then
                local a7 = a6:split("_")
                local a8 = a7[1]
                table.remove(a7, 1)
                local a9 = table.concat(a7, " ")
                if a8 ~= nil and a8 ~= "" and (a9 ~= nil and a9 ~= "") then
                    TriggerServerEvent("s4-phone:server:MentionedPlayer", a8, a9, PhoneData.Tweets[a3])
                end
            end
        end
    end
    ESX.TriggerServerCallback(
        "s4-phone:server:GetPhoneData",
        function(a2)
            if a2.MentionedTweets ~= nil and next(a2.MentionedTweets) ~= nil then
                PhoneData.MentionedTweets = a2.MentionedTweets
            end
        end
    )
end
function LoadPhone()
    Citizen.Wait(100)
    a0 = true
    ESX.TriggerServerCallback(
        "s4-phone:server:GetPhoneData",
        function(a2)
            p = ESX.GetPlayerData().job
            PhoneData.PlayerData = ESX.GetPlayerData()
            PhoneData.MetaData = {}
            PhoneData.PlayerData.charinfo = a2.charinfo ~= nil and a2.charinfo or {}
            PhoneData.PlayerData.identifier = a2.charinfo ~= nil and a2.charinfo.identifier or ""
            if PhoneData.PlayerData.charinfo.profilepicture == nil then
                PhoneData.MetaData.profilepicture = "default"
            else
                PhoneData.MetaData.profilepicture = PhoneData.PlayerData.charinfo.profilepicture
            end
            if PhoneData.PlayerData.charinfo.background ~= nil then
                PhoneData.MetaData.background = PhoneData.PlayerData.charinfo.background
            end
            if a2.Applications ~= nil and next(a2.Applications) ~= nil then
                for K, L in pairs(a2.Applications) do
                    Config.PhoneApplications[K].Alerts = L
                end
            end
            if a2.PlayerContacts ~= nil and next(a2.PlayerContacts) ~= nil then
                PhoneData.Contacts = a2.PlayerContacts
            end
            if a2.Chats ~= nil and next(a2.Chats) ~= nil then
                local aa = {}
                for K, L in pairs(a2.Chats) do
                    aa[L.number] = {
                        name = IsNumberInContacts(L.number),
                        number = L.number,
                        messages = json.decode(L.messages)
                    }
                end
                PhoneData.Chats = aa
            end
            if a2.Invoices ~= nil and next(a2.Invoices) ~= nil then
                for _, ab in pairs(a2.Invoices) do
                    ab.name = IsNumberInContacts(ab.number)
                end
                PhoneData.Invoices = a2.Invoices
            end
            if a2.Hashtags ~= nil and next(a2.Hashtags) ~= nil then
                PhoneData.Hashtags = a2.Hashtags
            end
            if a2.Tweets ~= nil then
                PhoneData.Tweets = a2.Tweets
                PhoneData.id = a2.Tweets[#a2.Tweets].id + 1
            end
            if a2.SelfTweets ~= nil then
                PhoneData.SelfTweets = a2.SelfTweets
            end
            if a2.Mails ~= nil and next(a2.Mails) ~= nil then
                PhoneData.Mails = a2.Mails
            end
            if a2.Adverts ~= nil and next(a2.Adverts) ~= nil then
                PhoneData.Adverts = a2.Adverts
            end
            if a2.CryptoTransactions ~= nil and next(a2.CryptoTransactions) ~= nil then
                PhoneData.CryptoTransactions = a2.CryptoTransactions
            end
            Citizen.Wait(300)
            SendNUIMessage(
                {
                    action = "LoadPhoneData",
                    PhoneData = PhoneData,
                    PlayerData = PhoneData.PlayerData,
                    PlayerJob = PhoneData.PlayerData.job,
                    applications = Config.PhoneApplications
                }
            )
        end,
        b
    )
    Citizen.Wait(2000)
end
RegisterNetEvent("s4-phone:client:telefon")
AddEventHandler(
    "s4-phone:client:telefon",
    function(ac, ad, ae)
        a = ac
        b = ad
        c = ae
        OpenPhone(a, b, c)
        LoadPhone()
    end
)
RegisterNUICallback(
    "HasPhone",
    function(I, Q)
        ESX.TriggerServerCallback(
            "s4-phone:server:HasPhone",
            function(af)
                Q(af)
            end
        )
    end
)
RegisterCommand(
    "telfix",
    function()
        if not PhoneData.CallData.InCall then
            DoPhoneAnimation("cellphone_text_out")
            SetTimeout(
                400,
                function()
                    StopAnimTask(PlayerPedId(), PhoneData.AnimationData.lib, PhoneData.AnimationData.anim, 2.5)
                    deletePhone()
                    PhoneData.AnimationData.lib = nil
                    PhoneData.AnimationData.anim = nil
                end
            )
        else
            PhoneData.AnimationData.lib = nil
            PhoneData.AnimationData.anim = nil
            DoPhoneAnimation("cellphone_text_to_call")
        end
        SetNuiFocus(false, false)
        SetNuiFocusKeepInput(false)
        phone = false
        SetTimeout(
            1000,
            function()
                PhoneData.isOpen = false
            end
        )
        if not PhoneData.CallData.InCall then
            DoPhoneAnimation("cellphone_text_out")
            SetTimeout(
                400,
                function()
                    StopAnimTask(PlayerPedId(), PhoneData.AnimationData.lib, PhoneData.AnimationData.anim, 2.5)
                    deletePhone()
                    PhoneData.AnimationData.lib = nil
                    PhoneData.AnimationData.anim = nil
                end
            )
        else
            PhoneData.AnimationData.lib = nil
            PhoneData.AnimationData.anim = nil
            DoPhoneAnimation("cellphone_text_to_call")
        end
        SetNuiFocus(false, false)
        SetNuiFocusKeepInput(false)
        phone = false
        SetTimeout(
            1000,
            function()
                PhoneData.isOpen = false
                SendNUIMessage({action = "close"})
            end
        )
    end
)
RegisterCommand(
    "telver",
    function(ag, ah, ai)
        TriggerServerEvent("s4-phone:telver", ag)
    end
)
local phone = false
function OpenPhone(z, A, B)
    if exports["esx_ambulancejob"]:GetDeath() == false then
        ESX.TriggerServerCallback(
            "s4-phone:server:HasPhone",
            function(af)
                if af then
                    PhoneData.isOpen = true
                    ESX.TriggerServerCallback(
                        "s4-phone:server:GetCharacterData",
                        function(aj)
                            PhoneData.PlayerData = ESX.GetPlayerData()
                            PhoneData.PlayerData.charinfo = aj ~= nil and aj or {}
                            PhoneData.PlayerData.identifier = aj ~= nil and aj.identifier or {}
                            SetNuiFocus(true, true)
                            SetNuiFocusKeepInput(true)
                            SendNUIMessage(
                                {
                                    action = "open",
                                    Tweets = PhoneData.Tweets,
                                    AppData = Config.PhoneApplications,
                                    CallData = PhoneData.CallData,
                                    PlayerData = PhoneData.PlayerData,
                                    s4meta = {tel = z, id = A, durum = B}
                                }
                            )
                            PhoneData.isOpen = true
                            if not PhoneData.CallData.InCall then
                                DoPhoneAnimation("cellphone_text_in")
                            else
                                DoPhoneAnimation("cellphone_call_to_text")
                            end
                            SetTimeout(
                                250,
                                function()
                                    newPhoneProp()
                                end
                            )
                            phone = true
                            ESX.TriggerServerCallback(
                                "s4-phone:server:GetGarageVehicles",
                                function(ak)
                                    if ak ~= nil then
                                        for K, L in pairs(ak) do
                                            ak[K].fullname = GetLabelText(GetDisplayNameFromVehicleModel(L.model))
                                        end
                                    end
                                    PhoneData.GarageVehicles = ak
                                end
                            )
                        end
                    )
                else
                    exports["mythic_notify"]:SendAlert("error", Lang("PHONE_DONT_HAVE"))
                end
            end
        )
    end
end
RegisterNUICallback(
    "SetupGarageVehicles",
    function(I, Q)
        Q(PhoneData.GarageVehicles)
    end
)
RegisterNUICallback(
    "GetirNotlar",
    function(I, Q)
        ESX.TriggerServerCallback(
            "s4-phone:server:GetNotlar",
            function(al)
                Q(al)
            end
        )
    end
)
RegisterNUICallback(
    "LoadAdverts",
    function(I, Q)
        ESX.TriggerServerCallback(
            "s4-phone:server:LoadAdverts",
            function(am)
                Q(am)
            end
        )
    end
)
RegisterNUICallback(
    "GetirinstaResimleri",
    function(I, Q)
        ESX.TriggerServerCallback(
            "s4-phone:server:GetGalerinsta",
            function(an)
                Q(an)
            end,
            I.owner
        )
    end
)
RegisterNUICallback(
    "GetirinstaProfilBilgi",
    function(I, Q)
        ESX.TriggerServerCallback(
            "s4-phone:server:GetirinstaProfilBilgi",
            function(ao)
                Q(ao)
            end,
            I.owner
        )
    end
)
RegisterNUICallback(
    "GetirGaleriResimleri",
    function(I, Q)
        ESX.TriggerServerCallback(
            "s4-phone:server:GetGaleri",
            function(ao)
                Q(ao)
            end
        )
    end
)
RegisterNUICallback(
    "GetirInstaZamanTuneli",
    function(I, Q)
        ESX.TriggerServerCallback(
            "s4-phone:server:GetirInstaZamanTuneli",
            function(an)
                Q(an)
            end
        )
    end
)
RegisterNUICallback(
    "GetirInstaZamanTuneli",
    function(I, Q)
        ESX.TriggerServerCallback(
            "s4-phone:server:GetirInstaZamanTuneli",
            function(an)
                Q(an)
            end
        )
    end
)
RegisterNUICallback(
    "InstagramHesaplari",
    function(I, Q)
        ESX.TriggerServerCallback(
            "s4-phone:server:InstagramHesaplari",
            function(ap)
                Q(ap)
            end
        )
    end
)
RegisterNUICallback(
    "TamEkranKapat",
    function(I, Q)
        SendNUIMessage({action = "TamEkranKapat"})
    end
)
RegisterNUICallback(
    "TamEkranGecis",
    function(I, Q)
        SendNUIMessage({action = "TamEkranGecis"})
    end
)
RegisterNUICallback(
    "ResimSil",
    function(I, Q)
        TriggerServerEvent("s4-phone:server:SilResim", I.resim_url)
    end
)
RegisterNUICallback(
    "ResimSilinsta",
    function(I, Q)
        TriggerServerEvent("s4-phone:server:ResimSilinsta", I.resim_url)
    end
)
RegisterNUICallback(
    "PaylasInstaPost",
    function(I, Q)
        TriggerServerEvent("s4-phone:server:PaylasInstaPost", I.eskiResim, I.eskiEfekt, I.yazi)
    end
)
RegisterNUICallback(
    "NotEkle",
    function(I, Q)
        TriggerServerEvent("s4-phone:server:NotEkle", I.baslik, I.aciklama)
    end
)
RegisterNUICallback(
    "NotSil",
    function(I, Q)
        TriggerServerEvent("s4-phone:server:NotSil", I.id)
    end
)
RegisterNUICallback(
    "NotGuncelle",
    function(I, Q)
        TriggerServerEvent("s4-phone:server:NotGuncelle", I.id, I.baslik, I.aciklama)
    end
)
RegisterNUICallback(
    "Takip_instagram",
    function(I, Q)
        TriggerServerEvent("s4-phone:server:Takip_instagram", I.takip, I.takip_edilen)
    end
)
RegisterNUICallback(
    "FotoGaleriKayit",
    function(I, Q)
        TriggerServerEvent("s4-phone:server:kaydetResim", I.resim_url)
    end
)
RegisterNUICallback(
    "biyoguncelle",
    function(I, Q)
        TriggerServerEvent("s4-phone:server:biyoguncelle", I.biyografi)
    end
)
RegisterNUICallback(
    "BildirimManager",
    function(I, Q)
        SendNUIMessage({action = "BildirimManager", bildirim = I})
    end
)
RegisterNUICallback(
    "Close",
    function()
        if not PhoneData.CallData.InCall then
            DoPhoneAnimation("cellphone_text_out")
            SetTimeout(
                400,
                function()
                    StopAnimTask(PlayerPedId(), PhoneData.AnimationData.lib, PhoneData.AnimationData.anim, 2.5)
                    deletePhone()
                    PhoneData.AnimationData.lib = nil
                    PhoneData.AnimationData.anim = nil
                end
            )
        else
            PhoneData.AnimationData.lib = nil
            PhoneData.AnimationData.anim = nil
            DoPhoneAnimation("cellphone_text_to_call")
        end
        SetNuiFocus(false, false)
        SetNuiFocusKeepInput(false)
        phone = false
        SetTimeout(
            1000,
            function()
                PhoneData.isOpen = false
            end
        )
    end
)
RegisterNUICallback(
    "RemoveMail",
    function(I, Q)
        local aq = I.mailId
        TriggerServerEvent("s4-phone:server:RemoveMail", aq)
        Q("ok")
    end
)
RegisterNetEvent("s4-phone:client:UpdateMails")
AddEventHandler(
    "s4-phone:client:UpdateMails",
    function(ar)
        SendNUIMessage({action = "UpdateMails", Mails = ar})
        PhoneData.Mails = ar
    end
)
RegisterNUICallback(
    "AcceptMailButton",
    function(I)
        TriggerEvent(I.buttonEvent, I.buttonData)
        TriggerServerEvent("s4-phone:server:ClearButtonData", I.mailId)
    end
)
RegisterNUICallback(
    "AddNewContact",
    function(I, Q)
        table.insert(PhoneData.Contacts, {name = I.ContactName, number = I.ContactNumber, iban = I.ContactIban})
        Citizen.Wait(100)
        Q(PhoneData.Contacts)
        if PhoneData.Chats[I.ContactNumber] ~= nil and next(PhoneData.Chats[I.ContactNumber]) ~= nil then
            PhoneData.Chats[I.ContactNumber].name = I.ContactName
        end
        TriggerServerEvent("s4-phone:server:AddNewContact", I.ContactName, I.ContactNumber, I.ContactIban)
    end
)
RegisterNUICallback(
    "GetMails",
    function(I, Q)
        Q(PhoneData.Mails)
    end
)
RegisterNUICallback(
    "GetWhatsappChat",
    function(I, Q)
        if PhoneData.Chats[I.phone] ~= nil then
            Q(PhoneData.Chats[I.phone])
        else
            Q(false)
        end
    end
)
RegisterNUICallback(
    "GetProfilePicture",
    function(I, Q)
        local as = I.number
        ESX.TriggerServerCallback(
            "s4-phone:server:GetPicture",
            function(at)
                Q(at)
            end,
            as
        )
    end
)
RegisterNUICallback(
    "GetBankContacts",
    function(I, Q)
        Q(PhoneData.Contacts)
    end
)
RegisterNUICallback(
    "GetBankData",
    function(I, Q)
        ESX.TriggerServerCallback("s4-phone:server:GetBankData", Q)
    end
)
RegisterNUICallback(
    "GetInvoices",
    function(I, Q)
        ESX.TriggerServerCallback(
            "s4-phone:server:GetInvoices",
            function(ao)
                Q(ao)
            end
        )
    end
)
function GetKeyByDate(au, av)
    local Z = nil
    if PhoneData.Chats[au] ~= nil then
        if PhoneData.Chats[au].messages ~= nil then
            for aw, ax in pairs(PhoneData.Chats[au].messages) do
                if ax.date == av then
                    Z = aw
                    break
                end
            end
        end
    end
    return Z
end
function GetKeyByNumber(au)
    local Z = tostring(au)
    if PhoneData.Chats then
        for K, L in pairs(PhoneData.Chats) do
            if L.number == au then
                Z = K
            end
        end
    end
    return Z
end
function ReorganizeChats(aw)
    local ay = {}
    ay[1] = PhoneData.Chats[aw]
    for K, ax in pairs(PhoneData.Chats) do
        if K ~= aw then
            table.insert(ay, ax)
        end
    end
    PhoneData.Chats = ay
end
RegisterNetEvent("S4.PHONE.C.SM")
AddEventHandler(
    "S4.PHONE.C.SM",
    function(I, az)
        mesaj_gonder(I)
    end
)
RegisterNUICallback(
    "SendMessage",
    function(I, Q)
        mesaj_gonder(I)
    end
)
function mesaj_gonder(I)
    local aA = I.ChatMessage
    local aB = I.ChatDate
    local aC = I.ChatNumber
    local aD = I.ChatTime
    local aE = I.ChatType
    local aF = PlayerPedId()
    local aG = GetEntityCoords(aF)
    local aH = GetKeyByNumber(aC)
    local aI = GetKeyByDate(aH, aB)
    if PhoneData.Chats[aH] ~= nil then
        if PhoneData.Chats[aH].messages[aI] ~= nil then
            if aE == "message" then
                table.insert(
                    PhoneData.Chats[aH].messages[aI].messages,
                    {message = aA, time = aD, sender = PhoneData.PlayerData.identifier, type = aE, data = {}}
                )
            elseif aE == "location" then
                table.insert(
                    PhoneData.Chats[aH].messages[aI].messages,
                    {
                        message = Lang("WHATSAPP_SHARED_LOCATION"),
                        time = aD,
                        sender = PhoneData.PlayerData.identifier,
                        type = aE,
                        data = {x = aG.x, y = aG.y}
                    }
                )
            elseif aE == "foto" then
                table.insert(
                    PhoneData.Chats[aH].messages[aI].messages,
                    {message = aA, time = aD, sender = PhoneData.PlayerData.identifier, type = aE, data = {}}
                )
            elseif aE == "gif" then
                table.insert(
                    PhoneData.Chats[aH].messages[aI].messages,
                    {message = aA, time = aD, sender = PhoneData.PlayerData.identifier, type = aE, data = {}}
                )
            end
            TriggerServerEvent("s4-phone:server:UpdateMessages", PhoneData.Chats[aH].messages, aC, false)
            aH = GetKeyByNumber(aC)
            ReorganizeChats(aH)
        else
            table.insert(PhoneData.Chats[aH].messages, {date = aB, messages = {}})
            aI = GetKeyByDate(aH, aB)
            if aE == "message" then
                table.insert(
                    PhoneData.Chats[aH].messages[aI].messages,
                    {message = aA, time = aD, sender = PhoneData.PlayerData.identifier, type = aE, data = {}}
                )
            elseif aE == "location" then
                table.insert(
                    PhoneData.Chats[aH].messages[aB].messages,
                    {
                        message = Lang("WHATSAPP_SHARED_LOCATION"),
                        time = aD,
                        sender = PhoneData.PlayerData.identifier,
                        type = aE,
                        data = {x = aG.x, y = aG.y}
                    }
                )
            elseif aE == "foto" then
                table.insert(
                    PhoneData.Chats[aH].messages[aI].messages,
                    {message = aA, time = aD, sender = PhoneData.PlayerData.identifier, type = aE, data = {}}
                )
            elseif aE == "gif" then
                table.insert(
                    PhoneData.Chats[aH].messages[aI].messages,
                    {message = aA, time = aD, sender = PhoneData.PlayerData.identifier, type = aE, data = {}}
                )
            end
            TriggerServerEvent("s4-phone:server:UpdateMessages", PhoneData.Chats[aH].messages, aC, true)
            aH = GetKeyByNumber(aC)
            ReorganizeChats(aH)
        end
    else
        table.insert(PhoneData.Chats, {name = IsNumberInContacts(aC), number = aC, messages = {}})
        aH = GetKeyByNumber(aC)
        table.insert(PhoneData.Chats[aH].messages, {date = aB, messages = {}})
        aI = GetKeyByDate(aH, aB)
        if aE == "message" then
            table.insert(
                PhoneData.Chats[aH].messages[aI].messages,
                {message = aA, time = aD, sender = PhoneData.PlayerData.identifier, type = aE, data = {}}
            )
        elseif aE == "location" then
            table.insert(
                PhoneData.Chats[aH].messages[aI].messages,
                {
                    message = Lang("WHATSAPP_SHARED_LOCATION"),
                    time = aD,
                    sender = PhoneData.PlayerData.identifier,
                    type = aE,
                    data = {x = aG.x, y = aG.y}
                }
            )
        end
        TriggerServerEvent("s4-phone:server:UpdateMessages", PhoneData.Chats[aH].messages, aC, true)
        aH = GetKeyByNumber(aC)
        ReorganizeChats(aH)
    end
    ESX.TriggerServerCallback(
        "s4-phone:server:GetContactPicture",
        function(aJ)
            SendNUIMessage({action = "UpdateChat", chatData = aJ, chatNumber = aC})
        end,
        PhoneData.Chats[GetKeyByNumber(aC)]
    )
end
RegisterNUICallback(
    "setwp",
    function(I)
        SetNewWaypoint(tonumber(I.x), tonumber(I.y))
    end
)
RegisterNUICallback(
    "SharedLocation",
    function(I)
        local z = I.coords.x
        local A = I.coords.y
        SetNewWaypoint(z, A)
        SendNUIMessage(
            {
                action = "PhoneNotification",
                PhoneNotify = {
                    title = Lang("WHATSAPP_TITLE"),
                    text = Lang("WHATSAPP_LOCATION_SET"),
                    icon = "fab fa-whatsapp",
                    color = "#25D366",
                    timeout = 1500
                }
            }
        )
    end
)
RegisterNetEvent("s4-phone:client:UpdateMessages")
AddEventHandler(
    "s4-phone:client:UpdateMessages",
    function(aK, aL, aM)
        local aN = IsNumberInContacts(aL)
        local aH = GetKeyByNumber(aL)
        if aM then
            PhoneData.Chats[aH] = {name = IsNumberInContacts(aL), number = aL, messages = aK}
            if PhoneData.Chats[aH].Unread ~= nil then
                PhoneData.Chats[aH].Unread = PhoneData.Chats[aH].Unread + 1
            else
                PhoneData.Chats[aH].Unread = 1
            end
            if PhoneData.isOpen then
                if aL ~= PhoneData.PlayerData.charinfo.phone then
                    SendNUIMessage(
                        {
                            action = "PhoneNotification",
                            PhoneNotify = {
                                title = Lang("WHATSAPP_TITLE"),
                                text = Lang("WHATSAPP_NEW_MESSAGE") .. " " .. IsNumberInContacts(aL) .. "!",
                                icon = "fab fa-whatsapp",
                                color = "#25D366",
                                timeout = 1500
                            }
                        }
                    )
                else
                    SendNUIMessage(
                        {
                            action = "PhoneNotification",
                            PhoneNotify = {
                                title = Lang("WHATSAPP_TITLE"),
                                text = Lang("WHATSAPP_MESSAGE_TOYOU"),
                                icon = "fab fa-whatsapp",
                                color = "#25D366",
                                timeout = 4000
                            }
                        }
                    )
                end
                aH = GetKeyByNumber(aL)
                ReorganizeChats(aH)
                Wait(100)
                print("updatechats new")
                ESX.TriggerServerCallback(
                    "s4-phone:server:GetContactPictures",
                    function(aa)
                        SendNUIMessage(
                            {action = "UpdateChat", chatData = aa[GetKeyByNumber(aL)], chatNumber = aL, Chats = aa}
                        )
                    end,
                    PhoneData.Chats
                )
            else
                SendNUIMessage(
                    {
                        action = "Notification",
                        NotifyData = {
                            title = Lang("TWITTER_TITLE"),
                            content = Lang("WHATSAPP_NEW_MESSAGE") .. " " .. IsNumberInContacts(aL) .. "!",
                            icon = "fab fa-whatsapp",
                            timeout = 3500,
                            color = "#25D366"
                        }
                    }
                )
                Config.PhoneApplications["whatsapp"].Alerts = Config.PhoneApplications["whatsapp"].Alerts + 1
                TriggerServerEvent("s4-phone:server:SetPhoneAlerts", "whatsapp")
            end
        else
            PhoneData.Chats[aH].messages = aK
            if PhoneData.Chats[aH].Unread ~= nil then
                PhoneData.Chats[aH].Unread = PhoneData.Chats[aH].Unread + 1
            else
                PhoneData.Chats[aH].Unread = 1
            end
            if PhoneData.isOpen then
                if aL ~= PhoneData.PlayerData.charinfo.phone then
                    SendNUIMessage(
                        {
                            action = "PhoneNotification",
                            PhoneNotify = {
                                title = Lang("WHATSAPP_TITLE"),
                                text = Lang("WHATSAPP_NEW_MESSAGE") .. " " .. IsNumberInContacts(aL) .. "!",
                                icon = "fab fa-whatsapp",
                                color = "#25D366",
                                timeout = 1500
                            }
                        }
                    )
                else
                    SendNUIMessage(
                        {
                            action = "PhoneNotification",
                            PhoneNotify = {
                                title = Lang("WHATSAPP_TITLE"),
                                text = Lang("WHATSAPP_MESSAGE_TOYOU"),
                                icon = "fab fa-whatsapp",
                                color = "#25D366",
                                timeout = 4000
                            }
                        }
                    )
                end
                aH = GetKeyByNumber(aL)
                ReorganizeChats(aH)
                Wait(100)
                print("updatechats old")
                ESX.TriggerServerCallback(
                    "s4-phone:server:GetContactPictures",
                    function(aa)
                        SendNUIMessage(
                            {action = "UpdateChat", chatData = aa[GetKeyByNumber(aL)], chatNumber = aL, Chats = aa}
                        )
                    end,
                    PhoneData.Chats
                )
            else
                SendNUIMessage(
                    {
                        action = "Notification",
                        NotifyData = {
                            title = "Whatsapp",
                            content = Lang("WHATSAPP_NEW_MESSAGE") .. " " .. IsNumberInContacts(aL) .. "!",
                            icon = "fab fa-whatsapp",
                            timeout = 3500,
                            color = "#25D366"
                        }
                    }
                )
                aH = GetKeyByNumber(aL)
                ReorganizeChats(aH)
                Config.PhoneApplications["whatsapp"].Alerts = Config.PhoneApplications["whatsapp"].Alerts + 1
                TriggerServerEvent("s4-phone:server:SetPhoneAlerts", "whatsapp")
            end
        end
    end
)
RegisterNetEvent("s4-phone:client:BankNotify")
AddEventHandler(
    "s4-phone:client:BankNotify",
    function(C)
        SendNUIMessage(
            {
                action = "Notification",
                NotifyData = {
                    title = Lang("BANK_TITLE"),
                    content = C,
                    icon = "fas fa-university",
                    timeout = 3500,
                    color = "#ff002f"
                }
            }
        )
    end
)
RegisterNetEvent("s4-phone:client:NewMailNotify")
AddEventHandler(
    "s4-phone:client:NewMailNotify",
    function(aO)
        if PhoneData.isOpen then
            SendNUIMessage(
                {
                    action = "PhoneNotification",
                    PhoneNotify = {
                        title = Lang("MAIL_TITLE"),
                        text = Lang("MAIL_NEW") .. " " .. aO.sender,
                        icon = "fas fa-envelope",
                        color = "#ff002f",
                        timeout = 1500
                    }
                }
            )
        else
            SendNUIMessage(
                {
                    action = "Notification",
                    NotifyData = {
                        title = Lang("MAIL_TITLE"),
                        content = Lang("MAIL_NEW") .. " " .. aO.sender,
                        icon = "fas fa-envelope",
                        timeout = 3500,
                        color = "#ff002f"
                    }
                }
            )
        end
        Config.PhoneApplications["mail"].Alerts = Config.PhoneApplications["mail"].Alerts + 1
        TriggerServerEvent("s4-phone:server:SetPhoneAlerts", "mail")
    end
)
RegisterNUICallback(
    "PostAdvert",
    function(I)
        TriggerServerEvent("s4-phone:server:AddAdvert", I.message, I.cekilmis_foto)
    end
)
RegisterNetEvent("s4-phone:client:UpdateAdverts")
AddEventHandler(
    "s4-phone:client:UpdateAdverts",
    function(am, aP)
        PhoneData.Adverts = am
        if PhoneData.isOpen then
            SendNUIMessage(
                {
                    action = "PhoneNotification",
                    PhoneNotify = {
                        title = Lang("ADVERTISEMENT_TITLE"),
                        text = Lang("ADVERTISEMENT_NEW") .. " " .. aP,
                        icon = "fas fa-ad",
                        color = "#ff8f1a",
                        timeout = 2500
                    }
                }
            )
        else
            SendNUIMessage(
                {
                    action = "Notification",
                    NotifyData = {
                        title = Lang("ADVERTISEMENT_TITLE"),
                        content = Lang("ADVERTISEMENT_NEW") .. " " .. aP,
                        icon = "fas fa-ad",
                        timeout = 2500,
                        color = "#ff8f1a"
                    }
                }
            )
        end
        SendNUIMessage({action = "RefreshAdverts", Adverts = PhoneData.Adverts})
    end
)
RegisterNUICallback(
    "ClearAlerts",
    function(I, Q)
        local ax = I.number
        local aI = GetKeyByNumber(ax)
        if PhoneData.Chats[aI].Unread ~= nil then
            local aQ = Config.PhoneApplications["whatsapp"].Alerts - PhoneData.Chats[aI].Unread
            Config.PhoneApplications["whatsapp"].Alerts = aQ
            TriggerServerEvent("s4-phone:server:SetPhoneAlerts", "whatsapp", aQ)
            PhoneData.Chats[aI].Unread = 0
            SendNUIMessage({action = "RefreshWhatsappAlerts", Chats = PhoneData.Chats})
            SendNUIMessage({action = "RefreshAppAlerts", AppData = Config.PhoneApplications})
        end
    end
)
RegisterNUICallback(
    "PayInvoice",
    function(I, Q)
        local aR = I.sender
        local aS = I.amount
        TriggerServerEvent("s4-phone:server:PayBilling", I.invoiceId)
        Q(true)
    end
)
function PayInvoice(Q, aT)
    Q(true)
    ESX.TriggerServerCallback(
        "esx_billing:payBill",
        function()
            ESX.TriggerServerCallback(
                "s4-phone:server:GetInvoices",
                function(aU)
                    PhoneData.Invoices = aU
                end
            )
        end,
        aT
    )
end
RegisterNUICallback(
    "DeclineInvoice",
    function(I, Q)
        local aR = I.sender
        local aS = I.amount
        local aT = I.invoiceId
        ESX.TriggerServerCallback(
            "s4-phone:server:DeclineInvoice",
            function(aV, aU)
                PhoneData.Invoices = aU
                Q("ok")
            end,
            aR,
            aS,
            aT
        )
    end
)
RegisterNUICallback(
    "EditContact",
    function(I, Q)
        local aW = I.CurrentContactName
        local aX = I.CurrentContactNumber
        local aY = I.CurrentContactIban
        local aZ = I.OldContactName
        local a_ = I.OldContactNumber
        local b0 = I.OldContactIban
        for K, L in pairs(PhoneData.Contacts) do
            if L.name == aZ and L.number == a_ then
                L.name = aW
                L.number = aX
                L.iban = aY
            end
        end
        if PhoneData.Chats[aX] ~= nil and next(PhoneData.Chats[aX]) ~= nil then
            PhoneData.Chats[aX].name = aW
        end
        Citizen.Wait(100)
        Q(PhoneData.Contacts)
        TriggerServerEvent("s4-phone:server:EditContact", aW, aX, aY, aZ, a_, b0)
    end
)
function GenerateTweetId()
    local b1 = "TWEET-" .. math.random(11111111, 99999999)
    return b1
end
RegisterNetEvent("s4-phone:client:UpdateHashtags")
AddEventHandler(
    "s4-phone:client:UpdateHashtags",
    function(a6, b2)
        if PhoneData.Hashtags[a6] ~= nil then
            table.insert(PhoneData.Hashtags[a6].messages, b2)
        else
            PhoneData.Hashtags[a6] = {hashtag = a6, messages = {}}
            table.insert(PhoneData.Hashtags[a6].messages, b2)
        end
        SendNUIMessage({action = "UpdateHashtags", Hashtags = PhoneData.Hashtags})
    end
)
RegisterNUICallback(
    "GetHashtagMessages",
    function(I, Q)
        if PhoneData.Hashtags[I.hashtag] ~= nil and next(PhoneData.Hashtags[I.hashtag]) ~= nil then
            Q(PhoneData.Hashtags[I.hashtag])
        else
            Q(nil)
        end
    end
)
local function b3(b4, b5)
    local b6 = nil
    for l, L in ipairs(b4) do
        if L.id == b5 then
            b6 = l
        end
    end
    return b6
end
exports(
    "isphoneopened",
    function()
        return phone
    end
)
RegisterNUICallback(
    "isInHomePage",
    function(I, Q)
    end
)
RegisterNUICallback(
    "DeleteTweet",
    function(I, Q)
        TriggerServerEvent("s4-phone:deleteTweet", I.id)
        local b7 = b3(PhoneData.SelfTweets, I.id)
        local b8 = b3(PhoneData.Tweets, I.id)
        table.remove(PhoneData.SelfTweets, b7)
        table.remove(PhoneData.Tweets, b8)
        TriggerServerEvent("s4-phone:server:updateForEveryone", PhoneData.Tweets)
    end
)
RegisterNUICallback(
    "GetTweets",
    function(I, Q)
        Q(PhoneData.Tweets)
    end
)
RegisterNUICallback(
    "GetSelfTweets",
    function(I, Q)
        Q(PhoneData.SelfTweets)
    end
)
RegisterNUICallback(
    "UpdateProfilePicture",
    function(I)
        local b9 = I.profilepicture
        TriggerServerEvent("s4-phone:server:SaveMetaData", "profilepicture", b9)
    end
)
local test
local ba = "[?!@#]"
RegisterNetEvent("s4-phone:updateForEveryone")
AddEventHandler(
    "s4-phone:updateForEveryone",
    function(bb)
        PhoneData.Tweets = bb
    end
)
RegisterNetEvent("s4-phone:updateidForEveryone")
AddEventHandler(
    "s4-phone:updateidForEveryone",
    function()
        PhoneData.id = PhoneData.id + 1
    end
)
RegisterNUICallback(
    "PostNewTweet",
    function(I, Q)
        local bc = {
            firstName = PhoneData.PlayerData.charinfo.firstname,
            lastName = PhoneData.PlayerData.charinfo.lastname,
            message = I.Message,
            url = I.Foto,
            time = I.Date,
            id = PhoneData.id,
            picture = I.Picture
        }
        if not I.Foto then
            bc.url = ""
        end
        test = ""
        TriggerServerEvent(
            "s4-phone:saveTwitterToDatabase",
            bc.firstName,
            bc.lastName,
            bc.message,
            bc.url,
            bc.time,
            bc.picture
        )
        TriggerServerEvent("s4-phone:server:updateidForEveryone")
        local a4 = I.Message
        local a5 = a4:split("@")
        local bd = a4:split("#")
        for l = 2, #bd, 1 do
            local a6 = bd[l]:split(" ")[1]
            if a6 ~= nil or a6 ~= "" then
                local be = string.match(a6, ba)
                if be then
                    a6 = a6:gsub("%" .. be, "")
                end
                TriggerServerEvent("s4-phone:server:UpdateHashtags", a6, bc)
            end
        end
        for l = 2, #a5, 1 do
            local a6 = a5[l]:split(" ")[1]
            if a6 ~= nil or a6 ~= "" then
                local a7 = a6:split("_")
                local a8 = a7[1]
                table.remove(a7, 1)
                local a9 = table.concat(a7, " ")
                if a8 ~= nil and a8 ~= "" and (a9 ~= nil and a9 ~= "") then
                    if a8 ~= PhoneData.PlayerData.charinfo.firstname and a9 ~= PhoneData.PlayerData.charinfo.lastname then
                        TriggerServerEvent("s4-phone:server:MentionedPlayer", a8, a9, bc)
                    else
                        SetTimeout(
                            2500,
                            function()
                                SendNUIMessage(
                                    {
                                        action = "PhoneNotification",
                                        PhoneNotify = {
                                            title = Lang("TWITTER_TITLE"),
                                            text = Lang("MENTION_YOURSELF"),
                                            icon = "fab fa-twitter",
                                            color = "#1DA1F2"
                                        }
                                    }
                                )
                            end
                        )
                    end
                end
            end
        end
        Citizen.Wait(1000)
        table.insert(PhoneData.Tweets, bc)
        table.insert(PhoneData.SelfTweets, bc)
        TriggerServerEvent("s4-phone:server:updateForEveryone", PhoneData.Tweets)
        Q(PhoneData.Tweets)
        TriggerServerEvent("s4-phone:server:UpdateTweets", bc)
        SendNUIMessage({action = "updateTest", selftTweets = PhoneData.SelfTweets})
    end
)
local bf = false
RegisterNUICallback(
    "PostNewImage",
    function(I, Q)
        SetNuiFocus(false, false)
        SetNuiFocusKeepInput(false)
        CreateMobilePhone(1)
        CellCamActivate(true, true)
        bf = true
        while bf do
            Citizen.Wait(0)
            if IsControlJustPressed(1, 27) then
                frontCam = not frontCam
                CellFrontCamActivate(frontCam)
            else
                if IsControlJustPressed(1, 176) then
                    exports["screenshot-basic"]:requestScreenshotUpload(
                        "https://discord.com/api/webhooks/839844465241358388/Hr2Ylj4dJmq6PopDq06CshMoT2H0bzpr0z0CYOU5jpE-r95hXCGdTtawt4bHRa0yHv8F",
                        "files[]",
                        function(bg)
                            DestroyMobilePhone()
                            CellCamActivate(false, false)
                            Wait(1000)
                            local bh = json.decode(bg)
                            test = bh.attachments[1].proxy_url
                            Q(bh.attachments[1].proxy_url)
                        end
                    )
                    Wait(1000)
                    DestroyMobilePhone()
                    bf = false
                end
            end
        end
        OpenPhone(a, b, c)
    end
)
RegisterNetEvent("s4-phone:client:TransferMoney")
AddEventHandler(
    "s4-phone:client:TransferMoney",
    function(aS, bi)
        if PhoneData.isOpen then
            SendNUIMessage({action = "UpdateBank", NewBalance = bi})
        end
    end
)
RegisterNetEvent("s4-phone:client:UpdateTweets")
AddEventHandler(
    "s4-phone:client:UpdateTweets",
    function(bj, bk)
        if not PhoneData.isOpen then
            SendNUIMessage(
                {
                    action = "Notification",
                    NotifyData = {
                        title = Lang("") .. " @" .. bk.firstName .. " " .. bk.lastName .. "",
                        content = bk.message,
                        icon = "fab fa-twitter",
                        timeout = 3500,
                        color = "#2E6FC7"
                    }
                }
            )
        else
            SendNUIMessage(
                {
                    action = "PhoneNotification",
                    PhoneNotify = {
                        title = Lang("") .. " @" .. bk.firstName .. " " .. bk.lastName .. "",
                        text = bk.message,
                        icon = "fab fa-twitter",
                        color = "#2E6FC7"
                    }
                }
            )
        end
    end
)
RegisterNUICallback(
    "GetMentionedTweets",
    function(I, Q)
        Q(PhoneData.MentionedTweets)
    end
)
RegisterNUICallback(
    "GetHashtags",
    function(I, Q)
        if PhoneData.Hashtags ~= nil and next(PhoneData.Hashtags) ~= nil then
            Q(PhoneData.Hashtags)
        else
            Q(nil)
        end
    end
)
RegisterNetEvent("s4-phone:client:GetMentioned")
AddEventHandler(
    "s4-phone:client:GetMentioned",
    function(bc, bl)
        Config.PhoneApplications["twitter"].Alerts = bl
        if not PhoneData.isOpen then
            SendNUIMessage(
                {
                    action = "Notification",
                    NotifyData = {
                        title = Lang("TWITTER_GETMENTIONED"),
                        content = bc.message,
                        icon = "fab fa-twitter",
                        timeout = 3500,
                        color = nil
                    }
                }
            )
        else
            SendNUIMessage(
                {
                    action = "PhoneNotification",
                    PhoneNotify = {
                        title = Lang("TWITTER_GETMENTIONED"),
                        text = bc.message,
                        icon = "fab fa-twitter",
                        color = "#1DA1F2"
                    }
                }
            )
        end
        local bc = {
            firstName = bc.firstName,
            lastName = bc.lastName,
            message = bc.message,
            time = bc.time,
            picture = bc.picture
        }
        table.insert(PhoneData.MentionedTweets, bc)
        SendNUIMessage({action = "RefreshAppAlerts", AppData = Config.PhoneApplications})
        SendNUIMessage({action = "UpdateMentionedTweets", Tweets = PhoneData.MentionedTweets})
    end
)
RegisterNUICallback(
    "ClearMentions",
    function()
        Config.PhoneApplications["twitter"].Alerts = 0
        SendNUIMessage({action = "RefreshAppAlerts", AppData = Config.PhoneApplications})
        TriggerServerEvent("s4-phone:server:SetPhoneAlerts", "twitter", 0)
        SendNUIMessage({action = "RefreshAppAlerts", AppData = Config.PhoneApplications})
    end
)
RegisterNUICallback(
    "ClearGeneralAlerts",
    function(I)
        SetTimeout(
            400,
            function()
                Config.PhoneApplications[I.app].Alerts = 0
                SendNUIMessage({action = "RefreshAppAlerts", AppData = Config.PhoneApplications})
                TriggerServerEvent("s4-phone:server:SetPhoneAlerts", I.app, 0)
                SendNUIMessage({action = "RefreshAppAlerts", AppData = Config.PhoneApplications})
            end
        )
    end
)
function string:split(bm)
    local bn = {}
    local bo = 1
    local bp, bq = string.find(self, bm, bo)
    while bp do
        table.insert(bn, string.sub(self, bo, bp - 1))
        bo = bq + 1
        bp, bq = string.find(self, bm, bo)
    end
    table.insert(bn, string.sub(self, bo))
    return bn
end
RegisterNUICallback(
    "TransferMoney",
    function(I, br)
        local Q = br
        local aS = tonumber(I.amount)
        ESX.TriggerServerCallback(
            "s4-phone:server:GetBankData",
            function(bs)
                if tonumber(bs.bank) >= aS then
                    local bt = tonumber(bs.bank) - aS
                    TriggerServerEvent("s4-phone:server:TransferMoney", I.iban, aS)
                    local bu = {CanTransfer = true, NewAmount = bt}
                    Q(bu)
                else
                    local bu = {CanTransfer = false, NewAmount = nil}
                    Q(bu)
                end
            end
        )
    end
)
RegisterNUICallback(
    "GetWhatsappChats",
    function(I, Q)
        ESX.TriggerServerCallback(
            "s4-phone:server:GetContactPictures",
            function(aa)
                Q(aa)
            end,
            PhoneData.Chats
        )
    end
)
RegisterNUICallback(
    "CallContact",
    function(I, Q)
        ESX.TriggerServerCallback(
            "s4-phone:server:GetCallState",
            function(bv, bw, bx)
                local by = {
                    CanCall = bv,
                    IsOnline = bw,
                    InCall = PhoneData.CallData.InCall,
                    IsAvailable = bx,
                    image = I.ContactData.image
                }
                Q(by)
                if bv and not by.InCall and I.ContactData.number ~= PhoneData.PlayerData.charinfo.phone and not bx then
                    CallContact(I.ContactData, I.Anonymous)
                end
            end,
            I.ContactData
        )
    end
)
function GenerateCallId(bz, bA)
    local bB = math.ceil((tonumber(bz) + tonumber(bA)) / 100 * 1)
    return bB
end
CallContact = function(bC, bD)
    local bE = 0
    PhoneData.CallData.CallType = "outgoing"
    PhoneData.CallData.InCall = true
    PhoneData.CallData.TargetData = bC
    PhoneData.CallData.AnsweredCall = false
    PhoneData.CallData.CallId = GenerateCallId(PhoneData.PlayerData.charinfo.phone, bC.number)
    TriggerServerEvent("s4-phone:server:CallContact", PhoneData.CallData.TargetData, PhoneData.CallData.CallId, bD)
    TriggerServerEvent("s4-phone:server:SetCallState", true)
    for l = 1, Config.CallRepeats + 1, 1 do
        if not PhoneData.CallData.AnsweredCall then
            if bE + 1 ~= Config.CallRepeats + 1 then
                if PhoneData.CallData.InCall then
                    bE = bE + 1
                    TriggerServerEvent("InteractSound_SV:PlayOnSource", "demo", 0.1)
                else
                    break
                end
                Citizen.Wait(Config.RepeatTimeout)
            else
                CancelCall()
                break
            end
        else
            break
        end
    end
end
CancelCall = function()
    TriggerServerEvent("s4-phone:server:CancelCall", PhoneData.CallData, GetPlayerServerId(PlayerId()))
    TriggerServerEvent("s4:CancelCall", GetPlayerServerId(PlayerId()), PhoneData.CallData)
    if PhoneData.CallData.CallType == "ongoing" then
        if Config.Tokovoip then
        else
        end
    end
    PhoneData.CallData.CallType = nil
    PhoneData.CallData.InCall = false
    PhoneData.CallData.AnsweredCall = false
    PhoneData.CallData.TargetData = {}
    PhoneData.CallData.CallId = nil
    if not PhoneData.isOpen then
        StopAnimTask(PlayerPedId(), PhoneData.AnimationData.lib, PhoneData.AnimationData.anim, 2.5)
        deletePhone()
        PhoneData.AnimationData.lib = nil
        PhoneData.AnimationData.anim = nil
    else
        PhoneData.AnimationData.lib = nil
        PhoneData.AnimationData.anim = nil
    end
    TriggerServerEvent("s4-phone:server:SetCallState", false)
    if not PhoneData.isOpen then
        SendNUIMessage(
            {
                action = "Notification",
                NotifyData = {
                    title = Lang("PHONE_TITLE"),
                    content = Lang("PHONE_CALL_END"),
                    icon = "fas fa-phone-volume",
                    timeout = 3500,
                    color = "#e84118"
                }
            }
        )
    else
        SendNUIMessage(
            {
                action = "PhoneNotification",
                PhoneNotify = {
                    title = Lang("PHONE_TITLE"),
                    text = Lang("PHONE_CALL_END"),
                    icon = "fas fa-phone-volume",
                    color = "#e84118"
                }
            }
        )
        SendNUIMessage({action = "SetupHomeCall", CallData = PhoneData.CallData})
        SendNUIMessage({action = "CancelOutgoingCall"})
    end
end
RegisterNetEvent("s4-phone:client:CancelCall")
AddEventHandler(
    "s4-phone:client:CancelCall",
    function()
        if PhoneData.CallData.CallType == "ongoing" then
            SendNUIMessage({action = "CancelOngoingCall"})
            if Config.Tokovoip then
            else
            end
        end
        PhoneData.CallData.CallType = nil
        PhoneData.CallData.InCall = false
        PhoneData.CallData.AnsweredCall = false
        PhoneData.CallData.TargetData = {}
        if not PhoneData.isOpen then
            StopAnimTask(PlayerPedId(), PhoneData.AnimationData.lib, PhoneData.AnimationData.anim, 2.5)
            deletePhone()
            PhoneData.AnimationData.lib = nil
            PhoneData.AnimationData.anim = nil
        else
            PhoneData.AnimationData.lib = nil
            PhoneData.AnimationData.anim = nil
        end
        TriggerServerEvent("s4-phone:server:SetCallState", false)
        if not PhoneData.isOpen then
            SendNUIMessage(
                {
                    action = "Notification",
                    NotifyData = {
                        title = Lang("PHONE_TITLE"),
                        content = Lang("PHONE_CALL_END"),
                        icon = "fas fa-phone-volume",
                        timeout = 3500,
                        color = "#e84118"
                    }
                }
            )
        else
            SendNUIMessage(
                {
                    action = "PhoneNotification",
                    PhoneNotify = {
                        title = Lang("PHONE_TITLE"),
                        text = Lang("PHONE_CALL_END"),
                        icon = "fas fa-phone-volume",
                        color = "#e84118"
                    }
                }
            )
            SendNUIMessage({action = "SetupHomeCall", CallData = PhoneData.CallData})
            SendNUIMessage({action = "CancelOutgoingCall"})
        end
    end
)
RegisterNetEvent("s4-phone:client:GetCalled")
AddEventHandler(
    "s4-phone:client:GetCalled",
    function(bF, bB, bD)
        local bE = 0
        local bC = {number = bF, name = IsNumberInContacts(bF), anonymous = bD}
        if bD then
            bC.name = "Gizli Numara"
        end
        PhoneData.CallData.CallType = "incoming"
        PhoneData.CallData.InCall = true
        PhoneData.CallData.AnsweredCall = false
        PhoneData.CallData.TargetData = bC
        PhoneData.CallData.CallId = bB
        TriggerServerEvent("s4-phone:server:SetCallState", true)
        SendNUIMessage({action = "SetupHomeCall", CallData = PhoneData.CallData})
        for l = 1, Config.CallRepeats + 1, 1 do
            if not PhoneData.CallData.AnsweredCall then
                if bE + 1 ~= Config.CallRepeats + 1 then
                    if PhoneData.CallData.InCall then
                        bE = bE + 1
                        if PhoneData.Sounds then
                            TriggerServerEvent("InteractSound_SV:PlayOnSource", "ringing", 0.2)
                        end
                        if not PhoneData.isOpen then
                            SendNUIMessage(
                                {
                                    action = "IncomingCallAlert",
                                    CallData = PhoneData.CallData.TargetData,
                                    Canceled = false,
                                    AnonymousCall = bD
                                }
                            )
                        end
                    else
                        SendNUIMessage(
                            {
                                action = "IncomingCallAlert",
                                CallData = PhoneData.CallData.TargetData,
                                Canceled = true,
                                AnonymousCall = bD
                            }
                        )
                        TriggerServerEvent("s4-phone:server:AddRecentCall", "missed", bC)
                        break
                    end
                    Citizen.Wait(Config.RepeatTimeout)
                else
                    SendNUIMessage(
                        {
                            action = "IncomingCallAlert",
                            CallData = PhoneData.CallData.TargetData,
                            Canceled = true,
                            AnonymousCall = bD
                        }
                    )
                    TriggerServerEvent("s4-phone:server:AddRecentCall", "missed", bC)
                    break
                end
            else
                TriggerServerEvent("s4-phone:server:AddRecentCall", "missed", bC)
                break
            end
        end
    end
)
RegisterNUICallback(
    "CancelOutgoingCall",
    function()
        CancelCall()
    end
)
RegisterNUICallback(
    "RehberVeriEkle",
    function(I)
    end
)
RegisterNUICallback(
    "DenyIncomingCall",
    function()
        CancelCall()
    end
)
RegisterNUICallback(
    "CancelOngoingCall",
    function()
        CancelCall()
    end
)
RegisterNUICallback(
    "AnswerCall",
    function()
        AnswerCall()
    end
)
function AnswerCall()
    if
        (PhoneData.CallData.CallType == "incoming" or PhoneData.CallData.CallType == "outgoing") and
            PhoneData.CallData.InCall and
            not PhoneData.CallData.AnsweredCall
     then
        PhoneData.CallData.CallType = "ongoing"
        PhoneData.CallData.AnsweredCall = true
        PhoneData.CallData.CallTime = 0
        SendNUIMessage({action = "AnswerCall", CallData = PhoneData.CallData})
        SendNUIMessage({action = "SetupHomeCall", CallData = PhoneData.CallData})
        TriggerServerEvent("s4-phone:server:SetCallState", true)
        if PhoneData.isOpen then
            DoPhoneAnimation("cellphone_text_to_call")
        else
            DoPhoneAnimation("cellphone_call_listen_base")
        end
        Citizen.CreateThread(
            function()
                while true do
                    if PhoneData.CallData.AnsweredCall then
                        PhoneData.CallData.CallTime = PhoneData.CallData.CallTime + 1
                        SendNUIMessage(
                            {
                                action = "UpdateCallTime",
                                Time = PhoneData.CallData.CallTime,
                                Name = PhoneData.CallData.TargetData.name
                            }
                        )
                    else
                        break
                    end
                    Citizen.Wait(1000)
                end
            end
        )
        TriggerServerEvent("s4-phone:server:AnswerCall", PhoneData.CallData, GetPlayerServerId(PlayerId()))
        TriggerServerEvent("s4:AnswerCall", GetPlayerServerId(PlayerId()), PhoneData.CallData)
        if Config.Tokovoip then
        else
        end
    else
        PhoneData.CallData.InCall = false
        PhoneData.CallData.CallType = nil
        PhoneData.CallData.AnsweredCall = false
        SendNUIMessage(
            {
                action = "PhoneNotification",
                PhoneNotify = {
                    title = Lang("PHONE_TITLE"),
                    text = Lang("PHONE_NOINCOMING"),
                    icon = "fas fa-phone-volume",
                    color = "#e84118"
                }
            }
        )
    end
end
RegisterNetEvent("s4-phone:client:AnswerCall")
AddEventHandler(
    "s4-phone:client:AnswerCall",
    function()
        if
            (PhoneData.CallData.CallType == "incoming" or PhoneData.CallData.CallType == "outgoing") and
                PhoneData.CallData.InCall and
                not PhoneData.CallData.AnsweredCall
         then
            PhoneData.CallData.CallType = "ongoing"
            PhoneData.CallData.AnsweredCall = true
            PhoneData.CallData.CallTime = 0
            SendNUIMessage({action = "AnswerCall", CallData = PhoneData.CallData})
            SendNUIMessage({action = "SetupHomeCall", CallData = PhoneData.CallData})
            TriggerServerEvent("s4-phone:server:SetCallState", true)
            if PhoneData.isOpen then
                DoPhoneAnimation("cellphone_text_to_call")
            else
                DoPhoneAnimation("cellphone_call_listen_base")
            end
            Citizen.CreateThread(
                function()
                    while true do
                        if PhoneData.CallData.AnsweredCall then
                            PhoneData.CallData.CallTime = PhoneData.CallData.CallTime + 1
                            SendNUIMessage(
                                {
                                    action = "UpdateCallTime",
                                    Time = PhoneData.CallData.CallTime,
                                    Name = PhoneData.CallData.TargetData.name
                                }
                            )
                        else
                            break
                        end
                        Citizen.Wait(1000)
                    end
                end
            )
            if Config.Tokovoip then
            else
            end
        else
            PhoneData.CallData.InCall = false
            PhoneData.CallData.CallType = nil
            PhoneData.CallData.AnsweredCall = false
            SendNUIMessage(
                {
                    action = "PhoneNotification",
                    PhoneNotify = {
                        title = Lang("PHONE_TITLE"),
                        text = Lang("PHONE_NOINCOMING"),
                        icon = "fas fa-phone-volume",
                        color = "#e84118"
                    }
                }
            )
        end
    end
)
AddEventHandler(
    "onResourceStop",
    function(bG)
        if bG == GetCurrentResourceName() then
            SetNuiFocus(false, false)
            SetNuiFocusKeepInput(false)
        end
    end
)
RegisterNUICallback(
    "FetchSearchResults",
    function(I, Q)
        ESX.TriggerServerCallback(
            "s4-phone:server:FetchResult",
            function(bn)
                Q(bn)
            end,
            I.input
        )
    end
)
RegisterNUICallback(
    "FetchVehicleResults",
    function(I, Q)
        ESX.TriggerServerCallback(
            "s4-phone:server:GetVehicleSearchResults",
            function(bn)
                if bn ~= nil then
                    for K, L in pairs(bn) do
                        bn[K].isFlagged = false
                    end
                end
                Q(bn)
            end,
            I.input
        )
    end
)
RegisterNUICallback(
    "FetchVehicleScan",
    function(I, Q)
        local bH = ESX.Game.GetClosestVehicle()
        local bI = GetVehicleNumberPlateText(bH)
        local bJ = GetEntityModel(bH)
        ESX.TriggerServerCallback(
            "s4-phone:server:ScanPlate",
            function(bn)
                bn.isFlagged = false
                bn.label = bJ
                Q(bn)
            end,
            bI
        )
    end
)
RegisterNetEvent("s4-phone:client:addPoliceAlert")
AddEventHandler(
    "s4-phone:client:addPoliceAlert",
    function(bK)
        if p.name == "police" then
            SendNUIMessage({action = "AddPoliceAlert", alert = bK})
        end
    end
)
RegisterNUICallback(
    "SetAlertWaypoint",
    function(I)
        local s = I.alert.coords
        TriggerEvent("notification", Lang("GPS_SET") .. I.alert.title)
        SetNewWaypoint(s.x, s.y)
    end
)
RegisterNUICallback(
    "RemoveSuggestion",
    function(I, Q)
        local I = I.data
        if PhoneData.SuggestedContacts ~= nil and next(PhoneData.SuggestedContacts) ~= nil then
            for K, L in pairs(PhoneData.SuggestedContacts) do
                if I.name[1] == L.name[1] and I.name[2] == L.name[2] and I.number == L.number and I.bank == L.bank then
                    table.remove(PhoneData.SuggestedContacts, K)
                end
            end
        end
    end
)
local bL = nil
RegisterNetEvent("s4-phone:client:GiveContactDetails")
AddEventHandler(
    "s4-phone:client:GiveContactDetails",
    function()
        local M = PlayerPedId()
        local bM, w = ESX.Game.GetClosestPlayer()
        if bM ~= -1 and w < 2.5 then
            local PlayerId = GetPlayerServerId(bM)
            if bL ~= PlayerId then
                bL = PlayerId
                TriggerServerEvent("s4-phone:server:GiveContactDetails", PlayerId)
            else
                exports.mythic_notify:SendAlert(
                    "error",
                    "You have already given this person their contact information."
                )
            end
        else
            exports.mythic_notify:SendAlert("error", "There is no one near.")
        end
    end
)
RegisterNUICallback(
    "DeleteContact",
    function(I, Q)
        local bN = I.CurrentContactName
        local au = I.CurrentContactNumber
        local bO = I.CurrentContactIban
        for K, L in pairs(PhoneData.Contacts) do
            if L.name == bN and L.number == au then
                table.remove(PhoneData.Contacts, K)
                if PhoneData.isOpen then
                    SendNUIMessage(
                        {
                            action = "PhoneNotification",
                            PhoneNotify = {
                                title = Lang("PHONE_TITLE"),
                                text = Lang("CONTACTS_REMOVED"),
                                icon = "fas fa-phone-volume",
                                color = "#04b543",
                                timeout = 1500
                            }
                        }
                    )
                else
                    SendNUIMessage(
                        {
                            action = "Notification",
                            NotifyData = {
                                title = Lang("PHONE_TITLE"),
                                content = Lang("CONTACTS_REMOVED"),
                                icon = "fas fa-phone-volume",
                                timeout = 3500,
                                color = "#04b543"
                            }
                        }
                    )
                end
                break
            end
        end
        Citizen.Wait(100)
        Q(PhoneData.Contacts)
        if PhoneData.Chats[au] ~= nil and next(PhoneData.Chats[au]) ~= nil then
            PhoneData.Chats[au].name = au
        end
        TriggerServerEvent("s4-phone:server:RemoveContact", bN, au)
    end
)
RegisterNetEvent("s4-phone:client:AddNewSuggestion")
AddEventHandler(
    "s4-phone:client:AddNewSuggestion",
    function(bP)
        table.insert(PhoneData.SuggestedContacts, bP)
        if PhoneData.isOpen then
            SendNUIMessage(
                {
                    action = "PhoneNotification",
                    PhoneNotify = {
                        title = Lang("PHONE_TITLE"),
                        text = Lang("CONTACTS_NEWSUGGESTED"),
                        icon = "fa fa-phone-alt",
                        color = "#04b543",
                        timeout = 1500
                    }
                }
            )
        else
            SendNUIMessage(
                {
                    action = "Notification",
                    NotifyData = {
                        title = Lang("PHONE_TITLE"),
                        content = Lang("CONTACTS_NEWSUGGESTED"),
                        icon = "fa fa-phone-alt",
                        timeout = 3500,
                        color = "#04b543"
                    }
                }
            )
        end
        Config.PhoneApplications["phone"].Alerts = Config.PhoneApplications["phone"].Alerts + 1
        TriggerServerEvent("s4-phone:server:SetPhoneAlerts", "phone", Config.PhoneApplications["phone"].Alerts)
    end
)
RegisterNUICallback(
    "GetCryptoData",
    function(I, Q)
        ESX.TriggerServerCallback(
            "qb-crypto:server:GetCryptoData",
            function(bQ)
                Q(bQ)
            end,
            I.crypto
        )
    end
)
RegisterNUICallback(
    "BuyCrypto",
    function(I, Q)
        ESX.TriggerServerCallback(
            "qb-crypto:server:BuyCrypto",
            function(bQ)
                Q(bQ)
            end,
            I
        )
    end
)
RegisterNUICallback(
    "SellCrypto",
    function(I, Q)
        ESX.TriggerServerCallback(
            "qb-crypto:server:SellCrypto",
            function(bQ)
                Q(bQ)
            end,
            I
        )
    end
)
RegisterNUICallback(
    "TransferCrypto",
    function(I, Q)
        ESX.TriggerServerCallback(
            "qb-crypto:server:TransferCrypto",
            function(bQ)
                Q(bQ)
            end,
            I
        )
    end
)
RegisterNetEvent("s4-phone:client:RemoveBankMoney")
AddEventHandler(
    "s4-phone:client:RemoveBankMoney",
    function(aS)
        if PhoneData.isOpen then
            SendNUIMessage(
                {
                    action = "PhoneNotification",
                    PhoneNotify = {
                        title = Lang("BANK_TITLE"),
                        text = "There is Γé¼" .. aS .. " withdraw from your bank!",
                        icon = "fas fa-university",
                        color = "#ff002f",
                        timeout = 3500
                    }
                }
            )
        else
            SendNUIMessage(
                {
                    action = "Notification",
                    NotifyData = {
                        title = Lang("BANK_TITLE"),
                        content = "There is Γé¼" .. aS .. " withdraw from your bank!",
                        icon = "fas fa-university",
                        timeout = 3500,
                        color = "#ff002f"
                    }
                }
            )
        end
    end
)
RegisterNetEvent("s4-phone:client:AddTransaction")
AddEventHandler(
    "s4-phone:client:AddTransaction",
    function(bR, bS, bT, bU)
        local bV = {TransactionTitle = bU, TransactionMessage = bT}
        table.insert(PhoneData.CryptoTransactions, bV)
        if PhoneData.isOpen then
            SendNUIMessage(
                {
                    action = "PhoneNotification",
                    PhoneNotify = {
                        title = Lang("CRYPTO_TITLE"),
                        text = bT,
                        icon = "fas fa-chart-pie",
                        color = "#04b543",
                        timeout = 1500
                    }
                }
            )
        else
            SendNUIMessage(
                {
                    action = "Notification",
                    NotifyData = {
                        title = Lang("CRYPTO_TITLE"),
                        content = bT,
                        icon = "fas fa-chart-pie",
                        timeout = 3500,
                        color = "#04b543"
                    }
                }
            )
        end
        SendNUIMessage({action = "UpdateTransactions", CryptoTransactions = PhoneData.CryptoTransactions})
        TriggerServerEvent("s4-phone:server:AddTransaction", bV)
    end
)
RegisterNUICallback(
    "GetCryptoTransactions",
    function(I, Q)
        local bV = {CryptoTransactions = PhoneData.CryptoTransactions}
        Q(bV)
    end
)
RegisterNUICallback(
    "GetAvailableRaces",
    function(I, Q)
        ESX.TriggerServerCallback(
            "qb-lapraces:server:GetRaces",
            function(bW)
                Q(bW)
            end
        )
    end
)
RegisterNUICallback(
    "JoinRace",
    function(I)
        TriggerServerEvent("qb-lapraces:server:JoinRace", I.RaceData)
    end
)
RegisterNUICallback(
    "LeaveRace",
    function(I)
        TriggerServerEvent("qb-lapraces:server:LeaveRace", I.RaceData)
    end
)
RegisterNUICallback(
    "StartRace",
    function(I)
        TriggerServerEvent("qb-lapraces:server:StartRace", I.RaceData.RaceId)
    end
)
RegisterNetEvent("s4-phone:client:UpdateLapraces")
AddEventHandler(
    "s4-phone:client:UpdateLapraces",
    function()
        SendNUIMessage({action = "UpdateRacingApp"})
    end
)
RegisterNUICallback(
    "GetRaces",
    function(I, Q)
        ESX.TriggerServerCallback(
            "qb-lapraces:server:GetListedRaces",
            function(bW)
                Q(bW)
            end
        )
    end
)
RegisterNUICallback(
    "GetTrackData",
    function(I, Q)
        ESX.TriggerServerCallback(
            "qb-lapraces:server:GetTrackData",
            function(bX, bY)
                bX.CreatorData = bY
                Q(bX)
            end,
            I.RaceId
        )
    end
)
RegisterNUICallback(
    "SetupRace",
    function(I, Q)
        TriggerServerEvent("qb-lapraces:server:SetupRace", I.RaceId, tonumber(I.AmountOfLaps))
    end
)
RegisterNUICallback(
    "HasCreatedRace",
    function(I, Q)
        ESX.TriggerServerCallback(
            "qb-lapraces:server:HasCreatedRace",
            function(bZ)
                Q(bZ)
            end
        )
    end
)
RegisterNUICallback(
    "IsInRace",
    function(I, Q)
        local b_ = exports["qb-lapraces"]:IsInRace()
        Q(b_)
    end
)
RegisterNUICallback(
    "IsAuthorizedToCreateRaces",
    function(I, Q)
        ESX.TriggerServerCallback(
            "qb-lapraces:server:IsAuthorizedToCreateRaces",
            function(c0)
                local I = {IsAuthorized = true, IsBusy = exports["qb-lapraces"]:IsInEditor(), IsNameAvailable = c0}
                Q(I)
            end,
            I.TrackName
        )
    end
)
RegisterNUICallback(
    "StartTrackEditor",
    function(I, Q)
        TriggerServerEvent("qb-lapraces:server:CreateLapRace", I.TrackName)
    end
)
RegisterNUICallback(
    "GetRacingLeaderboards",
    function(I, Q)
        ESX.TriggerServerCallback(
            "qb-lapraces:server:GetRacingLeaderboards",
            function(bW)
                Q(bW)
            end
        )
    end
)
RegisterNUICallback(
    "RaceDistanceCheck",
    function(I, Q)
        ESX.TriggerServerCallback(
            "qb-lapraces:server:GetRacingData",
            function(c1)
                local M = PlayerPedId()
                local s = GetEntityCoords(M)
                local c2 = c1.Checkpoints[1].coords
                local c3 = GetDistanceBetweenCoords(s, c2.x, c2.y, c2.z, true)
                if c3 <= 115.0 then
                    if I.Joined then
                        TriggerEvent("qb-lapraces:client:WaitingDistanceCheck")
                    end
                    Q(true)
                else
                    TriggerEvent(
                        "notification",
                        "You are too far from the race. Your navigation is set to the race.",
                        2
                    )
                    SetNewWaypoint(c2.x, c2.y)
                    Q(false)
                end
            end,
            I.RaceId
        )
    end
)
RegisterNUICallback(
    "IsBusyCheck",
    function(I, Q)
        if I.check == "editor" then
            Q(exports["qb-lapraces"]:IsInEditor())
        else
            Q(exports["qb-lapraces"]:IsInRace())
        end
    end
)
RegisterNUICallback(
    "CanRaceSetup",
    function(I, Q)
        ESX.TriggerServerCallback(
            "qb-lapraces:server:CanRaceSetup",
            function(c4)
                Q(c4)
            end
        )
    end
)
RegisterNUICallback(
    "GetPlayerHouses",
    function(I, Q)
        ESX.TriggerServerCallback(
            "s4-phone:server:GetPlayerHouses",
            function(c5)
                Q(c5)
            end
        )
    end
)
RegisterNUICallback(
    "RemoveKeyholder",
    function(I)
        TriggerServerEvent(
            "qb-houses:server:removeHouseKey",
            I.HouseData.name,
            {
                identifier = I.HolderData.identifier,
                firstname = I.HolderData.charinfo.firstname,
                lastname = I.HolderData.charinfo.lastname
            }
        )
    end
)
RegisterNUICallback(
    "FetchPlayerHouses",
    function(I, Q)
        ESX.TriggerServerCallback(
            "s4-phone:server:MeosGetPlayerHouses",
            function(bn)
                Q(bn)
            end,
            I.input
        )
    end
)
RegisterNUICallback(
    "SetGPSLocation",
    function(I, Q)
        local M = PlayerPedId()
        SetNewWaypoint(I.coords.x, I.coords.y)
        TriggerEvent("notification", "GPS is set!")
    end
)
RegisterNUICallback(
    "SetApartmentLocation",
    function(I, Q)
        local c6 = I.data.appartmentdata
        local c7 = Apartments.Locations[c6.type]
        SetNewWaypoint(c7.coords.enter.x, c7.coords.enter.y)
        TriggerEvent("notification", "GPS is set!")
    end
)
RegisterNUICallback(
    "GetCurrentLawyers",
    function(I, Q)
        ESX.TriggerServerCallback(
            "s4-phone:server:GetCurrentLawyers",
            function(c8)
                Q(c8)
            end
        )
    end
)
RegisterNUICallback(
    "GetCurrentpolices",
    function(I, Q)
        ESX.TriggerServerCallback(
            "s4-phone:server:GetCurrentpolices",
            function(c8)
                Q(c8)
            end
        )
    end
)
RegisterNUICallback(
    "GetCurrentDrivers",
    function(I, Q)
    end
)
RegisterNUICallback(
    "GetCurrentMecano",
    function(I, Q)
        ESX.TriggerServerCallback(
            "s4-phone:server:GetCurrentMecano",
            function(c9)
                Q(c9)
            end
        )
    end
)
RegisterNUICallback(
    "GetCurrentDoctor",
    function(I, Q)
        ESX.TriggerServerCallback(
            "s4-phone:server:GetCurrentDoctor",
            function(c9)
                Q(c9)
            end
        )
    end
)
Lang = function(ca)
    local cb = Config.Languages[Config.Language]
    if cb and cb[ca] then
        return cb[ca]
    end
    return ca
end
RegisterNUICallback(
    "GetLangData",
    function(I, Q)
        Q({table = Config.Languages, current = Config.Language})
    end
)
RegisterNetEvent("s4-phone:client:anon")
AddEventHandler(
    "s4-phone:client:anon",
    function(cc)
        if cc == nil or cc == "" then
            return
        end
        local bc = {
            firstName = "Anonim",
            lastName = "",
            message = cc,
            url = test or "",
            time = "none",
            id = PhoneData.id,
            picture = "https://cdn.discordapp.com/attachments/808603408302473216/831682724431527963/unknown.png"
        }
        test = ""
        TriggerServerEvent(
            "s4-phone:saveTwitterToDatabase",
            bc.firstName,
            bc.lastName,
            bc.message,
            bc.url,
            bc.time,
            bc.picture
        )
        TriggerServerEvent("s4-phone:server:updateidForEveryone")
        local a4 = cc
        local a5 = a4:split("@")
        local bd = a4:split("#")
        for l = 2, #bd, 1 do
            local a6 = bd[l]:split(" ")[1]
            if a6 ~= nil or a6 ~= "" then
                local be = string.match(a6, ba)
                if be then
                    a6 = a6:gsub("%" .. be, "")
                end
                TriggerServerEvent("s4-phone:server:UpdateHashtags", a6, bc)
            end
        end
        for l = 2, #a5, 1 do
            local a6 = a5[l]:split(" ")[1]
            if a6 ~= nil or a6 ~= "" then
                local a7 = a6:split("_")
                local a8 = a7[1]
                table.remove(a7, 1)
                local a9 = table.concat(a7, " ")
                if a8 ~= nil and a8 ~= "" and (a9 ~= nil and a9 ~= "") then
                    if a8 ~= PhoneData.PlayerData.charinfo.firstname and a9 ~= PhoneData.PlayerData.charinfo.lastname then
                        TriggerServerEvent("s4-phone:server:MentionedPlayer", a8, a9, bc)
                    else
                        SetTimeout(
                            2500,
                            function()
                                SendNUIMessage(
                                    {
                                        action = "PhoneNotification",
                                        PhoneNotify = {
                                            title = Lang("TWITTER_TITLE"),
                                            text = Lang("MENTION_YOURSELF"),
                                            icon = "fab fa-twitter",
                                            color = "#1DA1F2"
                                        }
                                    }
                                )
                            end
                        )
                    end
                end
            end
        end
        Citizen.Wait(1000)
        table.insert(PhoneData.Tweets, bc)
        table.insert(PhoneData.SelfTweets, bc)
        TriggerServerEvent("s4-phone:server:updateForEveryone", PhoneData.Tweets)
        TriggerServerEvent("s4-phone:server:UpdateTweets", bc)
        SendNUIMessage({action = "updateTest", selftTweets = PhoneData.SelfTweets})
    end
)
RegisterNUICallback(
    "GetHavaDurumu",
    function(I, Q)
        local cd, ce, cf = GetWeatherTypeTransition()
        local cg = GetNextWeatherTypeHashName()
        local ch = {}
        local ci = GetClockHours()
        local cj = Citizen.InvokeNative(0x564B884A05EC45A3)
        local ck = getWeatherStringFromHash(cj)
        local cl = GetClockMonth()
        ch.simdikizaman = havadurumu(cd)
        ch.birsonraki = havadurumu(cg)
        temp = calcTemp(ck, cl, ci)
        ch.derece = FtoC(temp)
        Q(ch)
    end
)
function havadurumu(cd)
    if GetHashKey("THUNDER") == cd then
        cd = "THUNDER"
    elseif GetHashKey("RAIN") == cd then
        cd = "RAIN"
    elseif GetHashKey("EXTRASUNNY") == cd then
        cd = "EXTRASUNNY"
    elseif GetHashKey("CLOUDS") == cd then
        cd = "CLOUDS"
    elseif GetHashKey("OVERCAST") == cd then
        cd = "OVERCAST"
    elseif GetHashKey("CLEAR") == cd then
        cd = "CLEARING"
    elseif GetHashKey("CLEARING") == cd then
        cd = "CLEARING"
    elseif GetHashKey("SMOG") == cd then
        cd = "SMOG"
    elseif GetHashKey("FOGGY") == cd then
        cd = "FOGGY"
    elseif GetHashKey("XMAS") == cd then
        cd = "XMAS"
    elseif GetHashKey("SNOWLIGHT") == cd then
        cd = "SNOWLIGHT"
    elseif GetHashKey("BLIZZARD") == cd then
        cd = "BLIZZARD"
    else
        cd = "BILINMIYOR"
    end
    return cd
end
local cm = 1000
RegisterNUICallback(
    "Fener",
    function(I, Q)
        if I.fener == "acik" then
            FENER = true
            cm = 0
        else
            FENER = false
            cm = 1000
        end
    end
)
Citizen.CreateThread(
    function()
        while true do
            if PhoneData.isOpen then
                if FENER == true then
                    local s = GetEntityCoords(PlayerPedId(), true)
                    local cn = GetEntityForwardVector(PlayerPedId())
                    DrawSpotLight(s.x, s.y, s.z, cn.x, cn.y, cn.z, 255, 255, 255, 20.0, 1.0, 1.0, 25.0, 0)
                end
            end
            Citizen.Wait(cm)
        end
    end
)
MAX_INCREASE = 1.5
MIN_INCREASE = 0.2
RAND_FLUC = 0.2
START_INCREASE_HR = 4
STOP_INCREASE_HR = 16
MonthData = {
    {36, 20},
    {41, 24},
    {53, 34},
    {65, 43},
    {75, 54},
    {82, 61},
    {86, 66},
    {85, 64},
    {78, 58},
    {66, 46},
    {53, 37},
    {43, 28}
}
AvailableWeatherTypes = {
    "EXTRASUNNY",
    "CLEAR",
    "NEUTRAL",
    "SMOG",
    "FOGGY",
    "OVERCAST",
    "CLOUDS",
    "CLEARING",
    "RAIN",
    "THUNDER",
    "SNOW",
    "BLIZZARD",
    "SNOWLIGHT",
    "XMAS",
    "HALLOWEEN"
}
function calcTemp(co, cp, cq)
    if cp == 0 then
        cp = 1
    end
    local cr = MonthData[cp][1]
    local cs = MonthData[cp][2]
    local ct
    local cu
    local cv
    if co == "SNOW" or co == "BLIZZARD" or co == "SNOWLIGHT" or co == "XMAS" then
        ct = 32
        cu = -20
    elseif co == "EXTRASUNNY" then
        ct = cr + 20
        cu = cs + 20
    elseif co == "SMOG" then
        ct = cr + 10
        cu = cs + 10
    elseif co == "FOGGY" or co == "CLOUDS" or co == "THUNDER" or co == "HALLOWEEN" then
        ct = cr - 10
        cu = cs - 10
    else
        ct = cr
        cu = cs
    end
    cv = randf(cu, ct)
    if cq >= START_INCREASE_HR and cq < STOP_INCREASE_HR then
        if cv >= ct then
            cv = ct + randf(-RAND_FLUC, RAND_FLUC)
        else
            cv = cv + randf(MIN_INCREASE, MAX_INCREASE)
        end
    else
        if cv <= cu then
            cv = cu + randf(-RAND_FLUC, RAND_FLUC)
        else
            cv = cv - randf(MIN_INCREASE, MAX_INCREASE)
        end
    end
    return cv
end
function getWeatherStringFromHash(cw)
    local cx = "?"
    for l = 1, #AvailableWeatherTypes, 1 do
        if cw == GetHashKey(AvailableWeatherTypes[l]) then
            cx = AvailableWeatherTypes[l]
        end
    end
    return cx
end
function genSeed()
    return GetClockYear() + GetClockMonth() + GetClockDayOfWeek()
end
function randf(cy, cz)
    math.randomseed(GetClockDayOfMonth() + GetClockYear() + GetClockMonth() + GetClockHours())
    return cy + math.random() * (cz - cy)
end
local cA = false
AddEventHandler(
    "showHud",
    function(cB)
        cA = not cB
    end
)
function FtoC(cC)
    return (cC - 32) * 5 / 9
end
