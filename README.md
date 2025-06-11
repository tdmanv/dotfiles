# dotfiles

Personal dotfiles managed with `stow`.

## Installation

### 1. Get Repo

Choose one of the following methods:

**HTTPS:**
```bash
cd
git clone https://github.com/tdmanv/dotfiles.git
```

**SSH:**
```bash
cd
git clone git@github.com:tdmanv/dotfiles.git
```

**Manual Download (if git is not available):**
```bash
cd
curl -sLO https://github.com/tdmanv/dotfiles/archive/master.tar.gz
tar xvf master.tar.gz
mv dotfiles-master dotfiles # Ensure the directory is named 'dotfiles'
```

### 2. Install Stow

`stow` is used to create symbolic links from the files in this repository to your home directory.

**macOS (using Homebrew):**
```bash
brew install stow
```

**Linux (Debian/Ubuntu):**
```bash
sudo apt-get update
sudo apt-get install stow
```
For other distributions, please use your system's package manager.

### 3. Install General Dependencies

These are common dependencies that many of the configurations might need. Specific tools might have additional dependencies listed in their respective sections.

```bash
# For Debian/Ubuntu based systems
sudo apt-get install -y git curl build-essential python3-dev cmake

# For macOS (many of these might be pre-installed or managed by brew)
# Ensure you have Xcode Command Line Tools: xcode-select --install
# brew install git curl cmake
```

## Configuration

All configurations are managed using `stow`. The general command structure is:
`stow --dir "${HOME}/dotfiles/stow" --target "${TARGET_PATH}" -S <package_name>`

Make sure you are in the `dotfiles` directory when running these commands, or adjust `"${HOME}/dotfiles/stow"` accordingly.

### Bash

To link Bash configuration files (e.g., `.bashrc`, `.bash_aliases`):

```bash
stow --dir "${HOME}/dotfiles/stow" --target "${HOME}" -S bash
```

**macOS users:** The `stow/bash/bashrc.mac` file contains macOS-specific configurations. You can source it from your main `~/.bashrc` file by adding a line like:
```bash
if [[ "$(uname)" == "Darwin" ]]; then
  source "${HOME}/dotfiles/stow/bash/bashrc.mac" # Adjust path if necessary
fi
```
(Note: The stowed `bashrc` might already include logic to source this.)

### Git

To link Git configuration files (e.g., `.gitconfig`):

```bash
stow --dir "${HOME}/dotfiles/stow" --target "${HOME}" -S git
```

### Inputrc

To link Inputrc configuration (e.g., `.inputrc` for readline behavior):

```bash
stow --dir "${HOME}/dotfiles/stow" --target "${HOME}" -S inputrc
```

### Neovim (nvim)

#### Install Neovim

**macOS (using Homebrew):**
```bash
brew install neovim
```

