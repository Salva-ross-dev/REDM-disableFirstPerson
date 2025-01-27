-- disableFirstPerson.lua

local firstPersonDisabled = true -- Einstellung, um die First-Person-Ansicht zu deaktivieren.

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(100) -- Regelmäßige Überprüfung (nicht zu häufig)

        if firstPersonDisabled then
            -- Kontrolliere die Kameraansicht
            local camMode = GetGameplayCamRelativeHeading() -- Überprüfe die aktuelle Kameraposition
            if camMode < -90.0 or camMode > 90.0 then
                -- Setze die Kamera zurück auf Third-Person
                SetFollowPedCamViewMode(1) -- Third-Person Ansicht
                SetFollowVehicleCamViewMode(1) -- Auch im Fahrzeug Third-Person setzen
            end
        end
    end
end)

-- Blockiere Eingaben zur First-Person-Ansicht
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0) -- Echtzeitüberwachung

        if firstPersonDisabled then
            DisableControlAction(0, 1, true) -- Kameraansicht ändern (Maus)
            DisableControlAction(0, 2, true) -- Kameraansicht ändern (Controller)
            DisableControlAction(0, 20, true) -- Umschalten auf First-Person
            DisableFirstPersonCamThisFrame() -- Verhindere die First-Person-Nutzung vollständig
        end
    end
end)
