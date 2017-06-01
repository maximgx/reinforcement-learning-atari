--[[ Aggiunta degli strati densamente connessi ]]
net:add(nn.Linear(nel, args.n_hid[1]))
net:add(args.nl())
local last_layer_size = args.n_hid[1]

for i=1,(#args.n_hid-1) do
    -- add Linear layer
    last_layer_size = args.n_hid[i+1]
    net:add(nn.Linear(args.n_hid[i], last_layer_size))
    net:add(args.nl())
end

--[[ Aggiunta dell'ultimo strato dei target per ogni azione ]]
net:add(nn.Linear(last_layer_size, args.n_actions))
