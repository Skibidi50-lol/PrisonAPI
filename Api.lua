game:GetService("StarterGui"):SetCore("SendNotification",{
    Title = "Prison API",
    Text = "Prison API - By Skibidi50-lol",
})

local player = game.Players.LocalPlayer

local function instantTP(cf)
	local char = player.Character or player.CharacterAdded:Wait()
	local root = char:FindFirstChild("HumanoidRootPart")
	local hum = char:FindFirstChild("Humanoid")
	if not root or not hum then return end
	hum.Health = 100
	root.Anchored = true
	root.CFrame = cf + Vector3.new(0,5,0)
	task.wait(0.05)
	root.Anchored = false
end

local PrisonAPI = {
    Noclip = false,
    AutoArrest = false,
    AutoAttack = false,
    AutoRespawn = false,
    --TPWALK
    TpWalkEnabled = false,
    TpStepSize = 0.25,
    --Give Gun
    selectedGun = "M9",
    --Dot esp
    Dots = {
        Enabled = false,
        DotSize = 10,
        FillColor = Color3.fromRGB(255, 138, 0),
        OutlineColor = Color3.fromRGB(0,0,0),
        FillTrans = 0.3,
        OutlineTrans = 0.1,
        OffsetY = 2,
    },
    Aimbot = {
        Enabled = false,
        TeamCheck = false,
        WallCheck = false,
        FOV = 150,
        Smoothness = 0.22,
        TargetPart = "Head",
        ShowFOV = false,
        FOVColor = Color3.fromRGB(255, 0, 150)
    },
    TargetKillAura = {
        Enabled = false,
        Target = nil,
        Connection = nil
    },
    TargetArrest = {
        Enabled = false,
        Target = nil,
        Connection = nil
    }
}

local function getGiverPosition(giver)
    if giver:IsA("Model") then
        return giver:GetPivot().p
    elseif giver:IsA("BasePart") then
        return giver.Position
    end
    return nil
end

local function GiveGun(gunName)
    local plr = game.Players.LocalPlayer
    local char = plr.Character or plr.CharacterAdded:Wait()
    local hrp = char:WaitForChild("HumanoidRootPart")
    
    -- Save exact old position + camera
    local oldPos = hrp.CFrame
    local oldCam = workspace.CurrentCamera.CFrame

    -- Find the giver
    local giver = nil
    for _, obj in workspace:GetDescendants() do
        if obj.Name == "TouchGiver" and obj:GetAttribute("ToolName") == gunName then
            giver = obj
            break
        end
    end

    if not giver then
        game:GetService("StarterGui"):SetCore("SendNotification",{
            Title = "Prison API",
            Text = "No Gun Found!",
        })
        return
    end

    local giverPos = getGiverPosition(giver)
    if not giverPos then return end

    hrp.CFrame = CFrame.new(giverPos + Vector3.new(0, 8, 0))
    
    task.wait(1)

    -- Instant return to exact old spot
    hrp.CFrame = oldPos
    workspace.CurrentCamera.CFrame = oldCam

    game:GetService("StarterGui"):SetCore("SendNotification",{
        Title = "Prison API",
        Text = "Succesfully Got Gun!",
    })
end
--Noclip
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local lplr = Players.LocalPlayer

--loop
RunService.Stepped:Connect(function()
    if not PrisonAPI.Noclip then return end
    if not lplr.Character then return end
    
    for _, part in pairs(lplr.Character:GetDescendants()) do
        if part:IsA("BasePart") and part.CanCollide then
            part.CanCollide = false
        end
    end
end)
--TpWalk
RunService.RenderStepped:Connect(function()
    if not PrisonAPI.TpWalkEnabled then return end

    local char = game.Players.LocalPlayer.Character
	    local hum = char:FindFirstChild("Humanoid")
    local hrp = char:FindFirstChild("HumanoidRootPart")

    if not hum or not hrp then return end

    local dir = hum.MoveDirection
    if dir.Magnitude > 0 then
        hrp.CFrame = hrp.CFrame + (dir * PrisonAPI.TpStepSize)
    end
end)
--Auto Arrest
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local me = Players.LocalPlayer
local remote = ReplicatedStorage.Remotes.ArrestPlayer

