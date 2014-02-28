AddCSLuaFile()

DEFINE_BASECLASS( "base_wire_entity" )

ENT.PrintName = "ACF Engine Maker"
ENT.WireDebugName = "ACF Engine Maker"

if CLIENT then
	
	function ACFEngineMakerGUICreate( Table )
		if not acfmenupanel.ModData then
			acfmenupanel.ModData = {}
		end
		if not acfmenupanel.ModData[Table.id] then
			acfmenupanel.ModData[Table.id] = {}
			acfmenupanel.ModData[Table.id]["ModTable"] = Table.modtable
		end
		
		acfmenupanel:CPanelText("Name", Table.name)
		acfmenupanel:CPanelText("Desc", "Desc : "..Table.desc)
		
		for ID,Value in pairs(acfmenupanel.ModData[Table.id]["ModTable"]) do
			if ID == 1 then
				ACF_ModingEngine()
			end
		end
				
	acfmenupanel.CustomDisplay:PerformLayout()
	
	end
	
	function ACF_ModingEngine( )
		--############
		--loading
		local Redcolor = 0
		local Greencolor = 0
		local Bluecolor = 0
		if file.Exists("acf/menucolor.txt", "DATA") then
			local MenuColor = file.Read("acf/menucolor.txt")
			local MenuColorTable = {}
			for w in string.gmatch(MenuColor, "([^,]+)") do
				table.insert(MenuColorTable, w)
			end
			Redcolor = tonumber(MenuColorTable[1])
			Greencolor = tonumber(MenuColorTable[2])
			Bluecolor = tonumber(MenuColorTable[3])
			local RedString = tostring(Redcolor)
			local GreenString = tostring(Greencolor)
			local BlueString = tostring(Bluecolor)
		else
			Redcolor = 0
			Greencolor = 0
			Bluecolor = 200
		end
		--First Load
		local NameLoad = "No Name"
		local SoundLoad = "No Sound"
		local ModelLoad = "models/engines/inline4s.mdl"
		local FuelTypeLoad = "Petrol"
		local EngineTypeLoad = "GenericPetrol"
		local TorqueLoad = 1
		local IdleLoad = 1
		local PeakMinLoad = 1
		local PeakMaxLoad = 1
		local LimitRpmLoad = 1
		local FlywheelLoad = 1
		local WeightLoad = 1
		local EngineSizeText = 1
		local EngineTypeText = 1
		local IselectText = "false"
		local IsTransText = "false"
		local FlywheelOverNumber = 1
		
		if not file.Exists("acf/lastengine.txt", "DATA") then
			local txt = NameLoad..","..SoundLoad..","..ModelLoad..","..FuelTypeLoad..","..EngineTypeLoad..","..TorqueLoad..","
			txt = txt ..IdleLoad..","..PeakMinLoad..","..PeakMaxLoad..","..LimitRpmLoad..","..FlywheelLoad..","..WeightLoad..","
			txt = txt ..EngineSizeText..","..EngineTypeText..","..IselectText..","..IsTransText..","..FlywheelOverNumber
			file.CreateDir("acf")
			file.CreateDir("acf/custom.engines")
			file.Write("acf/lastengine.txt", txt)
			acfmenupanel.CustomDisplay:PerformLayout()
		end
		--###########################################
		local wide = acfmenupanel.CustomDisplay:GetWide()
		
		Open = vgui.Create("DButton")
		Open:SetText("Open Engine Menu")
		Open:SetTextColor(Color(Redcolor,Greencolor,Bluecolor,255))
		Open:SetWide(wide)
		Open:SetTall(30)
		Open:SetVisible(true)
		Open.DoClick = function()
			RunConsoleCommand("acf_enginestart_browser_open")
		end
		acfmenupanel.CustomDisplay:AddItem(Open)
		
		DisplayModel = vgui.Create( "DModelPanel", acfmenupanel.CustomDisplay )
		DisplayModel:SetModel( ModelLoad )
		DisplayModel:SetCamPos( Vector( 250, 500, 250 ) )
		DisplayModel:SetLookAt( Vector( 0, 0, 0 ) )
		DisplayModel:SetFOV( 20 )
		DisplayModel:SetSize(acfmenupanel:GetWide(),acfmenupanel:GetWide())
		DisplayModel.LayoutEntity = function( panel, entity ) end
		acfmenupanel.CustomDisplay:AddItem( DisplayModel )
		
		acfmenupanel:CPanelText("EngName", "Engine Name : "..NameLoad)
		acfmenupanel:CPanelText("EngSound", "Sound : "..SoundLoad)
		acfmenupanel:CPanelText("EngModel", "Model : "..ModelLoad)
		acfmenupanel:CPanelText("EngFuel", "Fuel Type : "..FuelTypeLoad)
		acfmenupanel:CPanelText("EngType", "Engine Type : "..EngineTypeLoad)
		acfmenupanel:CPanelText("EngTorque", "Torque : "..TorqueLoad)
		acfmenupanel:CPanelText("EngIdle", "Idle Rpm : "..IdleLoad)
		acfmenupanel:CPanelText("EngPeakMin", "Peak Min Rpm : "..PeakMinLoad)
		acfmenupanel:CPanelText("EngPeakMax", "Peak Max Rpm : "..PeakMaxLoad)
		acfmenupanel:CPanelText("EngLimit", "Limit Rpm : "..LimitRpmLoad)
		acfmenupanel:CPanelText("EngFly", "Flywheel Mass : "..FlywheelLoad)
		acfmenupanel:CPanelText("EngWeight", "Weight : "..WeightLoad)
		
		Help = vgui.Create("DButton")
		Help:SetToolTip("1.Create/Load a engine in the Engine menu\n2.Update the text by selecting again Engine Maker\n3.Spawn the Engine !")
		Help:SetTextColor(Color(0,150,0,255))
		Help:SetWide(wide/2)
		Help:SetTall(30)
		Help:SetVisible(true)
		Help:SetText("Help")
		acfmenupanel.CustomDisplay:AddItem(Help)
		--Reload Last Engine
		if file.Exists("acf/lastengine.txt", "DATA") then
			local LastEngineText = file.Read("acf/lastengine.txt")
			local LastEngineTable = {}
			for w in string.gmatch(LastEngineText, "([^,]+)") do
				table.insert(LastEngineTable, w)
			end
			
			NameLoad = tostring(LastEngineTable[1])
			SoundLoad = tostring(LastEngineTable[2])
			ModelLoad = tostring(LastEngineTable[3])
			FuelTypeLoad = tostring(LastEngineTable[4])
			EngineTypeLoad = tostring(LastEngineTable[5])
			TorqueLoad = tonumber(LastEngineTable[6])
			IdleLoad = tonumber(LastEngineTable[7])
			PeakMinLoad = tonumber(LastEngineTable[8])
			PeakMaxLoad = tonumber(LastEngineTable[9])
			LimitRpmLoad = tonumber(LastEngineTable[10])
			FlywheelLoad = tonumber(LastEngineTable[11])
			WeightLoad = tonumber(LastEngineTable[12])
			IselectText = tostring(LastEngineTable[15])
			IsTransText = tostring(LastEngineTable[16])
			FlywheelOverNumber = tonumber(LastEngineTable[17])
			RunConsoleCommand( "acfmenu_data1", NameLoad )
			RunConsoleCommand( "acfmenu_data2", SoundLoad )
			RunConsoleCommand( "acfmenu_data3", ModelLoad )
			RunConsoleCommand( "acfmenu_data4", FuelTypeLoad )
			RunConsoleCommand( "acfmenu_data5", EngineTypeLoad )
			RunConsoleCommand( "acfmenu_data6", TorqueLoad )
			RunConsoleCommand( "acfmenu_data7", IdleLoad )
			RunConsoleCommand( "acfmenu_data8", PeakMinLoad )
			RunConsoleCommand( "acfmenu_data9", PeakMaxLoad )
			RunConsoleCommand( "acfmenu_data10", LimitRpmLoad )
			RunConsoleCommand( "acfmenu_data11", FlywheelLoad )
			RunConsoleCommand( "acfmenu_data12", WeightLoad )
			RunConsoleCommand( "acfmenu_data13", IselectText )
			RunConsoleCommand( "acfmenu_data14", IsTransText )
			RunConsoleCommand( "acfmenu_data15", FlywheelOverNumber )
			--###
			acfmenupanel:CPanelText("EngName", "Engine Name : "..NameLoad)
			acfmenupanel:CPanelText("EngSound", "Sound : "..SoundLoad)
			acfmenupanel:CPanelText("EngModel", "Model : "..ModelLoad)
			acfmenupanel:CPanelText("EngFuel", "Fuel Type : "..FuelTypeLoad)
			acfmenupanel:CPanelText("EngType", "Engine Type : "..EngineTypeLoad)
			acfmenupanel:CPanelText("EngTorque", "Torque : "..TorqueLoad)
			acfmenupanel:CPanelText("EngIdle", "Idle Rpm : "..IdleLoad)
			acfmenupanel:CPanelText("EngPeakMin", "Peak Min Rpm : "..PeakMinLoad)
			acfmenupanel:CPanelText("EngPeakMax", "Peak Max Rpm : "..PeakMaxLoad)
			acfmenupanel:CPanelText("EngLimit", "Limit Rpm : "..LimitRpmLoad)
			acfmenupanel:CPanelText("EngFly", "Flywheel Mass : "..FlywheelLoad)
			acfmenupanel:CPanelText("EngWeight", "Weight : "..WeightLoad)
			DisplayModel:SetModel( ModelLoad )
			
			acfmenupanel.CustomDisplay:PerformLayout()
		end
	
	end
	
	return
	
