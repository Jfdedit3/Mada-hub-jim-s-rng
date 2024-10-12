-- full script by z4trox
-- ui by Jfdedit3
-- v3.4

local TweenService = game:GetService("TweenService")
local replicatedStorage = game:GetService("ReplicatedStorage")

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

-- Onglet pour les auras
local Tab = fr:FindFirstChild("Tab") or Instance.new("Frame") -- Assurez-vous d'avoir un cadre pour les onglets
Tab.Name = "Aura"
Tab.Parent = fr

-- Fonction pour obtenir tous les noms d'aura
local function getAllAuraNames()
    local aurasFolder = replicatedStorage:WaitForChild("Auras")
    local auraNames = {}
    for _, aura in pairs(aurasFolder:GetChildren()) do
        table.insert(auraNames, aura.Name)
    end
    return auraNames
end

-- Récupérer la liste des noms d'aura
local auraNames = getAllAuraNames()

-- Fonction pour équiper une aura
local function equipAura(auraName)
    local args = {
        [1] = replicatedStorage:WaitForChild("Auras"):WaitForChild(auraName)
    }
    replicatedStorage:WaitForChild("Remotes"):WaitForChild("AuraEquip"):FireServer(unpack(args))
    print("Equipped aura:", auraName)
end

-- Ajout du menu déroulant pour sélectionner une aura
local auraDropdown = Instance.new("TextButton")
auraDropdown.Size = UDim2.new(1, 0, 0, 40)
auraDropdown.Position = UDim2.new(0, 0, 0, 30)
auraDropdown.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
auraDropdown.Text = ""
auraDropdown.TextColor3 = Color3.fromRGB(255, 255, 255)
auraDropdown.Font = Enum.Font.GothamBold
auraDropdown.TextSize = 14
auraDropdown.Parent = Tab

-- Ajouter un dropdown pour les auras
local auraSelection = Instance.new("Frame")
auraSelection.Size = UDim2.new(1, 0, 0, 150)
auraSelection.Position = UDim2.new(0, 0, 0, 70)
auraSelection.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
auraSelection.Parent = Tab

-- Créer un cadre pour la sélection d'aura avec défilement
local auraSelection = Instance.new("ScrollingFrame")
auraSelection.Size = UDim2.new(1, 0, 0, 200) -- Limite la hauteur du cadre
auraSelection.Position = UDim2.new(0, 0, 0, 30) -- Positionne le cadre sous le titre
auraSelection.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
auraSelection.ScrollBarThickness = 10 -- Épaisseur de la barre de défilement
auraSelection.Parent = fr
auraSelection.CanvasSize = UDim2.new(0, 0, 0, 0) -- Initialiser la taille du canevas à 0
auraSelection.ScrollBarImageColor3 = Color3.fromRGB(255, 255, 255) -- Couleur de la barre de défilement

local auraSelectionList = Instance.new("Frame")
auraSelectionList.Size = UDim2.new(1, 0, 0, 0) -- La hauteur sera ajustée dynamiquement
auraSelectionList.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
auraSelectionList.LayoutOrder = 1
auraSelectionList.Parent = auraSelection

-- Utiliser un UIListLayout pour gérer la disposition des boutons
local layout = Instance.new("UIListLayout")
layout.Padding = UDim.new(0, 5) -- Espacement entre les boutons
layout.SortOrder = Enum.SortOrder.LayoutOrder
layout.Parent = auraSelectionList

-- Créer les boutons pour chaque aura
for _, auraName in pairs(auraNames) do
    local auraButton = Instance.new("TextButton")
    auraButton.Size = UDim2.new(1, -10, 0, 40) -- Largeur complète moins un espacement
    auraButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    auraButton.Text = auraName
    auraButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    auraButton.Font = Enum.Font.GothamBold
    auraButton.TextSize = 14
    auraButton.Parent = auraSelectionList

    auraButton.MouseButton1Click:Connect(function()
        equipAura(auraName)
    end)
end

-- Ajuster la taille du canevas du ScrollingFrame
local function adjustAuraSelectionSize()
    local auraCount = #auraNames
    local totalHeight = auraCount * 45 -- Hauteur de chaque bouton plus espacement
    auraSelectionList.Size = UDim2.new(1, 0, 0, totalHeight) -- Ajuste la taille de la liste

    -- Met à jour la taille du canevas pour activer le défilement
    auraSelection.CanvasSize = UDim2.new(0, 0, 0, totalHeight) -- Met à jour la taille du canevas
end

adjustAuraSelectionSize()