RunService.Heartbeat:Connect(function()
    if not PrisonAPI.AutoArrest then return end
    local root = me.Character and me.Character:FindFirstChild("HumanoidRootPart")
    if not root then return end
    for _, plr in Players:GetPlayers() do
        if plr == me then continue end
        local char = plr.Character
        if not char then continue end
        local hrp = char:FindFirstChild("HumanoidRootPart")
        local hum = char:FindFirstChild("Humanoid")
        if not hrp or not hum or hum.Health <= 0 then continue end
        if (root.Position - hrp.Position).Magnitude <= 10 then
            task.spawn(function()
                pcall(remote.InvokeServer, remote, plr)
            end)
        end
    end
end)
--Auto Attack
    local cloneref = cloneref or function(obj)
    return obj
end

local playersService = cloneref(game:GetService('Players'))
local replicatedStorage = cloneref(game:GetService('ReplicatedStorage'))
local lplr = playersService.LocalPlayer

local function getClosestPlayer()
    local closestdist, closestplr = math.huge, nil
    for i,v in playersService:GetPlayers() do
        if v == lplr then continue end

        pcall(function()
            local dist = lplr:DistanceFromCharacter(v.Character.PrimaryPart.Position)
            if dist < 6 and dist < closestdist then
                closestdist = dist
                closestplr = v
            end
        end)
    end

    return closestplr
end

task.spawn(function()
    repeat
        local plr = getClosestPlayer()
        if plr then
            replicatedStorage.meleeEvent:FireServer(plr)
        end

        task.wait()
    until not PrisonAPI.AutoAttack
end)
--auto respawn
spawn(function()
    while task.wait() and PrisonAPI.AutoRespawn do
        if game.Players.LocalPlayer.Character.Humanoid.Health < 0.10 then 
            local lastCamPos = workspace.Camera.CFrame
            local lastPos = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
                wait(0.3)
            if game.Players.LocalPlayer.TeamColor.Name == "Bright blue" then
                workspace.Remote.TeamEvent:FireServer("Bright blue")
            elseif game.Players.LocalPlayer.TeamColor.Name == "Bright orange" then
                workspace.Remote.TeamEvent:FireServer("Bright orange")
            elseif game.Players.LocalPlayer.TeamColor.Name == "Really red" then
                workspace.Remote.TeamEvent:FireServer("Bright blue")
                wait(0.5)
            if not game.Players.LocalPlayer.TeamColor.Name == "Bright blue" then
                workspace.Remote.TeamEvent:FireServer("Bright orange")
            end
                wait(0.2)
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-975, 112, 2055)
            end
        wait(0.7)
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = lastPos
            workspace.Camera.CFrame = lastCamPos
        end
    end
end)
--TargetKill
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer

local function Notify(title, text, time)
    pcall(function()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = title or "Prison API",
            Text = text,
            Duration = time or 4
        })
    end)
end

function PrisonAPI:StartTargetKill(playerName)
    local targetPlr = game.Players:FindFirstChild(playerName)
    if not targetPlr or not targetPlr.Character or not targetPlr.Character:FindFirstChild("HumanoidRootPart") then
        game:GetService("StarterGui"):SetCore("SendNotification",{
            Title = "Target Kill",
            Text = "Player not found or not spawned!",
            Duration = 5
        })
        return
    end

    -- Stop any old aura
    if PrisonAPI.TargetKillAura.Connection then self.TargetKillAura.Connection:Disconnect() end

    PrisonAPI.TargetKillAura.Target = targetPlr
    PrisonAPI.TargetKillAura.Enabled = true

    game:GetService("StarterGui"):SetCore("SendNotification",{
        Title = "Target Kill Aura",
        Text = "Killing " .. playerName .. " (TP Under + Punch)",
        Duration = 5
    })

    PrisonAPI.TargetKillAura.Connection = game:GetService("RunService").Heartbeat:Connect(function()
        if not PrisonAPI.TargetKillAura.Enabled or not PrisonAPI.TargetKillAura.Target then return end

        local myChar = game.Players.LocalPlayer.Character
        if not myChar or not myChar:FindFirstChild("HumanoidRootPart") then return end
        local myRoot = myChar.HumanoidRootPart

        local tChar = self.TargetKillAura.Target.Character
        if not tChar or not tChar:FindFirstChild("HumanoidRootPart") then
            game:GetService("StarterGui"):SetCore("SendNotification",{
                Title = "Target Lost",
                Text = playerName .. " left the game",
                Duration = 5
            })
            self:StopTargetKill()
            return
        end

        local tRoot = tChar.HumanoidRootPart
        local tHum = tChar:FindFirstChild("Humanoid")

        if not tHum or tHum.Health <= 0 then
            game:GetService("StarterGui"):SetCore("SendNotification",{
                Title = "Target Killed!",
                Text = playerName .. " eliminated!",
                Duration = 6
            })
            PrisonAPI:StopTargetKill()
            return
        end

 
        local randomOffset = Vector3.new(math.random(-70,70)/100, 0, math.random(-70,70)/100)
        myRoot.CFrame = CFrame.new(tRoot.Position + randomOffset - Vector3.new(0, 4, 0), tRoot.Position)

        pcall(function()
            game:GetService("ReplicatedStorage").meleeEvent:FireServer(PrisonAPI.TargetKillAura.Target)
        end)
    end)