end

--###################################################
--##### 			END CL_INIT					#####
--###################################################

function ENT:Initialize()

	self.Throttle = 0
	self.Active = false
	self.IsMaster = true
	self.GearLink = {} -- a "Link" has these components: Ent, Rope, RopeLen, ReqTq
	self.FuelLink = {}

	self.LastCheck = 0
	self.LastThink = 0
	self.MassRatio = 1
	self.Legal = true
	self.CanUpdate = true
	self.RequiresFuel = 0
	
	--####################
	self.TqAdd = 0
	self.MaxRpmAdd = 0
	self.LimitRpmAdd = 0
	self.FlywheelMass = 0
	self.WeightKg = 0
	self.idle = 0
	self.CutMode = 0
	self.CutValue = 0
	self.CutRpm = 0
	self.DisableAutoClutch = 0
	self.Fuelusing = 0
	self.DisableCut = 0
	--#####################
	self.Outputs = WireLib.CreateSpecialOutputs( self, { "RPM", "Torque", "Power", "Fuel Use", "Entity", "Mass", "Physical Mass" }, { "NORMAL","NORMAL","NORMAL", "NORMAL", "ENTITY", "NORMAL", "NORMAL" } )
	Wire_TriggerOutput( self, "Entity", self )
end

--###################################################
--##### 			MAKE ENGINE					#####
--###################################################

