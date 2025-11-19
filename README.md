# PrisonAPI
working modules for making prison life script

# Functions
-- Example: Kill a player
PrisonAPI:StartTargetKill("Roblox")
--Arrest Random
PrisonAPI:StartTargetArrest("Roblox")
-- Example: Turn on Aimbot
PrisonAPI.Aimbot.Enabled = true
PrisonAPI.Aimbot.ShowFOV = true
PrisonAPI.Aimbot.WallCheck = true
PrisonAPI.Aimbot.TeamCheck = true
PrisonAPI.Aimbot.FOV = 150
PrisonAPI:StartAimbot()

PrisonAPI.Noclip = true
PrisonAPI.AutoArrest = true
PrisonAPI.AutoAttack = true
PrisonAPI.AutoRespawn = true
PrisonAPI.TpWalkEnabled = true
PrisonAPI.Dots.Enabled = true

PrisonAPI.EscapePrison()
PrisonAPI.YardTP()
PrisonAPI.PoliceRoomTP()
PrisonAPI.CrimBaseTP()

PrisonAPI.Btools()
PrisonAPI.BecomeCriminal()
PrisonAPI.NoAntiJump()
PrisonAPI.DeleteDoors(
PrisonAPI.DeleteCells()
PrisonAPI.DeleteCellDoors()