end

function PrisonAPI:StopTargetKill()
    if PrisonAPI.TargetKillAura.Connection then
        PrisonAPI.TargetKillAura.Connection:Disconnect()
        PrisonAPI.TargetKillAura.Connection = nil
    end
    PrisonAPI.TargetKillAura.Target = nil
    PrisonAPI.TargetKillAura.Enabled = { Enabled = false, Target = nil, Connection = nil }
    game:GetService("StarterGui"):SetCore("SendNotification",{
        Title = "Target Kill Aura",
        Text = "Disabled",
        Duration = 3
    })
end
--target arrest
function PrisonAPI:StartTargetArrest(playerName)
    local targetPlr = game.Players:FindFirstChild(playerName)
    if not targetPlr then
        game:GetService("StarterGui"):SetCore("SendNotification",{
            Title = "Target Arrest",
            Text = "Player not found!",
            Duration = 4
        })
        return false
    end
    if not targetPlr.Character or not targetPlr.Character:FindFirstChild("HumanoidRootPart") then
        game:GetService("StarterGui"):SetCore("SendNotification",{
            Title = "Target Arrest",
            Text = playerName.." not spawned yet!",
            Duration = 4
        })
        return false
    end

    -- Stop old one
    if PrisonAPI.TargetArrest.Connection then PrisonAPI.TargetArrest.Connection:Disconnect() end

    PrisonAPI.TargetArrest.Target = targetPlr
    PrisonAPI.TargetArrest.Enabled = true

    game:GetService("StarterGui"):SetCore("SendNotification",{
        Title = "Target Arrest ON",
        Text = "Arresting only: "..playerName,
        Duration = 5
    })

    PrisonAPI.TargetArrest.Connection = game:GetService("RunService").Heartbeat:Connect(function()
        if not PrisonAPI.TargetArrest.Enabled or not PrisonAPI.TargetArrest.Target then return end

        local myChar = game.Players.LocalPlayer.Character
        if not myChar or not myChar:FindFirstChild("HumanoidRootPart") then return end
        local myRoot = myChar.HumanoidRootPart

        local tChar = PrisonAPI.TargetArrest.Target.Character
        if not tChar then
            game:GetService("StarterGui"):SetCore("SendNotification",{
                Title = "Target Lost",
                Text = playerName.." left the game",
                Duration = 5
            })
            PrisonAPI:StopTargetArrest()
            return
        end

        local tRoot = tChar:FindFirstChild("HumanoidRootPart")
        local tHum = tChar:FindFirstChild("Humanoid")
        if not tRoot or not tHum or tHum.Health <= 0 then
            game:GetService("StarterGui"):SetCore("SendNotification",{
                Title = "Target Arrested!",
                Text = playerName.." has been arrested!",
                Duration = 6
            })
            PrisonAPI:StopTargetArrest()
            return
        end

        local offset = Vector3.new(math.random(-60,60)/100, 0, math.random(-60,60)/100)
        myRoot.CFrame = CFrame.new(tRoot.Position + offset - Vector3.new(0, 4, 0), tRoot.Position)

        if (myRoot.Position - tRoot.Position).Magnitude <= 14 then
            pcall(function()
                game:GetService("ReplicatedStorage").Remotes.ArrestPlayer:InvokeServer(PrisonAPI.TargetArrest.Target)
            end)
        end
    end)
end

function PrisonAPI:StopTargetArrest()
    if PrisonAPI.TargetArrest.Connection then
        PrisonAPI.TargetArrest.Connection:Disconnect()
        PrisonAPI.TargetArrest.Connection = nil
    end
    PrisonAPI.TargetArrest.Target = nil
    PrisonAPI.TargetArrest.Enabled = false
    game:GetService("StarterGui"):SetCore("SendNotification",{
        Title = "Target Arrest",
        Text = "Disabled",
        Duration = 3
    })