function MakeACF_EngineMaker(Owner, Pos, Angle, Id, Data1, Data2, Data3, Data4, Data5, Data6, Data7, Data8, Data9, Data10, Data11, Data12, Data13, Data14, Data15)

	if not Owner:CheckLimit("_acf_misc") then return false end

	local EngineMaker = ents.Create( "acf_enginemaker" )
	if not IsValid( EngineMaker ) then return false end
	
	local EID
	local List = list.Get("ACFEnts")
	if List["Mobility"][Id] then EID = Id else EID = "Maker" end
	local Lookup = List.Mobility[EID]
	
	EngineMaker:SetAngles(Angle)
	EngineMaker:SetPos(Pos)
	EngineMaker:Spawn()
	EngineMaker:SetPlayer(Owner)
	EngineMaker.Owner = Owner
	EngineMaker.Id = EID
	
	EngineMaker.elecpower = Lookup.elecpower
	EngineMaker.SoundPitch = Lookup.pitch or 1
	EngineMaker.SpecialHealth = true
	EngineMaker.ModTable = Lookup.modtable
		EngineMaker.ModTable[1] = Data1
		EngineMaker.ModTable[2] = Data2
		EngineMaker.ModTable[3] = Data3
		EngineMaker.ModTable[4] = Data4
		EngineMaker.ModTable[5] = Data5
		EngineMaker.ModTable[6] = Data6
		EngineMaker.ModTable[7] = Data7
		EngineMaker.ModTable[8] = Data8
		EngineMaker.ModTable[9] = Data9
		EngineMaker.ModTable[10] = Data10
		EngineMaker.ModTable[11] = Data11
		EngineMaker.ModTable[12] = Data12
		EngineMaker.ModTable[13] = Data13
		EngineMaker.ModTable[14] = Data14
		EngineMaker.ModTable[15] = Data15
		
		EngineMaker.Mod1 = Data1
		EngineMaker.Mod2 = Data2
		EngineMaker.Mod3 = Data3
		EngineMaker.Mod4 = Data4
		EngineMaker.Mod5 = Data5
		EngineMaker.Mod6 = Data6
		EngineMaker.Mod7 = Data7
		EngineMaker.Mod8 = Data8
		EngineMaker.Mod9 = Data9
		EngineMaker.Mod10 = Data10
		EngineMaker.Mod11 = Data11
		EngineMaker.Mod12 = Data12
		EngineMaker.Mod13 = Data13
		EngineMaker.Mod14 = Data14
		EngineMaker.Mod15 = Data15
		--Set Strings Values
		if tostring(EngineMaker.Mod1) != nil then EngineMaker.EngineName = tostring(EngineMaker.Mod1) else EngineMaker.EngineName = "No Name" end
		if tostring(EngineMaker.Mod2) != nil then EngineMaker.SoundPath = tostring(EngineMaker.Mod2) else EngineMaker.SoundPath = "" end
		if string.find(tostring(EngineMaker.Mod3),".mdl") then EngineMaker.Model = tostring(EngineMaker.Mod3) else EngineMaker.Model = "models/engines/inline4s.mdl" end
		if tostring(EngineMaker.Mod4) != nil then EngineMaker.FuelType = tostring(EngineMaker.Mod4) else EngineMaker.FuelType = "Petrol" end
		if tostring(EngineMaker.Mod5) != nil then EngineMaker.EngineType = tostring(EngineMaker.Mod5) else EngineMaker.EngineType = "GenericPetrol" end
		--Set Torque
		if(tonumber(EngineMaker.Mod6) >= 1) then EngineMaker.PeakTorque = tonumber(EngineMaker.Mod6)
		elseif(tonumber(Data6) < 1 or tonumber(Data6) == nil) then EngineMaker.PeakTorque = 1 end
		--Set Idle
		if(tonumber(EngineMaker.Mod7) >= 1) then EngineMaker.IdleRPM = tonumber(EngineMaker.Mod7)
		elseif(tonumber(EngineMaker.Mod7) < 1 or tonumber(EngineMaker.Mod7) == nil) then EngineMaker.IdleRPM = 1 end
		--Set PeakMin
		if(tonumber(EngineMaker.Mod8) >= 1) then EngineMaker.PeakMinRPM = tonumber(EngineMaker.Mod8)
		elseif(tonumber(EngineMaker.Mod8) < 1 or tonumber(EngineMaker.Mod8) == nil) then EngineMaker.PeakMinRPM = 1 end
		--Set PeakMax
		if(EngineMaker.Mod9 <= EngineMaker.Mod10 and tonumber(EngineMaker.Mod9) >= 1 ) then  EngineMaker.PeakMaxRPM = tonumber(EngineMaker.Mod9)
		elseif(EngineMaker.Mod9 > EngineMaker.Mod10 ) then EngineMaker.PeakMaxRPM = tonumber(EngineMaker.Mod10)
		elseif(tonumber(EngineMaker.Mod9) < 1 or tonumber(EngineMaker.Mod9) == nil) then EngineMaker.PeakMaxRPM = 1 end
		--Set Limit
		if(tonumber(EngineMaker.Mod10) >= 100) then EngineMaker.LimitRPM = tonumber(EngineMaker.Mod10)
		elseif(tonumber(EngineMaker.Mod10) < 100 or tonumber(EngineMaker.Mod10) == nil) then EngineMaker.LimitRPM = 100 end
		--Set Flywheel
		if(tonumber(EngineMaker.Mod11) >= 0.001) then EngineMaker.FlywheelMassValue = tonumber(EngineMaker.Mod11)
		elseif(tonumber(EngineMaker.Mod11) < 0.001 or tonumber(EngineMaker.Mod11) == nil) then EngineMaker.FlywheelMassValue = 0.001 end
		--Set Weight
		if(tonumber(EngineMaker.Mod12) >= 1) then EngineMaker.Weight = tonumber(EngineMaker.Mod12)
		elseif(tonumber(EngineMaker.Mod12) < 1 or tonumber(EngineMaker.Mod12) == nil ) then EngineMaker.Weight = 1 end
		--Set Electric/turbine stuff
		if tobool(EngineMaker.Mod13) != nil then EngineMaker.iselec = tobool(EngineMaker.Mod13) else EngineMaker.iselec = false end
		if tobool(EngineMaker.Mod14) != nil then EngineMaker.IsTrans = tobool(EngineMaker.Mod14) else EngineMaker.IsTrans = false end
		if tonumber(EngineMaker.Mod15) != nil then EngineMaker.FlywheelOverride = tonumber(EngineMaker.Mod15) else EngineMaker.FlywheelOverride = 1200  end
		--Set Original Values
		EngineMaker.PeakTorqueHeld = EngineMaker.PeakTorque
		EngineMaker.CutValue = EngineMaker.LimitRPM / 40
		EngineMaker.CutRpm = EngineMaker.LimitRPM - 100
		EngineMaker.Inertia = EngineMaker.FlywheelMassValue*(3.1416)^2
		--Set Custom Values
		EngineMaker.FlywheelMass3 = EngineMaker.FlywheelMassValue
		EngineMaker.PeakTorqueLoad = EngineMaker.PeakTorque
		EngineMaker.PeakTorqueAdd = EngineMaker.PeakTorque
		EngineMaker.Idling = EngineMaker.IdleRPM
		EngineMaker.PeakMaxRPM2 = EngineMaker.PeakMaxRPM
		EngineMaker.LimitRPM2 = EngineMaker.LimitRPM
		--calculate boosted peak kw
		if EngineMaker.EngineType == "Turbine" or EngineMaker.EngineType == "Electric" then
			EngineMaker.DisableCut = 1
			EngineMaker.peakkw = EngineMaker.PeakTorque * EngineMaker.LimitRPM / (4 * 9548.8)
			EngineMaker.PeakKwRPM = math.floor(EngineMaker.LimitRPM / 2)
		else
			EngineMaker.peakkw = EngineMaker.PeakTorque * EngineMaker.PeakMaxRPM / 9548.8
			EngineMaker.PeakKwRPM = EngineMaker.PeakMaxRPM
		end
		--calculate base fuel usage
		if EngineMaker.EngineType == "Electric" then
			EngineMaker.FuelUse = ACF.ElecRate / (ACF.Efficiency[EngineMaker.EngineType] * 60 * 60) --elecs use current power output, not max
		else
			EngineMaker.FuelUse = ACF.TorqueBoost * ACF.FuelRate * ACF.Efficiency[EngineMaker.EngineType] * EngineMaker.peakkw / (60 * 60)
		end
		--Creating Wire Inputs
		local Inputs = {"Active", "Throttle", "TqAdd"}
		if EngineMaker.EngineType != "Turbine" or EngineMaker.EngineType != "Electric" then --Create inputs engines
			table.insert(Inputs, "MaxRpmAdd")
			table.insert(Inputs, "LimitRpmAdd")
			table.insert(Inputs, "FlywheelMass")
			table.insert(Inputs, "Idle")
			table.insert(Inputs, "Disable Cutoff")
			table.insert(Inputs, "Gearbox RPM")
		elseif EngineMaker.EngineType == "Turbine" or EngineMaker.EngineType == "Electric" then	--Create ADV inputs for Electric&Turbine
			table.insert(Inputs, "LimitRpmAdd")
			table.insert(Inputs, "FlywheelMass")
			table.insert(Inputs, "Override")
			table.insert(Inputs, "Gearbox RPM")
		end
		EngineMaker.Inputs = Wire_CreateInputs( EngineMaker, Inputs )
	
	EngineMaker.FlyRPM = 0
	EngineMaker:SetModel( EngineMaker.Model )	
	EngineMaker.Sound = nil
	EngineMaker.RPM = {}

	EngineMaker:PhysicsInit( SOLID_VPHYSICS )      	
	EngineMaker:SetMoveType( MOVETYPE_VPHYSICS )     	
	EngineMaker:SetSolid( SOLID_VPHYSICS )

	EngineMaker.Out = EngineMaker:WorldToLocal(EngineMaker:GetAttachment(EngineMaker:LookupAttachment( "driveshaft" )).Pos)

	local phys = EngineMaker:GetPhysicsObject()  	
	if IsValid( phys ) then
		phys:SetMass( EngineMaker.Weight ) 
	end

	EngineMaker:SetNetworkedString( "WireName", EngineMaker.EngineName )
	------ GUI ---------
	EngineMaker.FlywheelMassGUI = EngineMaker.FlywheelMassValue
	EngineMaker:UpdateOverlayText()
	
	Owner:AddCount("_acf_enginemaker", EngineMaker)
	Owner:AddCleanup( "acfmenu", EngineMaker )
	
	ACF_Activate( EngineMaker, 0 )

	return EngineMaker
end
list.Set( "ACFCvars", "acf_enginemaker", {"id", "data1", "data2", "data3", "data4", "data5", "data6", "data7", "data8", "data9", "data10", "data11", "data12", "data13", "data14", "data15"} )
duplicator.RegisterEntityClass("acf_enginemaker", MakeACF_EngineMaker, "Pos", "Angle", "Id", "Mod1", "Mod2", "Mod3", "Mod4", "Mod5", "Mod6", "Mod7", "Mod8", "Mod9", "Mod10", "Mod11", "Mod12", "Mod13")

--###################################################
--##### 		UPDATE ENGINE					#####
--###################################################

