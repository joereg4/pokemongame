--[[
    GD50
    Pokemon

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

LevelUPMenuState = Class{__includes = BaseState}

function LevelUPMenuState:init(playerPokemon, stats, onClose)
    
    self.LevelUpMenu = Menu {
        x = VIRTUAL_WIDTH/2 - 192/2,
        y = VIRTUAL_HEIGHT/2 - 96/2,
        width = 192,
        height = 96,
        items = {
            {
                text = 'HP:      ' .. (playerPokemon.HP - stats.HPIncrease) .. " + " .. stats.HPIncrease .. " = " .. playerPokemon.HP,
                onSelect = onClose
            },
            {
                text = 'Attack:  ' .. (playerPokemon.attack - stats.attackIncrease) .. " + " .. stats.attackIncrease .. " = " .. playerPokemon.attack
            },
            {
                text = 'Defense: ' .. (playerPokemon.defense - stats.defenseIncrease) .. " + " .. stats.defenseIncrease .. " = " .. playerPokemon.defense
            },
            {
                text = 'Speed:   ' .. (playerPokemon.speed - stats.speedIncrease) .. " + " .. stats.speedIncrease .. " = " .. playerPokemon.speed
            }
        },
        noSelection = true
    }
end

function LevelUPMenuState:update(dt)
    self.LevelUpMenu:update(dt)
end

function LevelUPMenuState:render()
    self.LevelUpMenu:render()
end