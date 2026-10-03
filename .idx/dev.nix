{ pkgs, ... }: {
  channel = "stable-24.05";

  packages = [
    pkgs.nodejs_20
    pkgs.python311
    pkgs.python311Packages.pip
    pkgs.git
  ];

  env = {
    NODE_ENV = "development";
    PYTHONUNBUFFERED = "1";
  };

  idx = {
    extensions = [
      "ms-python.python"
      "ms-python.vscode-pylance"
      "dbaeumer.vscode-eslint"
      "esbenp.prettier-vscode"
    ];

    previews = {
      enable = true;

      previews = {
        web = {
          command = [
            "npm"
            "run"
            "dev"
            "--"
            "--hostname"
            "0.0.0.0"
            "--port"
            "$PORT"
          ];

          manager = "web";

          env = {
            PORT = "$PORT";
          };
        };
      };
    };

    workspace = {
      onCreate = {
        install-frontend =
          "if [ -f package.json ]; then npm install; fi";

        install-backend =
          "if [ -f backend/requirements.txt ]; then pip install -r backend/requirements.txt; fi";
      };

      onStart = {
        check-node = "node --version";
        check-python = "python --version";
      };
    };
  };
}