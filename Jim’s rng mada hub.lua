-- full script by z4trox
-- ui by Jfdedit3
-- v3.4

local TweenService = game:GetService("TweenService")

-- Chargement de la bibliothèque de notifications
local NotificationLoad = loadstring(game:HttpGet('https://raw.githubusercontent.com/treeofplant/Notif/main/library.lua', true))()

local gui = Instance.new("ScreenGui")
gui.Name = "Mada hub v3.4"
gui.Parent = game.CoreGui

-- Création du cadre principal (MainFrame)
local fr = Instance.new("Frame")
fr.Size = UDim2.new(0, 400, 0, 300)
fr.Position = UDim2.new(0.5, -200, 1.0, 0) -- Départ en dehors de l'écran (en bas)
fr.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
fr.BorderColor3 = Color3.fromRGB(0, 0, 0)
fr.BorderSizePixel = 1
fr.Active = true
fr.Draggable = true
fr.Parent = gui
fr.Visible = false

-- Application de coins arrondis
local function applyCorners(instance, cornerRadius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, cornerRadius)
    corner.Parent = instance
end
applyCorners(fr, 12)

-- Titre du cadre
local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(1, 0, 0, 30)
TitleLabel.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.Text = gui.Name
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.TextSize = 16
TitleLabel.Parent = fr
applyCorners(TitleLabel, 10)

-- Bouton de fermeture
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 20, 0, 20)
closeBtn.Position = UDim2.new(0.95, -20, 0, 5)
closeBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
closeBtn.Text = "|X|"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 14
closeBtn.Parent = fr
applyCorners(closeBtn, 5)

-- Animation d'apparition du GUI
local function showIntroductionAnimation()
    fr.Position = UDim2.new(0.5, -200, 0.5, -150)
    fr.Size = UDim2.new(0, 0, 0, 0)
    fr.Visible = true
    fr:TweenSize(UDim2.new(0, 400, 0, 300), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.75, true)
    fr:TweenPosition(UDim2.new(0.5, -200, 0.5, -150), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.75, true)
end

showIntroductionAnimation()

-- Fonction pour la fermeture du GUI
closeBtn.MouseButton1Down:Connect(function()
    local closeTween = TweenService:Create(fr, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
        Position = UDim2.new(0.5, -200, 1.0, 0), -- Sortie en bas de l'écran
    })
    closeTween:Play()
    closeTween.Completed:Connect(function()
        gui:Destroy()
    end)
end)

-- Ajout du texte de pied de page
local FooterLabel = Instance.new("TextLabel")
FooterLabel.Name = "FooterLabel"
FooterLabel.Parent = fr
FooterLabel.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
FooterLabel.Position = UDim2.new(0, 10, 1, -30)
FooterLabel.Size = UDim2.new(1, -20, 0, 30)
FooterLabel.Font = Enum.Font.GothamBold
FooterLabel.Text = "z4trox | v3.4 | https://discord.gg/c24QBGCu3V"
FooterLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
FooterLabel.TextSize = 12
FooterLabel.BackgroundTransparency = 1

-- Optimisations graphiques
local function optimizeGraphics()
    -- Limite le nombre de lumières dynamiques
    for _, light in pairs(workspace:GetChildren()) do
        if light:IsA("PointLight") or light:IsA("SpotLight") or light:IsA("SurfaceLight") then
            light.Enabled = false -- Désactive les lumières inutiles
        end
    end

    -- Réduire les effets de post-traitement
    local lighting = game:GetService("Lighting")
    
    -- Désactivation des effets inutiles pour optimiser les FPS
    if lighting:FindFirstChild("Bloom") then
        lighting.Bloom.Enabled = false
    end
    
    if lighting:FindFirstChild("ColorCorrection") then
        lighting.ColorCorrection.Enabled = false
    end
    
    if lighting:FindFirstChild("DepthOfField") then
        lighting.DepthOfField.Enabled = false
    end
    
    if lighting:FindFirstChild("SunRays") then
        lighting.SunRays.Enabled = false
    end
    
    if lighting:FindFirstChild("Atmosphere") then
        lighting.Atmosphere.Density = 0 -- Réduire l'atmosphère pour des performances accrues
    end
    
    -- Désactiver l'ombrage de l'environnement
    lighting.GlobalShadows = false