end

-- Auto stop on respawn
game.Players.LocalPlayer.CharacterAdded:Connect(function()
    if PrisonAPI.TargetArrest.Enabled then
        PrisonAPI:StopTargetArrest()
    end
end)
--no anti jump
function PrisonAPI:NoAntiJump()
    local PL = game:GetService("Players").LocalPlayer
    local PC = pcall

    local CH = PL.Character or PL.CharacterAdded:Wait()

    local TS = CH:FindFirstChild("AntiJump")

    if TS and TS:IsA("LocalScript") then
        PC(function()
            TS:Destroy()
        end)
    end
    game:GetService("StarterGui"):SetCore("SendNotification",{
        Title = "Prison API",
        Text = "No Anti Jump Applied",
    })
end
--workspace
function PrisonAPI:EscapePrison()
    instantTP(CFrame.new(-927.7, 94.1, 2055.3))
end

function PrisonAPI:YardTP()
    instantTP(CFrame.new(791.5, 98, 2498.5))
end

function PrisonAPI:PoliceRoomTP()
    instantTP(CFrame.new(837.9, 99.8, 2267.3))
end

function PrisonAPI:CrimBaseTP()
    instantTP(CFrame.new(-927.7, 94.1, 2055.3))
end

function PrisonAPI:DeleteDoors()
    game.workspace.Doors:Destroy()
end

function PrisonAPI:DeleteCells()
    game.workspace.Prison_Cellblock:Destroy()
end

function PrisonAPI:DeleteCellsDoors()
    game.workspace.CellDoors:Destroy()
end

function PrisonAPI:Btools()
    backpack = game:GetService("Players").LocalPlayer.Backpack

    hammer = Instance.new("HopperBin")
    hammer.Name = "Hammer"
    hammer.BinType = 4
    hammer.Parent = backpack

    cloneTool = Instance.new("HopperBin")
    cloneTool.Name = "Clone"
    cloneTool.BinType = 3
    cloneTool.Parent = backpack

    grabTool = Instance.new("HopperBin")
    grabTool.Name = "Grab"
    grabTool.BinType = 2
    grabTool.Parent = backpack

    game:GetService("StarterGui"):SetCore("SendNotification",{
        Title = "Prison API",
        Text = "Succesfully Get Btools!",
    })
end

function PrisonAPI:BecomeCriminal()
    local plr = game.Players.LocalPlayer
        local char = plr.Character
        if not char or not char:FindFirstChild("HumanoidRootPart") then
                game:GetService("StarterGui"):SetCore("SendNotification",{
                    Title = "Prison API Error",
                    Text = "Spawn First!",
                })
        return
    end

    local root = char.HumanoidRootPart
        
    savedPosition = {
        pos = root.CFrame,
        camera = workspace.CurrentCamera.CFrame
    }
        
    game:GetService("StarterGui"):SetCore("SendNotification",{
        Title = "Prison API",
        Text = "Old Position Saved Tp to Criminal Base",
    })

    instantTP(CFrame.new(-927.7, 94.1, 2055.3))
    task.wait(0.5)

    if plr.TeamColor.Name == "Bright orange" then
        pcall(function()
            game:GetService("ReplicatedStorage").Remote.TeamEvent:FireServer("Really red")
        end)
        task.wait(1.2)
    end

    task.wait(0.3)
    root.CFrame = savedPosition.pos
    workspace.CurrentCamera.CFrame = savedPosition.camera
        
    game:GetService("StarterGui"):SetCore("SendNotification",{
        Title = "Prison API",
        Text = "Succesfully Become Criminal!",
    })
        
    savedPosition = nil
end
--aimbot
local Camera = workspace.CurrentCamera
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Use the PrisonAPI table so the toggles actually work
PrisonAPI.Aimbot.Enabled = PrisonAPI.Aimbot.Enabled or false

local AimbotConnections = {}

-- FOV Circle
local FOVCircle = Drawing.new("Circle")
FOVCircle.Thickness = 2
FOVCircle.NumSides = 60
FOVCircle.Filled = false
FOVCircle.Transparency = 0.8
FOVCircle.Color = PrisonAPI.Aimbot.FOVColor
FOVCircle.Radius = PrisonAPI.Aimbot.FOV
FOVCircle.Visible = false

