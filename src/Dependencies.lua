--
-- libraries
--

Class = require "lib/class"
Event = require "lib/knife.event"
push = require "lib/push"
Timer = require "lib/knife.timer"

require "src/Animation"
require "src/constants"
require "src/Party"
require "src/Pokemon"
require "src/pokemon_defs"
require "src/StateMachine"
require "src/Util"

require "src/battle/BattleSprite"
require "src/battle/Opponent"

require "src/entity/entity_defs"
require "src/entity/Entity"
require "src/entity/Player"

require "src/gui/Menu"
require "src/gui/Panel"
require "src/gui/ProgressBar"
require "src/gui/Selection"
require "src/gui/Textbox"

require "src/states/BaseState"
require "src/states/StateStack"

require "src/states/entity/EntityBaseState"
require "src/states/entity/EntityIdleState"
require "src/states/entity/EntityWalkState"
require "src/states/entity/PlayerIdleState"
require "src/states/entity/PlayerWalkState"

require "src/states/game/BattleState"
require "src/states/game/BattleMenuState"
require "src/states/game/BattleMessageState"
require "src/states/game/LevelUPMenuState"
require "src/states/game/DialogueState"
require "src/states/game/FadeInState"
require "src/states/game/FadeOutState"
require "src/states/game/PlayState"
require "src/states/game/StartState"
require "src/states/game/TakeTurnState"

require "src/world/Level"
require "src/world/tile_ids"
require "src/world/Tile"
require "src/world/TileMap"

