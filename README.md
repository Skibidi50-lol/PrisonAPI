# PrisonAPI
working modules for making prison life script

# Functions
```lua
PrisonAPI Configs (change anytime):
Noclip = true/false
AutoArrest = true/false
AutoAttack = true/false
AutoRespawn = true/false
TpWalkEnabled = true/false | TpStepSize = 0.25
Dots.Enabled = true/false | DotSize = 10 | OffsetY = 2
Aimbot.Enabled = true/false | FOV = 150 | Smoothness = 0.22 | TargetPart = "Head" | TeamCheck = true/false | WallCheck = true/false | ShowFOV = true/false
TargetKillAura → PrisonAPI:StartTargetKill("Name") / :StopTargetKill()
TargetArrest → PrisonAPI:StartTargetArrest("Name") / :StopTargetArrest()
Aimbot → PrisonAPI:StartAimbot() / :StopAimbot()
GiveGun("M9"/"AK-47"/etc) | Btools() | BecomeCriminal() | EscapePrison() | YardTP() | PoliceRoomTP()
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