local function UpdateFOVCircle()
    if PrisonAPI.Aimbot.ShowFOV then
        FOVCircle.Visible = true
        FOVCircle.Radius = PrisonAPI.Aimbot.FOV
        FOVCircle.Color = PrisonAPI.Aimbot.FOVColor
        FOVCircle.Position = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)
    else
        FOVCircle.Visible = false
    end
end

-- UNIVERSAL Team check (just don't target same team)
local function IsEnemy(plr)
    if not PrisonAPI.Aimbot.TeamCheck then return true end
    if plr == LocalPlayer then return false end
    return plr.Team ~= LocalPlayer.Team
end

-- Wall check
local function CanSee(targetPart)
    if not PrisonAPI.Aimbot.WallCheck then return true end
    local rayParams = RaycastParams.new()
    rayParams.FilterDescendantsInstances = {LocalPlayer.Character or {}}
    rayParams.FilterType = Enum.RaycastFilterType.Blacklist
    
    local result = workspace:Raycast(Camera.CFrame.Position, (targetPart.Position - Camera.CFrame.Position), rayParams)
    return result == nil or result.Instance:IsDescendantOf(targetPart.Parent)
end

-- Get best target
local function GetTarget()
    local closest = nil
    local closestDist = math.huge
    local screenCenter = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)

    for _, plr in Players:GetPlayers() do
        if plr ~= LocalPlayer and IsEnemy(plr) then
            local char = plr.Character
            if char and char:FindFirstChild("Humanoid") and char.Humanoid.Health > 0 then
                local part = char:FindFirstChild(PrisonAPI.Aimbot.TargetPart) or char:FindFirstChild("Head")
                if part then
                    local pos, onScreen = Camera:WorldToViewportPoint(part.Position)
                    if onScreen then
                        local screenDist = (Vector2.new(pos.X, pos.Y) - screenCenter).Magnitude
                        if screenDist <= PrisonAPI.Aimbot.FOV then
                            if CanSee(part) then
                                local worldDist = (LocalPlayer.Character.HumanoidRootPart.Position - part.Position).Magnitude
                                if worldDist < closestDist then
                                    closestDist = worldDist
                                    closest = part
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    return closest
end

-- Main aimbot loop
local function StartAimbot()
    if AimbotConnections.Main then return end

    AimbotConnections.Main = RunService.RenderStepped:Connect(function()
        if not PrisonAPI.Aimbot.Enabled then return end
        if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then return end

        local target = GetTarget()
        if target then
            local targetPos = target.Position
            Camera.CFrame = Camera.CFrame:Lerp(CFrame.new(Camera.CFrame.Position, targetPos), PrisonAPI.Aimbot.Smoothness)
        end
    end)

    AimbotConnections.FOV = RunService.Heartbeat:Connect(UpdateFOVCircle)
end

local function StopAimbot()
    for _, conn in pairs(AimbotConnections) do
        if conn then conn:Disconnect() end
    end
    AimbotConnections = {}
    FOVCircle.Visible = false
end

-- Toggle handler
local function SetAimbotEnabled(state)
    PrisonAPI.Aimbot.Enabled = state
    if state then
        StartAimbot()
    else
        StopAimbot()
    end
end

-- Also update settings when changed
local function UpdateAimbotSettings()
    if PrisonAPI.Aimbot.Enabled then
        StopAimbot()
        StartAimbot()
    end
    UpdateFOVCircle()
end

--esp
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")

local TEAM_COLORS = {
    Inmates = Color3.fromRGB(255, 138, 0),
    Guards = Color3.fromRGB(0, 119, 255),
    Criminals = Color3.fromRGB(255, 51, 51)
}