gTextures = {
    ["tiles"] = love.graphics.newImage("graphics/sheet.png"),
    ["entities"] = love.graphics.newImage("graphics/entities.png"),
    ["cursor"] = love.graphics.newImage("graphics/cursor.png"),
    ["furret-artwork"] = love.graphics.newImage("graphics/pokemon/furret.png"),
    ["furret-back"] = love.graphics.newImage("graphics/pokemon/furret-back.png"),
    ["furret-front"] = love.graphics.newImage("graphics/pokemon/furret-front.png"),
    ["charizard-artwork"] = love.graphics.newImage("graphics/pokemon/charizard.png"),
    ["charizard-back"] = love.graphics.newImage("graphics/pokemon/charizard-back.png"),
    ["charizard-front"] = love.graphics.newImage("graphics/pokemon/charizard-front.png"),
    ["treecko-artwork"] = love.graphics.newImage("graphics/pokemon/treecko.png"),
    ["treecko-back"] = love.graphics.newImage("graphics/pokemon/treecko-back.png"),
    ["treecko-front"] = love.graphics.newImage("graphics/pokemon/treecko-front.png"),
    ["ambipom-artwork"] = love.graphics.newImage("graphics/pokemon/ambipom.png"),
    ["ambipom-back"] = love.graphics.newImage("graphics/pokemon/ambipom-back.png"),
    ["ambipom-front"] = love.graphics.newImage("graphics/pokemon/ambipom-front.png"),
    ["lugia-artwork"] = love.graphics.newImage("graphics/pokemon/lugia.png"),
    ["lugia-back"] = love.graphics.newImage("graphics/pokemon/lugia-back.png"),
    ["lugia-front"] = love.graphics.newImage("graphics/pokemon/lugia-front.png"),
    ["wailord-artwork"] = love.graphics.newImage("graphics/pokemon/wailord.png"),
    ["wailord-back"] = love.graphics.newImage("graphics/pokemon/wailord-back.png"),
    ["wailord-front"] = love.graphics.newImage("graphics/pokemon/wailord-front.png"),
    ["sharpedo-artwork"] = love.graphics.newImage("graphics/pokemon/sharpedo.png"),
    ["sharpedo-back"] = love.graphics.newImage("graphics/pokemon/sharpedo-back.png"),
    ["sharpedo-front"] = love.graphics.newImage("graphics/pokemon/sharpedo-front.png"),
    ["typhlosion-artwork"] = love.graphics.newImage("graphics/pokemon/typhlosion.png"),
    ["typhlosion-back"] = love.graphics.newImage("graphics/pokemon/typhlosion-back.png"),
    ["typhlosion-front"] = love.graphics.newImage("graphics/pokemon/typhlosion-front.png"),
    ["blastoise-artwork"] = love.graphics.newImage("graphics/pokemon/blastoise.png"),
    ["blastoise-back"] = love.graphics.newImage("graphics/pokemon/blastoise-back.png"),
    ["blastoise-front"] = love.graphics.newImage("graphics/pokemon/blastoise-front.png"),
    ["combusken-artwork"] = love.graphics.newImage("graphics/pokemon/combusken.png"),
    ["combusken-back"] = love.graphics.newImage("graphics/pokemon/combusken-back.png"),
    ["combusken-front"] = love.graphics.newImage("graphics/pokemon/combusken-front.png"),
    ["monferno-artwork"] = love.graphics.newImage("graphics/pokemon/monferno.png"),
    ["monferno-back"] = love.graphics.newImage("graphics/pokemon/monferno-back.png"),
    ["monferno-front"] = love.graphics.newImage("graphics/pokemon/monferno-front.png"),
    ["raichu-artwork"] = love.graphics.newImage("graphics/pokemon/raichu.png"),
    ["raichu-back"] = love.graphics.newImage("graphics/pokemon/raichu-back.png"),
    ["raichu-front"] = love.graphics.newImage("graphics/pokemon/raichu-front.png"),
    ["braviary-artwork"] = love.graphics.newImage("graphics/pokemon/braviary.png"),
    ["braviary-back"] = love.graphics.newImage("graphics/pokemon/braviary-back.png"),
    ["braviary-front"] = love.graphics.newImage("graphics/pokemon/braviary-front.png"),
    ["pancham-artwork"] = love.graphics.newImage("graphics/pokemon/pancham.png"),
    ["pancham-back"] = love.graphics.newImage("graphics/pokemon/pancham-back.png"),
    ["pancham-front"] = love.graphics.newImage("graphics/pokemon/pancham-front.png"),
    ["rayquaza-artwork"] = love.graphics.newImage("graphics/pokemon/rayquaza.png"),
    ["rayquaza-back"] = love.graphics.newImage("graphics/pokemon/rayquaza-back.png"),
    ["rayquaza-front"] = love.graphics.newImage("graphics/pokemon/rayquaza-front.png"),
    ["gyarados-artwork"] = love.graphics.newImage("graphics/pokemon/gyarados.png"),
    ["gyarados-back"] = love.graphics.newImage("graphics/pokemon/gyarados-back.png"),
    ["gyarados-front"] = love.graphics.newImage("graphics/pokemon/gyarados-front.png"),
    ["kyogre-artwork"] = love.graphics.newImage("graphics/pokemon/kyogre.png"),
    ["kyogre-back"] = love.graphics.newImage("graphics/pokemon/kyogre-back.png"),
    ["kyogre-front"] = love.graphics.newImage("graphics/pokemon/kyogre-front.png")
}

gFrames = {
    ["tiles"] = GenerateQuads(gTextures["tiles"], 16, 16),
    ["entities"] = GenerateQuads(gTextures["entities"], 16, 16)
}

gFonts = {
    ["small"] = love.graphics.newFont("fonts/font.ttf", 8),
    ["medium"] = love.graphics.newFont("fonts/font.ttf", 16),
    ["large"] = love.graphics.newFont("fonts/font.ttf", 32)
}

gSounds = {
    ["field-music"] = love.audio.newSource("sounds/field_music.wav", "static"),
    ["battle-music"] = love.audio.newSource("sounds/battle_music.mp3", "static"),
    ["blip"] = love.audio.newSource("sounds/blip.wav", "static"),
    ["powerup"] = love.audio.newSource("sounds/powerup.wav", "static"),
    ["hit"] = love.audio.newSource("sounds/hit.wav", "static"),
    ["run"] = love.audio.newSource("sounds/run.wav", "static"),
    ["heal"] = love.audio.newSource("sounds/heal.wav", "static"),
    ["exp"] = love.audio.newSource("sounds/exp.wav", "static"),
    ["levelup"] = love.audio.newSource("sounds/levelup.wav", "static"),
    ["victory-music"] = love.audio.newSource("sounds/victory.wav", "static"),
    ["intro-music"] = love.audio.newSource("sounds/intro.mp3", "static")
}
