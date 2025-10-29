{
  flake.modules.nixos.rocm = {
    hardware.amdgpu.opencl.enable = true;
  };
}