local function createBillboardDot(character, color)
    local head = character:FindFirstChild("Head")
    if not head then return end

    -- remove existing
    local oldGui = head:FindFirstChild("HeadDotGui")
    if oldGui then oldGui:Destroy() end

    local billboard = Instance.new("BillboardGui")
    billboard.Name = "HeadDotGui"
    billboard.Adornee = head
    billboard.Size = UDim2.new(0, PrisonAPI.Dots.DotSize, 0, PrisonAPI.Dots.DotSize)
    billboard.StudsOffset = Vector3.new(0, PrisonAPI.Dots.OffsetY, 0)
    billboard.AlwaysOnTop = true
    billboard.Parent = head

    local outline = Instance.new("Frame")
    outline.Size = UDim2.new(1,0,1,0)
    outline.BackgroundColor3 = PrisonAPI.Dots.OutlineColor
    outline.BackgroundTransparency = PrisonAPI.Dots.OutlineTrans
    outline.BorderSizePixel = 0
    outline.Parent = billboard

    local fill = Instance.new("Frame")
    fill.Size = UDim2.new(0.6,0,0.6,0)
    fill.Position = UDim2.new(0.2,0,0.2,0)
    fill.BackgroundColor3 = color
    fill.BackgroundTransparency = PrisonAPI.Dots.FillTrans
    fill.BorderSizePixel = 0
    fill.AnchorPoint = Vector2.new(0.5,0.5)
    fill.Position = UDim2.new(0.5,0,0.5,0)
    fill.Parent = billboard
end

local function updateDot(player)
    if player == LocalPlayer then return end
    if not player.Character or not player.Team then return end
    local color = TEAM_COLORS[player.Team.Name]
    if not color then return end

    if PrisonAPI.Dots.Enabled then
        createBillboardDot(player.Character, color)
    else
        local head = player.Character:FindFirstChild("Head")
        if head then
            local old = head:FindFirstChild("HeadDotGui")
            if old then old:Destroy() end
        end
    end
end

local function onPlayer(player)
    player.CharacterAdded:Connect(function()
        task.wait(0.1)
        updateDot(player)
    end)
end

for _, p in ipairs(Players:GetPlayers()) do
    onPlayer(p)
    updateDot(p)
end
Players.PlayerAdded:Connect(onPlayer)

-- continuously update visibility for toggling
RunService.RenderStepped:Connect(function()
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            updateDot(player)
        end
    end
end)
--esp
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")

local TEAM_COLORS = {
    Inmates = Color3.fromRGB(255, 138, 0),
    Guards = Color3.fromRGB(0, 119, 255),
    Criminals = Color3.fromRGB(255, 51, 51)
}

local function createBillboardDot(character, color)
    local head = character:FindFirstChild("Head")
    if not head then return end

    -- remove existing
    local oldGui = head:FindFirstChild("HeadDotGui")
    if oldGui then oldGui:Destroy() end

    local billboard = Instance.new("BillboardGui")
    billboard.Name = "HeadDotGui"
    billboard.Adornee = head
    billboard.Size = UDim2.new(0, PrisonAPI.Dots.DotSize, 0, PrisonAPI.Dots.DotSize)
    billboard.StudsOffset = Vector3.new(0, PrisonAPI.Dots.OffsetY, 0)
    billboard.AlwaysOnTop = true
    billboard.Parent = head

    local outline = Instance.new("Frame")
    outline.Size = UDim2.new(1,0,1,0)
    outline.BackgroundColor3 = PrisonAPI.Dots.OutlineColor
    outline.BackgroundTransparency = PrisonAPI.Dots.OutlineTrans
    outline.BorderSizePixel = 0
    outline.Parent = billboard

    local fill = Instance.new("Frame")
    fill.Size = UDim2.new(0.6,0,0.6,0)
    fill.Position = UDim2.new(0.2,0,0.2,0)
    fill.BackgroundColor3 = color
    fill.BackgroundTransparency = PrisonAPI.Dots.FillTrans
    fill.BorderSizePixel = 0
    fill.AnchorPoint = Vector2.new(0.5,0.5)
    fill.Position = UDim2.new(0.5,0,0.5,0)
    fill.Parent = billboard
end

local function updateDot(player)
    if player == LocalPlayer then return end
    if not player.Character or not player.Team then return end
    local color = TEAM_COLORS[player.Team.Name]
    if not color then return end

    if PrisonAPI.Dots.Enabled then
        createBillboardDot(player.Character, color)
    else
        local head = player.Character:FindFirstChild("Head")
        if head then
            local old = head:FindFirstChild("HeadDotGui")
            if old then old:Destroy() end
        end
    end
end

local function onPlayer(player)
    player.CharacterAdded:Connect(function()
        task.wait(0.1)
        updateDot(player)
    end)
end

for _, p in ipairs(Players:GetPlayers()) do
    onPlayer(p)
    updateDot(p)
end
Players.PlayerAdded:Connect(onPlayer)

-- continuously update visibility for toggling
RunService.RenderStepped:Connect(function()
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            updateDot(player)
        end
    end
end)