end

-- Appel de la fonction d'optimisation des graphismes
optimizeGraphics()

-- Notification d'optimisation terminée
NotificationLoad:NewNotification({
    ["Mode"] = "Custom",
    ["Title"] = "Welcome To Mada hub :)",
    ["Description"] = "v3.4 :D",
    ["Timeout"] = 5
})

-- Fonctionnalités supplémentaires ou paramètres
local settingsButton = Instance.new("TextButton")
settingsButton.Size = UDim2.new(0, 20, 0, 20)  -- Même taille que le bouton Close
settingsButton.Position = UDim2.new(0, 5, 0, 5)  -- Position opposée à Close (côté gauche)
settingsButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
settingsButton.Text = "⚙"  -- Icône de paramètres (ou "Param")
settingsButton.TextColor3 = Color3.fromRGB(255, 255, 255)
settingsButton.Font = Enum.Font.GothamBold
settingsButton.TextSize = 14
settingsButton.Parent = fr
applyCorners(settingsButton, 5)

settingsButton.MouseButton1Click:Connect(function()
    NotificationLoad:NewNotification({
        ["Mode"] = "Custom",
        ["Title"] = "Options",
        ["Description"] = "SOON.",
        ["Timeout"] = 3
    })
end)

-- Fonctionnalité pour afficher les auras
local replicatedStorage = game:GetService("ReplicatedStorage")
local player = game.Players.LocalPlayer

-- Créer un ScrollingFrame pour les boutons d'aura
local scrollingFrame = Instance.new("ScrollingFrame")
scrollingFrame.Parent = fr
scrollingFrame.Size = UDim2.new(1, -20, 0, 250)  -- Taille du ScrollingFrame ajustée
scrollingFrame.Position = UDim2.new(0, 10, 0, 40)  -- Position en dessous du titre
scrollingFrame.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
scrollingFrame.BackgroundTransparency = 0.3
scrollingFrame.BorderSizePixel = 0
scrollingFrame.ScrollBarThickness = 8
scrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 0) -- Taille ajustée en fonction du nombre de boutons

-- Fonction pour obtenir tous les noms d'aura
local function getAllAuraNames()
    local aurasFolder = replicatedStorage:WaitForChild("Auras")
    local auraNames = {}
    for _, aura in pairs(aurasFolder:GetChildren()) do
        table.insert(auraNames, aura.Name)
    end
    return auraNames
end

-- Obtenir la liste des noms d'aura
local auraNames = getAllAuraNames()

-- Ajuster la taille du Canvas en fonction du nombre d'aura
local buttonHeight = 40
local spacing = 5
local totalHeight = #auraNames * (buttonHeight + spacing)
scrollingFrame.CanvasSize = UDim2.new(0, 0, 0, totalHeight)

-- Fonction pour équiper une aura
local function equipAura(auraName)
    local args = {
        [1] = replicatedStorage:WaitForChild("Auras"):WaitForChild(auraName)
    }
    replicatedStorage:WaitForChild("Remotes"):WaitForChild("EquipAura"):FireServer(unpack(args))
end

-- Créer des boutons pour chaque aura
for i, auraName in ipairs(auraNames) do
    local auraButton = Instance.new("TextButton")
    auraButton.Size = UDim2.new(1, 0, 0, buttonHeight)
    auraButton.Position = UDim2.new(0, 0, 0, (i - 1) * (buttonHeight + spacing))
    auraButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    auraButton.Text = auraName
    auraButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    auraButton.Font = Enum.Font.Gotham
    auraButton.TextSize = 14
    auraButton.Parent = scrollingFrame

    -- Application de coins arrondis aux boutons
    applyCorners(auraButton, 5)

    -- Événement pour équiper l'aura lorsque le bouton est cliqué
    auraButton.MouseButton1Click:Connect(function()
        equipAura(auraName)
        NotificationLoad:NewNotification({
            ["Mode"] = "Custom",
            ["Title"] = "Aura Equipée",
            ["Description"] = auraName .. " a été équipée !",
            ["Timeout"] = 3
        })
    end)
end

-- Code de fin pour votre script