function ENT:Update( ArgsTable )	--That table is the player data, as sorted in the ACFCvars above, with player who shot, and pos and angle of the tool trace inserted at the start
	-- That table is the player data, as sorted in the ACFCvars above, with player who shot, 
	-- and pos and angle of the tool trace inserted at the start

	if self.Active then
		return false, "Turn off the engine before updating it!"
	end
	
	if ArgsTable[1] ~= self.Owner then -- Argtable[1] is the player that shot the tool
		return false, "You don't own that engine!"
	end

	local Id = ArgsTable[4]	-- Argtable[4] is the engine ID
	local Lookup = list.Get("ACFEnts").Mobility[Id]

	if ArgsTable[7] ~= self.Model then
		return false, "The new engine must have the same model!"
	end
	
	local Feedback = ""
	if Lookup.fuel != self.FuelType then
		Feedback = " Fuel type changed, fuel tanks unlinked."
		for Key,Value in pairs(self.FuelLink) do
			table.remove(self.FuelLink,Key)
			--need to remove from tank master?
		end
	end
	
	if self.Id != Id then
		self.Id = Id
		self.elecpower = Lookup.elecpower -- how much power does it output
		self.SoundPitch = Lookup.pitch or 1
		self.SpecialHealth = true
	end
	self.ModTable[1] = ArgsTable[5]
	self.ModTable[2] = ArgsTable[6]
	self.ModTable[3] = ArgsTable[7]
	self.ModTable[4] = ArgsTable[8]
	self.ModTable[5] = ArgsTable[9]
	self.ModTable[6] = ArgsTable[10]
	self.ModTable[7] = ArgsTable[11]
	self.ModTable[8] = ArgsTable[12]
	self.ModTable[9] = ArgsTable[13]
	self.ModTable[10] = ArgsTable[14]
	self.ModTable[11] = ArgsTable[15]
	self.ModTable[12] = ArgsTable[16]
	self.ModTable[13] = ArgsTable[17]
	self.ModTable[14] = ArgsTable[18]
	self.ModTable[15] = ArgsTable[19]
	self.Mod1 = ArgsTable[5]
	self.Mod2 = ArgsTable[6]
	self.Mod3 = ArgsTable[7]
	self.Mod4 = ArgsTable[8]
	self.Mod5 = ArgsTable[9]
	self.Mod6 = ArgsTable[10]
	self.Mod7 = ArgsTable[11]
	self.Mod8 = ArgsTable[12]
	self.Mod9 = ArgsTable[13]
	self.Mod10 = ArgsTable[14]
	self.Mod11 = ArgsTable[15]
	self.Mod12 = ArgsTable[16]
	self.Mod13 = ArgsTable[17]
	self.Mod14 = ArgsTable[18]
	self.Mod15 = ArgsTable[19]
	--Set String Values
	if tostring(self.Mod1) != nil then self.EngineName = tostring(self.Mod1) else self.EngineName = "No Name" end
	if tostring(self.Mod2) != nil then self.SoundPath = tostring(self.Mod2) else self.SoundPath = "" end
	if string.find(tostring(self.Mod3),".mdl") then self.Model = tostring(self.Mod3) else self.Model = "models/engines/v8s.mdl" end
	if tostring(self.Mod4) != nil then self.FuelType = tostring(self.Mod4) else self.FuelType = "Petrol" end
	if tostring(self.Mod5) != nil then self.EngineType = tostring(self.Mod5) else self.EngineType = "GenericPetrol" end
	--Set Torque
	if(tonumber(self.Mod6) >= 1) then self.PeakTorque = tonumber(self.Mod6)
	elseif(tonumber(self.Mod6) < 1 or tonumber(self.Mod6) == nil) then self.PeakTorque = 1 end
	--Set Idle
	if(tonumber(self.Mod7) >= 1) then self.IdleRPM = tonumber(self.Mod7)
	elseif(tonumber(self.Mod7) < 1 or tonumber(self.Mod7) == nil) then self.IdleRPM = 1 end
	--Set PeakMin
	if(tonumber(self.Mod8) >= 1) then self.PeakMinRPM = tonumber(self.Mod8)
	elseif(tonumber(self.Mod8) < 1 or tonumber(self.Mod8) == nil) then self.PeakMinRPM = 1 end
	--Set PeakMax
	if(self.Mod9 <= self.Mod10 and tonumber(self.Mod9) >= 1 ) then self.PeakMaxRPM = tonumber(self.Mod9)
	elseif(self.Mod9 > self.Mod10 ) then self.PeakMaxRPM = tonumber(self.Mod10)
	elseif(tonumber(self.Mod9) < 1 or tonumber(self.Mod9) == nil) then self.PeakMaxRPM = 1 end
	--Set Limit
	if(tonumber(self.Mod10) >= 100) then self.LimitRPM = tonumber(self.Mod10)
	elseif(tonumber(self.Mod10) < 100 or tonumber(self.Mod10) == nil) then self.LimitRPM = 100 end
	--Set Flywheel
	if(tonumber(self.Mod11) >= 0.001) then self.FlywheelMassValue = tonumber(self.Mod11)
	elseif(tonumber(self.Mod11) < 0.001 or tonumber(self.Mod11) == nil) then self.FlywheelMassValue = 0.001 end
	--Set Weight
	if(tonumber(self.Mod12) >= 1) then self.Weight = tonumber(self.Mod12)
	elseif(tonumber(self.Mod12) < 1 or tonumber(self.Mod12) == nil) then self.Weight = 1 end
	--Set Electric/Turbine Stuff
	if tobool(self.Mod13) != nil then self.iselec = tobool(self.Mod13) else self.iselec = false end
	if tobool(self.Mod14) != nil then self.IsTrans = tobool(self.Mod14) else self.IsTrans = false end
	if tonumber(self.Mod15) != nil then self.FlywheelOverride = tonumber(self.Mod15) else self.FlywheelOverride = 1200 end
	--Set Original Values
	self.PeakTorqueHeld = self.PeakTorque
	self.CutValue = self.LimitRPM / 40
	self.CutRpm = self.LimitRPM - 100
	self.Inertia = self.FlywheelMass3*(3.1416)^2
	--Set Custom Values
	self.FlywheelMass3 = self.FlywheelMassValue
	self.PeakTorqueLoad = self.PeakTorque
	self.PeakTorqueAdd = self.PeakTorque
	self.Idling = self.IdleRPM
	self.PeakMaxRPM2 = self.PeakMaxRPM
	self.LimitRPM2 = self.LimitRPM

	--calculate boosted peak kw
	if self.EngineType == "Turbine" or self.EngineType == "Electric" then
		self.DisableCut = 1
		self.peakkw = self.PeakTorque * self.LimitRPM / (4 * 9548.8)
		self.PeakKwRPM = math.floor(self.LimitRPM / 2)
	else
		self.peakkw = self.PeakTorque * self.PeakMaxRPM / 9548.8
		self.PeakKwRPM = self.PeakMaxRPM
	end
	--calculate base fuel usage
	if self.EngineType == "Electric" then
		self.FuelUse = ACF.ElecRate / (ACF.Efficiency[self.EngineType] * 60 * 60) --elecs use current power output, not max
	else
		self.FuelUse = ACF.TorqueBoost * ACF.FuelRate * ACF.Efficiency[self.EngineType] * self.peakkw / (60 * 60)
	end
	--Creating Wire Inputs
	local Inputs = {"Active", "Throttle", "TqAdd"}
	if self.EngineType != "Turbine" or self.EngineType != "Electric" then --Create inputs engines
		table.insert(Inputs, "MaxRpmAdd")
		table.insert(Inputs, "LimitRpmAdd")
		table.insert(Inputs, "FlywheelMass")
		table.insert(Inputs, "Idle")
		table.insert(Inputs, "Disable Cutoff")
		table.insert(Inputs, "Gearbox RPM")
	elseif self.EngineType == "Turbine" or self.EngineType == "Electric" then	--Create ADV inputs for Electric&Turbine
		table.insert(Inputs, "LimitRpmAdd")
		table.insert(Inputs, "FlywheelMass")
		table.insert(Inputs, "Override")
		table.insert(Inputs, "Gearbox RPM")
	end
	self.Inputs = Wire_CreateInputs( self, Inputs )
	
	self:SetModel( self.Model )	
	self:SetSolid( SOLID_VPHYSICS )
	self.Out = self:WorldToLocal(self:GetAttachment(self:LookupAttachment( "driveshaft" )).Pos)

	local phys = self:GetPhysicsObject()  	
	if IsValid( phys ) then 
		phys:SetMass( self.Weight ) 
	end

	self:SetNetworkedString( "WireName", self.EngineName )
	------ GUI ---------
	self.FlywheelMassGUI = self.FlywheelMassValue
	self:UpdateOverlayText()
	
	ACF_Activate( self, 1 )
	
	return true, "Engine updated successfully!"..Feedback
