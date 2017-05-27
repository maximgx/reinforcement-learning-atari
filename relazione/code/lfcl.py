-- reshape all feature planes into a vector per example
net:add(nn.Reshape(nel))

-- fully connected layer
net:add(nn.Linear(nel, args.n_hid[1]))
net:add(args.nl())
local last_layer_size = args.n_hid[1]

for i=1,(#args.n_hid-1) do
    -- add Linear layer
    last_layer_size = args.n_hid[i+1]
    net:add(nn.Linear(args.n_hid[i], last_layer_size))
    net:add(args.nl())
end

-- add the last fully connected layer (to actions)
net:add(nn.Linear(last_layer_size, args.n_actions))