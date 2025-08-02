# $mode: cache, frequency
function set-x3d -a mode
    echo -n 'Setting X3D mode to '
    echo "$mode" | sudo tee /sys/bus/platform/drivers/amd_x3d_vcache/*/amd_x3d_mode
end