end

--###################################################
--##### 			FUNCTIONS					#####
--###################################################

function ENT:UpdateOverlayText()
	--Better values for Power Gui and Torque Gui
	if self.RequiresFuel == 1 then
		self.PowerGUI = self.peakkw*ACF.TorqueBoost
		self.TorqueGUI = self.PeakTorqueAdd*ACF.TorqueBoost
	else
		self.PowerGUI = self.peakkw
		self.TorqueGUI = self.PeakTorqueAdd
	end
	
	local text = "Power: " .. math.Round(self.PowerGUI) .. " kW / " .. math.Round(self.PowerGUI * 1.34) .. " hp\n"
	text = text .. "Torque: " .. math.Round(self.TorqueGUI) .. " Nm / " .. math.Round(self.TorqueGUI * 0.73) .. " ft-lb\n"
	if self.EngineType == "Turbine" or self.EngineType == "Electric" then	--Set Gui on electric&turbine
		text = text .. "Override: " .. math.Round(self.FlywheelOverride) .. " RPM\n"
		text = text .. "Redline: " .. math.Round(self.LimitRPM) .. " RPM\n"
		text = text .. "FlywheelMass: " .. math.Round(self.FlywheelMassGUI,3) .. " Kg\n"
		text = text .. "Rpm: " .. math.Round(self.FlyRPM) .. " RPM\n"
		text = text .. "Consumption: " .. math.Round(self.Fuelusing,3) .. " liters/min\n"
		text = text .. "Weight: " .. math.Round(self.Weight) .. "Kg\n"
	else --Set Gui on Others
		text = text .. "Powerband: " .. math.Round(self.PeakMinRPM) .. " - " .. math.Round(self.PeakMaxRPM) .. " RPM\n"
		text = text .. "Redline: " .. math.Round(self.LimitRPM) .. " RPM\n"
		text = text .. "FlywheelMass: " .. math.Round(self.FlywheelMassGUI,3) .. " Kg\n"
		text = text .. "Rpm: " .. math.Round(self.FlyRPM) .. " RPM\n"
		text = text .. "Consumption: " .. math.Round(self.Fuelusing,3) .. " liters/min\n"
		text = text .. "Idle: " .. math.Round(self.IdleRPM) .. " RPM\n"
		text = text .. "Weight: " .. math.Round(self.Weight) .. "Kg\n"
	end
	self:SetOverlayText( text )
end

function ENT:UpdateEngineConsumption()
	if self.EngineType == "Turbine" or self.EngineType == "Electric" then
		self.peakkw = self.PeakTorqueAdd * self.LimitRPM / (4 * 9548.8)
		self.PeakKwRPM = math.floor(self.LimitRPM / 2)
	else
		self.peakkw = self.PeakTorqueAdd * self.PeakMaxRPM / 9548.8
		self.PeakKwRPM = self.PeakMaxRPM
	end
	if self.EngineType == "Electric" then 
		self.FuelUse = ACF.ElecRate / (ACF.Efficiency[self.EngineType] * 60 * 60) --elecs use current power output, not max
	else
		self.FuelUse = ACF.TorqueBoost * ACF.FuelRate * ACF.Efficiency[self.EngineType] * self.peakkw / (60 * 60)
	end
	self:UpdateOverlayText()
end

--###################################################
--##### 		TRIGGER INPUTS					#####
--###################################################

function ENT:TriggerInput( iname, value )
	if (iname == "Throttle") then
		self.Throttle = math.Clamp(value,0,100)/100
	elseif (iname == "Active") then
		if (value > 0 and not self.Active) then
			--make sure we have fuel
			local HasFuel
			if self.RequiresFuel == 0 then
				HasFuel = true
			else 
				for _,fueltank in pairs(self.FuelLink) do
					if fueltank.Fuel > 0 and fueltank.Active then HasFuel = true break end
				end
			end
			
			if HasFuel then
				self.RPM = {}
				self.RPM[1] = self.IdleRPM
				self.Active = true
				self.Active2 = true
				self.Sound = CreateSound(self, self.SoundPath)
				self.Sound:PlayEx(0.5,100)
				self:ACFInit()
			end
		elseif (value > 0) then
			local HasFuel
			if self.RequiresFuel == 0 then
				HasFuel = true
			else
				for _,fueltank in pairs(self.FuelLink) do
					if fueltank.Fuel <= 0 or not fueltank.Active then HasFuel = false break end
				end
			end
			if not HasFuel then
				self:TriggerInput( "Active" , 0 )
				self.Active = false
				Wire_TriggerOutput( self, "RPM", 0 )
				Wire_TriggerOutput( self, "Torque", 0 )
				Wire_TriggerOutput( self, "Power", 0 )
				Wire_TriggerOutput( self, "Fuel Use", 0 )
			end
		elseif (value <= 0 and self.Active) then
			self.Active = false
			Wire_TriggerOutput( self, "RPM", 0 )
			Wire_TriggerOutput( self, "Torque", 0 )
			Wire_TriggerOutput( self, "Power", 0 )
			Wire_TriggerOutput( self, "Fuel Use", 0 )
		end
	--##########################################
	elseif (iname == "TqAdd") then
		if (value ~= 0 ) then
			self.PeakTorqueAdd = self.PeakTorqueLoad+value
			self:UpdateEngineConsumption()
		elseif (value == 0 ) then
			self.PeakTorqueAdd = self.PeakTorqueLoad
			self:UpdateEngineConsumption()
		end
	elseif (iname == "MaxRpmAdd") then
		if (value ~= 0 ) then
			if( self.PeakMaxRPM2+value <= self.LimitRPM ) then
				self.PeakMaxRPM = self.PeakMaxRPM2+value
			elseif( self.PeakMaxRPM2+value > self.LimitRPM ) then
				self.PeakMaxRPM = self.LimitRPM
			end
			self:UpdateEngineConsumption()
		elseif (value == 0 ) then
			self.PeakMaxRPM = self.PeakMaxRPM2
			self:UpdateEngineConsumption()
		end
	elseif (iname == "LimitRpmAdd") then
		if (value ~= 0 ) then
			self.LimitRPM = self.LimitRPM2+value
			self.CutValue = self.LimitRPM / 40
			self.CutRpm = self.LimitRPM - 100
			self:UpdateEngineConsumption()
		elseif (value == 0 ) then
			self.LimitRPM = self.LimitRPM2
			self.CutValue = self.LimitRPM / 40
			self.CutRpm = self.LimitRPM - 100
			self:UpdateEngineConsumption()
		end
	elseif (iname == "FlywheelMass") then
		if (value > 0 ) then
			self.FlywheelMassValue = value
			self.FlywheelMassGUI = self.FlywheelMassValue
			self:UpdateOverlayText()
		elseif (value <= 0 ) then
			self.FlywheelMassValue = self.FlywheelMass3
			self.FlywheelMassGUI = self.FlywheelMassValue
			self:UpdateOverlayText()
		end
	elseif (iname == "Override") then
		if (value > 0 ) then
			self.FlywheelOverride = value
			self:UpdateOverlayText()
		elseif (value <= 0 ) then
			self.FlywheelOverride = self.FlywheelOverride2
			self:UpdateOverlayText()
		end
	elseif (iname == "Idle") then
		if (value > 0 ) then
			self.IdleRPM = value
			self:UpdateOverlayText()
		elseif (value <= 0 ) then
			self.IdleRPM = self.Idling
			self:UpdateOverlayText()
		end
	elseif (iname == "Disable Cutoff") then
		if (value > 0 ) then
			self.DisableCut = 1
		elseif (value <= 0 ) then
			self.DisableCut = 0
		end
	--Disabling AutoClutch on Engine while Moving
	elseif (iname == "Gearbox RPM") then
		if ((value*0.8) > self.IdleRPM and self.Throttle == 0) then
			self.DisableAutoClutch = 1
			self.GearboxRpm = value
		elseif (value <= self.IdleRPM or self.Throttle > 0 and self.DisableAutoClutch == 1) then
			self.DisableAutoClutch = 0
			self.GearboxRpm = 0
		end
	end
