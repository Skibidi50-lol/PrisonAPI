--[[
	Skids will not understand ts 😂😂😂😂
--]]




game:GetService("StarterGui"):SetCore("SendNotification", {
	Title = "Prison API",
	Text = "Prison API - By Skibidi50-lol",
})

local L_1_ = game.Players.LocalPlayer

local function L_2_func(L_40_arg0)
	local L_41_ = L_1_.Character or L_1_.CharacterAdded:Wait()
	local L_42_ = L_41_:FindFirstChild("HumanoidRootPart")
	local L_43_ = L_41_:FindFirstChild("Humanoid")
	if not L_42_ or not L_43_ then
		return
	end
	L_43_.Health = 100
	L_42_.Anchored = true
	L_42_.CFrame = L_40_arg0 + Vector3.new(0, 5, 0)
	task.wait(0.05)
	L_42_.Anchored = false
end

local L_3_ = {
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
		OutlineColor = Color3.fromRGB(0, 0, 0),
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

local function L_4_func(L_44_arg0)
	if L_44_arg0:IsA("Model") then
		return L_44_arg0:GetPivot().p
	elseif L_44_arg0:IsA("BasePart") then
		return L_44_arg0.Position
	end
	return nil
end

local function L_5_func(L_45_arg0)
	local L_46_ = game.Players.LocalPlayer
	local L_47_ = L_46_.Character or L_46_.CharacterAdded:Wait()
	local L_48_ = L_47_:WaitForChild("HumanoidRootPart")
    
    -- Save exact old position + camera
	local L_49_ = L_48_.CFrame
	local L_50_ = workspace.CurrentCamera.CFrame

    -- Find the giver
	local L_51_ = nil
	for L_53_forvar0, L_54_forvar1 in workspace:GetDescendants() do
		if L_54_forvar1.Name == "TouchGiver" and L_54_forvar1:GetAttribute("ToolName") == L_45_arg0 then
			L_51_ = L_54_forvar1
			break
		end
	end
	if not L_51_ then
		game:GetService("StarterGui"):SetCore("SendNotification", {
			Title = "Prison API",
			Text = "No Gun Found!",
		})
		return
	end
	local L_52_ = L_4_func(L_51_)
	if not L_52_ then
		return
	end
	L_48_.CFrame = CFrame.new(L_52_ + Vector3.new(0, 8, 0))
	task.wait(1)

    -- Instant return to exact old spot
	L_48_.CFrame = L_49_
	workspace.CurrentCamera.CFrame = L_50_
	game:GetService("StarterGui"):SetCore("SendNotification", {
		Title = "Prison API",
		Text = "Succesfully Got Gun!",
	})
end
--Noclip
local L_6_ = game:GetService("Players")
local L_7_ = game:GetService("RunService")
local L_8_ = L_6_.LocalPlayer

--loop
L_7_.Stepped:Connect(function()
	if not L_3_.Noclip then
		return
	end
	if not L_8_.Character then
		return
	end
	for L_55_forvar0, L_56_forvar1 in pairs(L_8_.Character:GetDescendants()) do
		if L_56_forvar1:IsA("BasePart") and L_56_forvar1.CanCollide then
			L_56_forvar1.CanCollide = false
		end
	end
end)
--TpWalk
L_7_.RenderStepped:Connect(function()
	if not L_3_.TpWalkEnabled then
		return
	end
	local L_57_ = game.Players.LocalPlayer.Character
	local L_58_ = L_57_:FindFirstChild("Humanoid")
	local L_59_ = L_57_:FindFirstChild("HumanoidRootPart")
	if not L_58_ or not L_59_ then
		return
	end
	local L_60_ = L_58_.MoveDirection
	if L_60_.Magnitude > 0 then
		L_59_.CFrame = L_59_.CFrame + (L_60_ * L_3_.TpStepSize)
	end
end)
--Auto Arrest
local L_9_ = game:GetService("Players")
local L_10_ = game:GetService("ReplicatedStorage")
local L_11_ = game:GetService("RunService")

local L_12_ = L_9_.LocalPlayer
local L_13_ = L_10_.Remotes.ArrestPlayer

L_11_.Heartbeat:Connect(function()
	if not L_3_.AutoArrest then
		return
	end
	local L_61_ = L_12_.Character and L_12_.Character:FindFirstChild("HumanoidRootPart")
	if not L_61_ then
		return
	end
	for L_62_forvar0, L_63_forvar1 in L_9_:GetPlayers() do
		if L_63_forvar1 == L_12_ then
			continue
		end
		local L_64_ = L_63_forvar1.Character
		if not L_64_ then
			continue
		end
		local L_65_ = L_64_:FindFirstChild("HumanoidRootPart")
		local L_66_ = L_64_:FindFirstChild("Humanoid")
		if not L_65_ or not L_66_ or L_66_.Health <= 0 then
			continue
		end
		if (L_61_.Position - L_65_.Position).Magnitude <= 10 then
			task.spawn(function()
				pcall(L_13_.InvokeServer, L_13_, L_63_forvar1)
			end)
		end
	end
end)
--Auto Attack
local L_14_ = cloneref or function(L_67_arg0)
	return L_67_arg0
end

local L_15_ = L_14_(game:GetService('Players'))
local L_16_ = L_14_(game:GetService('ReplicatedStorage'))
local L_17_ = L_15_.LocalPlayer

local function L_18_func()
	local L_68_, L_69_ = math.huge, nil
	for L_70_forvar0, L_71_forvar1 in L_15_:GetPlayers() do
		if L_71_forvar1 == L_17_ then
			continue
		end
		pcall(function()
			local L_72_ = L_17_:DistanceFromCharacter(L_71_forvar1.Character.PrimaryPart.Position)
			if L_72_ < 6 and L_72_ < L_68_ then
				L_68_ = L_72_
				L_69_ = L_71_forvar1
			end
		end)
	end
	return L_69_
end

task.spawn(function()
	repeat
		local L_73_ = L_18_func()
		if L_73_ then
			L_16_.meleeEvent:FireServer(L_73_)
		end
		task.wait()
	until not L_3_.AutoAttack
end)
--auto respawn
spawn(function()
	while task.wait() and L_3_.AutoRespawn do
		if game.Players.LocalPlayer.Character.Humanoid.Health < 0.10 then
			local L_74_ = workspace.Camera.CFrame
			local L_75_ = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
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
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = L_75_
			workspace.Camera.CFrame = L_74_
		end
	end
end)
--TargetKill
local L_19_ = game:GetService("Players")
local L_20_ = game:GetService("RunService")
local L_21_ = game:GetService("ReplicatedStorage")
local L_22_ = L_19_.LocalPlayer

local function L_23_func(L_76_arg0, L_77_arg1, L_78_arg2)
	pcall(function()
		game:GetService("StarterGui"):SetCore("SendNotification", {
			Title = L_76_arg0 or "Prison API",
			Text = L_77_arg1,
			Duration = L_78_arg2 or 4
		})
	end)
end

function L_3_:StartTargetKill(L_79_arg0)
	local L_80_ = game.Players:FindFirstChild(L_79_arg0)
	if not L_80_ or not L_80_.Character or not L_80_.Character:FindFirstChild("HumanoidRootPart") then
		game:GetService("StarterGui"):SetCore("SendNotification", {
			Title = "Target Kill",
			Text = "Player not found or not spawned!",
			Duration = 5
		})
		return
	end

    -- Stop any old aura
	if L_3_.TargetKillAura.Connection then
		self.TargetKillAura.Connection:Disconnect()
	end
	L_3_.TargetKillAura.Target = L_80_
	L_3_.TargetKillAura.Enabled = true
	game:GetService("StarterGui"):SetCore("SendNotification", {
		Title = "Target Kill Aura",
		Text = "Killing " .. L_79_arg0 .. " (TP Under + Punch)",
		Duration = 5
	})
	L_3_.TargetKillAura.Connection = game:GetService("RunService").Heartbeat:Connect(function()
		if not L_3_.TargetKillAura.Enabled or not L_3_.TargetKillAura.Target then
			return
		end
		local L_81_ = game.Players.LocalPlayer.Character
		if not L_81_ or not L_81_:FindFirstChild("HumanoidRootPart") then
			return
		end
		local L_82_ = L_81_.HumanoidRootPart
		local L_83_ = self.TargetKillAura.Target.Character
		if not L_83_ or not L_83_:FindFirstChild("HumanoidRootPart") then
			game:GetService("StarterGui"):SetCore("SendNotification", {
				Title = "Target Lost",
				Text = L_79_arg0 .. " left the game",
				Duration = 5
			})
			self:StopTargetKill()
			return
		end
		local L_84_ = L_83_.HumanoidRootPart
		local L_85_ = L_83_:FindFirstChild("Humanoid")
		if not L_85_ or L_85_.Health <= 0 then
			game:GetService("StarterGui"):SetCore("SendNotification", {
				Title = "Target Killed!",
				Text = L_79_arg0 .. " eliminated!",
				Duration = 6
			})
			L_3_:StopTargetKill()
			return
		end
		local L_86_ = Vector3.new(math.random(-70, 70) / 100, 0, math.random(-70, 70) / 100)
		L_82_.CFrame = CFrame.new(L_84_.Position + L_86_ - Vector3.new(0, 4, 0), L_84_.Position)
		pcall(function()
			game:GetService("ReplicatedStorage").meleeEvent:FireServer(L_3_.TargetKillAura.Target)
		end)
	end)
end

function L_3_:StopTargetKill()
	if L_3_.TargetKillAura.Connection then
		L_3_.TargetKillAura.Connection:Disconnect()
		L_3_.TargetKillAura.Connection = nil
	end
	L_3_.TargetKillAura.Target = nil
	L_3_.TargetKillAura.Enabled = {
		Enabled = false,
		Target = nil,
		Connection = nil
	}
	game:GetService("StarterGui"):SetCore("SendNotification", {
		Title = "Target Kill Aura",
		Text = "Disabled",
		Duration = 3
	})
end
--target arrest
function L_3_:StartTargetArrest(L_87_arg0)
	local L_88_ = game.Players:FindFirstChild(L_87_arg0)
	if not L_88_ then
		game:GetService("StarterGui"):SetCore("SendNotification", {
			Title = "Target Arrest",
			Text = "Player not found!",
			Duration = 4
		})
		return false
	end
	if not L_88_.Character or not L_88_.Character:FindFirstChild("HumanoidRootPart") then
		game:GetService("StarterGui"):SetCore("SendNotification", {
			Title = "Target Arrest",
			Text = L_87_arg0 .. " not spawned yet!",
			Duration = 4
		})
		return false
	end

    -- Stop old one
	if L_3_.TargetArrest.Connection then
		L_3_.TargetArrest.Connection:Disconnect()
	end
	L_3_.TargetArrest.Target = L_88_
	L_3_.TargetArrest.Enabled = true
	game:GetService("StarterGui"):SetCore("SendNotification", {
		Title = "Target Arrest ON",
		Text = "Arresting only: " .. L_87_arg0,
		Duration = 5
	})
	L_3_.TargetArrest.Connection = game:GetService("RunService").Heartbeat:Connect(function()
		if not L_3_.TargetArrest.Enabled or not L_3_.TargetArrest.Target then
			return
		end
		local L_89_ = game.Players.LocalPlayer.Character
		if not L_89_ or not L_89_:FindFirstChild("HumanoidRootPart") then
			return
		end
		local L_90_ = L_89_.HumanoidRootPart
		local L_91_ = L_3_.TargetArrest.Target.Character
		if not L_91_ then
			game:GetService("StarterGui"):SetCore("SendNotification", {
				Title = "Target Lost",
				Text = L_87_arg0 .. " left the game",
				Duration = 5
			})
			L_3_:StopTargetArrest()
			return
		end
		local L_92_ = L_91_:FindFirstChild("HumanoidRootPart")
		local L_93_ = L_91_:FindFirstChild("Humanoid")
		if not L_92_ or not L_93_ or L_93_.Health <= 0 then
			game:GetService("StarterGui"):SetCore("SendNotification", {
				Title = "Target Arrested!",
				Text = L_87_arg0 .. " has been arrested!",
				Duration = 6
			})
			L_3_:StopTargetArrest()
			return
		end
		local L_94_ = Vector3.new(math.random(-60, 60) / 100, 0, math.random(-60, 60) / 100)
		L_90_.CFrame = CFrame.new(L_92_.Position + L_94_ - Vector3.new(0, 4, 0), L_92_.Position)
		if (L_90_.Position - L_92_.Position).Magnitude <= 14 then
			pcall(function()
				game:GetService("ReplicatedStorage").Remotes.ArrestPlayer:InvokeServer(L_3_.TargetArrest.Target)
			end)
		end
	end)
end

function L_3_:StopTargetArrest()
	if L_3_.TargetArrest.Connection then
		L_3_.TargetArrest.Connection:Disconnect()
		L_3_.TargetArrest.Connection = nil
	end
	L_3_.TargetArrest.Target = nil
	L_3_.TargetArrest.Enabled = false
	game:GetService("StarterGui"):SetCore("SendNotification", {
		Title = "Target Arrest",
		Text = "Disabled",
		Duration = 3
	})
end

-- Auto stop on respawn
game.Players.LocalPlayer.CharacterAdded:Connect(function()
	if L_3_.TargetArrest.Enabled then
		L_3_:StopTargetArrest()
	end
end)
--no anti jump
function L_3_.NoAntiJump()
	local L_95_ = game:GetService("Players").LocalPlayer
	local L_96_ = pcall
	local L_97_ = L_95_.Character or L_95_.CharacterAdded:Wait()
	local L_98_ = L_97_:FindFirstChild("AntiJump")
	if L_98_ and L_98_:IsA("LocalScript") then
		L_96_(function()
			L_98_:Destroy()
		end)
	end
	game:GetService("StarterGui"):SetCore("SendNotification", {
		Title = "Prison API",
		Text = "No Anti Jump Applied",
	})
end
--workspace
function L_3_.EscapePrison()
	L_2_func(CFrame.new(-927.7, 94.1, 2055.3))
end

function L_3_.YardTP()
	L_2_func(CFrame.new(791.5, 98, 2498.5))
end

function L_3_.PoliceRoomTP()
	L_2_func(CFrame.new(837.9, 99.8, 2267.3))
end

function L_3_.CrimBaseTP()
	L_2_func(CFrame.new(-927.7, 94.1, 2055.3))
end

function L_3_.DeleteDoors()
	game.workspace.Doors:Destroy()
end

function L_3_.DeleteCells()
	game.workspace.Prison_Cellblock:Destroy()
end

function L_3_.DeleteCellsDoors()
	game.workspace.CellDoors:Destroy()
end

function L_3_.Btools()
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
	game:GetService("StarterGui"):SetCore("SendNotification", {
		Title = "Prison API",
		Text = "Succesfully Get Btools!",
	})
end

function L_3_.BecomeCriminal()
	local L_99_ = game.Players.LocalPlayer
	local L_100_ = L_99_.Character
	if not L_100_ or not L_100_:FindFirstChild("HumanoidRootPart") then
		game:GetService("StarterGui"):SetCore("SendNotification", {
			Title = "Prison API Error",
			Text = "Spawn First!",
		})
		return
	end
	local L_101_ = L_100_.HumanoidRootPart
	savedPosition = {
		pos = L_101_.CFrame,
		camera = workspace.CurrentCamera.CFrame
	}
	game:GetService("StarterGui"):SetCore("SendNotification", {
		Title = "Prison API",
		Text = "Old Position Saved Tp to Criminal Base",
	})
	L_2_func(CFrame.new(-927.7, 94.1, 2055.3))
	task.wait(0.5)
	if L_99_.TeamColor.Name == "Bright orange" then
		pcall(function()
			game:GetService("ReplicatedStorage").Remote.TeamEvent:FireServer("Really red")
		end)
		task.wait(1.2)
	end
	task.wait(0.3)
	L_101_.CFrame = savedPosition.pos
	workspace.CurrentCamera.CFrame = savedPosition.camera
	game:GetService("StarterGui"):SetCore("SendNotification", {
		Title = "Prison API",
		Text = "Succesfully Become Criminal!",
	})
	savedPosition = nil
end
--aimbot
local L_24_ = game:GetService("Players")
local L_25_ = game:GetService("RunService")
local L_26_ = game:GetService("Workspace")
local L_27_ = L_26_.CurrentCamera
local L_28_ = L_24_.LocalPlayer

local L_29_ = Drawing.new("Circle")
L_29_.Thickness = 2
L_29_.NumSides = 70
L_29_.Radius = L_3_.Aimbot.FOV
L_29_.Filled = false
L_29_.Color = L_3_.Aimbot.FOVColor
L_29_.Transparency = 0.7
L_29_.Visible = L_3_.Aimbot.ShowFOV

-- Update FOV Circle every frame
L_25_.RenderStepped:Connect(function()
	if L_3_.Aimbot.ShowFOV then
		L_29_.Position = Vector2.new(L_27_.ViewportSize.X / 2, L_27_.ViewportSize.Y / 2)
		L_29_.Radius = L_3_.Aimbot.FOV
		L_29_.Visible = true
	else
		L_29_.Visible = false
	end
end)

-- Check if enemy (team check)
local function L_30_func(L_102_arg0)
	if not L_102_arg0 or L_102_arg0 == L_28_ then
		return false
	end
	if not L_3_.Aimbot.TeamCheck then
		return true
	end
	return L_102_arg0.Team ~= L_28_.Team
end

-- Get best target inside FOV
local function L_31_func()
	local L_103_ = nil
	local L_104_ = L_3_.Aimbot.FOV
	local L_105_ = Vector2.new(L_27_.ViewportSize.X / 2, L_27_.ViewportSize.Y / 2)
	for L_106_forvar0, L_107_forvar1 in pairs(L_24_:GetPlayers()) do
		if L_30_func(L_107_forvar1) and L_107_forvar1.Character and L_107_forvar1.Character:FindFirstChild("Humanoid") and L_107_forvar1.Character.Humanoid.Health > 0 then
			local L_108_ = L_107_forvar1.Character:FindFirstChild(L_3_.Aimbot.TargetPart) or L_107_forvar1.Character:FindFirstChild("Head") or L_107_forvar1.Character:FindFirstChild("HumanoidRootPart")
			if L_108_ then
				local L_109_, L_110_ = L_27_:WorldToViewportPoint(L_108_.Position)
				if L_110_ then
					local L_111_ = (Vector2.new(L_109_.X, L_109_.Y) - L_105_).Magnitude
					if L_111_ < L_104_ then
						local L_112_ = true
						if L_3_.Aimbot.WallCheck then
							local L_113_ = Ray.new(L_27_.CFrame.Position, (L_108_.Position - L_27_.CFrame.Position).Unit * 500)
							local L_114_ = L_26_:FindPartOnRayWithIgnoreList(L_113_, {
								L_28_.Character
							})
							L_112_ = (L_114_ and L_114_:IsDescendantOf(L_107_forvar1.Character))
						end
						if L_112_ then
							L_104_ = L_111_
							L_103_ = L_108_
						end
					end
				end
			end
		end
	end
	return L_103_
end

-- Main Aimbot Loop
local L_32_
function L_3_:StartAimbot()
	if self.Aimbot.Enabled then
		return
	end
	self.Aimbot.Enabled = true
	if L_32_ then
		L_32_:Disconnect()
	end
	L_32_ = L_25_.RenderStepped:Connect(function()
		if not self.Aimbot.Enabled then
			return
		end
		if not L_28_.Character or not L_28_.Character:FindFirstChild("HumanoidRootPart") then
			return
		end
		local L_115_ = L_31_func()
		if L_115_ then
			local L_116_ = L_115_.Position
			L_27_.CFrame = L_27_.CFrame:Lerp(CFrame.new(L_27_.CFrame.Position, L_116_), self.Aimbot.Smoothness)
		end
	end)
	game:GetService("StarterGui"):SetCore("SendNotification", {
		Title = "Prison API",
		Text = "Aimbot Actived",
		Duration = 3
	})
end

function L_3_:StopAimbot()
	if L_32_ then
		L_32_:Disconnect()
		L_32_ = nil
	end
	self.Aimbot.Enabled = false
	game:GetService("StarterGui"):SetCore("SendNotification", {
		Title = "Prison API",
		Text = "Aimbot Deactived",
		Duration = 2
	})
end
--esp
local L_33_ = game:GetService("Players")
local L_34_ = L_33_.LocalPlayer
local L_35_ = game:GetService("RunService")

local L_36_ = {
	Inmates = Color3.fromRGB(255, 138, 0),
	Guards = Color3.fromRGB(0, 119, 255),
	Criminals = Color3.fromRGB(255, 51, 51)
}

local function L_37_func(L_117_arg0, L_118_arg1)
	local L_119_ = L_117_arg0:FindFirstChild("Head")
	if not L_119_ then
		return
	end

    -- remove existing
	local L_120_ = L_119_:FindFirstChild("HeadDotGui")
	if L_120_ then
		L_120_:Destroy()
	end
	local L_121_ = Instance.new("BillboardGui")
	L_121_.Name = "HeadDotGui"
	L_121_.Adornee = L_119_
	L_121_.Size = UDim2.new(0, L_3_.Dots.DotSize, 0, L_3_.Dots.DotSize)
	L_121_.StudsOffset = Vector3.new(0, L_3_.Dots.OffsetY, 0)
	L_121_.AlwaysOnTop = true
	L_121_.Parent = L_119_
	local L_122_ = Instance.new("Frame")
	L_122_.Size = UDim2.new(1, 0, 1, 0)
	L_122_.BackgroundColor3 = L_3_.Dots.OutlineColor
	L_122_.BackgroundTransparency = L_3_.Dots.OutlineTrans
	L_122_.BorderSizePixel = 0
	L_122_.Parent = L_121_
	local L_123_ = Instance.new("Frame")
	L_123_.Size = UDim2.new(0.6, 0, 0.6, 0)
	L_123_.Position = UDim2.new(0.2, 0, 0.2, 0)
	L_123_.BackgroundColor3 = L_118_arg1
	L_123_.BackgroundTransparency = L_3_.Dots.FillTrans
	L_123_.BorderSizePixel = 0
	L_123_.AnchorPoint = Vector2.new(0.5, 0.5)
	L_123_.Position = UDim2.new(0.5, 0, 0.5, 0)
	L_123_.Parent = L_121_
end

local function L_38_func(L_124_arg0)
	if L_124_arg0 == L_34_ then
		return
	end
	if not L_124_arg0.Character or not L_124_arg0.Team then
		return
	end
	local L_125_ = L_36_[L_124_arg0.Team.Name]
	if not L_125_ then
		return
	end
	if L_3_.Dots.Enabled then
		L_37_func(L_124_arg0.Character, L_125_)
	else
		local L_126_ = L_124_arg0.Character:FindFirstChild("Head")
		if L_126_ then
			local L_127_ = L_126_:FindFirstChild("HeadDotGui")
			if L_127_ then
				L_127_:Destroy()
			end
		end
	end
end

local function L_39_func(L_128_arg0)
	L_128_arg0.CharacterAdded:Connect(function()
		task.wait(0.1)
		L_38_func(L_128_arg0)
	end)
end

for L_129_forvar0, L_130_forvar1 in ipairs(L_33_:GetPlayers()) do
	L_39_func(L_130_forvar1)
	L_38_func(L_130_forvar1)
end
L_33_.PlayerAdded:Connect(L_39_func)

-- continuously update visibility for toggling
L_35_.RenderStepped:Connect(function()
	for L_131_forvar0, L_132_forvar1 in ipairs(L_33_:GetPlayers()) do
		if L_132_forvar1 ~= L_34_ and L_132_forvar1.Character then
			L_38_func(L_132_forvar1)
		end
	end
end)
