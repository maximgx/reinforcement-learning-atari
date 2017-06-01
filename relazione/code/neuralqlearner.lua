function nql:perceive(reward, rawstate, terminal, testing, testing_ep)
    --[[ Pre-elaborazione dello stato (sara' null se il gioco e' terminato) ]]
    local state = self:preprocess(rawstate):float()
    local curState

    --[[ Mapping della ricompensa nel range da -1 a 1, poi si prosegue... ]]

    self.transitions:add_recent_state(state, terminal)
    local currentFullState = self.transitions:get_recent()

    --[[ Archivia transizione s, a, r, s' ]]
    if self.lastState and not testing then
        self.transitions:add(self.lastState, self.lastAction, reward,
                             self.lastTerminal, priority)
    end

    if self.numSteps == self.learn_start+1 and not testing then
        self:sample_validation_data()
    end

    curState= self.transitions:get_recent()
    curState = curState:resize(1, unpack(self.input_dims))

    --[[ Esegui selezione di azione ]]
    local actionIndex = 1
    if not terminal then
        actionIndex = self:eGreedy(curState, testing_ep)
    end

    self.transitions:add_recent_action(actionIndex)

    --[[ Esegui aggiornamento Q Learning ]]
    if self.numSteps > self.learn_start and not testing and
        self.numSteps % self.update_freq == 0 then
        for i = 1, self.n_replay do
            self:qLearnMinibatch()
        end
    end

    if not testing then
        self.numSteps = self.numSteps + 1
    end

    self.lastState = state:clone()
    self.lastAction = actionIndex
    self.lastTerminal = terminal

    if self.target_q and self.numSteps % self.target_q == 1 then
        self.target_network = self.network:clone()
    end

    if not terminal then
        return actionIndex
    else return 0 end
end