end
--#########################
function ENT:ACF_Activate()
	--Density of steel = 7.8g cm3 so 7.8kg for a 1mx1m plate 1m thick
	local Entity = self
	Entity.ACF = Entity.ACF or {} 
	
	local Count
	local PhysObj = Entity:GetPhysicsObject()
	if PhysObj:GetMesh() then Count = #PhysObj:GetMesh() end
	if PhysObj:IsValid() and Count and Count>100 then

		if not Entity.ACF.Aera then
			Entity.ACF.Aera = (PhysObj:GetSurfaceArea() * 6.45) * 0.52505066107
		end
		--if not Entity.ACF.Volume then
		--	Entity.ACF.Volume = (PhysObj:GetVolume() * 16.38)
		--end
	else
		local Size = Entity.OBBMaxs(Entity) - Entity.OBBMins(Entity)
		if not Entity.ACF.Aera then
			Entity.ACF.Aera = ((Size.x * Size.y)+(Size.x * Size.z)+(Size.y * Size.z)) * 6.45
		end
		--if not Entity.ACF.Volume then
		--	Entity.ACF.Volume = Size.x * Size.y * Size.z * 16.38
		--end
	end
	
	Entity.ACF.Ductility = Entity.ACF.Ductility or 0
	--local Area = (Entity.ACF.Aera+Entity.ACF.Aera*math.Clamp(Entity.ACF.Ductility,-0.8,0.8))
	local Area = (Entity.ACF.Aera)
	--local Armour = (Entity:GetPhysicsObject():GetMass()*1000 / Area / 0.78) / (1 + math.Clamp(Entity.ACF.Ductility, -0.8, 0.8))^(1/2)	--So we get the equivalent thickness of that prop in mm if all it's weight was a steel plate
	local Armour = (Entity:GetPhysicsObject():GetMass()*1000 / Area / 0.78) 
	--local Health = (Area/ACF.Threshold) * (1 + math.Clamp(Entity.ACF.Ductility, -0.8, 0.8))												--Setting the threshold of the prop aera gone
	local Health = (Area/ACF.Threshold)
	
	local Percent = 1 
	
	if Recalc and Entity.ACF.Health and Entity.ACF.MaxHealth then
		Percent = Entity.ACF.Health/Entity.ACF.MaxHealth
	end
	
	Entity.ACF.Health = Health * Percent * ACF.EngineHPMult
	Entity.ACF.MaxHealth = Health * ACF.EngineHPMult
	Entity.ACF.Armour = Armour * (0.5 + Percent/2)
	Entity.ACF.MaxArmour = Armour * ACF.ArmorMod
	Entity.ACF.Type = nil
	Entity.ACF.Mass = PhysObj:GetMass()
	--Entity.ACF.Density = (PhysObj:GetMass()*1000)/Entity.ACF.Volume
	
	Entity.ACF.Type = "Prop"
end

function ENT:Think()

	local Time = CurTime()

	if self.Active2 then
		if self.Legal then
			self:CalcRPM()
		end

		if self.LastCheck < CurTime() then
			self:CheckRopes()
			self:CheckFuel()
			self:CalcMassRatio()
			self.Legal = self:CheckLegal()

			self.LastCheck = Time + math.Rand(5, 10)
		end
	end

	self.LastThink = Time
	self:NextThink( Time )
	return true

end

function ENT:CheckLegal()
	
	-- make sure weight is not below stock
	if self:GetPhysicsObject():GetMass() < self.Weight then return false end
	
	-- if it's not parented we're fine
	if not IsValid( self:GetParent() ) then return true end
	
	-- but not if it's parented to a parented prop
	if IsValid( self:GetParent():GetParent() ) then return false end
	
	-- parenting is only legal if it's also welded
	for k, v in pairs( constraint.FindConstraints( self, "Weld" ) ) do
		
		if v.Ent1 == self:GetParent() or v.Ent2 == self:GetParent() then return true end
		
	end
	
	return false
	
end

function ENT:CalcMassRatio()
	
	local Mass = 0
	local PhysMass = 0
	
	-- get the shit that is physically attached to the vehicle
	local PhysEnts = ACF_GetAllPhysicalConstraints( self )
	
	-- add any parented but not constrained props you sneaky bastards
	local AllEnts = table.Copy( PhysEnts )
	for k, v in pairs( PhysEnts ) do
		
		table.Merge( AllEnts, ACF_GetAllChildren( v ) )
	
	end
	
	for k, v in pairs( AllEnts ) do
		
		if not IsValid( v ) then continue end
		
		local phys = v:GetPhysicsObject()
		if not IsValid( phys ) then continue end
		
		Mass = Mass + phys:GetMass()
		
		if PhysEnts[ v ] then
			PhysMass = PhysMass + phys:GetMass()
		end
		
	end

	self.MassRatio = PhysMass / Mass
	
	Wire_TriggerOutput( self, "Mass", math.Round( Mass, 2 ) )
	Wire_TriggerOutput( self, "Physical Mass", math.Round( PhysMass, 2 ) )
	
end

function ENT:ACFInit()
	
	self:CalcMassRatio()

	self.LastThink = CurTime()
	self.Torque = self.PeakTorque
	self.FlyRPM = self.IdleRPM * 1.5

end

