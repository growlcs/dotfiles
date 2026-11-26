{
  description = "Personal dotfiles managed with Hjem";

  inputs.autolith.url = "github:lambda-symbolics/autolith";
  inputs.helix.url = "github:helix-editor/helix/25.07.1";
  inputs.lace.url = "git+file:///Users/growl/eng/personal/lace?ref=main";
  inputs.nixpkgs.follows = "autolith/nixpkgs";
  inputs.tool-nixpkgs.url = "github:NixOS/nixpkgs/4e192cac171f3184739c6095d9d259e3efc24473";

  outputs = inputs: import ./flake.output.nix inputs;
}
