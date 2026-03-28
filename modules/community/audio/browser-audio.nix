{
  flake.aspects.browser-audio = {
    nixos = {
      services.pipewire.extraConfig.pipewire."10-browser" = {
        "context.modules" = [
          {
            name = "libpipewire-module-loopback";
            args = {
              "node.description" = "Browser Audio";
              "capture.props" = {
                "node.name" = "browser-sink";
                "media.class" = "Audio/Sink";
                "audio.position" = [
                  "FL"
                  "FR"
                ];
              };
              "playback.props" = {
                "node.name" = "browser-sink.output";
                "node.passive" = true;
              };
            };
          }
        ];
      };
      services.pipewire.extraConfig.pipewire-pulse."10-browser" = {
        "pulse.rules" = [
          {
            matches = [
              { "application.name" = "Helium"; }
              { "application.name" = "brave-browser"; }
              { "application.name" = "Zen"; }
            ];
            actions = {
              "update-props" = {
                "target.object" = "browser-sink";
              };
            };
          }
        ];
      };
    };
  };
}