function ENT:CalcRPM()

	local DeltaTime = CurTime() - self.LastThink
	-- local AutoClutch = math.min(math.max(self.FlyRPM-self.IdleRPM,0)/(self.IdleRPM+self.LimitRPM/10),1)
	--local ClutchRatio = math.min(Clutch/math.max(TorqueDiff,0.05),1)
	
	--find first active tank with fuel
	local Tank = nil
	local boost = 1
	for _,fueltank in pairs(self.FuelLink) do
		if fueltank.Fuel > 0 and fueltank.Active then Tank = fueltank break end
		if fueltank.Fuel <= 0 or not fueltank.Active then Tank = false break end
	end
	if (not Tank) and self.RequiresFuel == 1 then  --make sure we've got a tank with fuel if needed
		self:TriggerInput( "Active" , 0 )
	end
	--if not Tank then
		--self:TriggerInput( "Active" , 0 )
	--end
	
	--calculate fuel usage
	if Tank then
		local Consumption
		if self.FuelType == "Electric" then
			Consumption = (self.Torque * self.FlyRPM / 9548.8) * self.FuelUse * DeltaTime
		else
			local Load = 0.3 + self.Throttle * 0.7
			Consumption = Load * self.FuelUse * (self.FlyRPM / self.PeakKwRPM) * DeltaTime / ACF.FuelDensity[Tank.FuelType]
		end
		Tank.Fuel = math.max(Tank.Fuel - Consumption,0)
		boost = ACF.TorqueBoost
		Wire_TriggerOutput(self, "Fuel Use", math.Round(60*Consumption/DeltaTime,3))
		self.Fuelusing = math.Round((60*Consumption/DeltaTime),3)
	else
		Wire_TriggerOutput(self, "Fuel Use", 0)
	end
	
	--Function Calling
	self:UpdateOverlayText()
	
	-- Calculate the current torque from flywheel RPM
	local TorqueScale = ACF.TorqueScale
	local TorqueMult = 1
	if (self.ACF.Health and self.ACF.MaxHealth) then
		TorqueMult = math.Clamp(((1 - TorqueScale) / (0.5)) * ((self.ACF.Health/self.ACF.MaxHealth) - 1) + 1, TorqueScale, 1)
	end
	
	self.PeakTorque = self.PeakTorqueAdd * TorqueMult
	self.Inertia = self.FlywheelMassValue*(3.1416)^2
	
	local Drag
	local TorqueDiff
	if self.Active then
	if( self.CutMode == 0 ) then
		self.Torque = boost * self.Throttle * math.max( self.PeakTorque * math.min( self.FlyRPM / self.PeakMinRPM , (self.LimitRPM - self.FlyRPM) / (self.LimitRPM - self.PeakMaxRPM), 1 ), 0 )
		
		if self.iselec == true then
			Drag = self.PeakTorque * (math.max( self.FlyRPM - self.IdleRPM, 0) / self.FlywheelOverride) * (1 - self.Throttle) / self.Inertia
		else
			Drag = self.PeakTorque * (math.max( self.FlyRPM - self.IdleRPM, 0) / self.PeakMaxRPM) * ( 1 - self.Throttle) / self.Inertia
		end
	
	elseif( self.CutMode == 1 ) then
		self.Torque = boost * 0 * math.max( self.PeakTorque * math.min( self.FlyRPM / self.PeakMinRPM , (self.LimitRPM - self.FlyRPM) / (self.LimitRPM - self.PeakMaxRPM), 1 ), 0 )
		
		if self.iselec == true then
			Drag = self.PeakTorque * (math.max( self.FlyRPM - self.IdleRPM, 0) / self.FlywheelOverride) * (1 - 0) / self.Inertia
		else
			Drag = self.PeakTorque * (math.max( self.FlyRPM - self.IdleRPM, 0) / self.PeakMaxRPM) * ( 1 - 0) / self.Inertia
		end
		
	end 
	-- Let's accelerate the flywheel based on that torque
	self.FlyRPM = math.max( self.FlyRPM + self.Torque / self.Inertia - Drag, 1 )
	if self.DisableAutoClutch == 0 then
		-- This is the presently avaliable torque from the engine
		TorqueDiff = math.max( self.FlyRPM - self.IdleRPM, 0 ) * self.Inertia
	elseif self.DisableAutoClutch == 1 then
		TorqueDiff = 0
	end

	end
	
	if( self.Active == false ) then
		self.Torque = boost * 0 * math.max( self.PeakTorque * math.min( self.FlyRPM / self.PeakMinRPM , (self.LimitRPM - self.FlyRPM) / (self.LimitRPM - self.PeakMaxRPM), 1 ), 0 )
		if self.iselec == true then
			Drag = self.PeakTorque * (math.max( self.FlyRPM - 0, 0) / self.FlywheelOverride) * (1 - 0) / self.Inertia
		else
			Drag = self.PeakTorque * (math.max( self.FlyRPM - 0, 0) / self.PeakMaxRPM) * ( 1 - 0) / self.Inertia
		end
	
	-- Let's accelerate the flywheel based on that torque
	self.FlyRPM = math.max( self.FlyRPM + self.Torque / self.Inertia - Drag, 1 )
	-- This is the presently avaliable torque from the engine
	TorqueDiff = 0
	
	end
	--##############
	
	-- The gearboxes don't think on their own, it's the engine that calls them, to ensure consistent execution order
	local Boxes = table.Count( self.GearLink )
	
	local TotalReqTq = 0
	
	-- Get the requirements for torque for the gearboxes (Max clutch rating minus any wheels currently spinning faster than the Flywheel)
	for Key, Link in pairs( self.GearLink ) do
	
		if not Link.Ent.Legal then continue end
		
		Link.ReqTq = Link.Ent:Calc( self.FlyRPM, self.Inertia )
		TotalReqTq = TotalReqTq + Link.ReqTq
		
	end

	-- Calculate the ratio of total requested torque versus what's avaliable
	local AvailRatio = math.min( TorqueDiff / TotalReqTq / Boxes, 1 )
	
	-- Split the torque fairly between the gearboxes who need it
	for Key, Link in pairs( self.GearLink ) do
		
		if not Link.Ent.Legal then continue end
		
		Link.Ent:Act( Link.ReqTq * AvailRatio * self.MassRatio, DeltaTime )
		
	end

	if self.DisableAutoClutch == 0 then
		self.FlyRPM = self.FlyRPM - math.min( TorqueDiff, TotalReqTq ) / self.Inertia
	elseif self.DisableAutoClutch == 1 then
		self.FlyRPM = self.GearboxRpm*0.8
	end
	
	--#######################################
	if( self.DisableCut == 0 ) then
		if( self.FlyRPM >= self.CutRpm and self.CutMode == 0 and self.DisableAutoClutch == 0 ) then
			self.CutMode = 1
			if self.Sound then
				self.Sound:Stop()
			end
			self.Sound = nil
			self.Sound2 = CreateSound(self, "acf_other/penetratingshots/00000293.wav")
			self.Sound2:PlayEx(0.5,100)
		end
		if( self.FlyRPM <= self.CutRpm - self.CutValue and self.CutMode == 1 ) then
			self.CutMode = 0
			self.Sound = CreateSound(self, self.SoundPath)
			self.Sound:PlayEx(0.5,100)
			if self.Sound2 then
				self.Sound2:Stop()
			end
		end
	elseif( self.DisableCut == 1 ) then
		self.CutMode = 0
	end
	if( self.FlyRPM <= 50 and self.Active == false ) then
		self.Active2 = false
		self.FlyRPM = 0
		if self.Sound then
			self.Sound:Stop()
		end
		self.Sound = nil
		self:UpdateOverlayText()
	end
	--#######################################

	-- Then we calc a smoothed RPM value for the sound effects
	table.remove( self.RPM, 10 )
	table.insert( self.RPM, 1, self.FlyRPM )
	local SmoothRPM = 0
	for Key, RPM in pairs( self.RPM ) do
		SmoothRPM = SmoothRPM + (RPM or 0)
	end
	SmoothRPM = SmoothRPM / 10

	local Power = self.Torque * SmoothRPM / 9548.8
	Wire_TriggerOutput(self, "Torque", math.floor(self.Torque))
	Wire_TriggerOutput(self, "Power", math.floor(Power))
	Wire_TriggerOutput(self, "RPM", self.FlyRPM)
	
	if self.Sound then
		self.Sound:ChangePitch( math.min( 20 + (SmoothRPM * self.SoundPitch) / 50, 255 ), 0 )
		self.Sound:ChangeVolume( 0.25 + (0.1 + 0.9 * ((SmoothRPM / self.LimitRPM) ^ 1.5)) * self.Throttle / 1.5, 0 )
	end
	
	return RPM
