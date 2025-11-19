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
