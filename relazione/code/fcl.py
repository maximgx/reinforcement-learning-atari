local net = nn.Sequential()
net:add(nn.Reshape(unpack(args.input_dims)))

--- first convolutional layer
local convLayer = nn.SpatialConvolution

net:add(convLayer(args.hist_len*args.ncols, args.n_units[1],
                    args.filter_size[1], args.filter_size[1],
                    args.filter_stride[1], args.filter_stride[1],1))
net:add(args.nl())

-- Add convolutional layers
for i=1,(#args.n_units-1) do
    -- second convolutional layer
    net:add(convLayer(args.n_units[i], args.n_units[i+1],
                        args.filter_size[i+1], args.filter_size[i+1],
                        args.filter_stride[i+1], args.filter_stride[i+1]))
    net:add(args.nl())
end
