-- Preleva per la prima volta uno stato e la ricompensa
local screen, reward, terminal = game_env:getState()

while step < opt.steps do
    step = step + 1
    -- Avendo lo stato, percepiscilo e scegli l'azione ottimale da eseguire
    local action_index = agent:perceive(reward, screen, terminal)

    if not terminal then
        --[[ Se il gioco non e' finito:
             1. esegui lo step compiendo l'azione appena scelta;
             2. ottieni lo stato e la ricompensa risultante.            ]]
        screen, reward, terminal = game_env:step(game_actions[action_index], true)
    else
        screen, reward, terminal = game_env:newGame()

    --[[ Output di informazioni, attivita' di garbage collector         ]]
    --[[ Esecuzione attivita' di validazione ogni V step                ]]
    --[[ Esecuzione attivita' di salvataggio parametri ogni S step      ]]
end