**Linux (AppImage - recommended for latest versions):**
```bash
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage
sudo mv nvim.appimage /usr/local/bin/nvim # Or any other location in your PATH
```
Refer to the [Neovim installation guide](https://github.com/neovim/neovim/blob/master/INSTALL.md) for other installation methods.

#### Install Neovim Dependencies

For a full experience with LSPs, linters, formatters, and plugins:

*   **Python support:**
    ```bash
    python3 -m pip install --user --upgrade pynvim
    ```
*   **Node.js and npm (for LSPs like `bash-language-server`, `tsserver`, etc.):**
    See the "Node.js / NVM" section below.
*   **Ripgrep (for Telescope search and other plugins):**
    ```bash
    # macOS
    brew install ripgrep
    # Linux
    sudo apt-get install ripgrep
    ```
*   **Other dependencies** (compilers like `gcc`/`clang`, `make`, `unzip`, etc.) might be needed for specific plugins or language servers.

#### Link Neovim Configuration

```bash
mkdir -p "${HOME}/.config/nvim"
stow --dir "${HOME}/dotfiles/stow" --target "${HOME}/.config/nvim" -S nvim
```

### Tmux

#### Install Tmux

```bash
# Linux (Debian/Ubuntu)
sudo apt-get install tmux

# macOS (using Homebrew)
brew install tmux
```

#### Link Tmux Configuration

```bash
stow --dir "${HOME}/dotfiles/stow" --target "${HOME}" -S tmux
```

**macOS users:** The `stow/tmux/tmux.conf.mac` file contains macOS-specific configurations. It is typically sourced automatically by the main `tmux.conf`.

#### Tmux Plugin Manager (TPM)

1.  Install TPM:
    ```bash
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    ```
2.  Install plugins:
    *   Launch Tmux.
    *   Press `prefix + I` (capital 'i') to fetch and install plugins defined in `tmux.conf`. (prefix is usually `Ctrl-b` or `Ctrl-a`).

#### Tmux Powerline Fonts (Optional)

For some themes (like powerline-based ones) to render correctly, you might need to install powerline-patched fonts:

1.  **Install Fontconfig (if not present):**
    ```bash
    # Linux (Debian/Ubuntu)
    sudo apt-get install fontconfig
    # macOS: Usually handled by the system or Homebrew.
    ```
2.  **Download and Install a Powerline Font:**
    You can find many pre-patched fonts. A common one is `PowerlineSymbols.otf`.
    ```bash
    wget https://github.com/Lokaltog/powerline/raw/develop/font/PowerlineSymbols.otf
    # For user-specific install (recommended):
    mkdir -p ~/.local/share/fonts
    mv PowerlineSymbols.otf ~/.local/share/fonts/
    # Or system-wide:
    # sudo mv PowerlineSymbols.otf /usr/share/fonts/opentype/ # Path may vary
    ```
3.  **Update Font Cache:**
    ```bash
    fc-cache -vf ~/.local/share/fonts/ # For user-specific
    # sudo fc-cache -vf /usr/share/fonts/ # For system-wide
    ```
4.  **Configure Fontconfig (Optional, for specific font matching):**
    This step might not always be necessary if your terminal emulator correctly picks up the font.
    ```bash
    wget https://github.com/Lokaltog/powerline/raw/develop/font/10-powerline-symbols.conf
    # For user-specific install:
    mkdir -p ~/.config/fontconfig/conf.d
    mv 10-powerline-symbols.conf ~/.config/fontconfig/conf.d/
    # Or system-wide:
    # sudo mv 10-powerline-symbols.conf /etc/fonts/conf.d/
    ```
5.  Configure your terminal emulator to use a Powerline-patched font.

### Zsh

#### Install Zsh

```bash
# Linux (Debian/Ubuntu)
sudo apt-get install zsh

# macOS (usually pre-installed, or use Homebrew)
# brew install zsh
```
You might want to set Zsh as your default shell: `chsh -s $(which zsh)`

#### Install Oh My Zsh (Optional, but common)

Follow the instructions on the [Oh My Zsh website](https://ohmyz.sh/#install).

#### Install Oh My Posh (Optional, for custom prompts)

Follow the instructions on the [Oh My Posh website](https://ohmyposh.dev/docs/installation).

#### Link Zsh Configuration

```bash
stow --dir "${HOME}/dotfiles/stow" --target "${HOME}" -S zsh
```
This will link files like `.zshrc`. The provided `.zshrc` might be configured to work with Oh My Zsh and Oh My Posh if you choose to install them.

### Node.js / NVM (Node Version Manager)

NVM allows you to manage multiple Node.js versions. This is useful for Neovim LSPs and other development tools.

1.  **Install NVM:**
    ```bash
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash
    ```
    (Check the [NVM GitHub page](https://github.com/nvm-sh/nvm) for the latest install script version.)
    You'll need to source NVM in your shell, or close and reopen your terminal. Add the following to your `.bashrc` or `.zshrc` if the installer doesn't:
    ```bash
    export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
    ```

2.  **Install Node.js (e.g., latest LTS):**
    ```bash
    nvm install --lts
    nvm use --lts
    nvm alias default 'lts/*' # Set LTS as default for new shells
    ```

3.  **Update npm (Node Package Manager):**
    ```bash
    npm install -g npm # To the latest version
    ```

4.  **Install Global npm Packages (Example):**
    ```bash
    # Bash Language Server (for Neovim LSP)
    npm i -g bash-language-server
    ```

## Miscellaneous

### Google Cloud SDK (gcloud)

Follow the official [Google Cloud SDK installation guide](https://cloud.google.com/sdk/docs/install) for your operating system.
A common method for Linux:

```bash
sudo apt-get install apt-transport-https ca-certificates gnupg
echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
sudo apt-get update && sudo apt-get install google-cloud-sdk
```

### Docker

Follow the official [Docker installation guide](https://docs.docker.com/engine/install/) for your OS.
For Ubuntu:

1.  **Set up the repository:**
    ```bash
    sudo apt-get update
    sudo apt-get install ca-certificates curl gnupg lsb-release
    sudo mkdir -p /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
    echo \
      "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
      $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    ```
2.  **Install Docker Engine:**
    ```bash
    sudo apt-get update
    sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin
    ```
3.  **Post-installation steps (optional, to run Docker without sudo):**
    Refer to [Docker post-installation steps](https://docs.docker.com/engine/install/linux-postinstall/).
    ```bash
    sudo groupadd docker
    sudo usermod -aG docker $USER
    newgrp docker # Activate changes, or log out and back in
    ```

### Codespaces (GitHub)

To create a GitHub Codespace using a specific devcontainer configuration:

```bash
gh codespace create --devcontainer-path ".devcontainer/buildimage/devcontainer.json" --repo <OWNER>/<REPO_NAME> --machine <MACHINE_TYPE> --branch <BRANCH_NAME>
```
Example:
```bash
gh codespace create --devcontainer-path ".devcontainer/buildimage/devcontainer.json" --repo kastenhq/k10 --machine basicLinux32gb --branch devcontainer
```
Refer to `gh codespace create --help` for more options.
