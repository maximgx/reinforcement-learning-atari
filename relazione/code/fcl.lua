--[[ Instaziazione del modello sequenziale e aggiunta di un primo strato
     Reshape che rimodella la forma dei dati per i prossimi strati
     convoluzionali. ]]
local net = nn.Sequential()
net:add(nn.Reshape(unpack(args.input_dims)))

--[[ Aggiunta del primo strato convoluzionale usando anche iperparametri ]]
local convLayer = nn.SpatialConvolution

net:add(convLayer(args.hist_len*args.ncols, args.n_units[1],
                    args.filter_size[1], args.filter_size[1],
                    args.filter_stride[1], args.filter_stride[1],1))
net:add(args.nl())

--[[ I restanti strati convoluzionali ]]
for i=1,(#args.n_units-1) do
    net:add(convLayer(args.n_units[i], args.n_units[i+1],
                        args.filter_size[i+1], args.filter_size[i+1],
                        args.filter_stride[i+1], args.filter_stride[i+1]))
    net:add(args.nl())
end