end

function ENT:CheckRopes()
	
	for Key, Link in pairs( self.GearLink ) do
		
		local Ent = Link.Ent
		
		-- make sure the rope is still there
		if not IsValid( Link.Rope ) then 
			self:Unlink( Ent )
		continue end
		
		local OutPos = self:LocalToWorld( self.Out )
		local InPos = Ent:LocalToWorld( Ent.In )
		
		-- make sure it is not stretched too far
		if OutPos:Distance( InPos ) > Link.RopeLen * 1.5 then
			self:Unlink( Ent )
		continue end
		
		-- make sure the angle is not excessive
		local Direction
		if self.IsTrans then Direction = -self:GetRight() else Direction = self:GetForward() end
		
		local DrvAngle = ( OutPos - InPos ):GetNormalized():DotProduct( Direction )
		if DrvAngle < 0.7 then
			self:Unlink( Ent )
		end
		
	end
	
end

--unlink fuel tanks out of range
function ENT:CheckFuel()
	for _,tank in pairs(self.FuelLink) do
		if self:GetPos():Distance(tank:GetPos()) > 512 then
			self:Unlink( tank )
			soundstr =  "physics/metal/metal_box_impact_bullet" .. tostring(math.random(1, 3)) .. ".wav"
			self:EmitSound(soundstr,500,100)
		end
	end
end

function ENT:Link( Target )

	if not IsValid( Target ) or Target:GetClass() ~= "acf_gearbox" and Target:GetClass() ~= "acf_fueltank" then
		return false, "Can only link to gearboxes or fuel tanks!"
	end
	
	if Target:GetClass() == "acf_fueltank" then 
		return self:LinkFuel( Target )
	end
	
	-- Check if target is already linked
	for Key, Link in pairs( self.GearLink ) do
		if Link.Ent == Target then
			return false, "That is already linked to this engine!"
		end
	end
	
	-- make sure the angle is not excessive
	local InPos = Target:LocalToWorld( Target.In )
	local OutPos = self:LocalToWorld( self.Out )
	
	local Direction
	if self.IsTrans then Direction = -self:GetRight() else Direction = self:GetForward() end
	
	local DrvAngle = ( OutPos - InPos ):GetNormalized():DotProduct( Direction )
	if DrvAngle < 0.7 then
		return false, "Cannot link due to excessive driveshaft angle!"
	end
	
	local Rope = constraint.CreateKeyframeRope( OutPos, 1, "cable/cable2", nil, self, self.Out, 0, Target, Target.In, 0 )
	
	local Link = {
		Ent = Target,
		Rope = Rope,
		RopeLen = ( OutPos - InPos ):Length(),
		ReqTq = 0
	}
	
	table.insert( self.GearLink, Link )
	table.insert( Target.Master, self )
	
	return true, "Link successful!"
end

function ENT:Unlink( Target )

	if Target:GetClass() == "acf_fueltank" then
		return self:UnlinkFuel( Target )
	end
	
	for Key, Link in pairs( self.GearLink ) do
		
		if Link.Ent == Target then
			
			-- Remove any old physical ropes leftover from dupes
			for Key, Rope in pairs( constraint.FindConstraints( Link.Ent, "Rope" ) ) do
				if Rope.Ent1 == self or Rope.Ent2 == self then
					Rope.Constraint:Remove()
				end
			end
			
			if IsValid( Link.Rope ) then
				Link.Rope:Remove()
			end
			
			table.remove( self.GearLink,Key )
			
			return true, "Unlink successful!"
			
		end
		
	end
	
	return false, "That gearbox is not linked to this engine!"
	
end

function ENT:LinkFuel( Target )
	
	if not (self.FuelType == "Any" and not (Target.FuelType == "Electric")) then
		if self.FuelType ~= Target.FuelType then
			return false, "Cannot link because fuel type is incompatible."
		end
	end
	
	if Target.NoLinks then
		return false, "This fuel tank doesn\'t allow linking."
	end
	
	for Key,Value in pairs(self.FuelLink) do
		if Value == Target then 
			return false, "That fuel tank is already linked to this engine!"
		end
	end
	
	if self:GetPos():Distance( Target:GetPos() ) > 512 then
		return false, "Fuel tank is too far away."
	end
	
	table.insert( self.FuelLink, Target )
	table.insert( Target.Master, self )
	
	self.RequiresFuel = 1
	
	return true, "Link successful! Now Require Fuel"
	
end

function ENT:UnlinkFuel( Target )
	
	for Key, Value in pairs( self.FuelLink ) do
		if Value == Target then
			self.RequiresFuel = 0
			table.remove( self.FuelLink, Key )
			return true, "Unlink successful! Now NOT Require Fuel"
		end
	end
	
	return false, "That fuel tank is not linked to this engine!"
	
end

function ENT:PreEntityCopy()

	//Link Saving
	local info = {}
	local entids = {}
	for Key, Link in pairs( self.GearLink ) do					--First clean the table of any invalid entities
		if not IsValid( Link.Ent ) then
			table.remove( self.GearLink, Key )
		end
	end
	for Key, Link in pairs( self.GearLink ) do					--Then save it
		table.insert( entids, Link.Ent:EntIndex() )
	end

	info.entities = entids
	if info.entities then
		duplicator.StoreEntityModifier( self, "GearLink", info )
	end
	
	--fuel tank link saving
	local fuel_info = {}
	local fuel_entids = {}
	for Key, Value in pairs(self.FuelLink) do					--First clean the table of any invalid entities
		if not Value:IsValid() then
			table.remove(self.FuelLink, Value)
		end
	end
	for Key, Value in pairs(self.FuelLink) do					--Then save it
		table.insert(fuel_entids, Value:EntIndex())
	end
	
	fuel_info.entities = fuel_entids
	if fuel_info.entities then
		duplicator.StoreEntityModifier( self, "FuelLink", fuel_info )
	end

	//Wire dupe info
	self.BaseClass.PreEntityCopy( self )

end

function ENT:PostEntityPaste( Player, Ent, CreatedEntities )

	//Link Pasting
	if (Ent.EntityMods) and (Ent.EntityMods.GearLink) and (Ent.EntityMods.GearLink.entities) then
		local GearLink = Ent.EntityMods.GearLink
		if GearLink.entities and table.Count(GearLink.entities) > 0 then
			timer.Simple( 0, function() -- this timer is a workaround for an ad2/makespherical issue https://github.com/nrlulz/ACF/issues/14#issuecomment-22844064
				for _,ID in pairs(GearLink.entities) do
					local Linked = CreatedEntities[ ID ]
					if IsValid( Linked ) then
						self:Link( Linked )
					end
				end
			end )
		end
		Ent.EntityMods.GearLink = nil
	end

	--fuel tank link Pasting
	if (Ent.EntityMods) and (Ent.EntityMods.FuelLink) and (Ent.EntityMods.FuelLink.entities) then
		local FuelLink = Ent.EntityMods.FuelLink
		if FuelLink.entities and table.Count(FuelLink.entities) > 0 then
			for _,ID in pairs(FuelLink.entities) do
				local Linked = CreatedEntities[ ID ]
				if IsValid( Linked ) then
					self.RequiresFuel = 1
					self:Link( Linked )
				end
			end
		end
		Ent.EntityMods.FuelLink = nil
	end
	
	//Wire dupe info
	self.BaseClass.PostEntityPaste( self, Player, Ent, CreatedEntities )

end

function ENT:OnRemove()
	if self.Sound then
		self.Sound:Stop()
	end
end