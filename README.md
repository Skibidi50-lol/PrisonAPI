# PrisonAPI
working open source module for making prison life script (currently on beta version)
# Load API
```lua
loadstring(game:HttpGet("https://raw.githubusercontent.com/Skibidi50-lol/PrisonAPI/refs/heads/main/Api.lua"))()
```
# Functions
```lua
PrisonAPI Configs (Remember to add PrisonAPI. to all these vars but not the give gun 
Noclip = true/false
AutoArrest = true/false
AutoAttack = true/false
AutoRespawn = true/false
TpWalkEnabled = true/false | TpStepSize = 0.25
Dots.Enabled = true/false | DotSize = 10 | OffsetY = 2
Aimbot.Enabled = true/false | FOV = 150 | Smoothness = 0.22 | TargetPart = "Head" | TeamCheck = true/false | WallCheck = true/false | ShowFOV = true/false
TargetKillAura → PrisonAPI:StartTargetKill("Name") or PrisonAPI:StartTargetKill(Target) / :StopTargetKill()
TargetArrest → PrisonAPI:StartTargetArrest("Name") or PrisonAPI:StartTargetArrest(Target) / :StopTargetArrest()
Aimbot → PrisonAPI:StartAimbot() / :StopAimbot()
GiveGun("M9"/"AK-47"/"Remington 870"/"M4A1") or GiveGun(selectedGun) --selected gun must be a gun name | FAL WILL NOT WORK
--Tp
PrisonAPI.EscapePrison() → Criminal Base
PrisonAPI.YardTP() → Yard
PrisonAPI.PoliceRoomTP() → Police Armory Room
PrisonAPI.CrimBaseTP() or PrisonAPI.EscapePrison() → Criminal Spawn
--workspace
PrisonAPI.DeleteDoors() → removes all doors
PrisonAPI.DeleteCells() → removes prison cell block
PrisonAPI.DeleteCellDoors() → removes only cell doors
PrisonAPI.Btools() → Hammer + Clone + Grab
PrisonAPI.BecomeCriminal() → instantly turn criminal + return to old position
PrisonAPI.NoAntiJump() → removes anti-jump script
